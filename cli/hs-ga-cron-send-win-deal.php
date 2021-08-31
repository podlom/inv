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
$logFileName = dirname(__FILE__) . '/../logs/hs-ga-cron-send-win-deal.log';

global $settings;

require_once 'vendor/autoload.php';
require_once 'config' . DIRECTORY_SEPARATOR . 'settings.php';
require_once 'lib' . DIRECTORY_SEPARATOR . 'functions.php';
require_once 'lib' . DIRECTORY_SEPARATOR . 'db.class.php';
require_once 'lib' . DIRECTORY_SEPARATOR . 'hubspot.class.php';


$keyId = 23;
$dealId = null;
if ( isset($argv[1])
    && (strlen($argv[1]) > 0)
) {
    $dealId = intval($argv[1]);
} else {
    die('Error 1001: deal_id is missing' . PHP_EOL);
}

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

    $dData = $hubSpot->getDealById($dealId);
    $json1 = json_decode($dData, true);
    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Deal data: ' . var_export($json1, 1) . PHP_EOL;
    logMsg( $msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true] );

    $status = $db->escape(trim('updated_deal'));
    $keyId = $db->escape($keyId);
    $portalId = $db->escape($json1['portalId']);
    $dealId = $db->escape($json1['dealId']);
    $dealName = $db->escape(trim($json1['properties']['dealname']['value']));
    $dealSum = $db->escape(trim($json1['properties']['amount']['value']));
    $dealData = $db->escape(trim($hubSpot->getDealById($json1['dealId'])));
    $dealStatus = 'Win';
    $dealStage = $db->escape(trim($json1['properties']['dealstage']['value']));
    $pipeline = $db->escape(trim($json1['properties']['pipeline']['value']));
    $associatedVids = $db->escape(join(',', $json1['associations']['associatedVids']));
    $associatedCompanyIds = $db->escape(join(',', $json1['associations']['associatedCompanyIds']));
    $chksum1 = $db->escape(sha1($dealId . $dealStatus . $dealStage . $pipeline));
    $query = "INSERT IGNORE INTO " . DB_TABLE . " SET `key_id` = '{$keyId}', " .
        "`status` = '{$status}', " .
        "`portal_id` = '{$portalId}', " .
        "`deal_id` = '{$dealId}', " .
        "`deal_name` = '{$dealName}', " .
        "`deal_sum` = '{$dealSum}', " .
        "`deal_data` = '{$dealData}', " .
        "`deal_status` = '{$dealStatus}', " .
        "`deal_stage` = '{$dealStage}', " .
        "`pipeline` = '{$pipeline}', " .
        "`associated_vids` = '{$associatedVids}', " .
        "`associated_company_ids` = '{$associatedCompanyIds}', " .
        "`chksum1` = '{$chksum1}', " .
        "`received` = NOW()";
    $db->query($query);

    $newId = $db->lastInsertId();
    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Insert Deal id: ' . var_export($newId, 1) . PHP_EOL;
    logMsg( $msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true] );
    //
} catch (\Exception $e) {
    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Fatal error (' . $e->getCode() . '): ' . $e->getMessage() . PHP_EOL;
    logMsg( $msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true] );
    die($msg);
}
//
