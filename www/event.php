<?php

/**
 * Created by PhpStorm
 * User: shtaras
 * Date: 2020-07-22
 * Time: 16:58
 * Modified: 2024-04-01 15:03
 *
 * @author Taras Shkodenko <taras@shkodenko.com>
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
//
$resHmtl = '';
//
if (!empty($_REQUEST)) {
    require_once app()->getPath() . '/cli/lib/db.class.php';
    $cfg = app()->getService('config')->get('app')->db;
    //
    /* if ($_SERVER['SERVER_NAME'] != 'inventure.com.ua') {
        // adjust db settings for dev environment
        $cfg['host'] = '127.0.0.1';
        $cfg['dbname'] = 'inventure_dev';
        $cfg['user'] = 'inventure_dev';
        $cfg['password'] = '[[)sq5J0mXKZ5x2E';
    } */
    //
    try {
        $db = new \DB($cfg['host'], $cfg['user'], $cfg['password'], $cfg['dbname']);
        $query = "SET collation_connection = utf8_unicode_ci";
        $res0 = $db->query($query);
        $query = "SET NAMES " . $cfg['charset'];
        $res1 = $db->query($query);
        $query = "SET CHARACTER SET " . $cfg['charset'];
        $res2 = $db->query($query);
        $query = "set @@collation_server = utf8_unicode_ci";
        $res3 = $db->query($query);
    } catch (\Exception $e) {
        $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Fatal error: ' . $e->getMessage() . PHP_EOL;
        die($msg);
    }
    //
    $msg = __FILE__ . ' +' . __LINE__ . ' $_SERVER: ' . var_export($_SERVER, true);
    l_m($msg);
    //
    // $msg = __FILE__ . ' +' . __LINE__ . ' $_SERVER HTTP_ACCEPT_LANGUAGE: ' . var_export($_SERVER['HTTP_ACCEPT_LANGUAGE'], true);
    // l_m($msg);
    //
    $lang = $defaultLang = 'ru';
    if (isset($_REQUEST['lang']) && !empty($_REQUEST['lang'])) {
        $lang = $_REQUEST['lang'];
    } else {
        if (isset($_SERVER['HTTP_ACCEPT_LANGUAGE']) && !empty($_SERVER['HTTP_ACCEPT_LANGUAGE'])) {
            $lang = locale_accept_from_http($_SERVER['HTTP_ACCEPT_LANGUAGE']);
        }
    }
    //
    if (strlen($lang) > 2) {
        // setlocale(LC_TIME, $lang);
        // setlocale(LC_TIME, 'ru_RU');
        // $msg = __FILE__ . ' +' . __LINE__ . ' set locale from $lang to: ' . var_export($lang, true);
        // l_m($msg);
        //
        $lang = substr($lang, 0, 2);
    }
    if ($lang !== $defaultLang) {
        $msg = __FILE__ . ' +' . __LINE__ . ' set $lang from locale: ' . var_export($lang, true);
        l_m($msg);
    } else {
        $msg = __FILE__ . ' +' . __LINE__ . ' used default $lang: ' . var_export($lang, true);
        l_m($msg);
    }
    $msg = __FILE__ . ' +' . __LINE__ . ' @ts $lang: ' . var_export($lang, true);
    l_m($msg);
    //
    // $msg = __FILE__ . ' +' . __LINE__ . ' $_SERVER HTTP_USER_AGENT: ' . var_export($_SERVER['HTTP_USER_AGENT'], true);
    // l_m($msg);
    //
    $routeId = 29;
    //
    $msg = __FILE__ . ' +' . __LINE__ . ' $_GET: ' . var_export($_GET, true) . '; $_POST: ' . var_export($_POST, true) . '; $_REQUEST: ' . var_export($_REQUEST, true);
    l_m($msg);
    //
    if ($lang == 'uk') {
        // $routeId = 29; // @ts fix 2024-04-01 $routeId = 7542;
        $routeId = 7542;
    } elseif ($lang == 'en') {
        $routeId = 7362;
    }
    $msg = __FILE__ . ' +' . __LINE__ . ' @ts $routeId: ' . var_export($routeId, true);
    l_m($msg);
    //
    $eventSortField = 'sort_1';
    $eventsSortOrder = 'ASC';
    $filterPastEventsSql = '(p0_.past2 = 0) OR (p0_.past2 IS NULL)';
    if (isset($_REQUEST['past'])) {
        $filterPastEvents = 1;
        $eventSortField = 'id_0';
        $eventsSortOrder = 'DESC';
        $filterPastEventsSql = '(p0_.past2 = 1)';
    } else {
        $filterPastEvents = 0;
    }
    l_m(__FILE__ . ' +' . __LINE__ . ' $filterPastEvents: ' . var_export($filterPastEvents, true) . PHP_EOL);
    l_m(__FILE__ . ' +' . __LINE__ . ' $filterPastEventsSql: ' . var_export($filterPastEventsSql, true) . PHP_EOL);
    //
    if (isset($_REQUEST['limit'])) {
        $limit = intval($_REQUEST['limit']);
    } else {
        $limit = 24; // Default limit value
    }
    l_m(__FILE__ . ' +' . __LINE__ . ' $limit: ' . var_export($limit, true) . PHP_EOL);
    //
    if (isset($_REQUEST['page'])) {
        $page = intval($_REQUEST['page']);
        $offset = ($page - 1) * $limit;
    } else {
        $page = 1;
        $offset = 0;
    }
    l_m(__FILE__ . ' +' . __LINE__ . ' $page: ' . var_export($page, true) . PHP_EOL);
    l_m(__FILE__ . ' +' . __LINE__ . ' $offset: ' . var_export($offset, true) . PHP_EOL);
    //
    if (isset($_REQUEST['action'])
        && ($_REQUEST['action'] == 'home')
    ) { // Get events for home page action
        $query = "SELECT SQL_CALC_FOUND_ROWS DISTINCT id_0 FROM (SELECT p0_.id AS id_0, p0_.sort1 AS sort_1, p0_.past2 AS past_2, p0_.h1 AS h1_1, p0_.status AS status_2, p0_.deleted AS deleted_3, p0_.published AS published_4, p0_.short_text AS short_text_5, p0_.subpath AS subpath_6, p0_.created AS created_7, p0_.updated AS updated_8, p0_.attr AS attr_9, p0_.class AS class_10, p0_.image_id AS image_id_11, p0_.user_id AS user_id_12, p0_.route_id AS route_id_13, p0_.parent_id AS parent_id_14 FROM Page p0_ WHERE ({$filterPastEventsSql}) AND (p0_.route_id = {$routeId}) AND p0_.class IN ('16') ORDER BY {$eventSortField} {$eventsSortOrder}) alias1 LIMIT 4 OFFSET 0 ";
        l_m(__FILE__ . ' +' . __LINE__ . ' SQL: ' . $query . PHP_EOL);
        $res2 = $db->query($query);
        // l_m( __FILE__ . ' +' . __LINE__ . ' Result: ' . var_export($res2, true) . PHP_EOL );
        //
        $query = "SELECT FOUND_ROWS()";
        l_m(__FILE__ . ' +' . __LINE__ . ' SQL: ' . $query);
        $res322 = $db->query($query);
        l_m(__FILE__ . ' +' . __LINE__ . ' Result322: ' . var_export($res322, true));
        //
        //
        $pageId = [];
        if (!empty($res2) && is_array($res2)) {
            foreach ($res2 as $r9) {
                $pageId[] = $r9['id_0'];
            }
        }
        l_m(__FILE__ . ' +' . __LINE__ . ' $pageId: ' . var_export($pageId, true) . PHP_EOL);
        if (!empty($pageId)) {
            $idsList = implode(',', $pageId);
            $query = "SELECT t0.id AS id_1, t0.sort1 AS sort_1, t0.past2 AS past_2, t0.h1 AS h1_2, t0.status AS status_3, t0.deleted AS deleted_4, t0.published AS published_5, t0.short_text AS short_text_6, t0.subpath AS subpath_7, t0.created AS created_8, t0.updated AS updated_9, t0.attr AS attr_10, t0.image_id AS image_id_11, t0.user_id AS user_id_12, t0.route_id AS route_id_13, t0.parent_id AS parent_id_14, t16.views AS views_15, t16.rating AS rating_17, t16.page_id AS page_id_18, t20.title AS title_19, t20.keywords AS keywords_21, t20.description AS description_22, t20.page_id AS page_id_23, t0.class, t30.url AS page_url_30 " .
                " FROM Page t0 " .
                " LEFT JOIN Analytics_Page t16 ON t16.page_id = t0.id " .
                " LEFT JOIN Metadata t20 ON t20.page_id = t0.id " .
                " LEFT JOIN PagePart t30 ON t30.id = t0.image_id AND t30.type = '4' " .
                " WHERE t0.id IN ({$idsList}) AND t0.status = '1' " .
                " ORDER BY sort_1 ASC";
            // l_m(__FILE__ . ' +' . __LINE__ . ' SQL: ' . $query . PHP_EOL);
            $res3 = $db->query($query);
            // l_m( __FILE__ . ' +' . __LINE__ . ' Result: ' . var_export($res3, true) . PHP_EOL );
            if (!empty($res3) && is_array($res3)) {
                //
                /*
                foreach ($res3 as &$r8) {
                    $attr = json_decode($r8['attr_10'], true);
                    $r8['attr'] = $attr;
                }
                l_m( __FILE__ . ' +' . __LINE__ . ' Result before sort: ' . var_export($r8, true) . PHP_EOL );
                uksort($r8, function ($a, $b) use ($order) {
                    $posA = array_search($a['attr']['attr8'], $order);
                    $posB = array_search($b['attr']['attr8'], $order);
                    return $posA - $posB;
                });
                l_m( __FILE__ . ' +' . __LINE__ . ' Result after sort: ' . var_export($r8, true) . PHP_EOL );
                */
                //
                $num = 1;
                $resHmtl .= '';
                
                foreach ($res3 as $r7) {
                    
                    // l_m(__FILE__ . ' +' . __LINE__ . ' Result: ' . var_export($r7, true) . PHP_EOL);
                    $imgHtml = '';
                    if (isset($r7['page_url_30']) && !empty($r7['page_url_30'])) {
                        $imgHtml = '<a href="/tools/events/' . $r7['subpath_7'] . '"><img class="" data-src="/img/thumbup.120.90' . $r7['page_url_30'] . '" alt="' . $r7['title_19'] . '" src="' . $r7['page_url_30'] . '"></a>';
                    }
                    $attr = json_decode($r7['attr_10'], true);
                    // l_m( __FILE__ . ' +' . __LINE__ . ' Attributes: ' . var_export($attr, true) . PHP_EOL );
                    //
                    $catHtml = '';
                    if (isset($attr['attr9']) && !empty($attr['attr9'])) {
                        $catHtml = '<div class="category"><img src="/i/pers.png" alt="">' . $attr['attr9'] . '</div>';
                    }
                    $dateHtml = '';
                    if (isset($attr['attr7']) && !empty($attr['attr7']) && isset($attr['attr8']) && !empty($attr['attr8'])) {
                        $format = 'H:i';
                        $format1 = 'd.m.Y';
                        $formatDay = date('d', (int)$attr['attr7']);
                        $formatMonth = date('M', (int)$attr['attr7']);
                        if ($lang == 'ru') {
                            $month = [
                                'Jan' => 'Январь',
                                'Feb' => 'Февраль',
                                'Mar' => 'Март',
                                'Apr' => 'Апрель',
                                'May' => 'Май',
                                'Jun' => 'Июнь',
                                'Jul' => 'Июль',
                                'Aug' => 'Август',
                                'Sep' => 'Сентябрь',
                                'Oct' => 'Октябрь',
                                'Nov' => 'Ноябрь',
                                'Dec' => 'Декабрь',
                            ];
                            if (isset($month[$formatMonth]) && !empty($month[$formatMonth])) {
                                $formatMonth = $month[$formatMonth];
                            }
                        }
                        $dt = date($format, (int)$attr['attr7']);
                        $dt1 = date($format1, (int)$attr['attr7']);
                        $dt2 = date($format, (int)$attr['attr8']);
                        $dateHtml = '<div class="date">' .
                            '<span><img src="/i/calendar.png"> ' . $dt1 . '</span>' .
                            '<span><img src="/i/clock.png"> ' . $dt . ' - ' . $dt2 . '</span>' .
                            '</div>';
                    }
                    // $resHmtl .= '<div class="cell small-12 medium-6 large-6 cell-num-' . $num . '">
                    //                 <div class="event">
                    //                     <div class="img">' .$imgHtml . '</div>
                    //                     <div class="content">
                    //                     <h5><a href="/tools/events/' . $r7['subpath_7'] . '">' . $r7['description_22'] . '</a></h5>
                    //                     ' . $dateHtml . '
                    //                     ' . $catHtml . '
                    //                     </div>
                    //                 </div>
                    //             </div>';

                    // <img class="lazyimg cards__img" data-src="/img/thumbup.120.90/' . $r7['page_url_30'] . '" alt="' . $r7['title_19'] . '" src="/img/thumbup.120.90/' . $r7['page_url_30'] . '">
                    
                    $resHmtl .= '
                    <a href="/tools/events/' . $r7['subpath_7'] . '" class="cards__item event mb-4">
                        <div class="event__date">
                            <div class="event__day font-semibold">' . $formatDay . '</div>
                            <div class="event__month">' . $formatMonth . '</div>
                        </div>                 
                        <img class="lazyload cards__img desktop-only" data-src="/img/thumbup.236.170/' . $r7['page_url_30'] . '" alt="' . $r7['title_19'] . '" src="/img/thumbup.120.9/' . $r7['page_url_30'] . '">
                        <div class="cards__img-wrapper mobile-only">
                            <picture>
                                <source media="(min-width:400px)" srcset="/img/thumbup.472.340/' . $r7['page_url_30'] . '">
                                <source media="(min-width:600px)" srcset="/img/thumbup.600.400/' . $r7['page_url_30'] . '">
                                <source media="(min-width:1024px)" srcset="/img/thumbup.120.90/' . $r7['page_url_30'] . '">
                                <img class="cards__img" src="/img/thumbup.375.275/' . $r7['page_url_30'] . '" alt="' . $r7['title_19'] . '">
                            </picture>  
                        </div>

                        <div class="desktop-ml-4 desktop-mr-4">
                            <h2 class="cards__title ine-clamp line-clamp--1" itemprop="headline">' . $r7['title_19'] . '</h2>
                            <div itemprop="description" class="the_shorttext line-clamp line-clamp--2">' . $r7['description_22'] . '</div>
                        </div>
                    </a>';
                    $num++;
                }
                $resHmtl .= '';
            }
        }
    } elseif (isset($_REQUEST['action']) && ($_REQUEST['action'] == 'events')) {
        // Get events for events section page

        /*
        $eventSortField = 'sort_1';
        $eventsSortOrder = 'ASC';
        if (isset($_REQUEST['past'])) {
            $filterPastEvents = 1;
            $eventSortField = 'id_0';
            $eventsSortOrder = 'DESC';
        } else {
            $filterPastEvents = 0;
        }
        l_m(__FILE__ . ' +' . __LINE__ . ' $filterPastEvents: ' . var_export($filterPastEvents, true) . PHP_EOL);
        */
        //
        /*
        if (isset($_REQUEST['limit'])) {
            $limit = intval($_REQUEST['limit']);
        } else {
            $limit = 24;
        }
        l_m(__FILE__ . ' +' . __LINE__ . ' $limit: ' . var_export($limit, true) . PHP_EOL);
        */
        //
        $numPages = 0;
        l_m(__FILE__ . ' +' . __LINE__ . ' @ts $numPages: ' . var_export($numPages, true) . PHP_EOL);
        //
        // $query = "SELECT DISTINCT id_0 FROM (SELECT p0_.id AS id_0, p0_.sort1 AS sort_1, p0_.past2 AS past_2, p0_.h1 AS h1_1, p0_.status AS status_2, p0_.deleted AS deleted_3, p0_.published AS published_4, p0_.short_text AS short_text_5, p0_.subpath AS subpath_6, p0_.created AS created_7, p0_.updated AS updated_8, p0_.attr AS attr_9, p0_.class AS class_10, p0_.image_id AS image_id_11, p0_.user_id AS user_id_12, p0_.route_id AS route_id_13, p0_.parent_id AS parent_id_14 FROM Page p0_ WHERE ({$filterPastEventsSql}) AND (p0_.route_id = 29) AND p0_.class IN ('16') ORDER BY {$eventSortField} {$eventsSortOrder}) alias1 LIMIT {$limit} OFFSET {$offset} ";
        $query = "SELECT SQL_CALC_FOUND_ROWS DISTINCT p0_.id AS id_0, p0_.sort1 AS sort_1, p0_.past2 AS past_2, p0_.h1 AS h1_1, p0_.status AS status_2, p0_.deleted AS deleted_3, p0_.published AS published_4, p0_.short_text AS short_text_5, p0_.subpath AS subpath_6, p0_.created AS created_7, p0_.updated AS updated_8, p0_.attr AS attr_9, p0_.class AS class_10, p0_.image_id AS image_id_11, p0_.user_id AS user_id_12, p0_.route_id AS route_id_13, p0_.parent_id AS parent_id_14 FROM Page p0_ WHERE ({$filterPastEventsSql}) AND (p0_.route_id = {$routeId}) AND p0_.class IN ('16') ORDER BY {$eventSortField} {$eventsSortOrder} LIMIT {$limit} OFFSET {$offset} ";
        l_m(__FILE__ . ' +' . __LINE__ . ' SQL: ' . $query . PHP_EOL);
        $res2 = $db->query($query);
        // l_m( __FILE__ . ' +' . __LINE__ . ' Result: ' . var_export($res2, true) . PHP_EOL );
        //
        $query = "SELECT FOUND_ROWS() AS num_events";
        l_m(__FILE__ . ' +' . __LINE__ . ' SQL: ' . $query);
        $res312 = $db->query($query);
        l_m(__FILE__ . ' +' . __LINE__ . ' Result312: ' . var_export($res312, true));
        //
        $pageId = [];
        if (!empty($res2) && is_array($res2)) {
            foreach ($res2 as $r9) {
                $pageId[] = $r9['id_0'];
            }
        }
        if (!empty($pageId)) {
            $idsList = implode(',', $pageId);
            $query = "SELECT t0.id AS id_1, t0.sort1 AS sort_1, t0.past2 AS past_2, t0.h1 AS h1_2, t0.status AS status_3, t0.deleted AS deleted_4, t0.published AS published_5, t0.short_text AS short_text_6, t0.subpath AS subpath_7, t0.created AS created_8, t0.updated AS updated_9, t0.attr AS attr_10, t0.image_id AS image_id_11, t0.user_id AS user_id_12, t0.route_id AS route_id_13, t0.parent_id AS parent_id_14, t16.views AS views_15, t16.rating AS rating_17, t16.page_id AS page_id_18, t20.title AS title_19, t20.keywords AS keywords_21, t20.description AS description_22, t20.page_id AS page_id_23, t0.class, t30.url AS page_url_30 " .
                " FROM Page t0 " .
                " LEFT JOIN Analytics_Page t16 ON t16.page_id = t0.id " .
                " LEFT JOIN Metadata t20 ON t20.page_id = t0.id " .
                " LEFT JOIN PagePart t30 ON t30.id = t0.image_id AND t30.type = '4' " .
                " WHERE t0.id IN ({$idsList}) AND t0.status = '1' " .
                " ORDER BY t0.sort1 {$eventsSortOrder}";
            l_m(__FILE__ . ' +' . __LINE__ . ' SQL: ' . $query . PHP_EOL);
            $res3 = $db->query($query);
            // l_m( __FILE__ . ' +' . __LINE__ . ' Result: ' . var_export($res3, true) . PHP_EOL );
            if (!empty($res3) && is_array($res3)) {
                //
                foreach ($res3 as &$r8) {
                    $attr = json_decode($r8['attr_10'], true);
                    $r8['attr'] = $attr;
                }
                //
                /* l_m( __FILE__ . ' +' . __LINE__ . ' Result before sort: ' . var_export($r8, true) . PHP_EOL );
                uksort($r8, function ($a, $b) use ($order) {
                    $posA = array_search($a['attr']['attr8'], $order);
                    $posB = array_search($b['attr']['attr8'], $order);
                    return $posA - $posB;
                });
                l_m( __FILE__ . ' +' . __LINE__ . ' Result after sort: ' . var_export($r8, true) . PHP_EOL ); */
                //
                $showPager = false;
                $num = 1;
                $resHmtl .= '<!-- @ts limit: ' . var_export($limit, true) . ' -->' . PHP_EOL;
                $resHmtl .= '<!-- @ts page: ' . var_export($page, true) . ' -->' . PHP_EOL;
                $resHmtl .= '<!-- @ts offset: ' . var_export($offset, true) . ' -->' . PHP_EOL;
                if (isset($res312[0]['num_events'])) {
                    $resHmtl .= '<!-- @ts num events: ' . var_export($res312[0]['num_events'], true) . ' -->' . PHP_EOL;

                    $numPages = ceil($res312[0]['num_events'] / $limit);
                    $resHmtl .= '<!-- @ts num pages: ' . var_export($numPages, true) . ' -->' . PHP_EOL;
                    if ($numPages > 1) {
                        $showPager = true;
                    }
                }
                $resHmtl .= '<!-- @ts show pager: ' . var_export($showPager, true) . ' -->' . PHP_EOL;
                $resHmtl .= '';
                $itemNo = 0;
                foreach ($res3 as $r7) {
                    $itemNo++;
                    $lastItem = false;
                    if ($limit == $itemNo) {
                        $lastItem = true;
                    }
                    $linkAttributes = '';
                    $nextPageUrl = increment_page_param($_SERVER['REQUEST_URI']);
                    if ($lastItem) {
                        $linkAttributes = 'hx-get="' . $nextPageUrl . '" hx-trigger="revealed" hx-indicator="#spinner" hx-swap="afterend"';
                    }
                    // l_m(__FILE__ . ' +' . __LINE__ . ' Result: ' . var_export($r7, true) . PHP_EOL);
                    $imgHtml = '';
                    if (isset($r7['page_url_30']) && !empty($r7['page_url_30'])) {
                        $imgHtml = '<a href="/tools/events/' . $r7['subpath_7'] . '"><img class="" data-src="/img/thumbup.120.90/' . $r7['page_url_30'] . '" alt="' . $r7['title_19'] . '" src="/img/thumbup.120.90/' . $r7['page_url_30'] . '"></a>';
                    }
                    $attr = json_decode($r7['attr_10'], true);
                    // l_m( __FILE__ . ' +' . __LINE__ . ' Attributes: ' . var_export($attr, true) . PHP_EOL );
                    //
                    $catHtml = '';
                    if (isset($attr['attr9']) && !empty($attr['attr9'])) {
                        $catHtml = '<div class="category"><img src="/i/pers.png" alt="">' . $attr['attr9'] . '</div>';
                    }
                    $dateHtml = '';
                    if (isset($attr['attr7']) && !empty($attr['attr7']) && isset($attr['attr8']) && !empty($attr['attr8'])) {
                        $format = 'H:i';
                        $format1 = 'd.m.Y';
                        $formatDay = date('d', (int)$attr['attr7']);
                        $formatMonth = date('M', (int)$attr['attr7']);
                        if ($lang == 'ru') {
                            $month = [
                                'Jan' => 'Январь',
                                'Feb' => 'Февраль',
                                'Mar' => 'Март',
                                'Apr' => 'Апрель',
                                'May' => 'Май',
                                'Jun' => 'Июнь',
                                'Jul' => 'Июль',
                                'Aug' => 'Август',
                                'Sep' => 'Сентябрь',
                                'Oct' => 'Октябрь',
                                'Nov' => 'Ноябрь',
                                'Dec' => 'Декабрь',
                            ];
                            if (isset($month[$formatMonth]) && !empty($month[$formatMonth])) {
                                $formatMonth = $month[$formatMonth];
                            }
                        }
                        $dt = date($format, (int)$attr['attr7']);
                        $dt1 = date($format1, (int)$attr['attr7']);
                        $dt2 = date($format, (int)$attr['attr8']);
                        $dateHtml = '<div class="date">' .
                            '<span><img src="/i/calendar.png"> ' . $dt1 . '</span>' .
                            '<span><img src="/i/clock.png"> ' . $dt . ' - ' . $dt2 . '</span>' .
                            '</div>';
                    }
                    // $resHmtl .= '<div class="cell small-12 medium-6 large-6 cell-num-' . $num . '">
                    //                 <div class="event">
                    //                     <div class="img">' .$imgHtml . '</div>
                    //                     <div class="content">
                    //                     <h5><a href="/tools/events/' . $r7['subpath_7'] . '">' . $r7['description_22'] . '</a></h5>
                    //                     ' . $dateHtml . '
                    //                     ' . $catHtml . '
                    //                     </div>
                    //                 </div>
                    //             </div>';

                    $resHmtl .= '
                    <a href="/tools/events/' . $r7['subpath_7'] . '" ' . $linkAttributes . ' class="cards__item event mb-4">
                        <div class="event__date past__event' . $r7['past_2'] . '">
                            <div class="event__day font-semibold">' . $formatDay . '</div>
                            <div class="event__month">' . $formatMonth . '</div>
                        </div>
                        <img class="cards__img desktop-only" src="/img/thumbup.120.90/' . $r7['page_url_30'] . '">
                        <div class="cards__img-wrapper mobile-only">
                            <picture>
                                <source media="(min-width:400px)" srcset="/img/thumbup.472.340/' . $r7['page_url_30'] . '">
                                <source media="(min-width:600px)" srcset="/img/thumbup.600.400/' . $r7['page_url_30'] . '">
                                <source media="(min-width:1024px)" srcset="/img/thumbup.120.90/' . $r7['page_url_30'] . '">
                                <img class="cards__img" src="/img/thumbup.375.275/' . $r7['page_url_30'] . '">
                            </picture>    
                        </div>

                        <div class="desktop-ml-4 desktop-mr-4">
                            <h2 class="cards__title ine-clamp line-clamp--1" itemprop="headline">' . $r7['title_19'] . '</h2>
                            <div itemprop="description" class="the_shorttext line-clamp line-clamp--2">' . $r7['description_22'] . '</div>
                        </div>
                    </a>';
                    $num++;
                }
                $resHmtl .= '';
                // if ($showPager) {
                //     // TODO: show pager for events here
                //     $resHmtl .= build_pager($page, $numPages, 5);
                // }
            }
        }
    }
}
//
if (!headers_sent()) {
    header('Access-Control-Allow-Origin: *');
    header('Content-Type: text/html; charset=utf-8');
}
die($resHmtl);
