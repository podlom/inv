<?php

namespace Analytics;

use Skynar\Module\AbstractModule;
use Skynar\Cron\Task;
use Skynar\Application;

class Module extends AbstractModule{

    protected function loadController(string $name){
        throw new \Exception('Method loadController() is not implemented.');
    }

    public function install($manager, $options=[]){
        $app = $this->getApp();
        $engine = new Engine($app);
        $app->getServiceManager()->set('analytics', $engine);
        //install table
        $engine->create();

        $file = $this->getApp()->getPath().'/data/analytics';
        $this->create_cron_script($file);
        $this->create_cron_task($file);

        return true;
    }

    public function create_cron_task($file){
        $cfg = app()->getService('config')->get('app')->cron;
        $class = $cfg['class'];
        $cron = new $class($cfg['exec']);
        $tasks = $cron->getTasks();
        array_filter($tasks, function($t) use($file){
            return strpos($t->command, $file)!==0;
        });
        $cfg = app()->getService('config')->get('Analytics','config');
        $tasks[] = Task::fromString($cfg['cron_time'].' '.$file);
    }

    public function create_cron_script($file){
        $code = $this->getService('template')->render('Analytics.cleanup', ['app'=>$this->getApp()]);
        file_put_contents($file, $code);
        chmod($file, 0755);
    }


    public function event_core_init($event){
        $event->getApp()->getServiceManager()->set('analytics', new Engine($event->getApp()));
    }

    public function event_core_terminate($event){
        $this->getService('log')->logWarn('anal!');
        $engine = $this->getService('analytics');
        //$engine->logRequest($this->getService('http')->getRequest());
        $engine->doUpdates();
    }

    public function event_doctrine_update($event){
        //unset($event->get('diff')->removedTables['analyticsrequest']);
    }

    public function event_page_view($e){
        $this->getService('analytics')->logView($e->get('page'));
    }

}
