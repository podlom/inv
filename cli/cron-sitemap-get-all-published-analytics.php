<?php

/**
 * Created by PhpStorm
 * User: Taras
 * Date: 2022-12-27
 * Time: 00:52
 *
 * @author Taras Shkodenko <taras@shkodenko.com>
 */

define('URL_PREFIX', 'https://inventure.com.ua/');

(PHP_SAPI !== 'cli' || isset($_SERVER['HTTP_USER_AGENT'])) && die(' +' . __LINE__ . ' Fatal error: cli usage only allowed');

global $settings, $db, $logFileName, $keyId, $data1;

$logFileName = dirname( dirname(__FILE__) ) . '/log/cron-sitemap-get-all-published-analytics_' . date('Y-m-d') . '.log';

// require_once 'vendor/autoload.php';
require_once 'config' . DIRECTORY_SEPARATOR . 'settings.php';
require_once 'lib' . DIRECTORY_SEPARATOR . 'db.class.php';
require_once 'lib' . DIRECTORY_SEPARATOR . 'functions.php';


function getAnalytics($lang = 'ru')
{
    global $db, $logFileName;

    $retVal = [];

    $timeZone = new \DateTimeZone('Europe/Kiev');

    $query = "select * from `analytics_{$lang}` where `status` = '1'";

    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Executing SQL: . ' . $query . PHP_EOL;
    logMsg($msg, $logFileName, ['echoLogMsg' => true, 'storeLog' => true]);

    $res = $db->query($query);

    if (!empty($res)) {
        foreach ($res as $r1) {
            switch ($r1['parent_id']) {
                case 23:
                    $analyticsCategoryUrl = 'analytics/database/';
                    break;
                case 74:
                    $analyticsCategoryUrl = 'analytics/formula/';
                    break;
                case 11608:
                    $analyticsCategoryUrl = 'analytics/articles/';
                    break;
                case 14597:
                    $analyticsCategoryUrl = 'analytics/we-invest-in-ukraine/';
                    break;
                case 25411:
                    $analyticsCategoryUrl = 'analytics/investments/';
                    break;
                case 25413:
                    $analyticsCategoryUrl = 'analytics/formula/';
                    break;
                case 25414:
                    $analyticsCategoryUrl = 'analytics/articles/';
                    break;
                case 25510:
                    $analyticsCategoryUrl = 'analytics/database/';
                    break;
                case 9788:
                    $analyticsCategoryUrl = 'analytics/formula/';
                    break;
                case 9789:
                    $analyticsCategoryUrl = 'analytics/investments/';
                    break;
                case 11946:
                    $analyticsCategoryUrl = 'analytics/articles/';
                    break;
                case 15073:
                    $analyticsCategoryUrl = 'analytics/we-invest-in-ukraine/';
                    break;
                case 15077:
                    $analyticsCategoryUrl = 'analytics/database/';
                    break;
                default:
                    $analyticsCategoryUrl = 'analytics/investments/'; // id = 20
                    break;
            }
            $dt3 = new \DateTime($r1['published'], $timeZone);
            $langPrefix = '/' . $lang . '/';
            if ($lang == 'ru') {
                $langPrefix = '/';
            }
            $retVal[] = [
                'loc' => $langPrefix . $analyticsCategoryUrl . $r1['subpath'],
                'lastmod' => $dt3->format('Y-m-d\TH:i:s+00:00'),
                'h1' => $r1['h1'],
                'category_title' => $r1['category_title'],
                'changefreq' => 'always',
                'priority' => 0.5,
            ];
        }
    }

    return $retVal;
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

    $langs = ['en', 'uk', 'ru'];
    foreach ($langs as $lang) {
        $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' $lang: . ' . var_export($lang, true) . PHP_EOL;
        logMsg($msg, $logFileName, ['echoLogMsg' => true, 'storeLog' => true]);
        $analytics = getAnalytics($lang);
        $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' $analytics: . ' . var_export($analytics, true) . PHP_EOL;
        logMsg($msg, $logFileName, ['echoLogMsg' => true, 'storeLog' => true]);
        // empty file
        file_put_contents('/home/inventure/data/web/inventure.com.ua/cli/php-sitemap-generator/all_published_analytics_' . $lang . '.txt', '');
        // @see: https://developers.google.com/search/docs/crawling-indexing/sitemaps/news-sitemap
        // /home/inventure/data/web/inventure.com.ua/cli/php-sitemap-generator/
        file_put_contents('/home/inventure/data/web/inventure.com.ua/cli/php-sitemap-generator/all_published_analytics_' . $lang . '.txt', serialize($analytics));
    }


} catch (\Exception $e) {
    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Fatal error: ' . $e->getMessage() . PHP_EOL;
    error_log( date('r') . ' ' . $msg . PHP_EOL, 3, $logFileName );
    die($msg);
}
