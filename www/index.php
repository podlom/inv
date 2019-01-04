<?php
//phpinfo();


define( 'SKYNAR_DEBUG', true);
define( 'SKYNAR_TIMING', true);

//phpinfo();exit;
//загружаем  хелпер
require_once realpath(realpath(__DIR__).'/../cms/actual/global.php');
//загружаем приложение и запускаем
//error_reporting(E_ALL);


$app = new Skynar\Application('inventure#beta', realpath(__DIR__.'/../'), __DIR__);
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

