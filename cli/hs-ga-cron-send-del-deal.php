<?php

/**
 * Created by PhpStorm.
 * User: Taras
 * Date: 13.09.2018
 * Time: 15:46
 *
 * @author Taras Shkodenko <taras@shkodenko.com>
 */

define('DB_TABLE', 'hs_ga');

(PHP_SAPI !== 'cli' || isset($_SERVER['HTTP_USER_AGENT'])) && die(' +' . __LINE__ . ' Fatal error: cli usage only allowed');

$limit = 30;
$logFileName = dirname(__FILE__) . '/../logs/hs-ga-cron-send-del-deal.log';

global $settings;

require_once 'vendor/autoload.php';
require_once 'config' . DIRECTORY_SEPARATOR . 'settings.php';
require_once 'lib' . DIRECTORY_SEPARATOR . 'functions.php';
require_once 'lib' . DIRECTORY_SEPARATOR . 'db.class.php';
require_once 'lib' . DIRECTORY_SEPARATOR . 'hubspot.class.php';


$keyId = 23;

// Create DB instance
try {
    $db = new DB(DBHOST, DBUSER, DBPASS, DBNAME);
} catch (\Exception $e) {
    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Fatal error: ' . $e->getMessage() . PHP_EOL;
    logMsg( $msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true] );
    die($msg);
}
//

// Check if settings for key_id exists
if (
    !is_null($keyId)
    && (!isset($settings[ $keyId ])
        || !isset($settings[ $keyId ]['hubspot'])
        || !isset($settings[ $keyId ]['hubspot']['api_key']))
) {
    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Error settings for key_id: ' . var_export($keyId, 1) . ' was not found.' . PHP_EOL;
    logMsg( $msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true] );
}
//

// Create HubSpot CRM instance
try {
    //
    $hubSpot = new Hubspot($settings[$keyId], $db);

    $msg = 'Now time(): ' . var_export(time(), 1) . PHP_EOL;
    logMsg( $msg, $logFileName, ['echoLogMsg' => true, 'storeLog' => true] );

    $msg = 'Now microtime(): ' . var_export(microtime(), 1) . PHP_EOL;
    logMsg( $msg, $logFileName, ['echoLogMsg' => true, 'storeLog' => true] );

    $msg = 'Now microtime(true): ' . var_export(microtime(true), 1) . PHP_EOL;
    logMsg( $msg, $logFileName, ['echoLogMsg' => true, 'storeLog' => true] );
    // 1557315572.825711

    $numDel = 0;
    $dealsAr = explode(',', '669174147,670268979,671434115,673556497,673583864,673786728,697475123,719869422,731525670,738402280,740792276,746653022,746653894,746657676,746677107,746680186,746681716,746693554,746710093,746723651,746732923,746980885,746984205,746987232,746997183,747046706,747691634,747704309,747705649,747726473,747753540,747767970,747775204,747799852,747807151,747889690,748289534,748305889,748313656,748321714,748322633,748337625,748358999,748373841,749430592,749450603,749487700,749489242,749492846,749495404,749498936,749499222,749501162,749501656,749501775,749502532,749502708,749505309,749507133,749607270,749616213,749631839,749679533,749683915,749724543,749749402,749973363,749975719,749975853,749981063,749991800,750007916,750012082,751515641,751715362,751719108,751729378,751997677,753236458,754070840,754107577,754109364,754109755,754118624,754141700,754334357,754456910,755239567,755518493,756056923');
    if (is_array($dealsAr) && !empty($dealsAr)) {
        foreach ($dealsAr as $dealId) {
            $dealId = $db->escape($dealId);
            $dData = $hubSpot->getDealById($dealId);
            $json1 = json_decode($dData, true);
            if (isset($json1['status']) && ($json1['status'] == 'error')) {
                if (isset($json1['message']) && ($json1['message'] == 'Deal does not exist')) {
                    $query = "SELECT `tid`, `cid`, `deal_name`, `deal_sum`, `deal_stage`, `pipeline` FROM " . DB_TABLE . " WHERE `deal_id` = '{$dealId}' AND `tid` <> '' AND `cid` <> '' LIMIT 1";
                    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' SQL: ' . $query . PHP_EOL;
                    logMsg( $msg, $logFileName, ['echoLogMsg' => true, 'storeLog' => true] );
                    $res1 = $db->query($query);
                    // die( var_export($res1, 1) );
                    if (!empty($res1[0])) {
                        $status = $db->escape(trim('deleted_deal'));
                        $keyId = $db->escape($keyId);
                        $dealName = $db->escape(trim($res1[0]['deal_name']));
                        $dealSum = $db->escape(trim($res1[0]['deal_sum']));
                        $dealStatus = 'Deleted';
                        $dealStage = $db->escape(trim($res1[0]['deal_stage']));
                        $pipeline = $db->escape(trim($res1[0]['pipeline']));
                        $chksum1 = $db->escape(sha1($dealId . $dealStatus . $dealStage . $pipeline));
                        $tId = $db->escape($res1[0]['tid']);
                        $cId = $db->escape($res1[0]['cid']);
                        //
                        $query = "INSERT IGNORE INTO " . DB_TABLE . " SET `key_id` = '{$keyId}', " .
                            "`status` = '{$status}', " .
                            "`deal_id` = '{$dealId}', " .
                            "`deal_name` = '{$dealName}', " .
                            "`deal_sum` = '{$dealSum}', " .
                            "`deal_status` = '{$dealStatus}', " .
                            "`deal_stage` = '{$dealStage}', " .
                            "`pipeline` = '{$pipeline}', " .
                            "`chksum1` = '{$chksum1}', " .
                            "`tid` = '{$tId}', " .
                            "`cid` = '{$cId}', " .
                            "`received` = NOW()";
                    } else { // Send offline source request to GA
                        $status = $db->escape(trim('deleted_deal'));
                        $keyId = $db->escape($keyId);
                        $dealStatus = 'Deleted';
                        $dealStage = $db->escape(trim(''));
                        $pipeline = $db->escape(trim(''));
                        $chksum1 = $db->escape(sha1($dealId . $dealStatus . $dealStage . $pipeline));
                        //
                        $query = "INSERT IGNORE INTO " . DB_TABLE . " SET `key_id` = '{$keyId}', " .
                            "`status` = '{$status}', " .
                            "`deal_id` = '{$dealId}', " .
                            "`deal_status` = '{$dealStatus}', " .
                            "`deal_stage` = '{$dealStage}', " .
                            "`pipeline` = '{$pipeline}', " .
                            "`chksum1` = '{$chksum1}', " .
                            "`received` = NOW()";
                    }
                    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' SQL: ' . $query . PHP_EOL;
                    logMsg( $msg, $logFileName, ['echoLogMsg' => true, 'storeLog' => false] );
                    $db->query($query);
                    //
                    $newId = $db->lastInsertId();
                    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Insert Deal id: ' . var_export($newId, 1) . PHP_EOL;
                    logMsg( $msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true] );
                    $numDel ++;
                }
            }
        }
    }
    if ($numDel) {
        $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Number of deleted deals: ' . var_export($numDel, 1) . PHP_EOL;
        logMsg( $msg, $logFileName, ['echoLogMsg' => true, 'storeLog' => true] );
    }
} catch (\Exception $e) {
    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Fatal error (' . $e->getCode() . '): ' . $e->getMessage() . PHP_EOL;
    logMsg( $msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true] );
    die($msg);
}
