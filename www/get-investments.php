<?php

/**
 * Created by PhpStorm
 * User: shtaras
 * Date: 10/1/19
 * Time: 16:04
 *
 * @author Taras Shkodenko <ts@doagency.net>
 */

function l_m($msg)
{
    $logFileName = dirname(__FILE__) . '/get-investments.log';
    if (!file_exists($logFileName)) {
        touch($logFileName);
        chmod($logFileName, 0666);
    }
    // Do not log on prod by default
    if ($_SERVER['SERVER_NAME'] === 'inventure.com.ua') {
        return false;
    }
    if (is_writeable($logFileName)) {
        error_log(date('r') . ' ' . $msg . PHP_EOL, 3, $logFileName);
    }
}

require_once '../cli/lib/db.class.php';

define('DBHOST', '127.0.0.1');
define('DBUSER', 'inventure_dev');
define('DBPASS', '[[)sq5J0mXKZ5x2E');
define('DBNAME', 'inventure_dev');

if (!empty($_GET)) {
    l_m( __FILE__ . ' +' . __LINE__ . ' $_GET: ' . var_export($_GET, true) );
}

try {
    $db = new DB(DBHOST, DBUSER, DBPASS, DBNAME);
    $query = "SET collation_connection = utf8_unicode_ci";
    $res0 = $db->query($query);
    $query = "SET NAMES utf8";
    $res1 = $db->query($query);

    if (isset($_GET['get_directories'])) {
        // region: Киев, Харьков, …  (запятой отделяем выбранные параметры с мультиселекта)
        // branch: Отрасль  (запятой отделяем выбранные параметры с мультиселекта)
        // type: Тип  (запятой отделяем выбранные параметры с мультиселекта)
        if (!headers_sent()) {
            header('Access-Control-Allow-Origin: *');
        }
        $result = [
            'region' => [
                    'Украина',
                    'СНГ',
                    'Центральная и Восточная Европа',
                    'Западная Европа',
                    'США',
                    'Азия',
                ],
            'branch' => [
                    'Сельское хозяйство',
                    'Пищевая промышленность',
                    'Добывающая промышленность',
                    'Металлургия и металлообработка',
                    'Машиностроение и производство электрооборудования',
                    'Нефтехимическая промышленность',
                    'Фармацевтическая промышленность',
                    'Деревообработка и целлюлозно-бумажная промышленность',
                    'Текстильная промышленность',
                    'Строительство и недвижимость',
                    'Финансовая деятельность',
                    'Оптовая и розничная торговля',
                    'Бизнес услуги',
                    'Транспорт и складское хозяйство',
                    'Телекоммуникации и связь',
                    'Искусство, развлечения, спорт и отдых',
                    'Электроэнергетика и топливная промышленность',
                    'Водообеспечение и переработка отходов',
                    'Информационные технологии и интернет проекты',
                    'Инновации и высокие технологии',
                    'Гостиницы и общественное питание',
                    'Здравоохранение и социальная помощь',
                    'Потребительские услуги',
                    'Образование',
                    'Организации и ассоциации',
                ],
            'type' => [
                    'Инвестиционные проекты и стартапы',
                    'Продажа бизнеса',
                    'Недвижимость',
                    'Земля',
                    'Франчайзинг',
                    'Предложения инвесторов',
                ],
        ];
        l_m( __FILE__ . ' +' . __LINE__ . ' $result: ' . var_export($result, true) );
        die(json_encode($result));
    }

    if (isset($_GET['limit'])) {
        $limit = intval($_GET['limit']);
    } else {
        $limit = 9;
    }

    if (isset($_GET['page'])) {
        $page = intval($_GET['page']);
        $offset = ($page - 1) * $limit;
    } else {
        $page = 1;
        $offset = 0;
    }

    $minPrice = $minPriceSql = '';
    if (isset($_GET['price1'])) {
        $minPrice = intval($_GET['price1']);
        if ($minPrice >= 0) {
            $minPriceSql = 'AND p0_.attr NOT LIKE "%\"attr15\":\"\"%" ';
        }
    }
    $maxPrice = $maxPriceSql = '';
    if (isset($_GET['price2'])) {
        $maxPrice = intval($_GET['price2']);
        if ($maxPrice >= 0) {
            $maxPriceSql = 'AND p0_.attr NOT LIKE "%\"attr15\":\"\"%" ';
        }
    }
    $priceSql = '';
    if (!empty($minPriceSql)) {
        $priceSql = $minPriceSql;
    } elseif (!empty($maxPriceSql)) {
        $priceSql = $maxPriceSql;
    }

    $minp = 9999999; // Минимальна цена инвестиций
    $maxp = 0; // Максимальная цена инвестиций

    $query = "SELECT SQL_CALC_FOUND_ROWS p0_.id AS id, " .
        " p0_.h1 AS h1, " .
        " p0_.status AS status, " .
        " p0_.deleted AS deleted, " .
        " p0_.published AS published, " .
        " p0_.short_text AS short_text, " .
        " p0_.subpath AS subpath, " .
        " p0_.created AS created, " .
        " p0_.updated AS updated, " .
        " p0_.attr AS attr, " .
        " p0_.class AS class, " .
        " p0_.image_id AS image_id, " .
        " p2_.url AS image_url, " .
        " p0_.user_id AS user_id, " .
        " p0_.route_id AS route_id, " .
        " p0_.parent_id AS parent_id " .
        " FROM Page p0_ " .
        " INNER JOIN Routing r1_ ON p0_.route_id = r1_.id " .
        " LEFT JOIN PagePart p2_ ON p0_.image_id = p2_.id AND p2_.type IN ('4') " .
        " LEFT JOIN Analytics_Page a3_ ON p0_.id = a3_.page_id " .
        " WHERE (r1_.path LIKE '/investments' AND p0_.status = 1) " .
        $priceSql .
        " AND p0_.class IN ('16') " .
        " ORDER BY p0_.published DESC " .
        " LIMIT {$limit} OFFSET {$offset}";
    l_m( __FILE__ . ' +' . __LINE__ . ' SQL: ' . $query );
    $res2 = $db->query($query);
    l_m( __FILE__ . ' +' . __LINE__ . ' Result: ' . var_export($res2, true) );
    $res4 = [];
    if (!empty($res2) && is_array($res2)) {
        foreach ($res2 as $a2) {
            $j2 = json_decode($a2['attr'], true);
            if (isset($j2['attr15'])) { // Price attribute found
                if (!empty($minPrice) && intval($j2['attr15']) >= $minPrice) {
                    if (intval($j2['attr15']) > $maxp) {
                        $maxp = intval($j2['attr15']);
                    }
                    if (intval($j2['attr15']) < $minp) {
                        $minp = intval($j2['attr15']);
                    }
                    $res4[] = $a2;
                    continue;
                }
                if (!empty($maxPrice) && intval($j2['attr15']) <= $maxPrice) {
                    if (intval($j2['attr15']) > $maxp) {
                        $maxp = intval($j2['attr15']);
                    }
                    if (intval($j2['attr15']) < $minp) {
                        $minp = intval($j2['attr15']);
                    }
                    $res4[] = $a2;
                }
            } else { // No price attribute found
                $res4[] = $a2;
            }
        }
    }

    $query = "SELECT FOUND_ROWS()";
    l_m( __FILE__ . ' +' . __LINE__ . ' SQL: ' . $query );
    $res3 = $db->query($query);
    l_m( __FILE__ . ' +' . __LINE__ . ' Result: ' . var_export($res3, true) );

    if (!headers_sent()) {
        header('Access-Control-Allow-Origin: *');
    }
    $result = [
        'data' => $res4,
        // 'total' => intval($res3[0]['FOUND_ROWS()']),
        'total' => count($res4),
        'limit' => $limit,
        'page' => $page,
        'minp' => $minp,
        'maxp' => $maxp,
    ];
    die(json_encode($result));

} catch (\Exception $e) {
    $res2 = [
        'result' => false,
        'message' => date('r') . ' +' . __LINE__ . ' DB connection error <!-- ' . $e->getMessage() . ' -->' . PHP_EOL,
    ];
    die(json_encode($res2));
}
