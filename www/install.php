<?php

use Auth\Access\Role;
use Auth\User;
//phpinfo();


define( 'SKYNAR_DEBUG', true);
define( 'SKYNAR_TIMING', true);

//phpinfo();exit;
//загружаем  хелпер
require_once realpath(realpath(__DIR__).'/../cms/actual/global.php');
//загружаем приложение и запускаем
//error_reporting(E_ALL);


$app = new Skynar\Application('inventure', realpath(__DIR__.'/../'), __DIR__);
try{
	$app->init();
	$log = $app->getService('module')->install(['Core', 'Auth', 'Page', 'React', 'Blog', 'Attribute', 'Analytics', 'Metadata', 'Locale', 'Sphinx', 'Redirect', 'Sitemap', 'Blacklist', 'Digest', 'EventSort', 'Widget', 'Poll', 'Rating', 'Map', 'Payment', 'Liqpay', 'Mail', 'BulletinBoard', 'Banner']);
	$u = [];
	$em = $app->getService('doctrine')->getEntityManager();
	$u[] = $em->getReference(\Auth\User::class, 1);
	$u[] = $em->getReference(\Auth\User::class, 2);
	$r = $em->getReference(\Auth\Access\Role::class, 'admin');
	foreach($u as $i){
		$i->addRole($r);
		$i->save();
	}
	$i->save(1);
	//$app->getService('module')->getModule('React')->build(['React', 'Mail'], true);
	/*$u = User::getRepository()->findOneBy(['email'=>'dev@feelgoodlabs.com']);
	//$u->setEmail('dev@feelgoodlabs.com');
	$u->setName('Developer');
	$u->setPasswd('workonit');
	$u->addRole($app->getService('doctrine')->getEntityManager()->getReference(Role::class, 'admin'));
	$u->save(1);*/
	//*/
	$log->dump();
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

debug('ok');
