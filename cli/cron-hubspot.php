<?php

/**
 * Created by PhpStorm
 * User: Taras
 * Date: 2019-05-02
 * Time: 11:12
 *
 * @author Taras Shkodenko <ts@doagency.net>
 */

define('DB_TABLE', 'hubspot');
define('GA_TABLE', 'hs_ga');

(PHP_SAPI !== 'cli' || isset($_SERVER['HTTP_USER_AGENT'])) && die(' +' . __LINE__ . ' Fatal error: cli usage only allowed');

global $settings, $db, $hubSpot, $logFileName, $keyId, $data1;

$logFileName = dirname( dirname(__FILE__) ) . '/log/cron-hubspot_' . date('Y-m-d') . '.log';

// require_once 'vendor/autoload.php';
require_once 'config' . DIRECTORY_SEPARATOR . 'settings.php';
require_once 'lib' . DIRECTORY_SEPARATOR . 'db.class.php';
require_once 'lib' . DIRECTORY_SEPARATOR . 'functions.php';
require_once 'lib' . DIRECTORY_SEPARATOR . 'hubspot.class.php';


/**
 * Handle user register form
 * @param $formData
 * @return bool
 *
 * @author Taras Shkodenko <ts@doagency.net>
 */
function userRegister($formData)
{
    global $db, $hubSpot, $logFileName;

    $retVal = false;
    $contactData = [];
    $contactData['email'] = $formData['email'];
    $p0 = strpos($formData['name'], ' ');
    if ($p0 !== false) {
        $aN1 = explode(' ', $formData['name']);
        $contactData['firstname'] = $aN1[0];
        $contactData['lastname'] = $aN1[1];
    } else {
        $contactData['firstname'] = $formData['name'];
    }
    if (isset($formData['phone'])) {
        $contactData['phone'] = $formData['phone'];
    }
    // TODO: get contact owner - now hardcoded test responsible user to - ts@doagency.net
    // $contactData['hubspot_owner_id'] = 36382326;
    //
    // Тип клиента
    $contactData['type_of_client'] = 'Клиент'; // @see: https://app.hubspot.com/property-settings/1982701/contact/type_of_client
    //
    $res1 = $hubSpot->findContactByEmail($formData['email']);
    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Hubspot::findContactByEmail result: ' . var_export($res1, 1) . PHP_EOL;
    logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);

    if ($res1 !== false) {
        $jR2 = json_decode($res1, true);
        if (isset($jR2['status']) && isset($jR2['message'])) {
            if (
                ($jR2['status'] == 'error')
                && ($jR2['message'] == 'contact does not exist')
            ) {
                // Add new contact
                $gaJson = json_decode($formData['ga_utm'], true);
                if (!empty($gaJson)) {
                    $contactData['source'] = $gaJson['source_title'];
                }
                $res2 = $hubSpot->addContact($contactData);
                $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Hubspot::addContact result: ' . var_export($res2, 1) . PHP_EOL;
                logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
                //
                if (!empty($res2) && ($res2 !== false)) {
                    $jR3 = json_decode($res2, true);
                    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Contact vId: ' . $jR3["vid"] . '; Profile URL: ' . $jR3["profile-url"] . PHP_EOL;
                    logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
                    $retVal = true;
                }
            }
        } else {
            if (isset($jR2["vid"]) && isset($jR2["profile-url"])) {
                $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Contact is already exists vId: ' . $jR2["vid"] . '; Profile URL: ' . $jR2["profile-url"] . PHP_EOL;
                $retVal = true;
            } else {
                $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Other result json: ' . var_export($jR2, 1) . PHP_EOL;
            }
            logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
        }
    }
    return $retVal;
}

/**
 * @param $formData
 * @return bool
 *
 * @author Taras Shkodenko <ts@doagency.net>
 */
function bulletinAdd($formData)
{
    global $db, $hubSpot, $logFileName, $keyId, $data1;

    $retVal = false;

    $vid = null;

    /**
     * @example:
     * $formData = [
     *  'page' => [
     *     'attr' => [
     *       'attr_5' => 'Тестович Тестер Тестовый',
     *       'attr_3' => '0671234433',
     *       'attr_4' => 'podlom+173@gmail.com',
     *       'attr_10' => [
     *         'loc' => 'Тестовое расположение в Киеве',
     *         'lat' => '',
     *         'lng' => '',
     *       ],
     *       'attr_15' => '1234500',
     *     ],
     *     'category' => [
     *       'parent' => '15088',
     *     ],
     *     'announce' => [
     *       'h1' => 'Тестовое название инвестиционного проекта',
     *       'short_text' => 'Краткое описание инвестиционного проекта',
     *     ],
     *     'meta' => [
     *       'keywords' => 'слово1, слово2, слово3, слово4, слово5, слово6, слово7',
     *     ],
     *     'content' => [
     *       'text' => 'Полное описание тестового инвестиционного проекта',
     *     ],
     *   ],
     * ];
     */

    $contactData = [];
    $contactData['email'] = $formData['page']['attr']['attr_4'];
    $p0 = strpos($formData['page']['attr']['attr_5'], ' ');
    if ($p0 !== false) {
        $aN0 = explode(' ', $formData['page']['attr']['attr_5']);
        $contactData['firstname'] = $aN0[1];
        $contactData['lastname'] = $aN0[0];
    } else {
        $contactData['firstname'] = $formData['page']['attr']['attr_5'];
    }
    if (isset($formData['page']['attr']['attr_3']) && !empty($formData['page']['attr']['attr_3'])) {
        $contactData['phone'] = $formData['page']['attr']['attr_3'];
    }
    $gaJson = json_decode($formData['ga_utm'], true);
    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' $gaJson: ' . var_export($gaJson, true) . PHP_EOL;
    logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
    if (!empty($gaJson)) {
        $contactData['source'] = $gaJson['source_title'];
    }
    // TODO: get contact owner - now hardcoded to - ts@doagency.net
    // $contactData['hubspot_owner_id'] = 36382326;
    //
    // Тип клиента
    $contactData['type_of_client'] = 'Клиент'; // @see: https://app.hubspot.com/property-settings/1982701/contact/type_of_client
    //
    $res1 = $hubSpot->findContactByEmail($formData['page']['attr']['attr_4']);
    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Hubspot::findContactByEmail(' . $formData['page']['attr']['attr_4'] . ') result: ' . var_export($res1, 1) . PHP_EOL;
    logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);

    if ($res1 !== false) {
        $jR2 = json_decode($res1, true);
        if (isset($jR2['status']) && isset($jR2['message'])) {
            if (
                ($jR2['status'] == 'error')
                && ($jR2['message'] == 'contact does not exist')
            ) {
                // Add new contact
                $res2 = $hubSpot->addOrUpdateContact($contactData);
                $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Hubspot::addContact result: ' . var_export($res2, 1) . PHP_EOL;
                logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
                //
                if (!empty($res2) && ($res2 !== false)) {
                    $jR3 = json_decode($res2, true);
                    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Contact vId: ' . $jR3["vid"] . '; Profile URL: ' . $jR3["profile-url"] . PHP_EOL;
                    logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
                    $retVal = true;
                    $vid = $jR3["vid"];
                }
            }
        } else {
            if (isset($jR2["vid"]) && isset($jR2["profile-url"])) {
                $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Contact is already exists vId: ' . $jR2["vid"] . '; Profile URL: ' . $jR2["profile-url"] . PHP_EOL;
                $retVal = true;
                $vid = $jR2["vid"];
            } else {
                $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Other result json: ' . var_export($jR2, 1) . PHP_EOL;
            }
            logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
        }
    }
    //
    if (empty($vid)) {
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Do not add a Deal without contact: ' . var_export($vid, 1) . PHP_EOL;
        logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
        return $retVal;
    }
    //
    $dealData = [];
    if (!is_null($vid)) {
        $dealData['associatedVids'] = $vid;
    }
    $dealData['dealname'] = $formData['page']['announce']['h1'];
    if (isset($formData['latel_deal_name']) && !empty($formData['latel_deal_name'])) {
        $dealData['dealname'] = $formData['latel_deal_name'];
    }
    $dealData['pipeline'] = '700575'; // 'Board'
    $dealData['dealstage'] = '700576'; // 'Leads'
    if (isset($formData['page']['attr']['attr_15']) && !empty($formData['page']['attr']['attr_15'])) {
        // $dealData['amount'] = "{$formData['page']['attr']['attr_15']}";
    }
    //
    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Deal data: ' . var_export($dealData, 1) . PHP_EOL;
    logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
    //
    $res3 = $hubSpot->addDeal($dealData);
    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Deal add result: ' . var_export($res3, 1) . PHP_EOL;
    logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
    //
    $dealJson = json_decode($res3, true);
    if (!empty($dealJson)) {
        $res4 = $hubSpot->updateDeal([
            'dealId'  =>  $dealJson['dealId'],
            'amount'  =>  "{$formData['page']['attr']['attr_15']}",
        ]);
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Update deal result: ' . var_export($res4, 1) . PHP_EOL;
        logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
    }
    //
    $dData1 = unserialize($data1);
    if (isset($dData1['formData']) && !empty($dData1['formData'])) {
        $uFd = unserialize($dData1['formData']);
        if (isset($uFd['ga_utm']) && !empty($uFd['ga_utm'])) {
            /**
             * Подписка на рассылку Digest
             *
             * отправляется сразу после подписки пользователем на рассылку
             *
             * @example: v=1&t=event&tid=UA-42378215-1&cid={google client id}&ec=DoMiteSystems&ea=Subscribe&el={id контакта crm}
             */
            $uGaUtm = json_decode($uFd['ga_utm'], true);
            //
            $tid = $db->escape(trim($uGaUtm['ga']['trackingId']));
            if (empty($tid) && isset($uGaUtm['ga']) && isset($uGaUtm['ga']['tid']) && !empty($uGaUtm['ga']['tid'])) {
                $tid = $db->escape(trim($uGaUtm['ga']['tid']));
            }
            $cid = $db->escape(trim($uGaUtm['ga']['clientId']));
            if (empty($cid) && isset($uGaUtm['ga']) && isset($uGaUtm['ga']['cid']) && !empty($uGaUtm['ga']['cid'])) {
                $cid = $db->escape(trim($uGaUtm['ga']['cid']));
            }
            //
            $status = $db->escape(trim('new_deal'));
            //
            $keyId = $db->escape($keyId);
            $portalId = $db->escape($dealJson['portalId']);
            $dealId = $db->escape($dealJson['dealId']);
            $dealName = $db->escape(trim($dealJson['properties']['dealname']['value']));
            $dealSum = $db->escape(trim($dealJson['properties']['amount']['value']));
            $dealData = $db->escape(trim($hubSpot->getDealById($dealJson['dealId'])));
            $dealStatus = 'New';
            $dealStage = $db->escape(trim($dealJson['properties']['dealstage']['value']));
            $pipeline = $db->escape(trim($dealJson['properties']['pipeline']['value']));
            $associatedVids = $db->escape(join(',', $dealJson['associations']['associatedVids']));
            $associatedCompanyIds = $db->escape(join(',', $dealJson['associations']['associatedCompanyIds']));
            $chksum1 = $db->escape(sha1($dealId . $dealStatus . $dealStage . $pipeline));
            //
            $ec = $db->escape(trim('DoMiteSystems'));
            $ea = $db->escape(trim('Lead [New]'));
            $el = $db->escape(trim('Подача объявления'));
            //
            $query = "INSERT IGNORE INTO " . GA_TABLE . " SET `key_id` = '{$keyId}', " .
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
                "`tid` = '{$tid}', " .
                "`cid` = '{$cid}', " .
                "`ec` = '{$ec}', " .
                "`ea` = '{$ea}', " .
                "`el` = '{$el}', " .
                "`received` = NOW()";
            $db->query($query);
        }
    }
    //

    return $retVal;
}

function sfInvestor($formData)
{
    global $db, $hubSpot, $logFileName, $keyId, $data1;

    $retVal = false;
    $vid = null;

    if (
        empty($formData['email'])
        || empty($formData['firstname'])
        || empty($formData['lastname'])
    ) {
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Empty required form data: ' . var_export($formData, 1) . PHP_EOL;
        logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);

        return $retVal;
    }

    $formData['email'] = trim($formData['email']);

    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Form data: ' . var_export($formData, 1) . PHP_EOL;
    logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);

    /**
     * @example:
     *
     * $formData = [
     *    'name' => 'Тестович Воррен Баффет',
     *    'company' => 'Умный капиталист',
     *    'job' => 'Главный инвестор',
     *    'email' => 'podlom+922@gmail.com',
     *    'City' => NULL,
     *    'phone' => '0671111222',
     *    'skype' => 'test_skype',
     *    'stage' => 'a:2:{i:0;s:31:"Стартап (Startup / Seed)";i:1;s:68:"Стадия роста и расширения (Growth / Expansion)";}',
     *    'types' => 'a:8:{i:0;s:45:"Финансовая деятельность";i:1;s:25:"Бизнес услуги";i:2;s:46:"Телекоммуникации и связь";i:3;s:68:"Искусство, развлечения, спорт и отдых";i:4;s:84:"Информационные технологии и интернет проекты";i:5;s:57:"Инновации и высокие технологии";i:6;s:22
    :"Образование";i:7;s:57:"Инновации и высокие технологии";}',
     *    'type_other' => NULL,
     *    'location' => 'a:2:{i:0;s:14:"Украина";i:1;s:6:"СНГ";}',
     *    'location_other' => NULL,
     *    'size' => 'a:1:{i:0;s:17:"до $100 тыс.";}',
     *    'inv' => 'a:2:{i:0;s:24:"Кредитование";i:1;s:28:"Сотрудничество";}',
     *    'type' => 'a:0:{}',
     *    'type2' => 'a:0:{}',
     *    'term' => 'a:0:{}',
     *    'rdy' => 'a:0:{}',
     *    'strong' => 'a:2:{i:0;s:10:"Связи";i:1;s:20:"Технологии";}',
     *    'strong_other' => NULL,
     *    'info' => 'Тестовые дополнительные критерии инвестирования',
     * ];
     */

    $contactData = [];
    $contactData['email'] = $formData['email'];
    $contactData['firstname'] = $formData['firstname'];
    // Подписка на рассылку
    if (preg_match('/([A-Za-z]+)/', $contactData['firstname'])) {
        $contactData['mailing'] = 'Дайджест (английский)';
    } else {
        $contactData['mailing'] = 'Дайджест (русский);Рассылка инвесторам';
    }
    //
    $contactData['lastname'] = $formData['lastname'];
    if (isset($formData['phone']) && !empty($formData['phone'])) {
        $contactData['phone'] = $formData['phone'];
    }
    if (isset($formData['company']) && !empty($formData['company'])) {
        $contactData['company'] = $formData['company'];
    }
    if (isset($formData['job']) && !empty($formData['job'])) {
        $contactData['jobtitle'] = $formData['job'];
    }
    $gaJson = json_decode($formData['ga_utm'], true);
    if (!empty($gaJson)) {
        $contactData['source'] = $gaJson['source_title'];
    }
    //
    // Стадии инвестирования [Стартап (Startup / Seed)]
    //
    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' $formData["stage"]: ' . var_export($formData['stage'], 1) . PHP_EOL;
    logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
    //
    if (!empty($formData['stage'])) { // @see: https://app.hubspot.com/property-settings/1982701/contact/stages
        $stages = [
            0 => 'Стартап (Startup / Seed)',
            1 => 'Стадия роста и расширения (Growth / Expansion)',
            2 => 'Поздние стадии (Later Stage / Exit)',
            3 => 'Проблемные активы (Distressed Assets)',
        ];
        $arStage = $formData['stage'];
        //
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' $arStage: ' . var_export($arStage, 1) . PHP_EOL;
        logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
        //
        if (is_array($arStage) && !empty($arStage)) {
            $allStages = [];
            foreach ($arStage as $st99) {
                if (isset($stages[ $st99 ])) {
                    $allStages[] = $stages[ $st99 ];
                }
            }
            if (!empty($allStages)) {
                $contactData['stages'] = join(';', $allStages);
            }
        } elseif (!empty($formData['stage'])) {
            if (isset($stages[ $formData['stage'] ])) {
                $contactData['stages'] = $stages[ $formData['stage'] ];
            }
        }
        //
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' $contactData["stages"]: ' . var_export($contactData['stages'], 1) . PHP_EOL;
        logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
        //
    }
    //
    // Отрасль [Сельское хозяйство]
    //
    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' $formData["types"]: ' . var_export($formData['types'], 1) . PHP_EOL;
    logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
    //
    if (!empty($formData['types'])) { // @see: https://app.hubspot.com/property-settings/1982701/contact/sector
        $sectors = [
            0 => 'Сельское хозяйство',
            1 => 'Пищевая промышленность',
            2 => 'Добывающая промышленность',
            3 => 'Металлургия и металлообработка',
            4 => 'Машиностроение и производство электрооборудования',
            5 => 'Нефтехимическая промышленность',
            6 => 'Фармацевтическая промышленность',
            7 => 'Деревообработка и целлюлозно-бумажная промышленность',
            8 => 'Текстильная промышленность',
            9 => 'Строительство и недвижимость',
            10 => 'Финансовая деятельность',
            11 => 'Оптовая и розничная торговля',
            12 => 'Бизнес услуги',
            13 => 'Транспорт и складское хозяйство',
            14 => 'Телекоммуникации и связь',
            15 => 'Искусство, развлечения, спорт и отдых',
            16 => 'Электроэнергетика и топливная промышленность',
            17 => 'Водообеспечение и переработка отходов',
            18 => 'Информационные технологии и интернет проекты',
            19 => 'Инновации и высокие технологии',
            20 => 'Здравоохранение и социальная помощь',
            21 => 'Потребительские услуги',
            22 => 'Образование',
            23 => 'Организации и ассоциации',
        ];
        // $arTypes = unserialize($formData['types']);
        $arTypes = $formData['types'];
        //
        if (is_array($arTypes) && !empty($arTypes)) {
            $allTypes = [];
            foreach ($arTypes as $at88) {
                if (isset($sectors[ trim($at88) ])) {
                    $allTypes[] = $sectors[ trim($at88) ];
                }
            }
            if (!empty($allTypes)) {
                $contactData['sector'] = trim( join(';', $allTypes) );
            }
        } elseif (!empty($arTypes)) {
            // $contactData['sector'] = trim($formData['types']);
            if (isset($sectors[ trim($formData['types']) ])) {
                $contactData['sector'] = $sectors[ trim($formData['types']) ];
            }
        }
        //
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' $contactData["sector"]: ' . var_export($contactData['sector'], 1) . PHP_EOL;
        logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
        //
    }
    // Объемы инвестирования [до $100 тыс.]
    //
    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' $formData["size"]: ' . var_export($formData['size'], 1) . PHP_EOL;
    logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
    //
    if (!empty($formData['size'])) { // @see: https://app.hubspot.com/property-settings/1982701/contact/value
        $values = [
            0 => 'до $100 тыс.',
            1 => 'от $100 тыс. до $500 тыс.',
            2 => 'от 500 тыс. до $1 млн.',
            3 => 'от $1 млн. до $5 млн.',
            4 => 'от $5 млн. до $10 млн.',
            5 => 'более $10 млн.',
        ];
        // $aSize = unserialize($formData['size']);
        $aSize = $formData['size'];
        //
        if (is_array($aSize) && !empty($aSize)) {
            $allSizes = [];
            foreach ($aSize as $a77) {
                if (isset($values[ $a77 ])) {
                    $allSizes[] = $values[ $a77 ];
                }
            }
            if (!empty($allSizes)) {
                $contactData['value'] = trim( join(';', $allSizes) );
            }
        } elseif (!empty($formData['size'])) {
            // $contactData['value'] = trim( $formData['size'] );
            if (isset($values[ trim($formData['size']) ])) {
                $contactData['value'] = $values[ trim($formData['size']) ];
            }
        }
        //
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' $contactData["value"]: ' . var_export($contactData['value'], 1) . PHP_EOL;
        logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
        //
    }
    // Регион [Украина]
    //
    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' $formData["location"]: ' . var_export($formData['location'], 1) . PHP_EOL;
    logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
    //
    if (!empty($formData['location'])) { // @see: https://app.hubspot.com/property-settings/1982701/contact/region
        $regions = [
            0 => 'Украина',
            1 => 'СНГ',
            2 => 'Центральная и Восточная Европа',
            3 => 'Западная Европа',
            4 => 'США',
            5 => 'Азия',
        ];
        $aRegion = $formData['location'];
        //
        if (is_array($aRegion) && !empty($aRegion)) {
            $allRegions = [];
            foreach ($aRegion as $a55) {
                if (isset($regions[ $a55 ])) {
                    $allRegions[] = $regions[ $a55 ];
                }
            }
            if (!empty($allRegions)) {
                $contactData['region'] = trim( join(';', $allRegions) );
            }
        } elseif (!empty($formData['location'])) {
            if (isset($regions[ $formData['location'] ])) {
                $contactData['region'] = $regions[ $formData['location'] ];
            }
        }
        //
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' $contactData["region"]: ' . var_export($contactData['region'], 1) . PHP_EOL;
        logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
        //
    }
    // Сильные стороны [Финансы]
    //
    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' $formData["strong"]: ' . var_export($formData['strong'], 1) . PHP_EOL;
    logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
    //
    if (!empty($formData['strong'])) { // @see: https://app.hubspot.com/property-settings/1982701/contact/strengths
        $strengths = [
            0 => 'Финансы',
            1 => 'Управление',
            2 => 'Связи',
            3 => 'Технологии',
            4 => 'Недвижимость',
        ];
        // $aStrengths = unserialize($formData['strong']);
        $aStrengths = $formData['strong'];
        //
        if (is_array($aStrengths) && !empty($aStrengths)) {
            // $contactData['strengths'] = trim( join(';', $aStrengths) );
            $allStr = [];
            foreach ($aStrengths as $a44) {
                if (isset($strengths[ $a44 ])) {
                    $allStr[] = $strengths[ $a44 ];
                }
            }
            if (!empty($allStr)) {
                $contactData['strengths'] = trim( join(';', $allStr) );
            }
        } elseif (!empty($formData['strong'])) {
            // $contactData['strengths'] = trim( $formData['strong'] );
            if (isset($strengths[ trim($formData['strong']) ])) {
                $contactData['strengths'] = $strengths[ trim($formData['strong']) ];
            }
        }
        //
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' $contactData["strengths"]: ' . var_export($contactData['strengths'], 1) . PHP_EOL;
        logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
        //
    }
    // Форма инвестирования [Кредитование]
    //
    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' $formData["inv"]: ' . var_export($formData['inv'], 1) . PHP_EOL;
    logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
    //
    if (!empty($formData['inv'])) { // @see: https://app.hubspot.com/property-settings/1982701/contact/form_of_investment
        $formsOfInv = [
            0 => 'Кредитование',
            1 => 'Сотрудничество',
            2 => 'Контрольный пакет (более 50% доли в бизнесе)',
            3 => 'Миноритарный пакет (менее 50% доли в бизнесе)',
        ];
        $aInvForm = unserialize($formData['inv']);
        if (is_array($aInvForm) && !empty($aInvForm)) {
            // $contactData['form_of_investment'] = trim( join(';', $aInvForm) );
            $allForms = [];
            foreach ($aInvForm as $a33) {
                if (isset($formsOfInv[ $a33 ])) {
                    $allForms[] = $formsOfInv[ $a33 ];
                }
            }
            if (!empty($allForms)) {
                $contactData['form_of_investment'] = trim( join(';', $allForms) );
            }
        } elseif (!empty($formData['inv'])) {
            // $contactData['form_of_investment'] = trim( $formData['inv'] );
            if (isset($formsOfInv[ trim($formData['inv']) ])) {
                $contactData['form_of_investment'] = $formsOfInv[ trim($formData['inv']) ];
            }
        }
    }
    //
    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' $contactData["form_of_investment"]: ' . var_export($contactData['form_of_investment'], 1) . PHP_EOL;
    logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
    //
    // Тип клиента
    $contactData['type_of_client'] = 'Инвестор'; // @see: https://app.hubspot.com/property-settings/1982701/contact/type_of_client
    //
    // TODO: get contact owner - now hardcoded to - ts@doagency.net
    // $contactData['hubspot_owner_id'] = 36382326;
    //
    $res1 = $hubSpot->findContactByEmail($formData['email']);
    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Hubspot::findContactByEmail(' . $formData['email'] . ') result: ' . var_export($res1, 1) . PHP_EOL;
    logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);

    if ($res1 !== false) {
        $jR2 = json_decode($res1, true);
        if (isset($jR2['status']) && isset($jR2['message'])) {
            if (
                ($jR2['status'] == 'error')
                && ($jR2['message'] == 'contact does not exist')
            ) {
                $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Debug $contactData: ' . var_export($contactData, 1) . PHP_EOL;
                logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
                
                // Add new or update existing contact
                $res2 = $hubSpot->addOrUpdateContact($contactData);
                $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Hubspot::addOrUpdateContact result: ' . var_export($res2, 1) . PHP_EOL;
                logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
                //
                if (!empty($res2) && ($res2 !== false)) {
                    $jR3 = json_decode($res2, true);
                    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Contact vId: ' . $jR3["vid"] . '; Profile URL: ' . $jR3["profile-url"] . PHP_EOL;
                    logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
                    $retVal = true;
                    $vid = $jR3["vid"];
                }
            }
        } else {
            if (isset($jR2["vid"]) && isset($jR2["profile-url"])) {
                $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Contact is already exists vId: ' . $jR2["vid"] . '; Profile URL: ' . $jR2["profile-url"] . PHP_EOL;
                $retVal = true;
                $vid = $jR2["vid"];
            } else {
                $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Other result json: ' . var_export($jR2, 1) . PHP_EOL;
            }
            logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
        }
    }
    //
    if (empty($vid)) { // Do not add deal without contact
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Errors creating contact empty vid: ' . var_export($vid, 1) . PHP_EOL;
        logMsg($msg, $logFileName, ['echoLogMsg' => true, 'storeLog' => true]);
        return $retVal;
    }
    //
    $dealData = [];
    if (!is_null($vid)) {
        $dealData['associatedVids'] = $vid;
    }
    // 'properties'
    $dealData['dealname']  = 'Регистрация инвестора';
    if (isset($formData['latel_deal_name']) && !empty($formData['latel_deal_name'])) {
        $dealData['dealname']  = $formData['latel_deal_name'];
    }
    /* if (!empty($formData['name'])) {
        $dealData['dealname'] .= ' ' . $formData['name'];
    }
    if (!empty($formData['size'])) {
        $arSize = unserialize($formData['size']);
        if (!empty($arSize) && is_array($arSize)) {
            $lastSize = end($arSize);
            $dealData['dealname'] .= ' ' . $lastSize;
        }
    } */
    // $dealData['pipeline']  = '284b44a8-da35-471c-a3df-d5eff6f50f98'; // 'Buy Pipeline',
    // $dealData['dealstage'] = '73fe7273-d5f6-4eb2-9653-60d83d0fae04'; // 'Issues',
    $dealData['pipeline'] = '714da3ad-adca-4cea-847b-2e02ef6c4fe1'; // 'Pipeline'
    $dealData['dealstage'] = '449211'; // 'Leads'
    // "hubspot_owner_id"
    // "closedate"
    // $dealData['amount'] = join(', ', $arSize);
    // "dealtype"
    //
    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Deal data: ' . var_export($dealData, 1) . PHP_EOL;
    logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
    //
    $res3 = $hubSpot->addDeal($dealData);
    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Deal add result: ' . var_export($res3, 1) . PHP_EOL;
    logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
    //
    $dealJson = json_decode($res3, true);
    //
    $dData1 = unserialize($data1);
    if (isset($dData1['formData']) && !empty($dData1['formData'])) {
        $uFd = unserialize($dData1['formData']);
        if (isset($uFd['ga_utm']) && !empty($uFd['ga_utm'])) {
            $uGaUtm = json_decode($uFd['ga_utm'], true);
            $tid = $db->escape(trim($uGaUtm['ga']['trackingId']));
            if (empty($tid) && isset($uGaUtm['ga']) && isset($uGaUtm['ga']['tid']) && !empty($uGaUtm['ga']['tid'])) {
                $tid = $db->escape(trim($uGaUtm['ga']['tid']));
            }
            $cid = $db->escape(trim($uGaUtm['ga']['clientId']));
            if (empty($cid) && isset($uGaUtm['ga']) && isset($uGaUtm['ga']['cid']) && !empty($uGaUtm['ga']['cid'])) {
                $cid = $db->escape(trim($uGaUtm['ga']['cid']));
            }
            $status = $db->escape(trim('new_deal'));
            $keyId = $db->escape($keyId);
            $portalId = $db->escape($dealJson['portalId']);
            $dealId = $db->escape($dealJson['dealId']);
            $dealName = $db->escape(trim($dealJson['properties']['dealname']['value']));
            $dealSum = $db->escape(trim($dealJson['properties']['amount']['value']));
            $dealData = $db->escape(trim($hubSpot->getDealById($dealJson['dealId'])));
            $dealStatus = 'New';
            $dealStage = $db->escape(trim($dealJson['properties']['dealstage']['value']));
            $pipeline = $db->escape(trim($dealJson['properties']['pipeline']['value']));
            $associatedVids = $db->escape(join(',', $dealJson['associations']['associatedVids']));
            $associatedCompanyIds = $db->escape(join(',', $dealJson['associations']['associatedCompanyIds']));
            $chksum1 = $db->escape(sha1($dealId . $dealStatus . $dealStage . $pipeline));
            /**
             * Новая заявка (цель: Лиды)
             *
             * Отправляется когда пользователь отправляет любую заявку с сайта:
             * Регистрация инвестора
             *
             * Название продукта - "Реклама и продвижение", "Индивидуальный подход", “Регистрация инвестора”, “Обратная связь” (для всех неизвестных)
             *
             * Для всех начало: v=1&t=event&tid=UA-42378215-1&cid={google client id}
             * @example: &ec=DoMiteSystems&ea=Lead [New]&el={Название продукта}
             */
            //
            $ec = $db->escape(trim('DoMiteSystems'));
            $ea = $db->escape(trim('Lead [New]'));
            $el = $db->escape(trim('Регистрация инвестора'));
            //
            $query = "INSERT IGNORE INTO " . GA_TABLE . " SET `key_id` = '{$keyId}', " .
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
                "`tid` = '{$tid}', " .
                "`cid` = '{$cid}', " .
                "`ec` = '{$ec}', " .
                "`ea` = '{$ea}', " .
                "`el` = '{$el}', " .
                "`received` = NOW()";
            $db->query($query);
        }
        //
        if (!empty($formData['info'])) {
            // @see: https://developers.hubspot.com/docs/methods/engagements/create_engagement
            $addNoteRes = $hubSpot->addDealNote([
                'engagement' => [
                    "active" => true,
                    "ownerId" => $hubSpot->getOwnerId(),
                    "type" => "NOTE",
                    "timestamp" => $hubSpot->getTimeStamp(),
                ],
                'associations' => [
                    "contactIds" => [ $vid ],
                    "companyIds" => [ ],
                    "dealIds" => [ $dealJson['dealId'] ],
                    "ownerIds" => [ $hubSpot->getOwnerId() ],
                ],
                'attachments' => [],
                'metadata' => [
                    "body" => $formData['info'],
                ],
            ]);
            $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Add note res: ' . var_export($addNoteRes, 1) . PHP_EOL;
            logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
        }
    }
    //

    return $retVal;
}

function sfCallback($formData)
{
    global $db, $hubSpot, $logFileName, $keyId, $data1;

    $logPrefs = ['echoLogMsg' => false, 'storeLog' => true];

    $retVal = false;
    return $retVal; // @ts 2020-12-14 stop callback spam

    $vid = null;

    if (
        empty($formData['tel'])
        || empty($formData['firstname'])
        || empty($formData['lastname'])
    ) {
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Empty required form data: ' . var_export($formData, 1) . PHP_EOL;
        logMsg($msg, $logFileName, $logPrefs);
        return $retVal;
    }

    $formData['tel'] = trim($formData['tel']);

    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Form data: ' . var_export($formData, 1) . PHP_EOL;
    logMsg($msg, $logFileName, $logPrefs);

    $res1 = $hubSpot->findContactByPhone($formData['tel']);
    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Hubspot::findContactByPhone(' . $formData['tel'] . ') result: ' . var_export($res1, 1) . PHP_EOL;
    logMsg($msg, $logFileName, $logPrefs);

    $json1 = json_decode($res1, true);
    // $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' $json1: ' . var_export($json1, 1) . PHP_EOL;
    // logMsg($msg, $logFileName, $logPrefs);
    if (isset($json1['contacts'], $json1['contacts'][0], $json1['contacts'][0]['vid'])) {
        $vid = $json1['contacts'][0]['vid'];
        //
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Found contact with $vid: ' . var_export($vid, 1) . PHP_EOL;
        logMsg($msg, $logFileName, $logPrefs);
    }
    if ($json1['total'] == 0) {
        $contactData = [];
        if (empty($formData['email']) || !isset($formData['email'])) {
            $contactData['email'] = 'callback+' . time() . '-' . rand(100, 999) . '@inventure.com.ua';
        } else {
            $contactData['email'] = $formData['email'];
        }
        $contactData['firstname'] = $formData['firstname'];
        $contactData['lastname'] = $formData['lastname'];
        $contactData['phone'] = $formData['tel'];
        $gaJson = json_decode($formData['ga_utm'], true);
        if (!empty($gaJson)) {
            $contactData['source'] = $gaJson['source_title'];
        }
        //
        // Тип клиента
        $contactData['type_of_client'] = 'Клиент'; // @see: https://app.hubspot.com/property-settings/1982701/contact/type_of_client
        //
        $res2 = $hubSpot->addOrUpdateContact($contactData);
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Hubspot::addOrUpdateContact result: ' . var_export($res2, 1) . PHP_EOL;
        logMsg($msg, $logFileName, $logPrefs);

        $jR2 = json_decode($res2, true);
        if (isset($jR2['vid'])) {
            $vid = $jR2['vid'];
        }
    }

    //
    $dealData = [];
    if (!is_null($vid)) {
        $dealData['associatedVids'] = $vid;
    }
    //
    // $dealData['dealname']  = 'Callback';
    $dealData['dealname'] = 'Callback';
    if (isset($formData['latel_deal_name']) && !empty($formData['latel_deal_name'])) {
        $dealData['dealname'] = $formData['latel_deal_name'];
    }
    //
    $dealData['pipeline'] = '714da3ad-adca-4cea-847b-2e02ef6c4fe1'; // 'Pipeline'
    $dealData['dealstage'] = '449211'; // 'Leads'
    //
    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Deal data: ' . var_export($dealData, 1) . PHP_EOL;
    logMsg($msg, $logFileName, $logPrefs);
    //
    $res3 = $hubSpot->addDeal($dealData);
    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Deal add result: ' . var_export($res3, 1) . PHP_EOL;
    logMsg($msg, $logFileName, $logPrefs);
    //
    $dealJson = json_decode($res3, true);
    // $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Deal result data: ' . var_export($dealJson, 1) . PHP_EOL;
    // logMsg($msg, $logFileName, $logPrefs);
    if (!empty($dealJson)) {
        $retVal = true;
    }
    //
    $dData1 = unserialize($data1);
    if (isset($dData1['formData']) && !empty($dData1['formData'])) {
        $uFd = unserialize($dData1['formData']);
        if (isset($uFd['ga_utm']) && !empty($uFd['ga_utm'])) {
            /**
             * Новая заявка (цель: Лиды)
             * Отправляется когда пользователь отправляет любую заявку с сайта:
             * Callback
             * Название продукта - "Реклама и продвижение", "Индивидуальный подход", “Регистрация инвестора”, “Обратная связь” (для всех неизвестных)
             * @example: v=1&t=event&tid=UA-42378215-1&cid={google client id}&ec=DoMiteSystems&ea=Lead [New]&el={Название продукта}
             */
            $uGaUtm = json_decode($uFd['ga_utm'], true);
            //
            $tid = $db->escape(trim($uGaUtm['ga']['trackingId']));
            if (empty($tid) && isset($uGaUtm['ga']) && isset($uGaUtm['ga']['tid']) && !empty($uGaUtm['ga']['tid'])) {
                $tid = $db->escape(trim($uGaUtm['ga']['tid']));
            }
            $cid = $db->escape(trim($uGaUtm['ga']['clientId']));
            if (empty($cid) && isset($uGaUtm['ga']) && isset($uGaUtm['ga']['cid']) && !empty($uGaUtm['ga']['cid'])) {
                $cid = $db->escape(trim($uGaUtm['ga']['cid']));
            }
            //
            $status = $db->escape(trim('new_deal'));
            //
            $keyId = $db->escape($keyId);
            $portalId = $db->escape($dealJson['portalId']);
            $dealId = $db->escape($dealJson['dealId']);
            $dealName = $db->escape(trim($dealJson['properties']['dealname']['value']));
            $dealSum = $db->escape(trim($dealJson['properties']['amount']['value']));
            $dealData = $db->escape(trim($hubSpot->getDealById($dealJson['dealId'])));
            $dealStatus = 'New';
            $dealStage = $db->escape(trim($dealJson['properties']['dealstage']['value']));
            $pipeline = $db->escape(trim($dealJson['properties']['pipeline']['value']));
            $associatedVids = $db->escape(join(',', $dealJson['associations']['associatedVids']));
            $associatedCompanyIds = $db->escape(join(',', $dealJson['associations']['associatedCompanyIds']));
            $chksum1 = $db->escape(sha1($dealId . $dealStatus . $dealStage . $pipeline));
            $contactVid = $db->escape($vid);
            //
            $ec = $db->escape(trim('DoMiteSystems'));
            $ea = $db->escape(trim('Lead [New]'));
            $el = $db->escape(trim('Обратная связь'));
            //
            $query = "INSERT IGNORE INTO " . GA_TABLE . " SET `key_id` = '{$keyId}', " .
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
                "`contact_vid` = '{$contactVid}', " .
                "`associated_company_ids` = '{$associatedCompanyIds}', " .
                "`chksum1` = '{$chksum1}', " .
                "`tid` = '{$tid}', " .
                "`cid` = '{$cid}', " .
                "`ec` = '{$ec}', " .
                "`ea` = '{$ea}', " .
                "`el` = '{$el}', " .
                "`received` = NOW()";
            $db->query($query);
        }
    }
    //

    return $retVal;
}

function sfApproach($formData)
{
    global $db, $hubSpot, $logFileName, $keyId, $data1;

    $logPrefs = ['echoLogMsg' => false, 'storeLog' => true];

    $retVal = false;
    $vid = null;

    if (
        empty($formData['email'])
        || empty($formData['firstname'])
        || empty($formData['lastname'])
    ) {
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Empty required form data: ' . var_export($formData, 1) . PHP_EOL;
        logMsg($msg, $logFileName, $logPrefs);

        return $retVal;
    }

    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Form data: ' . var_export($formData, 1) . PHP_EOL;
    logMsg($msg, $logFileName, $logPrefs);

    /**
     * @example:
     * $formData = [
     *    'name' => 'Дмитрий Монатик',
     *    'email' => 'podlom+monatik@gmail.com',
     *    'tel' => '0636886884',
     *    'text' => 'А ну давай, танцуй!',
     * ];
     */

    // $res1 = $hubSpot->findContactByEmail($formData['email']);
    //
    $res1 = $hubSpot->findContactByPhone($formData['tel']);
    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Hubspot::findContactByPhone(' . $formData['tel'] . ') result: ' . var_export($res1, 1) . PHP_EOL;
    logMsg($msg, $logFileName, $logPrefs);

    $json1 = json_decode($res1, true);
    if ((isset($json1['status']) && ($json1['status'] == 'error'))
        && ($json1['message'] == 'contact does not exist')
    ) {
        $contactData = [];
        $contactData['email'] = $formData['email'];
        $contactData['lastname'] = $formData['lastname'];
        $contactData['firstname'] = $formData['firstname'];
        $gaJson = json_decode($formData['ga_utm'], true);
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' $gaJson: ' . var_export($gaJson, true) . PHP_EOL;
        logMsg($msg, $logFileName, $logPrefs);
        if (!empty($gaJson)) {
            $contactData['source'] = $gaJson['source_title'];
        }
        $contactData['phone'] = $formData['tel'];
        //
        // Тип клиента
        $contactData['type_of_client'] = 'Клиент'; // @see: https://app.hubspot.com/property-settings/1982701/contact/type_of_client
        //
        // Add new or update existing contact
        $res2 = $hubSpot->addOrUpdateContact($contactData);
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Hubspot::addOrUpdateContact result: ' . var_export($res2, 1) . PHP_EOL;
        logMsg($msg, $logFileName, $logPrefs);
        //
        $json2 = json_decode($res2, true);
        if (isset($json2['vid'])) {
            $vid = $json2['vid'];
        }
    } elseif (isset($json1['vid'])) {
        $vid = $json1['vid'];
    } else {
        $contactData = [];
        // $contactData['email'] = $formData['email'];
        $contactData['lastname'] = $formData['lastname'];
        $contactData['firstname'] = $formData['firstname'];
        $contactData['phone'] = $formData['tel'];
        $contactData['type_of_client'] = 'Клиент';
        // $res3 = $hubSpot->addOrUpdateContact($contactData);
        //
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' $contactData: ' . var_export($contactData, 1) . PHP_EOL;
        logMsg($msg, $logFileName, $logPrefs);
        //
        $res3 = $hubSpot->addContact($contactData);
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Hubspot::addOrUpdateContact result: ' . var_export($res3, 1) . PHP_EOL;
        logMsg($msg, $logFileName, $logPrefs);
        //
        $json3 = json_decode($res3, true);
        if (isset($json3['vid'])) {
            $vid = $json3['vid'];
        }
    }
    //
    if (empty($vid)) {
        //
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' $vid is empty: ' . var_export($vid, 1) . PHP_EOL;
        logMsg($msg, $logFileName, $logPrefs);
        //
        $contactData = [];
        if (empty($formData['email']) || !isset($formData['email'])) {
            $contactData['email'] = 'approach+' . time() . '-' . rand(100, 999) . '@inventure.com.ua';
        } else {
            $contactData['email'] = $formData['email'];
        }
        $contactData['firstname'] = $formData['firstname'];
        $contactData['lastname'] = $formData['lastname'];
        $contactData['phone'] = $formData['tel'];
        $contactData['type_of_client'] = 'Клиент';
        $res22 = $hubSpot->addOrUpdateContact($contactData);
        //
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Hubspot::addOrUpdateContact result: ' . var_export($res22, 1) . PHP_EOL;
        logMsg($msg, $logFileName, $logPrefs);
        //
        $jR22 = json_decode($res22, true);
        if (isset($jR22['vid'])) {
            $vid = $jR22['vid'];
        }
    }
    // Create deal
    $dealData = [];
    if (!is_null($vid)) {
        $dealData['associatedVids'] = $vid;
    }
    if (!isset($formData['latel_deal_name'])) {
        $formData['latel_deal_name'] = 'Реклама и продвижение';
    }
    $dealData['dealname']  = $formData['latel_deal_name'];
    $dealData['pipeline'] = '714da3ad-adca-4cea-847b-2e02ef6c4fe1'; // 'Pipeline'
    $dealData['dealstage'] = '449211'; // 'Leads'
    /* if (!empty($formData['price'])) {
        $dealData['amount'] = $formData['price'];
    } */
    //
    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Deal data: ' . var_export($dealData, 1) . PHP_EOL;
    logMsg($msg, $logFileName, $logPrefs);
    $res3 = $hubSpot->addDeal($dealData);
    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Deal add result: ' . var_export($res3, 1) . PHP_EOL;
    logMsg($msg, $logFileName, $logPrefs);
    //
    // Add note from text form field
    if (!empty($formData['text']) || !empty($formData['querytype']) || !empty($formData['price']) || !empty($formData['region'])) {
        $dealJson = json_decode($res3, true);
        if (!is_null($dealJson)) {
            $retVal = true;
            $noteText = '';
            if (isset($formData['querytype'])) {
                $qryType = [
                    '0' => 'Продажа бизнеса',
                    '1' => 'Инвестиции в действующий бизнес',
                    '2' => 'Инвестиции в стартап',
                    '3' => 'Продажа коммерческой недвижимости',
                    '4' => 'Реклама франшизы',
                    '5' => 'Другое'
                ];
                $qType = $formData['querytype'];
                if (isset($qryType[ $formData['querytype'] ])) {
                    $qType = $qryType[ $formData['querytype'] ];
                }
                $noteText .= ' С чем связан ваш запрос: ' . $qType . '<br />' . PHP_EOL;
            }
            if (!empty($formData['price'])) {
                $noteText .= ' Требуемые инвестиции / Цена $: ' . $formData['price'] . '<br />' . PHP_EOL;
            }
            if (!empty($formData['region'])) {
                $noteText .= ' Регион: ' . $formData['region'] . '<br />' . PHP_EOL;
            }
            $noteText .= $formData['text'] . PHP_EOL;
            // @see: https://developers.hubspot.com/docs/methods/engagements/create_engagement
            $addNoteRes = $hubSpot->addDealNote([
                'engagement' => [
                    "active" => true,
                    "ownerId" => $hubSpot->getOwnerId(),
                    "type" => "NOTE",
                    "timestamp" => $hubSpot->getTimeStamp(),
                ],
                'associations' => [
                    "contactIds" => [ $vid ],
                    "companyIds" => [ ],
                    "dealIds" => [ $dealJson['dealId'] ],
                    "ownerIds" => [ $hubSpot->getOwnerId() ],
                ],
                'attachments' => [],
                'metadata' => [
                    "body" => $noteText,
                ],
            ]);
            $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Add note res: ' . var_export($addNoteRes, 1) . PHP_EOL;
            logMsg($msg, $logFileName, $logPrefs);
        }
    }
    //
    $dealJson = json_decode($res3, true);
    $dData1 = unserialize($data1);
    if (isset($dData1['formData']) && !empty($dData1['formData'])) {
        $uFd = unserialize($dData1['formData']);
        if (isset($uFd['ga_utm']) && !empty($uFd['ga_utm'])) {
            if (empty($gaJson)) {
                $gaJson = json_decode($uFd['ga_utm'], true);
            }
            if (!empty($gaJson)) {
                $tid = $db->escape(trim($gaJson['ga']['trackingId']));
                if (empty($tid) && isset($gaJson['ga']) && isset($gaJson['ga']['tid']) && !empty($gaJson['ga']['tid'])) {
                    $tid = $db->escape(trim($gaJson['ga']['tid']));
                }
                $cid = $db->escape(trim($gaJson['ga']['clientId']));
                if (empty($cid) && isset($gaJson['ga']) && isset($gaJson['ga']['cid']) && !empty($gaJson['ga']['cid'])) {
                    $cid = $db->escape(trim($gaJson['ga']['cid']));
                }
            }
            $status = $db->escape(trim('new_deal'));
            $keyId = $db->escape($keyId);
            $portalId = $db->escape($dealJson['portalId']);
            $dealId = $db->escape($dealJson['dealId']);
            $dealName = $db->escape(trim($dealJson['properties']['dealname']['value']));
            $dealSum = $db->escape(trim($dealJson['properties']['amount']['value']));
            $dealData = $db->escape(trim($hubSpot->getDealById($dealJson['dealId'])));
            $dealStatus = 'New';
            $dealStage = $db->escape(trim($dealJson['properties']['dealstage']['value']));
            $pipeline = $db->escape(trim($dealJson['properties']['pipeline']['value']));
            $associatedVids = $db->escape(join(',', $dealJson['associations']['associatedVids']));
            $associatedCompanyIds = $db->escape(join(',', $dealJson['associations']['associatedCompanyIds']));
            $chksum1 = $db->escape(sha1($dealId . $dealStatus . $dealStage . $pipeline));
            /**
             * @see: https://docs.google.com/document/d/1EVix_Ax_2FNKmOMq_3pkyEcQjDRtitm2k1XZ2SDu7kA/edit?ts=5d130f3a#
             *
             * Новая заявка (цель: Лиды)
             *
             * Отправляется когда пользователь отправляет любую заявку с сайта:
             * Индивидуальный подход
             * Реклама и продвижение
             *
             * Название продукта - "Реклама и продвижение", "Индивидуальный подход", “Регистрация инвестора”, “Обратная связь” (для всех неизвестных)
             *
             * Для всех начало: v=1&t=event&tid=UA-42378215-1&cid={google client id}
             * @example: &ec=DoMiteSystems&ea=Lead [New]&el={Название продукта}
             */
            //
            $ec = $db->escape(trim('DoMiteSystems'));
            $ea = $db->escape(trim('Lead [New]'));
            $el = $db->escape(trim( $formData['latel_deal_name'] ));
            //
            $query = "INSERT IGNORE INTO " . GA_TABLE . " SET `key_id` = '{$keyId}', " .
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
                "`tid` = '{$tid}', " .
                "`cid` = '{$cid}', " .
                "`ec` = '{$ec}', " .
                "`ea` = '{$ea}', " .
                "`el` = '{$el}', " .
                "`received` = NOW()";
            $db->query($query);
        }
    }
    //

    return $retVal;
}

function fSubscribe($formData)
{
    global $db, $hubSpot, $logFileName, $keyId, $data1;

    $retVal = false;
    $vid = null;

    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Form data: ' . var_export($formData, 1) . PHP_EOL;
    logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);

    if (empty($formData['email'])) {
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Empty email: ' . var_export($formData['email'], 1) . PHP_EOL;
        logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
        return $retVal;
    }

    $res1 = $hubSpot->findContactByEmail($formData['email']);
    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Hubspot::findContactByEmail(' . $formData['email'] . ') result: ' . var_export($res1, 1) . PHP_EOL;
    logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);

    $json1 = json_decode($res1, true);
    if (
        ($json1['status'] == 'error')
        && ($json1['message'] == 'contact does not exist')
    ) {
        $contactData = [];
        $contactData['email'] = $formData['email'];
        //
        if (isset($formData['firstname']) && !empty($formData['firstname']) && isset($formData['lastname']) && !empty($formData['lastname'])) {
            $contactData['lastname'] = $formData['lastname'];
            $contactData['firstname'] = $formData['firstname'];
        } else {
            $p0 = strpos($formData['name'], ' ');
            if ($p0 !== false) {
                $a0 = explode(' ', $formData['name']);
                $contactData['lastname'] = $a0[0];
                $contactData['firstname'] = $a0[1];
            } else {
                $contactData['firstname'] = $formData['name'];
            }
        }
        //
        if (isset($formData['company']) && !empty($formData['company'])) {
            $contactData['company'] = $formData['company'];
        }
        //
        if (isset($formData['job']) && !empty($formData['job'])) {
            $contactData['jobtitle'] = $formData['job'];
        } elseif (isset($formData['jobtitle']) && !empty($formData['jobtitle'])) {
            $contactData['jobtitle'] = $formData['jobtitle'];
        }
        //
        if (isset($formData['phone']) && !empty($formData['phone'])) {
            $contactData['phone'] = Hubspot::cleanPhoneNumber($formData['phone']);
        } elseif (isset($formData['tel']) && !empty($formData['tel'])) {
            $contactData['phone'] = Hubspot::cleanPhoneNumber($formData['tel']);
        }
        //
        $gaJson = json_decode($formData['ga_utm'], true);
        if (!empty($gaJson)) {
            $contactData['source'] = $gaJson['source_title'];
        }
        //
        // Подписка на рассылку Digest
        if (is_array($formData['lang']) && !empty($formData['lang'])) {
            $sep1 = '';
            foreach ($formData['lang'] as $lId => $ln) {
                if ($ln == 'en') {
                    $contactData['mailing'] .= $sep1 . 'Дайджест (английский)';
                } else {
                    $contactData['mailing'] .= $sep1 . 'Дайджест (русский)';
                }
                $sep1 = ';';
            }
        } elseif (!empty($formData['lang'])) {
            if ($formData['lang'] == 'ru') {
                $contactData['mailing'] = 'Дайджест (русский)';
            } else {
                $contactData['mailing'] = 'Дайджест (английский)';
            }
        }
        //
        // Тип клиента
        $contactData['type_of_client'] = 'Клиент'; // @see: https://app.hubspot.com/property-settings/1982701/contact/type_of_client
        //
        $res2 = $hubSpot->addOrUpdateContact($contactData);
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Hubspot::addOrUpdateContact result: ' . var_export($res2, 1) . PHP_EOL;
        logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
        //
        $json2 = json_decode($res2, true);
        if (isset($json2['vid'])) {
            $vid = $json2['vid'];
        }
    } elseif (isset($json1['vid'])) {
        $vid = $json1['vid'];
    }

    if (empty($vid)) {
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Empty contact id: ' . var_export($vid, 1) . PHP_EOL;
        logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
        return $retVal;
    }

    /*
    if (!empty($gaJson)) {
        $tid = $db->escape(trim($gaJson['ga']['trackingId']));
        $cid = $db->escape(trim($gaJson['ga']['clientId']));
        $status = $db->escape(trim('new_deal'));
        $keyId = $db->escape($keyId);
        $portalId = $db->escape($hubSpot->getPortalId());
        $dealId = $db->escape(0);
        $dealName = $db->escape('');
        $dealSum = $db->escape('');
        $dealData = $db->escape('');
        $dealStatus = 'New';
        $dealStage = $db->escape('');
        $pipeline = $db->escape('');
        $associatedVids = $db->escape('');
        $associatedCompanyIds = $db->escape('');
        $chksum1 = $db->escape(sha1($dealId . $dealStatus . $dealStage . $pipeline));
        //
        $ec = $db->escape(trim('DoMiteSystems'));
        $ea = $db->escape(trim('Lead [New]'));
        $el = $db->escape(trim('Subscribe'));
        //
        $query = "INSERT IGNORE INTO " . GA_TABLE . " SET `key_id` = '{$keyId}', " .
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
            "`tid` = '{$tid}', " .
            "`cid` = '{$cid}', " .
            "`ec` = '{$ec}', " .
            "`ea` = '{$ea}', " .
            "`el` = '{$el}', " .
            "`received` = NOW()";
        $db->query($query);
    }
    */

    return $retVal;
}

function sfInvestmentCallback($formData)
{
    global $db, $hubSpot, $logFileName, $keyId, $data1;

    $retVal = false;
    $vid = null;

    if (empty($formData['email']) || empty($formData['firstname']) || empty($formData['lastname'])) {
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Wrong form empty validation data: ' . var_export($formData, 1) . PHP_EOL;
        logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);

        return $retVal;
    }

    $formData['email'] = trim($formData['email']);

    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Form data: ' . var_export($formData, 1) . PHP_EOL;
    logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);

    $res1 = $hubSpot->findContactByEmail($formData['email']);
    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Hubspot::findContactByEmail(' . $formData['email'] . ') result: ' . var_export($res1, 1) . PHP_EOL;
    logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);

    $json1 = json_decode($res1, true);
    if (
        ($json1['status'] == 'error')
        && ($json1['message'] == 'contact does not exist')
    ) {
        $contactData = [];
        $contactData['email'] = $formData['email'];
        /* $p0 = strpos($formData['name'], ' ');
        if ($p0 !== false) {
            $a0 = explode(' ', $formData['name']);
            $contactData['lastname'] = $a0[0];
            $contactData['firstname'] = $a0[1];
        } else {
            $contactData['firstname'] = $formData['name'];
        } */
        $contactData['lastname'] = $formData['lastname'];
        $contactData['firstname'] = $formData['firstname'];
        $contactData['phone'] = Hubspot::cleanPhoneNumber($formData['tel']);
        $gaJson = json_decode($formData['ga_utm'], true);
        if (!empty($gaJson)) {
            $contactData['source'] = $gaJson['source_title'];
        }
        // Тип клиента
        $contactData['type_of_client'] = 'Клиент'; // @see: https://app.hubspot.com/property-settings/1982701/contact/type_of_client
        //
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Contact Data: ' . var_export($contactData, true) . PHP_EOL;
        logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
        //
        $res2 = $hubSpot->addOrUpdateContact($contactData);
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Hubspot::addOrUpdateContact result: ' . var_export($res2, 1) . PHP_EOL;
        logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
        //
        $json2 = json_decode($res2, true);
        if (isset($json2['vid'])) {
            $vid = $json2['vid'];
        }
    } elseif (isset($json1['vid'])) {
        $vid = $json1['vid'];
    }
    // Add a Deal
    if (!isset($formData['latel_deal_name']) || empty($formData['latel_deal_name'])) {
        $formData['latel_deal_name'] = 'Связаться со мной';
    }
    $dealData = [];
    //
    // 'properties'
    //
    if (!is_null($vid)) {
        $dealData['associatedVids'] = $vid;
    }
    $dealData['dealname']  = $formData['latel_deal_name'];
    // $dealData['pipeline'] = 'default'; // 'Sales Pipeline'
    // $dealData['dealstage'] = 'ba59711e-9fa6-4e0d-9a31-d44b448b7039'; // 'Issues'
    $dealData['pipeline'] = '714da3ad-adca-4cea-847b-2e02ef6c4fe1'; // 'Pipeline'
    $dealData['dealstage'] = '449211'; // 'Leads'
    //
    // "hubspot_owner_id"
    // "closedate"
    // $dealData['amount'] = $formData['page']['attr']['attr_15'];
    // "dealtype"
    //
    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Deal data: ' . var_export($dealData, 1) . PHP_EOL;
    logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
    //
    $res3 = $hubSpot->addDeal($dealData);
    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Deal add result: ' . var_export($res3, 1) . PHP_EOL;
    logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
    //
    $dealJson = json_decode($res3, true);
    if (!empty($dealJson)) {
        $retVal = true;
    }
    // $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Deal json: ' . var_export($dealJson, 1) . PHP_EOL;
    // logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
    //
    if (isset($dealJson['dealId'])) {
        $retVal = true;
        // @see: https://developers.hubspot.com/docs/methods/engagements/create_engagement
        $addNoteRes = $hubSpot->addDealNote([
            'engagement' => [
                "active" => true,
                "ownerId" => $hubSpot->getOwnerId(),
                "type" => "NOTE",
                "timestamp" => $hubSpot->getTimeStamp(),
            ],
            'associations' => [
                "contactIds" => [ $vid ],
                "companyIds" => [ ],
                "dealIds" => [ $dealJson['dealId'] ],
                "ownerIds" => [ $hubSpot->getOwnerId() ],
            ],
            'attachments' => [],
            'metadata' => [
                "body" => "URL: " . $formData['url'],
            ],
        ]);
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Add note res: ' . var_export($addNoteRes, 1) . PHP_EOL;
        logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
    }
    //
    $dData1 = unserialize($data1);
    if (isset($dData1['formData']) && !empty($dData1['formData'])) {
        $uFd = unserialize($dData1['formData']);
        if (isset($uFd['ga_utm']) && !empty($uFd['ga_utm'])) {
            /**
             * Новая заявка (цель: Лиды)
             *
             * Отправляется когда пользователь отправляет любую заявку с сайта:
             * Callback
             *
             * Название продукта - "Реклама и продвижение", "Индивидуальный подход", “Регистрация инвестора”, “Обратная связь” (для всех неизвестных)
             *
             * @example: v=1&t=event&tid=UA-42378215-1&cid={google client id}&ec=DoMiteSystems&ea=Lead [New]&el={Название продукта}
             */
            $uGaUtm = json_decode($uFd['ga_utm'], true);
            //
            $tid = $db->escape(trim($uGaUtm['ga']['trackingId']));
            if (empty($tid) && isset($uGaUtm['ga']) && isset($uGaUtm['ga']['tid']) && !empty($uGaUtm['ga']['tid'])) {
                $tid = $db->escape(trim($uGaUtm['ga']['tid']));
            }
            $cid = $db->escape(trim($uGaUtm['ga']['clientId']));
            if (empty($cid) && isset($uGaUtm['ga']) && isset($uGaUtm['ga']['cid']) && !empty($uGaUtm['ga']['cid'])) {
                $cid = $db->escape(trim($uGaUtm['ga']['cid']));
            }
            //
            $status = $db->escape(trim('new_deal'));
            //
            $keyId = $db->escape($keyId);
            $portalId = $db->escape($dealJson['portalId']);
            $dealId = $db->escape($dealJson['dealId']);
            $dealName = $db->escape(trim($dealJson['properties']['dealname']['value']));
            $dealSum = $db->escape(trim($dealJson['properties']['amount']['value']));
            $dealData = $db->escape(trim($hubSpot->getDealById($dealJson['dealId'])));
            $dealStatus = 'New';
            $dealStage = $db->escape(trim($dealJson['properties']['dealstage']['value']));
            $pipeline = $db->escape(trim($dealJson['properties']['pipeline']['value']));
            $associatedVids = $db->escape(join(',', $dealJson['associations']['associatedVids']));
            $associatedCompanyIds = $db->escape(join(',', $dealJson['associations']['associatedCompanyIds']));
            $chksum1 = $db->escape(sha1($dealId . $dealStatus . $dealStage . $pipeline));
            $contactVid = $db->escape($vid);
            //
            $ec = $db->escape(trim('DoMiteSystems'));
            $ea = $db->escape(trim('Lead [New]'));
            $el = $db->escape(trim('Обратная связь'));
            //
            $query = "INSERT IGNORE INTO " . GA_TABLE . " SET `key_id` = '{$keyId}', " .
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
                "`contact_vid` = '{$contactVid}', " .
                "`associated_company_ids` = '{$associatedCompanyIds}', " .
                "`chksum1` = '{$chksum1}', " .
                "`tid` = '{$tid}', " .
                "`cid` = '{$cid}', " .
                "`ec` = '{$ec}', " .
                "`ea` = '{$ea}', " .
                "`el` = '{$el}', " .
                "`received` = NOW()";
            $db->query($query);
        }
    }
    //

    return $retVal;
}

function fUnSubscribe($formData)
{
    global $db, $hubSpot, $logFileName;

    $logPrefs = ['echoLogMsg' => false, 'storeLog' => true];
    $retVal = false;
    $vid = null;

    $formData['email'] = trim($formData['email']);

    if (empty($formData['email'])) {
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Error: empty required form data: ' . var_export($formData, 1) . PHP_EOL;
        logMsg($msg, $logFileName, $logPrefs);

        return $retVal;
    }

    $res1 = $hubSpot->findContactByEmail($formData['email']);
    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Hubspot::findContactByEmail(' . $formData['email'] . ') result: ' . var_export($res1, 1) . PHP_EOL;
    logMsg($msg, $logFileName, $logPrefs);

    $json1 = json_decode($res1, true);
    if (isset($json1['vid'])) {
        $contactData = [];
        $contactData['vid'] = $json1['vid'];
        $contactData['mailing'] = '';
        $res2 = $hubSpot->updateContact($contactData);
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Hubspot::addOrUpdateContact result: ' . var_export($res2, 1) . PHP_EOL;
        logMsg($msg, $logFileName, $logPrefs);
        //
        if (!empty($res2) && ($res2 !== false)) {
            $jR3 = json_decode($res2, true);
            $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Contact vId: ' . $jR3["vid"] . '; Profile URL: ' . $jR3["profile-url"] . PHP_EOL;
            logMsg($msg, $logFileName, $logPrefs);
            $retVal = true;
        }
    }

    // TODO: send GA event unsubscribed

    return $retVal;
}

function fLandForm1($formData)
{
    // @see: https://setup.inventure.com.ua
    
    global $db, $hubSpot, $logFileName;

    $logPrefs = ['echoLogMsg' => false, 'storeLog' => true];
    $retVal = false;
    $vid = null;

    /**
     * @example Taras Shkodenko, [16.09.19 15:22]
    {'formName':'landing_form1','email':'user@email.com','first_name':'First','last_name':'Last','tel':'+380671231122','dealname':'Deal Name','pipeline':'714da3ad-adca-4cea-847b-2e02ef6c4fe1','dealstage':'449211','amount':'123.45','test_result':'Test result goes here...'}
     */
    if (empty($formData['email']) || empty($formData['first_name'])) {
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Wrong form empty validation data: ' . var_export($formData, 1) . PHP_EOL;
        logMsg($msg, $logFileName, $logPrefs);

        return $retVal;
    }

    $formData['email'] = trim($formData['email']);

    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Form data: ' . var_export($formData, 1) . PHP_EOL;
    logMsg($msg, $logFileName, $logPrefs);

    $res1 = $hubSpot->findContactByEmail($formData['email']);
    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Hubspot::findContactByEmail(' . $formData['email'] . ') result: ' . var_export($res1, 1) . PHP_EOL;
    logMsg($msg, $logFileName, $logPrefs);
    $json1 = json_decode($res1, true);
    if (
        ($json1['status'] == 'error')
        && ($json1['message'] == 'contact does not exist')
    ) {
        $contactData = [];
        $contactData['email'] = $formData['email'];
        $contactData['firstname'] = $formData['first_name'];
        if (isset($formData['last_name'])) {
            $contactData['lastname'] = $formData['last_name'];
        }
        if (isset($formData['tel'])) {
            $contactData['phone'] = Hubspot::cleanPhoneNumber($formData['tel']);
        }
        if (isset($formData['jobtitle'])) {
            $contactData['jobtitle'] = $formData['jobtitle'];
        }
        $gaJson = json_decode($formData['ga_utm'], true);
        if (!empty($gaJson) && isset($gaJson['source_title'])) {
            $contactData['source'] = $gaJson['source_title'];
        }
        // Тип клиента
        $contactData['type_of_client'] = 'Клиент'; // @see: https://app.hubspot.com/property-settings/1982701/contact/type_of_client
        //
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Contact Data: ' . var_export($contactData, true) . PHP_EOL;
        logMsg($msg, $logFileName, $logPrefs);
        //
        $res2 = $hubSpot->addOrUpdateContact($contactData);
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Hubspot::addOrUpdateContact result: ' . var_export($res2, 1) . PHP_EOL;
        logMsg($msg, $logFileName, $logPrefs);
        //
        $json2 = json_decode($res2, true);
        if (isset($json2['vid'])) {
            $vid = $json2['vid'];
        }
    } elseif (isset($json1['vid'])) {
        $vid = $json1['vid'];
    }
    // Add a Deal
    if (!isset($formData['dealname']) || empty($formData['dealname'])) {
        $formData['dealname'] = 'Связаться со мной';
    }
    $dealData = [];
    if (!is_null($vid)) {
        $dealData['associatedVids'] = $vid;
    }
    $dealData['dealname']  = $formData['dealname'];
    $dealData['pipeline'] = '714da3ad-adca-4cea-847b-2e02ef6c4fe1'; // 'Pipeline'
    $dealData['dealstage'] = '449211'; // 'Leads'
    //
    // "hubspot_owner_id"
    // "closedate"
    // $dealData['amount'] = $formData['page']['attr']['attr_15'];
    // "dealtype"
    //
    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Deal data: ' . var_export($dealData, 1) . PHP_EOL;
    logMsg($msg, $logFileName, $logPrefs);
    //
    $res3 = $hubSpot->addDeal($dealData);
    $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Deal add result: ' . var_export($res3, 1) . PHP_EOL;
    logMsg($msg, $logFileName, $logPrefs);
    //
    $dealJson = json_decode($res3, true);
    if (!empty($dealJson)) {
        $retVal = true;
    }
    // $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Deal json: ' . var_export($dealJson, 1) . PHP_EOL;
    // logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
    //
    if (isset($dealJson['dealId']) && isset($formData['test_result']) && !empty($formData['test_result'])) {
        $retVal = true;
        // @see: https://developers.hubspot.com/docs/methods/engagements/create_engagement
        $addNoteRes = $hubSpot->addDealNote([
            'engagement' => [
                "active" => true,
                "ownerId" => $hubSpot->getOwnerId(),
                "type" => "NOTE",
                "timestamp" => $hubSpot->getTimeStamp(),
            ],
            'associations' => [
                "contactIds" => [ $vid ],
                "companyIds" => [ ],
                "dealIds" => [ $dealJson['dealId'] ],
                "ownerIds" => [ $hubSpot->getOwnerId() ],
            ],
            'attachments' => [],
            'metadata' => [
                "body" => $formData['test_result'],
            ],
        ]);
        $msg = date('r') . ' ' . __METHOD__ . ' +' . __LINE__ . ' Add note res: ' . var_export($addNoteRes, 1) . PHP_EOL;
        logMsg($msg, $logFileName, $logPrefs);
    }

    // TODO: send GA event ladning test passed

    return $retVal;
}

$limit = 30;

$keyId = null;
if ( isset($argv[1])
    && (strlen($argv[1]) > 0)
) {
    $keyId = intval($argv[1]);
}

try {
    $db = new DB(DBHOST, DBUSER, DBPASS, DBNAME);
    $query = "SET collation_connection = utf8_unicode_ci";
    $res1001 = $db->query($query);
    $query = "SET NAMES utf8";
    $res1002 = $db->query($query);
    $query = "SET CHARACTER SET utf8";
    $res1003 = $db->query($query);
    $query = "set @@collation_server = utf8_unicode_ci";
    $res1004 = $db->query($query);
    //
    if (!is_null($keyId)) {
        $keyId = $db->escape($keyId);
        // $query = "SELECT * FROM `" . DB_TABLE . "` WHERE `status` = 'new' AND `key_id` = '{$keyId}' ORDER BY `id` ASC LIMIT {$limit} OFFSET 0 FOR UPDATE";
        $query = "SELECT * FROM `" . DB_TABLE . "` WHERE `status` = 'new' AND `key_id` = '{$keyId}' ORDER BY `id` DESC LIMIT {$limit} OFFSET 0 FOR UPDATE";
        // $logFileName = dirname(__FILE__) . DIRECTORY_SEPARATOR . 'logs/cron-hubspot_' . intval($keyId) . '_' . date('Y-m-d') . '.log';
    } else {
        $query = "SELECT * FROM `" . DB_TABLE . "` WHERE `status` = 'new' ORDER BY `id` ASC LIMIT {$limit} OFFSET 0 FOR UPDATE";
    }
    //
    // echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Executing SQL: ' . $query . PHP_EOL;
    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Executing SQL: . ' . $query . PHP_EOL;
    logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
    //
    $res = $db->query($query);
    // echo 'Got result: ' . var_export($res, 1) . PHP_EOL;
    if (!empty($res)) {
        foreach ($res as $r1) {
            $id = intval($r1['id']);
            $keyId = intval($r1['key_id']);
            $data1 = $r1['data'];
            //
            $logFileName = dirname(__FILE__) . '/logs/cron-hubspot_' . $keyId . '_' . date('Y-m-d') . '.log';
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
            //
            try {
                $hubSpot = new Hubspot($settings[$keyId], $db);
                //
                // $owners = $hubSpot->getOwners();
                // $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Owners: ' . var_export($owners, 1) . PHP_EOL;
                // logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
                //
                // $pJson = $hubSpot->getDealPipelines();
                // $pipelines = json_decode($pJson, true);
                // $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Pipelines: ' . var_export($pipelines, 1) . PHP_EOL;
                // logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
                //
                // $contGroups = $hubSpot->getContactPropertyGroups();
                // $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Contact Groups: ' . var_export($contGroups, 1) . PHP_EOL;
                // logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
                //
                // $contProps = $hubSpot->getAllContactProperties();
                // $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' All Contact Properties: ' . var_export($contProps, 1) . PHP_EOL;
                // logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
                //
            } catch (\Exception $e) {
                $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Fatal error (' . $e->getCode() . '): ' . $e->getMessage() . PHP_EOL;
                logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
                die($msg);
            }
            //
            echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Result ' . var_export($r1, true) . PHP_EOL;
            //
            $formData = unserialize($r1['data']);
            echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Form meta data: ' . var_export($formData, true) . PHP_EOL;
            //
            if (!isset($formData['formData']) || empty($formData['formData'])) {
                $query = "UPDATE `" . DB_TABLE . "` SET `updated_at` = NOW(), `status` = 'error1_form_data' WHERE `id` = '{$r1['id']}'";
                $res1 = $db->query($query);
                continue; // Go to next record
            }
            //
            if (isset($formData['formData']) && !empty($formData['formData'])) {
                $d1 = unserialize($formData['formData']);
                echo date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Form data: ' . var_export($d1, true) . PHP_EOL;
            }
            //
            $f1 = $formData['formName'];
            switch ($f1) {
                case 'user_register':
                    userRegister($d1);
                    $email = $db->escape($d1['email']);
                    $phone = $db->escape($d1['phone']);
                    $name = $db->escape($d1['name_name']);
                    $query = "UPDATE `" . DB_TABLE . "` SET `status` = 'processed', `updated_at` = NOW(), `email` = '{$email}', `phone` = '{$phone}', `name` = '{$name}' WHERE `id` = '{$id}'";
                    $db->query($query);
                    continue; // go to the next record
                    break;
                case 'bulletin_add':
                    bulletinAdd($d1);
                    $email = $db->escape($d1['page']['attr']['attr_4']);
                    $phone = $db->escape($d1['page']['attr']['attr_3']);
                    $name = $db->escape($d1['page']['attr']['attr_5']);
                    $query = "UPDATE `" . DB_TABLE . "` SET `status` = 'processed', `updated_at` = NOW(), `email` = '{$email}', `phone` = '{$phone}', `name` = '{$name}' WHERE `id` = '{$id}'";
                    $db->query($query);
                    continue; // go to the next record
                    break;
                case 'sf_investor':
                    if (isset($d1['sf_investor']['manager']) && ($d1['sf_investor']['manager'] == 'on')) {
                        $d1['sf_investor']['tel'] = $d1['sf_investor']['phone'];
                        $d1['sf_investor']['latel_deal_name'] = 'Заказан звонок от менеджера';
                        sfCallback($d1['sf_investor']);
                    }
                    sfInvestor($d1['sf_investor']);
                    $email = $db->escape($d1['sf_investor']['email']);
                    $phone = $db->escape($d1['sf_investor']['phone']);
                    $name = $db->escape(trim($d1['sf_investor']['firstname'] . ' ' . $d1['sf_investor']['lastname']));
                    $query = "UPDATE `" . DB_TABLE . "` SET `status` = 'processed', `updated_at` = NOW(), `email` = '{$email}', `phone` = '{$phone}', `name` = '{$name}' WHERE `id` = '{$id}'";
                    $db->query($query);
                    continue; // go to the next record
                    break;
                case 'sf_callback':
                case 'sf_msb_form1':
                    $name = $db->escape(trim($d1['firstname'] . ' ' . $d1['lastname']));
                    if (empty($d1['firstname']) 
                        && empty($d1['lastname']) 
                        && !empty($d1['fullname'])) {
                        // fix name
                        $p0 = strpos($d1['fullname'], ' ');
                        if ($p0 !== false) {
                            $n0 = explode(' ', $d1['fullname']);
                            $d1['firstname'] = $n0[0];
                            $d1['lastname'] = $n0[1];
                        } else {
                            $d1['firstname'] = $d1['fullname'];
                            $d1['lastname'] = substr($d1['fullname'], 0, 1);
                        }
                        //
                        $name = $db->escape(trim($d1['fullname']));
                        if (!isset($d1['latel_deal_name']) || empty($d1['latel_deal_name'])) {
                            $d1['latel_deal_name'] = 'MSB Callback';
                        }
                    }
                    if (empty($d1['firstname']) 
                        && empty($d1['lastname']) 
                        && !empty($d1['name'])) {
                        // fix name
                        $p0 = strpos($d1['name'], ' ');
                        if ($p0 !== false) {
                            $n0 = explode(' ', $d1['name']);
                            $d1['firstname'] = $n0[0];
                            $d1['lastname'] = $n0[1];
                        } else {
                            $d1['firstname'] = $d1['name'];
                            $d1['lastname'] = substr($d1['name'], 0, 1);
                        }
                        //
                        $name = $db->escape(trim($d1['name']));
                        if (!isset($d1['latel_deal_name']) || empty($d1['latel_deal_name'])) {
                            $d1['latel_deal_name'] = 'MSB Callback';
                        }
                    }
                    $phone = $db->escape($d1['tel']);
                    if (empty($d1['tel']) && !empty($d1['phone'])) {
                        $d1['tel'] = $d1['phone'];
                        $phone = $db->escape($d1['phone']);
                    }
                    sfCallback($d1);
                    $query = "UPDATE `" . DB_TABLE . "` SET `status` = 'processed', `updated_at` = NOW(), `phone` = '{$phone}', `name` = '{$name}' WHERE `id` = '{$id}'";
                    $db->query($query);
                    continue; // go to the next record
                    break;
                case 'sf_approach':
                case 'sf_msb_form2':
                    $name = $db->escape(trim($d1['firstname'] . ' ' . $d1['lastname']));
                    if (!isset($d1['firstname']) && !isset($d1['lastname']) && isset($d1['name'])) {
                        // fix name
                        $p0 = strpos($d1['name'], ' ');
                        if ($p0 !== false) {
                            $n0 = explode(' ', $d1['name']);
                            $d1['firstname'] = $n0[0];
                            $d1['lastname'] = $n0[1];
                        } else {
                            $d1['firstname'] = $d1['lastname'] = $d1['name'];
                        }
                        //
                        $name = $db->escape(trim($d1['name']));
                        if (empty($d1['latel_deal_name'])) {
                            $d1['latel_deal_name'] = 'MSB Quiz';
                        }
                        $d1['text'] = $d1['quiz'];
                        if (empty($d1['email'])) {
                            $d1['email'] = 'noreply-smb+' . rand(0, 9999) . '@inventure.com.ua';
                        }
                    }
                    sfApproach($d1);
                    $email = $db->escape($d1['email']);
                    $phone = $db->escape($d1['tel']);
                    $query = "UPDATE `" . DB_TABLE . "` SET `status` = 'processed', `updated_at` = NOW(), `email` = '{$email}', `phone` = '{$phone}', `name` = '{$name}' WHERE `id` = '{$id}'";
                    $db->query($query);
                    continue; // go to the next record
                    break;
                case 'subscribe':
                    fSubscribe($d1); // digest
                    if (isset($d1['name']) && !empty($d1['name'])) {
                        $name = $db->escape($d1['name']);
                    } elseif (isset($d1['firstname']) && !empty($d1['firstname']) && isset($d1['lastname']) && !empty($d1['lastname'])) {
                        $name = $db->escape($d1['firstname'] . ' ' . $d1['lastname']);
                    }
                    $email = $db->escape($d1['email']);
                    if (isset($d1['tel']) && !empty($d1['tel'])) {
                        $phone = $db->escape($d1['tel']);
                    } elseif (isset($d1['phone']) && !empty($d1['phone'])) {
                        $phone = $db->escape($d1['phone']);
                    }
                    $query = "UPDATE `" . DB_TABLE . "` SET `status` = 'processed', `updated_at` = NOW(), `email` = '{$email}', `phone` = '{$phone}', `name` = '{$name}' WHERE `id` = '{$id}'";
                    $db->query($query);
                    continue; // go to the next record
                    break;
                case 'sf_investment_callback':
                    sfInvestmentCallback($d1);
                    $name = $db->escape(trim($d1['firstname'] . ' ' . $d1['lastname']));
                    $email = $db->escape($d1['email']);
                    $phone = $db->escape($d1['tel']);
                    $query = "UPDATE `" . DB_TABLE . "` SET `status` = 'processed', `updated_at` = NOW(), `email` = '{$email}', `phone` = '{$phone}', `name` = '{$name}' WHERE `id` = '{$id}'";
                    $db->query($query);
                    continue; // go to the next record
                    break;
                case 'unsubscribe':
                    fUnSubscribe($d1);
                    $name = $db->escape($d1['name']);
                    $email = $db->escape($d1['email']);
                    $phone = $db->escape($d1['tel']);
                    $query = "UPDATE `" . DB_TABLE . "` SET `status` = 'processed', `updated_at` = NOW(), `email` = '{$email}', `phone` = '{$phone}', `name` = '{$name}' WHERE `id` = '{$id}'";
                    $db->query($query);
                    continue; // go to the next record
                    break;
                case 'landing_form1':
                    fLandForm1($d1);
                    $name = $db->escape(trim($d1['first_name'] . ' ' . $d1['last_name']));
                    $email = $db->escape($d1['email']);
                    $phone = $db->escape($d1['tel']);
                    $query = "UPDATE `" . DB_TABLE . "` SET `status` = 'processed', `updated_at` = NOW(), `email` = '{$email}', `phone` = '{$phone}', `name` = '{$name}' WHERE `id` = '{$id}'";
                    $db->query($query);
                    continue; // go to the next record
                    break;
                default:
                    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Form handler for: ' . var_export($f1, true) . ' is not implemented yet.' . PHP_EOL;
                    logMsg($msg, $logFileName, ['echoLogMsg' => false, 'storeLog' => true]);
                    break;
            }
            sleep(1);
        }
    }
} catch (\Exception $e) {
    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Fatal error: ' . $e->getMessage() . PHP_EOL;
    error_log( date('r') . ' ' . $msg . PHP_EOL, 3, $logFileName );
    die($msg);
}
