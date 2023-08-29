<?php
/**
 * @package Skynar
 * @version 0.1
 * @link http://skynar.co/
 * @author Evgen Pochekuev <themastir@gmail.com>
 * @copyright 2009-2015
 */


namespace Analytics;

use Skynar\Module\Installer as Base;

class Installer extends Base{

   public function install(){
   		//$app = $this->getApp();
        //$engine = new Engine($app);
        //$app->getServiceManager()->set('analytics', $engine);
        //install table
        //$engine->create();

        //$file = $this->getApp()->getPath().'/data/analytics';
        //$this->create_cron_script($file);
        //$this->create_cron_task($file);

    }

    public function update($version){
        return true;
    }


}
