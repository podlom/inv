<?php

define( 'SKYNAR_DEBUG', true);

require '../cms/actual/global.php';
require_once '../cms/actual/lib/Skynar/Event/iEventListner.php';
require_once '../cms/actual/lib/Skynar/Module/AbstractModule.php';
require_once '../cms/actual/lib/vendor/Symfony/Component/EventDispatcher/Event.php';
require_once '../cms/actual/lib/Skynar/Event/Event.php';
// for prod - /home/inventure/data/web/inventure.com.ua/mod/Auth/Module.php
require_once '../mod/Auth/Module.php';
require_once '../mod/Analytics/Module.php';
require_once '../mod/Analytics/Engine.php';
require_once '../mod/Sphinx/Module.php';
require_once '../mod/Sphinx/Service.php';
require_once '../mod/Sitemap/Module.php';
require_once '../mod/Sitemap/Event.php';


$app = new Skynar\Application('inventure', '/home/inventure/data/web/inventure.com.ua', '/home/inventure/data/web/inventure.com.ua/www');
// $app = new Skynar\Application('inventure#invda', '/home/devinv/d/w/dev.inventure.com.ua', '/home/devinv/d/w/dev.inventure.com.ua/www');
$app->init();

$time = microtime(1);
$event = $app->getService('module')->getModule('Sitemap')->runGenerateEvent();
$time = microtime(1)-$time;

echo 'done: '.$event->getLinksCount().' links found! Total time: '.number_format($time, 2).'s';
