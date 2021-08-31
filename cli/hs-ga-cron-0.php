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
$logFileName = dirname( dirname(__FILE__) ) . '/log/hs-ga-cron-0_' . date('Y-m-d') . '.log';

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
} else {
    die('Error 1001: key_id is missing');
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
    // @example: 1557315572.825711

    //
    $pJson = $hubSpot->getDealPipelines();
    $pipelines = json_decode($pJson, true);
    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Pipelines: ' . var_export($pipelines, 1) . PHP_EOL;
    logMsg($msg, $logFileName, ['echoLogMsg' => true, 'storeLog' => true]);
    //

    $recModDeals = $hubSpot->getRecentlyModifiedDeals([]);
    // TODO: implement deal since TS
    /* if (date('G') == 0) {
        $recCreDeals = $hubSpot->getRecentlyCreatedDeals([]);
    } else {
        $ex0 = explode('.', microtime(true));
        $ts = $ex0[0] . substr($ex0[1], 0, 3);
        $msg = 'TS: ' . var_export($ts, 1) . PHP_EOL;
        logMsg( $msg, $logFileName, ['echoLogMsg' => true, 'storeLog' => true] );

        $ts2 = $ts - (1 * 60 * 60);
        $msg = 'TS2: ' . var_export($ts2, 1) . PHP_EOL;
        logMsg( $msg, $logFileName, ['echoLogMsg' => true, 'storeLog' => true] );

        $recCreDeals = $hubSpot->getRecentlyCreatedDeals([
            'since' => $ts2,
        ]);
    } */
    $json1 = json_decode($recModDeals, true);
    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Recently modified deals: ' . var_export($json1, 1) . PHP_EOL;
    logMsg( $msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true] );
    //
    if (!empty($json1['results'])) {
        foreach ($json1['results'] as $r0) {
            $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Modified Deal Data: ' . var_export($r0, 1) . PHP_EOL;
            logMsg( $msg, $logFileName, ['echoLogMsg' => true, 'storeLog' => true] );
            //
            $status = $db->escape(trim('new_deal'));
            $keyId = $db->escape($keyId);
            $portalId = $db->escape($r0['portalId']);
            $dealId = $db->escape($r0['dealId']);
            $dealName = $db->escape(trim($r0['properties']['dealname']['value']));
            $dealSum = $db->escape(trim($r0['properties']['amount']['value']));
            $dealData = $db->escape(trim($hubSpot->getDealById($r0['dealId'])));
            //
            $ec = '';
            $ea = '';
            $el = '';
            $ev = '';
            $cm1 = '';
            //
            $doNotSendEvent = false;
            $dealStatus = '';
            //
            if (
                ($r0['properties']['pipeline']['value'] == '714da3ad-adca-4cea-847b-2e02ef6c4fe1')
                && ($r0['properties']['dealstage']['value'] == '449211')
            ) {
                /**
                 * status = New
                 *
                 * Новая заявка (цель: Лиды)
                 * Отправляется когда пользователь отправляет любую заявку с сайта:
                 * Обратная связь
                 * Подписка на дайджест
                 * Регистрация инвестора
                 * Индивидуальный подход
                 * Реклама и продвижение
                 * Оплата объявления (не оплаченное)
                 *
                 * Название продукта - "Реклама и продвижение", "Индивидуальный подход", “Регистрация инвестора”, “Обратная связь” (для всех неизвестных)
                 *
                 * Для всех начало: v=1&t=event&tid=UA-42378215-1&cid={google client id}
                 * @example: &ec=DoMiteSystems&ea=Lead [New]&el={Название продукта}
                 */

                $dealStatus = 'New';
                $ec = $db->escape( 'DoMiteSystems' );
                $ea = $db->escape( 'Lead [New]' );
                if (!in_array($dealName, ['Реклама и продвижение', 'Индивидуальный подход', 'Регистрация инвестора', 'Обратная связь'])) {
                    $el = $db->escape( 'Обратная связь' );
                } else {
                    $el = $db->escape( $dealName );
                }
            } elseif (
                (($r0['properties']['pipeline']['value'] == 'default')
                || ($r0['properties']['dealstage']['value'] == '44c33add-e9a8-4027-92fc-df17f3e7e89e'))
                && (isset($r0['properties']['sucess_fee']['value']) && !empty($r0['properties']['sucess_fee']['value']))
            ) {
                /**
                 * Успех сделки (цель: Сделки)
                 *
                 * Когда сделка попадает из воронки Sell или Buy в статус Closed
                 * Регистрация инвестора
                 * Индивидуальный подход
                 * Реклама и продвижение
                 * Оплата объявления (оплаченное)
                 *
                 * Название продукта - "Реклама и продвижение", "Индивидуальный подход", “Регистрация инвестора”, “Обратная связь” (для всех неизвестных)
                 *
                 * Для всех начало: v=1&t=event&tid=UA-42378215-1&cid={google client id}
                 * @example: &ec=DoMiteSystems&ea=Lead [Success]&el={Название продукта}&ev={сумма из поля Success Fee}&cm1={Количество дней с момента создания сделки до завершения}
                 * - ВНИМАНИЕ!!! - не отправлять событие если поле Success Fee не заполнено!
                 */

                $doNotSendEvent = true;
                if (isset($r0['properties']['sucess_fee']['value']) && !empty($r0['properties']['sucess_fee']['value'])) {
                    $dealStatus = 'Closed';

                    $ec = $db->escape( 'DoMiteSystems' );
                    $ea = $db->escape( 'Lead [Success]' );
                    if (!in_array($dealName, ['Реклама и продвижение', 'Индивидуальный подход', 'Регистрация инвестора', 'Обратная связь'])) {
                        $el = $db->escape( 'Обратная связь' );
                    } else {
                        $el = $db->escape( $dealName );
                    }
                    $ev = $db->escape( $r0['properties']['sucess_fee']['value'] );
                    $cm1 = $db->escape( intval($r0['properties']['days_to_close']['value']) + 1 );

                    $doNotSendEvent = false;
                }

            } elseif (
                (($r0['properties']['pipeline']['value'] == 'default')
                    || ($r0['properties']['pipeline']['value'] == '284b44a8-da35-471c-a3df-d5eff6f50f98') )
                && (isset($r0['properties']['prepaid']['value']) && !empty($r0['properties']['prepaid']['value']))
            ) {
                /**
                 * Актуализация заявки (цель: Предоплата)
                 *
                 * Когда сделка попадает из воронки Pipeline в воронку Sell или Buy
                 * Регистрация инвестора
                 * Индивидуальный подход
                 * Реклама и продвижение
                 *
                 * Название продукта - "Реклама и продвижение", "Индивидуальный подход", “Регистрация инвестора”, “Обратная связь” (для всех неизвестных)
                 *
                 * Для всех начало: v=1&t=event&tid=UA-42378215-1&cid={google client id}
                 * @example: &ec=DoMiteSystems&ea=Lead [Prepaid]&el={Название продукта}&ev={сумма из поля prepaid}
                 * - ВНИМАНИЕ!!! - не отправлять событие если поле prepaid не заполнено!
                 */

                $doNotSendEvent = true;
                if (isset($r0['properties']['prepaid']['value']) && !empty($r0['properties']['prepaid']['value'])) {
                    $dealStatus = 'Prepaid';
                    $ec = $db->escape( 'DoMiteSystems' );
                    $ea = $db->escape( 'Lead [Prepaid]' );
                    if (!in_array($dealName, ['Реклама и продвижение', 'Индивидуальный подход', 'Регистрация инвестора', 'Обратная связь'])) {
                        $el = $db->escape( 'Обратная связь' );
                    } else {
                        $el = $db->escape( $dealName );
                    }
                    $ev = $db->escape( $r0['properties']['prepaid']['value'] );
                    $doNotSendEvent = false;
                }
            }

            //
            $dealStage = $db->escape(trim($r0['properties']['dealstage']['value']));
            $pipeline = $db->escape(trim($r0['properties']['pipeline']['value']));
            $associatedVids = $db->escape(join(',', $r0['associations']['associatedVids']));
            $associatedCompanyIds = $db->escape(join(',', $r0['associations']['associatedCompanyIds']));
            //
            if (!empty($dealStatus)) {
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
                    "`ec` = '{$ec}', " .
                    "`ea` = '{$ea}', " .
                    "`el` = '{$el}', " .
                    "`ev` = '{$ev}', " .
                    "`cm1` = '{$cm1}', " .
                    "`received` = NOW()";

                if ($doNotSendEvent) {
                    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Do not sending event. Deal Status: ' . var_export($dealStatus, true) . '. Closed without success fee data: ' . var_export($r0, true) . PHP_EOL;
                    logMsg( $msg, $logFileName, ['echoLogMsg' => true, 'storeLog' => true] );
                } else {
                    $resQry9 = $db->query($query);
                    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' SQL (res: ' . var_export($resQry9, true) . '): ' . var_export($query, 1) . PHP_EOL;
                    logMsg( $msg, $logFileName, ['echoLogMsg' => true, 'storeLog' => true] );
                }

            }
            sleep(rand(1, 2));
        }
    }
} catch (\Exception $e) {
    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Fatal error (' . $e->getCode() . '): ' . $e->getMessage() . PHP_EOL;
    logMsg( $msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true] );
    die($msg);
}
