<?php

/**
 * Created by PhpStorm
 * User: shtaras
 * Date: 11/27/19
 * Time: 12:52
 *
 * @author Taras Shkodenko <ts@doagency.net>
 */

function l_m($msg)
{
    $logFileName = dirname(__FILE__) . '/page-attr.log';
    if (!file_exists($logFileName)) {
        touch($logFileName);
        chmod($logFileName, 0666);
    }
    // Do not log if client IP does not match list below
    if (($_SERVER['REMOTE_ADDR'] !== '95.158.38.79') // Grand Villas
        && ($_SERVER['REMOTE_ADDR'] !== '178.214.193.98') // InVenture office
    ) {
        // error_log(__FILE__ . ' +' . __LINE__ . ' ' . __FUNCTION__ . ' log to file is disabled for client IP: ' . $_SERVER['REMOTE_ADDR']);
        return false;
    } else {
        if (is_writeable($logFileName)) {
            error_log(date('r') . ' ' . $msg . PHP_EOL, 3, $logFileName);
        }
    }
}

require_once realpath(__DIR__.'/../bootstrap.php');


$app_name = trim(file_get_contents(__DIR__.'/../app_id'));
$app = new Skynar\Application($app_name, realpath(__DIR__.'/../'), __DIR__);
try {
    $app->init();
} catch (Throwable $e) {
    echo $app->getService('template')->renderException($e);
}

if (!empty($_REQUEST)) {
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

    $msg = __FILE__ . ' +' . __LINE__ . ' $_REQUEST: ' . var_export($_REQUEST, true);
    l_m( $msg );

    $pageId = null;
    if (isset($_REQUEST['page_id']) && !empty($_REQUEST['page_id'])) {
        @$pageId = intval($_REQUEST['page_id']);
    }
    $attrId = null;
    if (isset($_REQUEST['attr_id']) && !empty($_REQUEST['attr_id'])) {
        @$attrId = intval($_REQUEST['attr_id']);
    }
    $levelId = null;
    if (isset($_REQUEST['level']) && !empty($_REQUEST['level'])) {
        @$levelId = intval($_REQUEST['level']);
    }

    $msg = __FILE__ . ' +' . __LINE__ . ' $pageId: ' . var_export($pageId, true) . '; $attrId: ' . var_export($attrId, true) . '; $levelId: ' . var_export($levelId, true) . PHP_EOL;
    l_m($msg);

    if (isset($_REQUEST['action']) && ($_REQUEST['action'] == 'set')) { // Update attr data
        $resData = '';
        $query = "SELECT * FROM `Page` WHERE `id` = '{$pageId}'";
        $res10 = $db->query($query);

        $msg = __FILE__ . ' +' . __LINE__ . ' Page data: ' . var_export($res10, true) . PHP_EOL;
        l_m( $msg );

        if (is_array($res10)
            && !empty($res10)
            && isset($res10[0], $res10[0]['attr'])
        ) { // Page attr value update
            $jData = json_decode($res10[0]['attr'], true);
            if (is_null($levelId)) {
                if (isset($jData['attr' . $attrId], $_REQUEST['value'])) {
                    $jData['attr' . $attrId] = $_REQUEST['value'];
                    //
                    $msg = __FILE__ . ' +' . __LINE__ . ' Update existing attribute: ' . var_export('attr' . $attrId, true) . PHP_EOL;
                    l_m( $msg );
                } else {
                    $jData['attr' . $attrId] = $_REQUEST['value'];
                    //
                    $msg = __FILE__ . ' +' . __LINE__ . ' New attribute: ' . var_export('attr' . $attrId, true) . PHP_EOL;
                    l_m( $msg );
                }
            } else {
                if (isset($jData['attr' . $attrId][$levelId], $jData['attr' . $attrId], $_REQUEST['value'])) {
                    $jData['attr' . $attrId][$levelId] = $_REQUEST['value'];
                    //
                    $msg = __FILE__ . ' +' . __LINE__ . ' Update existing attribute: ' . var_export('attr' . $attrId, true) . ' level: ' . var_export($levelId, true) . PHP_EOL;
                    l_m( $msg );
                } else {
                    $jData['attr' . $attrId][$levelId] = $_REQUEST['value'];
                    //
                    $msg = __FILE__ . ' +' . __LINE__ . ' New attribute: ' . var_export('attr' . $attrId, true) . ' level: ' . var_export($levelId, true) . PHP_EOL;
                    l_m( $msg );
                }
            }

            $attr = $db->escape(json_encode($jData));
            $query = "UPDATE `Page` SET `attr` = '{$attr}', `updated` = NOW() WHERE `id` = '{$pageId}'";

            $msg = __FILE__ . ' +' . __LINE__ . ' SQL: ' . $query . PHP_EOL;
            l_m( $msg );

            $res12 = $db->query($query);

            $msg = __FILE__ . ' +' . __LINE__ . ' Update db result: ' . var_export($res12, true) . PHP_EOL;
            l_m( $msg );

            if (!headers_sent()) {
                header('Content-Type: text/plain; charset=utf-8');
            }
            echo $res12;
        }
    } elseif (isset($_REQUEST['action']) && ($_REQUEST['action'] == 'set_slug')) { // Set new slug value

        $query = "SELECT * FROM `Page` WHERE `id` = '{$pageId}'";
        $res15 = $db->query($query);
        //
        $msg = __FILE__ . ' +' . __LINE__ . ' Page data: ' . var_export($res15, true) . PHP_EOL;
        l_m( $msg );
        //
        if (($_REQUEST['slug'] !== $res15[0]['subpath']) && isset($_REQUEST['slug']) && !empty($_REQUEST['slug'])) {
            $slug = $db->escape(trim($_REQUEST['slug']));
            $query = "UPDATE `Page` SET `subpath` = '{$slug}', `updated` = NOW() WHERE `id` = '{$pageId}'";
            //
            $msg = __FILE__ . ' +' . __LINE__ . ' SQL: ' . $query . PHP_EOL;
            l_m( $msg );
            //
            $res16 = $db->query($query);
            //
            $msg = __FILE__ . ' +' . __LINE__ . ' Update db result: ' . var_export($res16, true) . PHP_EOL;
            l_m( $msg );
            //
            if (!headers_sent()) {
                header('Content-Type: text/plain; charset=utf-8');
            }
            echo $res16;
        }

    } elseif (isset($_REQUEST['action']) && ($_REQUEST['action'] == 'get_text')) { // Get page text
        $resData = '';
        $query = "SELECT * FROM `PagePart` WHERE `page_id`  = '{$pageId}' AND `name` = 'content'";
        $res19 = $db->query($query);
        //
        // $msg = __FILE__ . ' +' . __LINE__ . ' Got db data: ' . var_export($res19, true) . PHP_EOL;
        // l_m($msg);
        //
        if (is_array($res19) && !empty($res19)) {
            if (isset($res19[0], $res19[0]['text']) && !empty(isset($res19[0]['text']))) {
                $resData = $res19[0]['text'];
            }
        }
        //
        if (!headers_sent()) {
            header('Content-Type: text/html;charset=UTF-8');
        }
        echo $resData;

    } elseif (isset($_REQUEST['action']) && ($_REQUEST['action'] == 'get_setting')) { // Get settings attr data
        $settingName = $_REQUEST['name'];

        $resData = '';
        $query = "SELECT * FROM `Core_Attribute_Type` WHERE `name` = '{$settingName}'";
        $res94 = $db->query($query);
        //
        if (is_array($res94) && !empty($res94)) {
            if (isset($res94, $res94[0], $res94[0]['comment'])) {
                $resData = $res94[0]['comment'];
            }
            //
            $msg = __FILE__ . ' +' . __LINE__ . ' Res data: ' . var_export($resData, true) . PHP_EOL;
            l_m( $msg );
            //
            if (!headers_sent()) {
                header('Content-Type: text/plain; charset=utf-8');
            }
            echo $resData;
        }

    } elseif (isset($_REQUEST['action']) && ($_REQUEST['action'] == 'get')) { // Get attr data
        $resData = '';
        $query = "SELECT * FROM `Page` WHERE `id` = '{$pageId}'";
        $res14 = $db->query($query);
        //
        // $msg = __FILE__ . ' +' . __LINE__ . ' Got db data: ' . var_export($res14, true) . PHP_EOL;
        // l_m( $msg );
        //
        if (is_array($res14) && !empty($res14)) {
            if (isset($res14, $res14[0], $res14[0]['attr'])
                && !empty($res14[0]['attr'])
            ) {
                $jData = json_decode($res14[0]['attr'], true);
                if (is_null($levelId)) {
                    if (isset($jData['attr' . $attrId])) {
                        $resData = $jData['attr' . $attrId];
                    }
                } else {
                    if (isset($jData['attr' . $attrId], $jData['attr' . $attrId][$levelId])) {
                        $resData = $jData['attr' . $attrId][$levelId];
                    }
                }
            }
        }
        //
        $msg = __FILE__ . ' +' . __LINE__ . ' Res data: ' . var_export($resData, true) . PHP_EOL;
        l_m( $msg );
        //
        if (!headers_sent()) {
            header('Content-Type: text/plain; charset=utf-8');
        }
        echo $resData;
    }
}
