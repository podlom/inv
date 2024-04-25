<?php

/**
 * Created by PhpStorm
 * User: shtaras
 * Date: 2024-03-08
 * Time: 20:23
 * Modified: 2024-03-22 14:07
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
    //
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
    //
    // $msg = __FILE__ . ' +' . __LINE__ . ' $_SERVER HTTP_USER_AGENT: ' . var_export($_SERVER['HTTP_USER_AGENT'], true);
    // l_m($msg);
    //
    $msg = __FILE__ . ' +' . __LINE__ . ' $_GET: ' . var_export($_GET, true) . '; $_POST: ' . var_export($_POST, true) . '; $_REQUEST: ' . var_export($_REQUEST, true);
    l_m($msg);
    //
    $categorySqlValue = '';
    if (isset($_REQUEST['category']) && !empty($_REQUEST['category'])) {
        $category = $_REQUEST['category'];
        $msg = __FILE__ . ' +' . __LINE__ . ' @ts $category: ' . var_export($category, true);
        l_m($msg);
        //
        if ($lang == 'ru') {
            /**
             * category_title    parent_id
             * Инвестиционная, финансовая и бизнес аналитика Украина    20
             * Рейтинги Украины: инвестиции, компании, инвесторы, бизнес    23
             * Интервью с инвесторами, бизнесменами и предпринимателями    74
             * Статьи об инвестициях и бизнесе в Украине    11608
             * Инвестируем в Украину | We invest in Ukraine    14597
             */

            if ($category == 'investments') {
                // $categorySqlValue = ' WHERE `category_title` = "Инвестиционная, финансовая и бизнес аналитика Украина" ';
                $categorySqlValue = ' WHERE `parent_id` = "20" ';
            } elseif ($category == 'database') {
                // $categorySqlValue = ' WHERE `category_title` = "Рейтинги Украины: инвестиции, компании, инвесторы, бизнес" ';
                $categorySqlValue = ' WHERE `parent_id` = "23" ';
            } elseif ($category == 'formula') {
                // $categorySqlValue = ' WHERE `category_title` = "Интервью с инвесторами, бизнесменами и предпринимателями" ';
                $categorySqlValue = ' WHERE `parent_id` = "74" ';
            } elseif ($category == 'articles') {
                // $categorySqlValue = ' WHERE `category_title` = "Статьи об инвестициях и бизнесе в Украине" ';
                $categorySqlValue = ' WHERE `parent_id` = "11608" ';
            } elseif ($category == 'we-invest-in-ukraine') {
                // $categorySqlValue = ' WHERE `category_title` = "Инвестируем в Украину | We invest in Ukraine" ';
                $categorySqlValue = ' WHERE `parent_id` = "14597" ';
            }
        } elseif ($lang == 'uk') {
            if ($category == 'investments') {
                $categorySqlValue = ' WHERE `category_title` = "Інвестиційна аналітика та економічні дослідження" ';
            } elseif ($category == 'database') {
                $categorySqlValue = ' WHERE `category_title` = "Інструментарій інвестора" ';
            } elseif ($category == 'formula') {
                $categorySqlValue = ' WHERE `category_title` = "Інтерв\'ю з інвесторами, бізнесменами та підприємцями" ';
            } elseif ($category == 'articles') {
                $categorySqlValue = ' WHERE `category_title` = "Статті про інвестиції в Україні" ';
            } elseif ($category == 'we-invest-in-ukraine') {
                $categorySqlValue = ' WHERE `category_title` = "Інвестуємо в Україну | We invest in Ukraine" ';
            }
        } elseif ($lang == 'en') {
            /**
             * category_title    parent_id
             * Interviews with investors, businessmen and entrepreneurs    9788
             * Investment, economic, marketing research in Ukraine    9789
             * Articles about investments and business in Ukraine    11946
             * Investing in Ukraine | We invest in Ukraine    15073
             * Ratings and rankings of Ukraine: investments, companies, investors, business    15077
             */

            if ($category == 'investments') {
                // $categorySqlValue = ' WHERE `category_title` = "Investment, economic, marketing research in Ukraine" ';
                $categorySqlValue = ' WHERE `parent_id` = "9789" ';
            } elseif ($category == 'database') {
                // $categorySqlValue = ' WHERE `category_title` = "Investor Toolkit" ';
                $categorySqlValue = ' WHERE `parent_id` = "15077" ';
            } elseif ($category == 'formula') {
                // $categorySqlValue = ' WHERE `category_title` = "Interviews with investors, businessmen and entrepreneurs" ';
                $categorySqlValue = ' WHERE `parent_id` = "9788" ';
            } elseif ($category == 'articles') {
                // $categorySqlValue = ' WHERE `category_title` = "Articles about investments and business in Ukraine" ';
                $categorySqlValue = ' WHERE `parent_id` = "11946" ';
            } elseif ($category == 'we-invest-in-ukraine') {
                // $categorySqlValue = ' WHERE `category_title` = "Investing in Ukraine | We invest in Ukraine" ';
                $categorySqlValue = ' WHERE `parent_id` = "15073" ';
            }
        }
    }
    $msg = __FILE__ . ' +' . __LINE__ . ' @ts $categorySqlValue: ' . var_export($categorySqlValue, true);
    l_m($msg);
    //
    if (isset($_REQUEST['action']) && ($_REQUEST['action'] == 'analytics-list')) { // Get events for home page action
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

        $query = "SELECT SQL_CALC_FOUND_ROWS * FROM analytics_{$lang} {$categorySqlValue} LIMIT {$limit} OFFSET {$offset} ";
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
        $nextPage = $page + 1;
        $itemNo = 0;

        $resHmtl .= '';
        if (!empty($res2) && is_array($res2)) {
            foreach ($res2 as $r9) {
                $itemNo ++;
                //
                if ($r9['category_title'] == 'Инвестиционная, финансовая и бизнес аналитика Украина') {
                    $categoryUrl = '/analytics/investments';
                } elseif ($r9['category_title'] == 'Рейтинги Украины: инвестиции, компании, инвесторы, бизнес') {
                    $categoryUrl = '/tools/database';
                } elseif ($r9['category_title'] == 'Интервью с инвесторами, бизнесменами и предпринимателями') {
                    $categoryUrl = '/analytics/formula';
                } elseif ($r9['category_title'] == 'Статьи об инвестициях и бизнесе в Украине') {
                    $categoryUrl = '/analytics/articles';
                } elseif ($r9['category_title'] == 'Инвестируем в Украину | We invest in Ukraine') {
                    $categoryUrl = '/analytics/we-invest-in-ukraine';

                } elseif ($r9['category_title'] == 'Інвестиційна аналітика та економічні дослідження') {
                    $categoryUrl = '/uk/analytics/investments';
                } elseif ($r9['category_title'] == 'Інтерв\'ю з інвесторами, бізнесменами та підприємцями') {
                    $categoryUrl = '/uk/analytics/formula';
                } elseif ($r9['category_title'] == 'Статті про інвестиції в Україні') {
                    $categoryUrl = '/uk/analytics/articles';
                } elseif ($r9['category_title'] == 'Інвестуємо в Україну | We invest in Ukraine') {
                    $categoryUrl = '/uk/analytics/we-invest-in-ukraine';
                } elseif ($r9['category_title'] == 'Рейтинги Україна: інвестиції, компанії, інвестори, бізнес') {
                    $categoryUrl = '/uk/tools/database';

                } elseif ($r9['category_title'] == 'Interviews with investors, businessmen and entrepreneurs') {
                    $categoryUrl = '/en/analytics/formula';
                } elseif ($r9['category_title'] == 'Investment, economic, marketing research in Ukraine') {
                    $categoryUrl = '/en/analytics/investments';
                } elseif ($r9['category_title'] == 'Articles about investments and business in Ukraine') {
                    $categoryUrl = '/en/analytics/articles';
                } elseif ($r9['category_title'] == 'Investing in Ukraine | We invest in Ukraine') {
                    $categoryUrl = '/en/analytics/we-invest-in-ukraine';
                } elseif ($r9['category_title'] == 'Ratings and rankings of Ukraine: investments, companies, investors, business') {
                    $categoryUrl = '/en/tools/database';

                } else {
                    $categoryUrl = '';
                }
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
                    '<img class="cards__img" itemprop="image" src="/img/thumb.350.254' . $r9['picture_url'] . '" data-src="/img/thumb.350.254' . $r9['picture_url'] . '" alt="Stonepeak привлекает $3,3 млрд для своего первого инфраструктурного фонда ориентированного на Азию" itemscope="" itemtype="http://schema.org/ImageObject"> </div> ' .
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

    }

}
//
if (!headers_sent()) {
    header('Access-Control-Allow-Origin: *');
    header('Content-Type: text/html; charset=utf-8');
}
die($resHmtl);
