<?php
define( 'SKYNAR_DEBUG', true);
require '../cms/actual/global.php';


// $app = new Skynar\Application('inventure', '/home/inventure/data/web/inventure.com.ua', '/home/inventure/data/web/inventure.com.ua/www');
$app = new Skynar\Application('inventure#invda', '/home/devinv/d/w/dev.inventure.com.ua', '/home/devinv/d/w/dev.inventure.com.ua/www');
$app->init();

$time = microtime(1);
$event = $app->getService('module')->getModule('Sitemap')->runGenerateEvent();
$time = microtime(1)-$time;

echo 'done: '.$event->getLinksCount().' links found! Total time: '.number_format($time, 2).'s';