<?php

(PHP_SAPI !== 'cli' || isset($_SERVER['HTTP_USER_AGENT'])) && die(' +' . __LINE__ . ' PHP Fatal Error: cli only usage allowed.' . PHP_EOL);

/**
 * Created by PhpStorm
 * User: shtaras
 * Date: 11/1/19
 * Time: 16:07
 *
 * @author Taras Shkodenko <ts@doagency.net>
 */

require_once 'lib/db.class.php';


try {
    require_once 'config' . DIRECTORY_SEPARATOR . 'inv-prod-settings.php';
    $db = new DB(INV_PROD_DBHOST, INV_PROD_DBUSER, INV_PROD_DBPASS, INV_PROD_DBNAME);

    $query = "select id, attr from Page where (attr like '%\"attr13\":_,%' or attr like '%\"attr13\":10,%')";
    $res19 = $db->query($query);
    if (!empty($res19) && is_array($res19)) {
        foreach ($res19 as $r) {
            // echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' DB result: ' . var_export($r, true) . PHP_EOL;
            $d = json_decode($r['attr'], true);
            // echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' New rating data: ' . var_export($d['attr13'], true) . PHP_EOL;
            $query = "UPDATE Page SET `rating` = '{$d['attr13']}' WHERE `id` = '{$r['id']}'";
            echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' SQL: ' . $query . PHP_EOL;
            $res20 = $db->query($query);
            $query = "UPDATE Analytics_Page SET `rating` = '{$d['attr13']}' WHERE `page_id` = '{$r['id']}'";
            echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' SQL: ' . $query . PHP_EOL;
            $res21 = $db->query($query);
        }
    }

} catch (\Exception $e) {
    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Fatal error: ' . $e->getMessage() . PHP_EOL;
    die($msg);
}