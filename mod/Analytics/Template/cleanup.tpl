#!/usr/bin/env php
require '{c('QWEB_ROOT')}/global.php';

$app = new Skynar\Application('{$app->getName()}', '{$app->getPath()}', '{$app->getWebRoot()}');
$app->init();
$app->setService('Analytics')->buildAnalytics();
$app->terminate();
