<?php

use Auth\Access\Role;
use Auth\User;


define( 'SKYNAR_DEBUG', true);
define( 'SKYNAR_TIMING', true);

require_once realpath(__DIR__.'/../bootstrap.php');


$app_name = trim(file_get_contents(__DIR__.'/../app_id'));
$app = new Skynar\Application($app_name, realpath(__DIR__.'/../'), __DIR__);
try {
	$app->init();
    if ($app->getService('cache')->deleteAll()) {
        debug('ok');
    }
} catch (Throwable $e) {
	debug($e, false);
	debug($e->getTraceAsString());
  	// echo $app->getService('template')->renderException($e);
}

debug('ob');
