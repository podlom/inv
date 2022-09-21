<?php

/**
 * Created by PhpStorm
 * User: Taras
 * Date: 2022-09-21
 * Time: 11:12
 *
 * @author Taras Shkodenko <taras@shkodenko.com>
 */

define('URL_PREFIX', 'https://inventure.com.ua/');

(PHP_SAPI !== 'cli' || isset($_SERVER['HTTP_USER_AGENT'])) && die(' +' . __LINE__ . ' Fatal error: cli usage only allowed');

global $settings, $db, $logFileName, $keyId, $data1;

$logFileName = dirname( dirname(__FILE__) ) . '/log/cron-sitemap-get-new-articles_' . date('Y-m-d') . '.log';

// require_once 'vendor/autoload.php';
require_once 'config' . DIRECTORY_SEPARATOR . 'settings.php';
require_once 'lib' . DIRECTORY_SEPARATOR . 'db.class.php';
require_once 'lib' . DIRECTORY_SEPARATOR . 'functions.php';


function getNewsRu()
{
    global $db, $logFileName;

    $retVal = [];

    $timeZone = new \DateTimeZone('Europe/Kiev');
    $dt = new \DateTime('now', $timeZone);
    $dt1 = $dt->format('Y-m-d');
    $dt->sub(new \DateInterval('P2D'));
    $dt2 = $dt->format('Y-m-d');

    $query = "select * from `news_ru` where `published` between '{$dt2}' and '{$dt1}'";

    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Executing SQL: . ' . $query . PHP_EOL;
    logMsg($msg, $logFileName, ['echoLogMsg' => true, 'storeLog' => true]);

    $res = $db->query($query);

    if (!empty($res)) {
        foreach ($res as $r1) {
            $newsCategoryUrl = 'news/world/';
            if ($r1['parent_id'] == 24) {
                $newsCategoryUrl = 'news/ukraine/';
            }
            $retVal[] = URL_PREFIX . $newsCategoryUrl . $r1['subpath'];
        }
    }

    return $res;
}


try {
    $db = new DB('127.0.0.1', 'inventure', '6Qq2fnX51zShHhDO', 'inventure_prod');
    $query = "SET collation_connection = utf8_unicode_ci";
    $res1001 = $db->query($query);
    $query = "SET NAMES utf8";
    $res1002 = $db->query($query);
    $query = "SET CHARACTER SET utf8";
    $res1003 = $db->query($query);
    $query = "set @@collation_server = utf8_unicode_ci";
    $res1004 = $db->query($query);

    $newsRu = getNewsRu();
    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' $newsRu: . ' . var_export($newsRu, true) . PHP_EOL;
    logMsg($msg, $logFileName, ['echoLogMsg' => true, 'storeLog' => true]);

    // /home/inventure/data/web/inventure.com.ua/cli/php-sitemap-generator/

} catch (\Exception $e) {
    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Fatal error: ' . $e->getMessage() . PHP_EOL;
    error_log( date('r') . ' ' . $msg . PHP_EOL, 3, $logFileName );
    die($msg);
}
