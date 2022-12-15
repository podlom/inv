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


function getNews($lang = 'ru')
{
    global $db, $logFileName;

    $retVal = [];

    $timeZone = new \DateTimeZone('Europe/Kiev');
    $dt = new \DateTime('now', $timeZone);
    $dt1 = $dt->format('Y-m-d');
    $dt->sub(new \DateInterval('P2D'));
    $dt2 = $dt->format('Y-m-d');

    $query = "select * from `news_{$lang}` where `published` between '{$dt2}' and '{$dt1}'";

    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Executing SQL: . ' . $query . PHP_EOL;
    logMsg($msg, $logFileName, ['echoLogMsg' => true, 'storeLog' => true]);

    $res = $db->query($query);

    if (!empty($res)) {
        foreach ($res as $r1) {
            $newsCategoryUrl = 'news/world/';
            if ($r1['parent_id'] == 24) {
                $newsCategoryUrl = 'news/ukraine/';
            }
            $dt3 = new \DateTime($r1['published'], $timeZone);
            $langPrefix = '/' . $lang . '/';
            if ($lang == 'ru') {
                $langPrefix = '/';
            }
            $retVal[] = [
                'loc' => $langPrefix . $newsCategoryUrl . $r1['subpath'],
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
        $news = getNews($lang);
        $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' $news: . ' . var_export($news, true) . PHP_EOL;
        logMsg($msg, $logFileName, ['echoLogMsg' => true, 'storeLog' => true]);
        // empty file
        file_put_contents('/home/inventure/data/web/inventure.com.ua/cli/php-sitemap-generator/news_' . $lang . '.txt', '');
        // @see: https://developers.google.com/search/docs/crawling-indexing/sitemaps/news-sitemap
        // /home/inventure/data/web/inventure.com.ua/cli/php-sitemap-generator/
        file_put_contents('/home/inventure/data/web/inventure.com.ua/cli/php-sitemap-generator/news_' . $lang . '.txt', serialize($news));
    }


} catch (\Exception $e) {
    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Fatal error: ' . $e->getMessage() . PHP_EOL;
    error_log( date('r') . ' ' . $msg . PHP_EOL, 3, $logFileName );
    die($msg);
}
