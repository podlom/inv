<?php

/**
 * Created by PhpStorm
 * User: podlo
 * Date: 2024-03-11
 * Time: 18:21
 * Modified: 2025-07-11 23:19
 *
 * @author Taras Shkodenko <taras.shkodenko@gmail.com>
 */

require_once 'lib/functions.php';
require_once realpath(__DIR__ . '/../bootstrap.php');


$app_name = trim(file_get_contents(__DIR__ . '/../app_id'));
$app = new Skynar\Application($app_name, realpath(__DIR__ . '/../'), __DIR__);
try {
    $app->init();
} catch (Throwable $e) {
    echo $app->getService('template')->renderException($e);
}

$resHmtl = '';
if (!empty($_REQUEST)) {
    try {
        $db = getDb();
    } catch (\Exception $e) {
        $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Fatal error: ' . $e->getMessage() . PHP_EOL;
        die($msg);
    }
    $msg = __FILE__ . ' +' . __LINE__ . ' $_SERVER: ' . var_export($_SERVER, true);
    l_m($msg);

    $lang = $defaultLang = 'ru';
    if (isset($_REQUEST['lang']) && !empty($_REQUEST['lang']) && in_array($_REQUEST['lang'], ['uk', 'en', 'ru'])) {
        $lang = $_REQUEST['lang'];
    }
    $categoryUrl = '/tools/video';
    $routeId = 7331;
    if (strlen($lang) > 2) {
        $lang = substr($lang, 0, 2);
    }
    if ($lang !== $defaultLang) {
        $msg = __FILE__ . ' +' . __LINE__ . ' set $lang from locale: ' . var_export($lang, true);
        l_m($msg);
    } else {
        $msg = __FILE__ . ' +' . __LINE__ . ' used default $lang: ' . var_export($lang, true);
        l_m($msg);
    }
    //
    // $msg = __FILE__ . ' +' . __LINE__ . ' $_SERVER HTTP_USER_AGENT: ' . var_export($_SERVER['HTTP_USER_AGENT'], true);
    // l_m($msg);
    //
    $msg = __FILE__ . ' +' . __LINE__ . ' $_GET: ' . var_export($_GET, true) . '; $_POST: ' . var_export($_POST, true) . '; $_REQUEST: ' . var_export($_REQUEST, true);
    l_m($msg);
    
    if (isset($_REQUEST['action']) && ($_REQUEST['action'] == 'video-list'))
    { // Get events for home page action
        if (isset($_REQUEST['limit'])) {
            $limit = intval($_REQUEST['limit']);
        } else {
            $limit = 24;
        }
        l_m(__FILE__ . ' +' . __LINE__ . ' $limit: ' . var_export($limit, true) . PHP_EOL);

        if (isset($_REQUEST['page'])) {
            $page = intval($_REQUEST['page']);
            $offset = ($page - 1) * $limit;
        } else {
            $page = 1;
            $offset = 0;
        }
        l_m(__FILE__ . ' +' . __LINE__ . ' $page: ' . var_export($page, true) . PHP_EOL);
        l_m(__FILE__ . ' +' . __LINE__ . ' $offset: ' . var_export($offset, true) . PHP_EOL);
        
        $videoCategoryId = 77;
        if ($lang == 'uk') {
            $routeId = 7548;
            $categoryUrl = '/uk/tools/video';
            $videoCategoryId = 75;
        } elseif ($lang == 'en') {
            $routeId = 7420;
            $categoryUrl = '/en/tools/video';
            $videoCategoryId = 76;
        }
        $atrrName = 'attr' . $videoCategoryId;
        
        $query = "SELECT SQL_CALC_FOUND_ROWS p.*, '' AS picture_url, ap.`views` AS `page_views` " .
            " FROM `Page` AS `p` " .
            " LEFT JOIN `Analytics_Page` AS `ap` ON ((`p`.`id` = `ap`.`page_id`)) " .
            " WHERE p.`status` = 1 AND p.route_id = {$routeId} " .
            " ORDER BY p.`id` DESC " .
            " LIMIT {$limit} OFFSET {$offset} ";

        l_m(__FILE__ . ' +' . __LINE__ . ' SQL: ' . $query . PHP_EOL);
        $res2 = $db->query($query);
        // l_m( __FILE__ . ' +' . __LINE__ . ' Result: ' . var_export($res2, true) . PHP_EOL );
        
        $query = "SELECT FOUND_ROWS()";
        l_m(__FILE__ . ' +' . __LINE__ . ' SQL: ' . $query);
        $res322 = $db->query($query);
        l_m(__FILE__ . ' +' . __LINE__ . ' Result322: ' . var_export($res322, true));
        
        $nextPage = $page + 1;
        $itemNo = 0;

        $resHmtl .= '';
        if (!empty($res2) && is_array($res2)) {
            foreach ($res2 as $r9) {
                $attr55 = '';
                if (isset($r9['attr'])) {
                    $decodedAttr = json_decode($r9['attr'], true);
                    if (isset($decodedAttr['attr55'])) {
                        $attr55 = $decodedAttr['attr55'];
                    }
                }
                //
                $itemNo ++;
                //
                $lastItem = false;
                if ($limit == $itemNo) {
                    $lastItem = true;
                }
                $linkAttributes = '';
                $nextPageUrl = increment_page_param($_SERVER['REQUEST_URI']);
                if ($lastItem) {
                    $linkAttributes = 'hx-get="' . $nextPageUrl . '" hx-trigger="revealed" hx-indicator="#spinner" hx-swap="afterend"';
                }
                // $pageId[] = $r9['id'];
                $dateStr = date("d.m.y", strtotime($r9['created']));
                //
                $resHmtl .= '<div ' . $linkAttributes . ' data-item-no="' . $itemNo . '" itemprop="itemListElement" itemscope="" itemtype="http://schema.org/Article">' .
                    '<meta itemprop="position" content="0">' .
                    '<a href="' . $categoryUrl . '/' . $r9['subpath'] . '" class="cards__item">' .
                    '<div class="cards__labels flex"> </div> ' .
                    '<div class="cards__img-wrapper"> ' .
                    // '<img class="cards__img" itemprop="image" src="/img/thumb.350.254' . $r9['picture_url'] . '" data-src="/img/thumb.350.254' . $r9['picture_url'] . '" alt="Stonepeak привлекает $3,3 млрд для своего первого инфраструктурного фонда ориентированного на Азию" itemscope="" itemtype="http://schema.org/ImageObject">' .
                    ' <img src="//img.youtube.com/vi/' . $attr55 . '/mqdefault.jpg" class="cards__img" itemscope itemtype="http://schema.org/ImageObject"> '.
                    ' </div> ' .
                    '<h2 class="cards__title" itemprop="headline">' . $r9['h1'] . '</h2> ' .
                    '<div itemprop="description" class="the_shorttext">' . $r9['short_text'] . '</div> ' .
                    '<div class="cards__meta flex justify-between mt-auto opacity-75 text-sm"> ' .
                    '<div class="cards__date text-sm"> ' . $dateStr . ' </div> ' .
                    '<div class="cards__meta-wrapper text-sm"> ' .
                    '<div class="cards__meta-stat"> ' .
                    '<img data-src="/images/icons/eye.svg" width="16px" height="16px" alt="Views icon" class="mr-2 ls-is-cached lazyloaded" src="/images/icons/eye.svg"> ' .
                    '<div>' . $r9['page_views'] . '</div> ' .
                    '</div> ' .
                    '</div> ' .
                    '</div> ' .
                    '</a></div>';
            }
        }
        // $resHmtl .= '</div>';
    }
}

if (!headers_sent()) {
    header('Access-Control-Allow-Origin: *');
    header('Content-Type: text/html; charset=utf-8');
}
die($resHmtl);
