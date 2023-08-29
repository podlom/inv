<?php

namespace Analytics;

use Skynar\Http\Request;

/**
 * Storage for requests (shuld i use it?)
 * !T add domain support
 */
class Engine{

    private $app;
    private $updates=[];

    public function __construct($app){
        $this->app = $app;
    }


    public function doUpdates(){
        foreach($this->updates as $up){
            call_user_func_array([$this, array_shift($up)], $up);
        }
    }

    public function logAction($name, $data=[]){
        //!T
    }

    public function logView(\Core\Page $page){
        $this->updates[] = ['doLogView', $page];
    }

    public function logRequest(Request $request){
        $this->updates[] = ['doLogRequest', $request];
    }

    protected function doLogView(\Core\Page $page){
        $connection = $this->getConnection();
        //inc counter
        //$qb = $connection->createQueryBuilder();
        $qb = $this->app->getService('doctrine')->getQueryBuilder();
        $qb->update(\Analytics\Page::class, 'p')
        ->set('p.views','p.views+1')
        ->where('p.page = '.$page->getId());
        $query = $connection->query($qb->getQuery()->getSql());
        $this->app->getService('log')->logDebug('[Anlytics] update views');
        if($query->rowCount()==0){
            $p = new \Analytics\Page;
            $p->setPage($page);
            $p->save(1);
            $this->app->getService('log')->logDebug('[Anlytics] insert view');
        }

    }

    public function doLogRequest(Request $request){

        //save request, if its not saved
        if(!$request->server->get('Analytics.stored', false)){
            $request->server->set('Analytics.stored', true);
            $headers = $request->headers->all();
            $headers['ip'] = $request->server->get('HTTP_CLIENT_IP',
                $request->server->get('HTTP_X_FORWARDED_FOR',
                    $request->server->get('REMOTE_ADDR')));
            $this->insert($headers, $this->app->getService('session')->getSession()->getId());
        }
    }

    public function create($drop=false){
        $sql = $drop?'DROP TABLE IF EXISTS AnalyticsRequest;':'';
        $sql .= <<<EOF
CREATE TABLE IF NOT EXISTS AnalyticsRequest(
    date datetime DEFAULT NULL,
    headers blob,
    session varchar(255)
) ENGINE=ARCHIVE
PARTITION BY LIST ( DAY(date) ) (
EOF;
            for($i=1;$i<=31;$i++)
                $sql .= '
    PARTITION d'.$i.' VALUES IN('.$i.')'.($i==31?PHP_EOL.')':',');
        $this->getConnection()->prepare($sql)->execute();
    }

    protected function trancate($day){
        if(!is_numeric($day))
            return false;
        $sql = 'ALTER TABLE AnalyticsRequest TRUNCATE PARTITION d'.$day;
        $this->getConnection()->query($sql)->execute();
    }

    protected function getConnection(){
        return $this->app->getService('doctrine')->getConnection();
    }

    public function insert($headers, $sess_id){
        $query = $this->getConnection()->prepare('INSERT INTO AnalyticsRequest (date, headers, session) VALUES (NOW(), :headers, :session)');
        $query->execute([
            'headers'=>json_encode($headers, JSON_NUMERIC_CHECK | JSON_UNESCAPED_UNICODE | JSON_BIGINT_AS_STRING),
            'session'=>$sess_id,
        ]);
        return true;
    }

    public function buildAnalytics(){
        $conn = $this->getConnection();
        //build statistics
        $current = new DateTime();
        $current->setTime(0,0,0);
        $query = $connection->prepare('SELECT date, path, session, referer FROM AnalyticsRequest WHERE date < :date');
        $query->bindValue('date', $current);
        $iterator = $query->getIterator();
        foreach($iterator as $data){
            if(isset($first_date))
                $first_date = $data['date'];
            //!T process results
            break;
            $query->closeCursor();
        }

        while(($first_date < $current) && ($first_date->format('d') != $current->format('d')) ){
            $day = $first_date->format('d');
            $this->trancate((int)$day);
            $first_date->modify('+1 day');
        }
    }

}
