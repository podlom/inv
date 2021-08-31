<?php

/**
 * Created by PhpStorm
 * User: shtaras
 * Date: 11/27/19
 * Time: 12:52
 *
 * @author Taras Shkodenko <ts@doagency.net>
 */

require_once realpath(__DIR__.'/../bootstrap.php');


$app_name = trim(file_get_contents(__DIR__.'/../app_id'));
$app = new Skynar\Application($app_name, realpath(__DIR__.'/../'), __DIR__);
try {
    $app->init();
} catch (Throwable $e) {
    echo $app->getService('template')->renderException($e);
}

if (!empty($_POST)) {
    require_once app()->getPath() . '/cli/lib/db.class.php';
    $cfg = app()->getService('config')->get('app')->db;

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

    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' POST: ' . var_export($_POST, true);
    error_log( $msg );

    $parentTplId = intval($_POST['parent_template_id']);
    $mailingId = intval($_POST['mailing_id']);

    if (isset($_POST['action']) && ($_POST['action'] == 'set')) {
        if (empty($_POST['form_data'])) {
            $query = "DELETE FROM `email_template_data` WHERE `parent_template_id` = '{$parentTplId}'";
            $res13 = $db->query($query);
        } else {
            parse_str($_POST['form_data'], $out);
            $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' parsed data: ' . var_export($out, true);
            error_log( $msg );

            $query = "SELECT * FROM `email_template_data` WHERE `parent_template_id` = '{$parentTplId}'";
            $res10 = $db->query($query);

            $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Data: ' . var_export($res10, true) . PHP_EOL;
            error_log( $msg );

            $dbData = $db->escape(serialize($out));
            if (is_array($res10) && empty($res10)) {
                $query = "INSERT INTO `email_template_data` SET `parent_template_id` = '{$parentTplId}', `mailing_id` = '{$mailingId}', `data` = '{$dbData}', `created` = NOW()";
                $res11 = $db->query($query);
            } elseif (is_array($res10) && !empty($res10)) {
                $query = "UPDATE `email_template_data` SET `mailing_id` = '{$mailingId}', `data` = '{$dbData}', `updated` = NOW() WHERE `parent_template_id` = '{$parentTplId}'";
                $res12 = $db->query($query);
            }
        }
    } elseif (isset($_POST['action']) && ($_POST['action'] == 'get')) {
        $resHmtl = '';
        $query = "SELECT * FROM `email_template_data` WHERE `parent_template_id` = '{$parentTplId}'";
        $res14 = $db->query($query);
        $n = 0;
        if (is_array($res14) && !empty($res14)) {
            // die('<pre>' . var_export($res14, true) . '</pre>');
            if (isset($res14, $res14[0], $res14[0]['data']) && !empty($res14[0]['data'])) {
                $u1 = unserialize($res14[0]['data']);
                if (isset($u1, $u1['inv']) && is_array($u1['inv']) && is_array($u1['inv'])) {
                    foreach ($u1['inv'] as $k9 => $v9) {
                        $resHmtl .= '<div class="fieldwrapper" id="field' . $n . '">';
                        $resHmtl .= '<input type="button" value="[ - ]" onclick="$(this).parent().remove()">';
                        $resHmtl .= '<table><tr><td><label>Адрес картинки: </label></td><td><input type="text" style="width: 500px;" name="inv[' . $n . '][img]" value="' . $v9['img'] . '"></td></tr>';
                        $resHmtl .= '<tr><td><label>Заголовок предложения: </label></td><td><input type="text" style="width: 500px;" name="inv[' . $n . '][title]" value="' . $v9['title'] . '"></td></tr>';
                        $resHmtl .= '<tr><td><label>Регион: </label></td><td><input type="text" style="width: 500px;" name="inv[' . $n . '][region]" value="' . $v9['region'] . '"></td></tr>';
                        $resHmtl .= '<tr><td><label>Цена: </label></td><td><input type="text" style="width: 500px;" name="inv[' . $n . '][price]" value="' . $v9['price'] . '"></td></tr>';
                        $resHmtl .= '<tr><td><label>Адрес страницы предложения: </label></td><td><input type="text" style="width: 500px;" name="inv[' . $n . '][url]" value="' . $v9['url'] . '"></td></tr></table>';
                        $resHmtl .= '</div>';
                        $n ++;
                    }
                }
            }
        }
        if (!headers_sent()) {
            header('Content-Type: text/html; charset=utf-8');
        }
        echo $resHmtl;
    } elseif (isset($_POST['action']) && ($_POST['action'] == 'get_type')) {
        $resHmtl = '';
        $query = "SELECT parent_template_id FROM `email_template` WHERE id = '{$parentTplId}'";
        $res15 = $db->query($query);
        if (is_array($res15) && !empty($res15)) {
            if (isset($res15, $res15[0], $res15[0]['parent_template_id']) && !empty($res15[0]['parent_template_id'])) {
                $resHmtl = $res15[0]['parent_template_id'];
            }
        }
        if (!headers_sent()) {
            header('Content-Type: text/plain; charset=utf-8');
        }
        echo $resHmtl;
    }
}
