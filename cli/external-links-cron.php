<?php

(PHP_SAPI !== 'cli' || isset($_SERVER['HTTP_USER_AGENT'])) && die(' +' . __LINE__ . ' PHP Fatal Error: cli only usage allowed.' . PHP_EOL);

/**
 * Created by PhpStorm
 * User: podlo
 * Date: 2025-07-03
 * Time: 14:23
 *
 * @author Taras Shkodenko <taras.shkodenko@gmail.com>
 */

require_once 'lib/db.class.php';


try {
    require_once 'config' . DIRECTORY_SEPARATOR . 'inv-prod-settings.php';
    $db = new DB(INV_PROD_DBHOST, INV_PROD_DBUSER, INV_PROD_DBPASS, INV_PROD_DBNAME);
    //
    $query = "SET collation_connection = utf8_unicode_ci";
    $res1001 = $db->query($query);
    $query = "SET NAMES utf8";
    $res1002 = $db->query($query);
    $query = "SET CHARACTER SET utf8";
    $res1003 = $db->query($query);
    $query = "set @@collation_server = utf8_unicode_ci";
    $res1004 = $db->query($query);
    //
    // $doCommit = false;
    //
    // $query = "START TRANSACTION;";
    // echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' SQL: ' . $query . PHP_EOL;
    // $res18 = $db->query($query);
    // echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' res: ' . var_export($res18, true) . PHP_EOL;
    //
    $query = "SELECT pp.*, p.h1 as page_title " .
        " FROM `PagePart` AS pp " .
        " LEFT JOIN `Page` AS p ON p.id = pp.page_id".
        " WHERE pp.`id` > 3000 " .
        " AND (pp.`text` LIKE '%<a%' AND pp.`text` LIKE '%href=\"\"%') " .
        " ORDER BY rand() " .
        " LIMIT 0, 5 FOR UPDATE"
        ;

    echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' SQL: ' . $query . PHP_EOL;

    $res19 = $db->query($query);
    if (!empty($res19) && is_array($res19)) {
        foreach ($res19 as $r) {
            echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' DB result: ' . var_export($r, true) . PHP_EOL;
            preg_match_all('|href="(.*)"|', $r['text'], $m, PREG_OFFSET_CAPTURE);
            if (!empty($m)) {
                echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Found matches: ' . PHP_EOL . var_export($m, true) . PHP_EOL;
                if (isset($m[0][0][1])) {
                    $s1 = substr($r['text'], 0, $m[0][0][1]);
                    $s1 .= ' alt="' . str_replace('"', '&quot;', trim($r['page_title'])) . '" ';
                    $s1 .= substr($r['text'], $m[0][0][1] + 6);
                    //
                    $newTextValue = str_replace("'", '', $s1);
                    echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' New text value: ' . PHP_EOL . $newTextValue . PHP_EOL;

                    // $query = "UPDATE `PagePart` SET `text` = '{$newTextValue}' WHERE `id` = '{$r['id']}'";
                    // echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' SQL: ' . PHP_EOL . $query . PHP_EOL;
                    // $res20 = $db->query($query);
                    // echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' DB result: ' . var_export($res20, true) . PHP_EOL;

                    // $doCommit = true;
                }
            }
        }
        /* if ($doCommit) {
            $query = "COMMIT;";
            echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' SQL: ' . $query . PHP_EOL;
            $res21 = $db->query($query);
            echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' res: ' . var_export($res21, true) . PHP_EOL;
        } */
    }

} catch (\Exception $e) {
    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Fatal error: ' . $e->getMessage() . PHP_EOL;
    die($msg);
}