<?php

//
if ($_SERVER['REMOTE_ADDR'] == '95.158.38.121') {
    define('SKYNAR_DEBUG_SQL', true);
}
//

require_once realpath(__DIR__.'/../bootstrap.php');

$app_name = trim(file_get_contents(__DIR__.'/../app_id'));

$app = new Skynar\Application($app_name, realpath(__DIR__.'/../'), __DIR__);
try{
$app->init();
$app->run();

} catch (Throwable $e){
  echo $app->getService('template')->renderException($e);
}
//$b = new tool\Bcrypt();

//$app->compileStyle();
//$app->init();
//$app->getService('doctrine')->createDatabase();
/*
$app->getCache()->deleteAll();
$app->updateModels();
$app->db()->updateDatabase();
$app->db()->generateProxy();
//$em = app()->db()->getEntityManager();
//*/

