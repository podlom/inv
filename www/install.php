<?php

use Auth\Access\Role;
use Auth\User;


define( 'SKYNAR_DEBUG', true);
define( 'SKYNAR_TIMING', true);

require_once realpath(__DIR__.'/../bootstrap.php');


$app_name = trim(file_get_contents(__DIR__.'/../app_id'));

$app = new Skynar\Application($app_name, realpath(__DIR__.'/../'), __DIR__);
try{
	$app->init();
    // $app->getService('cache')->deleteAll();
	$log = $app->getService('module')->install(['Core', 'Auth', 'Page', 'React', 'Blog', 'Attribute', 'Analytics', 'Metadata', 'Locale', 'Sphinx', 'Redirect', 'Sitemap', 'Blacklist', 'Digest', 'EventSort', 'Widget', 'Poll', 'Rating', 'Map', 'Payment', 'Liqpay', 'Mail', 'BulletinBoard', 'Banner', 'Dashboard', 'Tinyurl', 'Template', 'Review', 'SeoText']);
	
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
	debug($e, false);
	debug($e->getTraceAsString());
  	//echo $app->getService('template')->renderException($e);
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
