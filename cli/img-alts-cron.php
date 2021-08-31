<?php

(PHP_SAPI !== 'cli' || isset($_SERVER['HTTP_USER_AGENT'])) && die(' +' . __LINE__ . ' PHP Fatal Error: cli only usage allowed.' . PHP_EOL);

/**
 * Created by PhpStorm
 * User: shtaras
 * Date: 2021-03-01
 * Time: 14:23
 *
 * @author Taras Shkodenko <ts@doagency.net>
 */

require_once 'lib/db.class.php';

const
    DBHOST = '127.0.0.1',
    DBUSER = 'inventure',
    DBPASS = '6Qq2fnX51zShHhDO',
    DBNAME = 'inventure_prod';

try {
    $db = new DB(DBHOST, DBUSER, DBPASS, DBNAME);
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
    $query = "SELECT * FROM `PagePart` " .
        " WHERE `id` > 3000 " .
        " AND (`text` LIKE '%<img%' AND `text` LIKE '%alt=\"\"%') " .
        " LIMIT 0, 5 "
        ; // " FOR UPDATE"
    echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' SQL: ' . $query . PHP_EOL;
    $res19 = $db->query($query);
    if (!empty($res19) && is_array($res19)) {
        foreach ($res19 as $r) {
            echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' DB result: ' . var_export($r, true) . PHP_EOL;
            preg_match_all('|alt=""|', $r['text'], $m, PREG_OFFSET_CAPTURE);
            if (!empty($m)) {
                if (isset($m[0][0][1])) {
                    $s1 = substr($r['text'], 0, $m[0][0][1]);
                    $s1 .= ' alt="' . str_replace('"', '&quot;', $r['title']) . '" ';
                    $s1 .= substr($r['text'], $m[0][0][1] + 6);
                    $s1 = str_replace("'", '', $s1);
                    echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' New text value: ' . $s1 . PHP_EOL;

                    $query = "UPDATE `PagePart` SET `text` = '{$s1}' WHERE `id` = '{$r['id']}'";
                    echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' SQL: ' . $query . PHP_EOL;
                    $res20 = $db->query($query);
                    echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' res: ' . var_export($res20, true) . PHP_EOL;

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