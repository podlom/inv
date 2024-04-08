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
    $query = "SET collation_connection = utf8_unicode_ci";
    $res0 = $db->query($query);
    $query = "SET NAMES utf8";
    $res1 = $db->query($query);
    $query = "SET CHARACTER SET utf8";
    $res2 = $db->query($query);
    $query = "set @@collation_server = utf8_unicode_ci";
    $res3 = $db->query($query);

    $query = "show variables like '%colla%'";
    echo 'Executing SQL: ' . $query . PHP_EOL;
    $res4 = $db->query($query);
    echo 'Result: ' . var_export($res4, true) . PHP_EOL;

    $query = "show variables like '%charac%'";
    echo 'Executing SQL: ' . $query . PHP_EOL;
    $res5 = $db->query($query);
    echo 'Result: ' . var_export($res5, true) . PHP_EOL;

    /**
     * CREATE TABLE `base_email_template` (
     * `id` int(11) NOT NULL AUTO_INCREMENT,
     * `parent_template_id` int(11) NOT NULL DEFAULT 0,
     * `mailing_id` int(11) NOT NULL DEFAULT 0,
     * `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
     * `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
     * `text` longtext COLLATE utf8_unicode_ci,
     * `status` smallint(6) NOT NULL DEFAULT '1',
     * `created` datetime DEFAULT NULL,
     * `updated` datetime DEFAULT NULL,
     * PRIMARY KEY (`id`)
     * ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
     */

/**
 * $templateText = file_get_contents('/home/devinv/d/w/dev.inventure.com.ua/template/Mail.mailing_default.tpl');
    if (!empty($templateText)) {
        $query = "insert into `base_email_template` " .
            " set id = 1, `parent_template_id` = 0, " .
            " `mailing_id` = 0, `name` = 'Default Base Email Template', " .
            " `type` = 'base',  `text` = '" . $db->escape($templateText) . "', " .
            " `status` = 1, `created` = NOW(), `updated` = NOW()";
        $res12 = $db->query($query);
        if ($res12) {
            echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Setup base template #1 is complete' . PHP_EOL;
        }
    }

    $templateText = file_get_contents('/home/devinv/d/w/dev.inventure.com.ua/template/Mail.mailing_default_newsletter.tpl');
    if (!empty($templateText)) {
        $query = "insert into `base_email_template` " .
            " set id = 2, `parent_template_id` = 1, " .
            " `mailing_id` = 0, `name` = 'Default Newsletter Base Email Template', " .
            " `type` = 'base',  `text` = '" . $db->escape($templateText) . "', " .
            " `status` = 1, `created` = NOW(), `updated` = NOW()";
        $res13 = $db->query($query);
        if ($res13) {
            echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Setup base template #2 is complete' . PHP_EOL;
        }
    }

    $templateText = file_get_contents('/home/devinv/d/w/dev.inventure.com.ua/template/Mail.mailing_default_digest.tpl');
    if (!empty($templateText)) {
        $query = "insert into `base_email_template` " .
            " set id = 3, `parent_template_id` = 1, " .
            " `mailing_id` = 0, `name` = 'Default Digest Base Email Template', " .
            " `type` = 'base',  `text` = '" . $db->escape($templateText) . "', " .
            " `status` = 1, `created` = NOW(), `updated` = NOW()";
        $res13 = $db->query($query);
        if ($res13) {
            echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Setup base template #3 is complete' . PHP_EOL;
        }
    }

*/

    $query = "select max(id) as max_id from `base_email_template`";
    $res15 = $db->query($query);
    if ($res15) {
        echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Setup is complete base templates are added: ' . var_export($res15, true) . PHP_EOL;
    }

} catch (\Exception $e) {
    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Fatal error: ' . $e->getMessage() . PHP_EOL;
    die($msg);
}