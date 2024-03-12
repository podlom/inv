<?php

/**
 * Created by PhpStorm
 * User: shtaras
 * Date: 2024-03-08
 * Time: 19:25
 * Modified: 2024-03-09 11:01
 *
 * @author Taras Shkodenko <taras@shkodenko.com>
 */

function l_m(string $msg)
{
    $logFileName = dirname(__FILE__) . '/news.log';
    if (!file_exists($logFileName)) {
        touch($logFileName);
        chmod($logFileName, 0666);
    }
    // IP: 193.0.217.7 - Kyiv - Volodymyra Ivasyuka 24-a
    // IP: 176.37.192.192 - Kyiv - Rollhouse cafe
    // IP: 185.143.147.154 - Kyiv - Kreshchatyk, 25 hall
    if (is_writeable($logFileName) && isset($_SERVER['HTTP_CF_CONNECTING_IP']) && ($_SERVER['HTTP_CF_CONNECTING_IP'] == '193.0.217.97')) {
        error_log(date('r') . ' ' . $msg . PHP_EOL, 3, $logFileName);
    }

    // Do not log if client IP does not match list below
    if (($_SERVER['REMOTE_ADDR'] !== '185.11.28.246') // @ts 2021-02-25; ISP Best; Grand Villas; home
        && ($_SERVER['REMOTE_ADDR'] !== '178.214.193.98') // InVenture office; Kyiv
        && ($_SERVER['REMOTE_ADDR'] !== '176.106.0.146') // Ilmolino Saksaganskogo str. 120; Kyiv
        && ($_SERVER['REMOTE_ADDR'] !== '185.143.147.154') // Kreshchatyk str. 25; Kyiv
        && ($_SERVER['REMOTE_ADDR'] !== '193.0.217.97') // Volodymyra Ivasyuka ave. 24-a; Kyiv
    ) {
        // error_log(__FILE__ . ' +' . __LINE__ . ' ' . __FUNCTION__ . ' log to file is disabled for client IP: ' . $_SERVER['REMOTE_ADDR']);
        return false;
    } else {
        if (is_writeable($logFileName)) {
            error_log(date('r') . ' ' . $msg . PHP_EOL, 3, $logFileName);
        }
    }
}

function increment_page_param(string $url) : string
{
    // Розділити URL на шлях та параметри
    $parts = parse_url($url);
    $query = isset($parts['query']) ? $parts['query'] : '';
    parse_str($query, $params);

    // Перевірити, чи існує параметр 'page'
    if (isset($params['page'])) {
        // Збільшити значення параметра 'page' на 1
        $params['page']++;

        // Побудувати новий рядок запиту
        $new_query = http_build_query($params);

        // Побудувати новий URL
        $new_url = $parts['path'] . '?' . $new_query;

        // Перевірити, чи є які-небудь інші параметри та додати їх до нового URL, якщо так
        if (isset($parts['fragment'])) {
            $new_url .= '#' . $parts['fragment'];
        }

        return $new_url;
    }

    // Якщо параметр 'page' не знайдено, повернути той самий URL
    return $url;
}


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
    if (isset($_REQUEST['action']) && ($_REQUEST['action'] == 'news-list')) { // Get events for home page action
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

        $query = "SELECT SQL_CALC_FOUND_ROWS * FROM news_{$lang} LIMIT {$limit} OFFSET {$offset} ";
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
                if ($r9['category_title'] == 'Новости инвестиций Украины') {
                    $categoryUrl = '/news/ukraine';
                } elseif ($r9['category_title'] == 'Новости инвестиций мира') {
                    $categoryUrl = '/news/world';
                } elseif ($r9['category_title'] == 'Новини інвестицій України') {
                    $categoryUrl = '/uk/news/ukraine';
                } elseif ($r9['category_title'] == 'Світові новини інвестицій') {
                    $categoryUrl = '/uk/news/world';
                } elseif ($r9['category_title'] == 'News in Ukraine') {
                    $categoryUrl = '/en/news/ukraine';
                } elseif ($r9['category_title'] == 'World news') {
                    $categoryUrl = '/en/news/world';
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
                $resHmtl .= '<div ' . $linkAttributes . '  data-item-no="' . $itemNo . '" itemprop="itemListElement" itemscope="" itemtype="http://schema.org/Article">' .
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
