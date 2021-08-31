<?php

/**
 * Created by PhpStorm.
 * User: Taras
 * Date: 14.09.2018
 * Time: 11:34
 *
 * @author Taras Shkodenko <taras@shkodenko.com>
 */

define('DB_TABLE', 'hs_ga');

(PHP_SAPI !== 'cli' || isset($_SERVER['HTTP_USER_AGENT'])) && die(' +' . __LINE__ . ' Fatal error: cli usage only allowed');

$limit = 30;
$logFileName = dirname( dirname(__FILE__) ) . '/log/hs-ga-cron-4.log';

global $settings;

// require_once 'vendor/autoload.php';
require_once 'config' . DIRECTORY_SEPARATOR . 'settings.php';
require_once 'lib' . DIRECTORY_SEPARATOR . 'functions.php';
require_once 'lib' . DIRECTORY_SEPARATOR . 'db.class.php';
require_once 'lib' . DIRECTORY_SEPARATOR . 'hubspot.class.php';


$keyId = null;
if ( isset($argv[1])
    && (strlen($argv[1]) > 0)
) {
    $keyId = intval($argv[1]);
    $logFileName = dirname(__FILE__) . DIRECTORY_SEPARATOR . 'logs' . DIRECTORY_SEPARATOR . 'hs-ga-cron-4_' . $keyId . '.log';
}

try {
    $db = new DB(DBHOST, DBUSER, DBPASS, DBNAME);
    if (!is_null($keyId)) {
        $keyId = $db->escape($keyId);
        $query = "SELECT * FROM `" . DB_TABLE . "` WHERE `status` = 'deleted_deal' AND `key_id` = '{$keyId}' LIMIT {$limit} OFFSET 0 FOR UPDATE";
    } else {
        $query = "SELECT * FROM `" . DB_TABLE . "` WHERE `status` = 'deleted_deal' LIMIT {$limit} OFFSET 0 FOR UPDATE";
    }
    $res = $db->query($query);
    //
    // $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Got result: ' . var_export($res, 1) . PHP_EOL;
    // logMsg( $msg, $logFileName, ['echoLogMsg' => true, 'storeLog' => true] );
    //
    if (!empty($res)) {
        foreach ($res as $r1) {
            //
            $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' $r1 data: ' . var_export($r1, 1) . PHP_EOL;
            logMsg( $msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true] );
            //
            $gaId = $r1['id'];
            //
            $reqParams = [];
            /* if (!empty($r1['req_params'])) {
                parse_str($r1['req_params'], $reqParams);
            } */
            //
            $dealData = unserialize($r1['deal_data']);
            $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Deal data: ' . var_export($dealData, 1) . PHP_EOL;
            logMsg( $msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true] );
            //
            // Check if settings for key_id exists
            if (
                !isset($settings[ $keyId ])
                || !isset($settings[ $keyId ]['hubspot'])
                || !isset($settings[ $keyId ]['hubspot']['api_key'])
            ) {
                $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Error settings for key_id: ' . var_export($keyId, 1) . ' was not found.' . PHP_EOL;
                logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
                continue;
            }
            // Create HubSpot CRM instance
            try {
                //
                $hubSpot = new Hubspot($settings[$keyId], $db);
                //
            } catch (\Exception $e) {
                $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Fatal error (' . $e->getCode() . '): ' . $e->getMessage() . PHP_EOL;
                logMsg( $msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true] );
                die($msg);
            }
            //
            $pipelineStatusName = $dealName = '';
            $dealName = $r1['deal_name'];
            $pipelines = json_decode($hubSpot->getDealPipelines(), true);
            //
            $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Current pipeline id: ' . var_export($r1['pipeline'], 1) . PHP_EOL;
            logMsg( $msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true] );
            //
            // $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' All $pipelines: ' . var_export($pipelines, 1) . PHP_EOL;
            // logMsg( $msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true] );
            //
            foreach ($pipelines as $p1) {
                //
                $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Current pipeline: ' . var_export($p1, 1) . PHP_EOL;
                logMsg( $msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true] );
                //
                if ($p1['pipelineId'] == $r1['pipeline']) {
                    $pipelineStatusName = $p1['label'];
                    break;
                }
            }
            //
            $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Got pipeline status name: ' . var_export($pipelineStatusName, 1) . PHP_EOL;
            logMsg( $msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true] );
            //
            $hitUrl = 'http://www.google-analytics.com/collect?v=1';
            $tid = $r1['tid']; // 'UA-111571365-3';
            $cid = $r1['cid']; // '1301070883.1536824245';
            $type = 'event';
            $ec = 'DoMiteSystems';
            if (!empty($r1['ec'])) {
                $ec = $r1['ec'];
            }
            $ea = urlencode(trim($pipelineStatusName . ' [Deleted]'));
            if (!empty($r1['ea'])) {
                $ea = $r1['ea'];
            }
            $el = urlencode(trim($r1['deal_name'] . ' [' . $r1['deal_id'] . ']'));
            if (!empty($r1['el'])) {
                $el = $r1['el'];
            }
            $ev = intval($r1['deal_sum']);
            $cd1 = urlencode(trim($pipelineStatusName));
            $cd2 = urlencode(trim($dealName));
            //
            $hitUrl .= '&tid=' . $tid;
            $hitUrl .= '&cid=' . $cid;
            $hitUrl .= '&t=' . $type;
            $hitUrl .= '&ec=' . $ec;
            $hitUrl .= '&ea=' . $ea; // @see: https://developers.google.com/analytics/devguides/collection/protocol/v1/parameters#ea
            $hitUrl .= '&el=' . $el; // @see: https://developers.google.com/analytics/devguides/collection/protocol/v1/parameters#el
            $hitUrl .= '&ev=' . $ev;
            $hitUrl .= '&cd1=' . $cd1;
            $hitUrl .= '&cd2=' . $cd2;
            //
            if (!empty($tid) || !empty($cid)) {
                // Online source
                $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' $tid: ' . var_export($tid, 1) . PHP_EOL;
                logMsg( $msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true] );
                //
                $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' $cid: ' . var_export($cid, 1) . PHP_EOL;
                logMsg( $msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true] );
                //
                $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Hit URL: ' . var_export($hitUrl, 1) . PHP_EOL;
                logMsg( $msg, $logFileName, ['echoLogMsg' => true, 'storeLog' => true] );
                //
                $hRes = file_get_contents($hitUrl);
                $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Hit result: ' . var_export($hRes, 1) . PHP_EOL;
                logMsg( $msg, $logFileName, ['echoLogMsg' => true, 'storeLog' => true] );
                //
                $gaId = $db->escape($gaId);
                // $pipelineStatusName = $db->escape($pipelineStatusName);
                $query2 = "UPDATE `" . DB_TABLE . "` SET `status` = 'ga_hit_sent', `updated_at` = NOW() WHERE `id` = '{$gaId}'";
                $res2 = $db->query($query2);
                $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Got result: ' . var_export($res2, 1) . PHP_EOL;
                logMsg( $msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true] );
                // echo $msg;
            } else {
                // Offile source
                if (isset($settings[ $r1['key_id'] ]['google_offline_source'])) {
                    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Sending offline source request...' . PHP_EOL;
                    logMsg( $msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true] );
                    // echo $msg;
                    //
                    $tid = $settings[ $r1['key_id'] ]['google_offline_source']; // 'UA-42378215-1';
                    $cid = trim(md5($r1['associated_vids'])); // Клиент айди (cid) формируем по принципу MD5 от ID клиента
                    $type = 'event';
                    $ec = 'DoMiteSystems';
                    if (!empty($r1['ec'])) {
                        $ec = $r1['ec'];
                    }
                    $ea = urlencode(trim($pipelineStatusName . ' [Deleted]'));
                    if (!empty($r1['ea'])) {
                        $ea = $r1['ea'];
                    }
                    $el = urlencode(trim($r1['deal_name'] . ' [' . $r1['deal_id'] . ']'));
                    if (!empty($r1['el'])) {
                        $el = $r1['el'];
                    }
                    $ev = intval($r1['deal_sum']);
                    $cs = 'offline';
                    $cm = urlencode(trim('Партнер'));
                    // $cn = 'Партнер';
                    //
                    $z = rand(1111, 9999);
                    //
                    // @example:
                    // v=1&
                    // t=event&
                    // tid=UA-106987787-1&
                    // cid=acf78451-eb56-4624-b691-895e11b548bb&
                    // ec=Сделки [LeadBox]&
                    // ea=Первичный контакт [New]&
                    // el=Liraofficeplus 2pм 2 GSM [1234567]&
                    // ev=1500&
                    // cs=offline&
                    // cm=select&
                    // cn=Партнер&
                    // z=1234
                    //
                    $hitUrl = 'http://www.google-analytics.com/collect?v=1';
                    $hitUrl .= '&t=' . $type; // @see: https://developers.google.com/analytics/devguides/collection/protocol/v1/parameters#t
                    $hitUrl .= '&tid=' . $tid;
                    $hitUrl .= '&cid=' . $cid;
                    //
                    $hitUrl .= '&ec=' . $ec; // @see: https://developers.google.com/analytics/devguides/collection/protocol/v1/parameters#ec
                    $hitUrl .= '&ea=' . $ea; // @see: https://developers.google.com/analytics/devguides/collection/protocol/v1/parameters#ea
                    $hitUrl .= '&el=' . $el; // @see: https://developers.google.com/analytics/devguides/collection/protocol/v1/parameters#el
                    $hitUrl .= '&ev=' . $ev; // @see: https://developers.google.com/analytics/devguides/collection/protocol/v1/parameters#ev
                    //
                    $hitUrl .= '&cd1=' . $cd1;
                    $hitUrl .= '&cd2=' . $cd2;
                    //
                    $hitUrl .= '&cs=' . $cs; // @see: https://developers.google.com/analytics/devguides/collection/protocol/v1/parameters#cs
                    $hitUrl .= '&cm=' . $cm; // @see: https://developers.google.com/analytics/devguides/collection/protocol/v1/parameters#cm
                    // $hitUrl .= '&cn=' . $cn; // @see: https://developers.google.com/analytics/devguides/collection/protocol/v1/parameters#cn
                    $hitUrl .= '&z=' . $z; // @see: https://developers.google.com/analytics/devguides/collection/protocol/v1/parameters#z
                    //
                    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Hit URL: ' . var_export($hitUrl, 1) . PHP_EOL;
                    logMsg( $msg, $logFileName, ['echoLogMsg' => true, 'storeLog' => true] );
                    // echo $msg;
                    //
                    $hRes = file_get_contents($hitUrl);
                    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Hit result: ' . var_export($hRes, 1) . PHP_EOL;
                    logMsg( $msg, $logFileName, ['echoLogMsg' => true, 'storeLog' => true] );
                    echo $msg;
                    //
                    $gaId = $db->escape($gaId);
                    // $pipelineStatusName = $db->escape($pipelineStatusName);
                    $query3 = "UPDATE `" . DB_TABLE . "` SET `status` = 'ga_hit_sent', `updated_at` = NOW() WHERE `id` = '{$gaId}'";
                    $res3 = $db->query($query3);
                    //
                    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Got result: ' . var_export($res3, 1) . PHP_EOL;
                    logMsg( $msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true] );
                    // echo $msg;
                    //
                } else {
                    //
                    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Error: can`t get GA_UTM in data lead: ' . var_export($dealData, 1) . PHP_EOL;
                    logMsg( $msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true] );
                    //
                    $gaId = $db->escape($gaId);
                    $query = "UPDATE `" . DB_TABLE . "` SET `status` = 'error_1', `updated_at` = NOW() WHERE `id` = '{$gaId}'";
                    $res1 = $db->query($query);
                    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Got result: ' . var_export($res1, 1) . PHP_EOL;
                    logMsg( $msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true] );
                    // echo $msg;
                }
            }
            //
            sleep(1);
        }
    }
} catch (\Exception $e) {
    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Fatal error: ' . $e->getMessage() . PHP_EOL;
    logMsg( $msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true] );
    die($msg);
}
