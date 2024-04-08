<?php

(PHP_SAPI !== 'cli' || isset($_SERVER['HTTP_USER_AGENT'])) && die(' +' . __LINE__ . ' PHP Fatal Error: cli only usage allowed.' . PHP_EOL);

/**
 * Created by PhpStorm
 * User: shtaras
 * Date: 9/27/19
 * Time: 14:34
 *
 * @author Taras Shkodenko <ts@doagency.net>
 */

require_once 'lib/db.class.php';


try {
    require_once 'config' . DIRECTORY_SEPARATOR . 'inv-prod-settings.php';
    $db = new DB(INV_PROD_DBHOST, INV_PROD_DBUSER, INV_PROD_DBPASS, INV_PROD_DBNAME);
    $query = "SET collation_connection = utf8_unicode_ci";
    $res0 = $db->query($query);
    $query = "SET NAMES utf8";
    $res1 = $db->query($query);

    $query = "select count(subpath), subpath from `Page` group by subpath having count(subpath) > 1";
    $res2 = $db->query($query);
    // echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Found pages with dublicate URIs: ' . var_export($res2, true) . PHP_EOL;
    if (is_array($res2) && !empty($res2)) {
        foreach ($res2 as $n2 => $a2) {
            $query = "select id, route_id, subpath from `Page` where subpath = '{$a2['subpath']}' order by id asc";
            $res3 = $db->query($query);
            // echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Found pages with dublicate URIs: ' . var_export($res3, true) . PHP_EOL;
            if (is_array($res3) && !empty($res3)) {
                foreach ($res3 as $n3 => $a3) {
                    if ($n3 > 0) {
                        echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Fix pages with dublicate URIs: ' . var_export($a3, true) . PHP_EOL;
                        $query = "update `Page` set subpath = concat(subpath, '-', id) where id = '{$a3['id']}'";
                        $res4 = $db->query($query);
                    }
                }
            }
        }
    } else {
        echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' No pages with dublicate URIs found.' . PHP_EOL;
    }

} catch (\Exception $e) {
    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Fatal error: ' . $e->getMessage() . PHP_EOL;
    die($msg);
}