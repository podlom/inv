<?php

(PHP_SAPI !== 'cli' || isset($_SERVER['HTTP_USER_AGENT'])) && die(' +' . __LINE__ . ' PHP Fatal Error: cli only usage allowed.' . PHP_EOL);

/**
 * Created by PhpStorm
 * User: shtaras
 * Date: 2020-08-06
 * Time: 13:35
 * Modified: 2024-05-01 22:04
 *
 * @author Taras Shkodenko <taras@shkodenko.com>
 */

require_once 'lib/db.class.php';


try {
    require_once 'config' . DIRECTORY_SEPARATOR . 'inv-prod-settings.php';
    $db = new DB(INV_PROD_DBHOST, INV_PROD_DBUSER, INV_PROD_DBPASS, INV_PROD_DBNAME);

    $pastEvents = $currEvents = 0;
    $curTime = time();

    $query = "SELECT DISTINCT id_0, attr_9, sort_1, past_2 FROM (
SELECT p0_.id AS id_0, p0_.sort1 AS sort_1, p0_.past2 AS past_2, p0_.h1 AS h1_1, p0_.status AS status_2, p0_.deleted AS deleted_3, p0_.published AS published_4, p0_.short_text AS short_text_5, p0_.subpath AS subpath_6, p0_.created AS created_7, p0_.updated AS updated_8, p0_.attr AS attr_9, p0_.class AS class_10, p0_.image_id AS image_id_11, p0_.user_id AS user_id_12, p0_.route_id AS route_id_13, p0_.parent_id AS parent_id_14 FROM Page p0_ WHERE ((p0_.route_id = 29) OR (p0_.route_id = 7542) OR (p0_.route_id = 7362)) AND p0_.class IN ('16')
) dctrn_result_inner ORDER BY id_0 DESC";
    $res19 = $db->query($query);
    if (!empty($res19) && is_array($res19)) {
        foreach ($res19 as $r) {
            echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' DB result: ' . var_export($r, true) . PHP_EOL;
            $d = json_decode($r['attr_9'], true);
            echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Current time: ' . var_export($curTime, true) . ' Attributes data: ' . var_export($d, true) . PHP_EOL;
            $sort1 = 0;
            if (isset($d['attr7']) && ($d['attr7'] > 0)) {
                $sort1 = $d['attr7'];
            }
            if (isset($d['attr8']) && ($d['attr8'] <= $curTime)) {
                $past2 = 1;
                $pastEvents ++;
            } else {
                $past2 = 0;
                $currEvents ++;
            }
            $query = "UPDATE Page SET `sort1` = '{$sort1}', `past2` = '{$past2}' WHERE `id` = '{$r['id_0']}'";
            echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' SQL: ' . $query . PHP_EOL;
            $res20 = $db->query($query);
        }
    }
    echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Past events: ' . $pastEvents . ' ; Current events: ' . $currEvents . PHP_EOL;

} catch (\Exception $e) {
    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Fatal error: ' . $e->getMessage() . PHP_EOL;
    die($msg);
}