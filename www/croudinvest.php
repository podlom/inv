<?php

/**
 * Created by PhpStorm
 * User: shtaras
 * Date: 2020-08-16
 * Time: 17:52
 *
 * @author Taras Shkodenko <taras@shkodenko.com>
 */

function l_m($msg)
{
    $logFileName = dirname(__FILE__) . '/croudinvest.log';
    if (!file_exists($logFileName)) {
        touch($logFileName);
        chmod($logFileName, 0666);
    }
    // Do not log on prod by default
    if ($_SERVER['SERVER_NAME'] === 'inventure.com.ua') {
        // error_log(__FILE__ . ' +' . __LINE__ . ' ' . __FUNCTION__ . ' log to file is disabled for production env: ' . $_SERVER['SERVER_NAME']);
        return false;
    }
    // Do not log if client IP does not match list below
    if (($_SERVER['REMOTE_ADDR'] !== '185.11.28.232') // @ts 2021-08-16; ISP Best; Grand Villas; home
        && ($_SERVER['REMOTE_ADDR'] !== '178.214.193.98') // InVenture office; Kyiv
        && ($_SERVER['REMOTE_ADDR'] !== '178.214.223.66') // Unit.City office; Kyiv
        && ($_SERVER['REMOTE_ADDR'] !== '176.106.0.146') // Ilmolino Saksaganskogo str. 120; Kyiv
    ) {
        // error_log(__FILE__ . ' +' . __LINE__ . ' ' . __FUNCTION__ . ' log to file is disabled for client IP: ' . $_SERVER['REMOTE_ADDR']);
        return false;
    } else {
        if (is_writeable($logFileName)) {
            error_log(date('r') . ' ' . $msg . PHP_EOL, 3, $logFileName);
        }
    }
}

function renderForm1($pageId)
{
    $pageId = intval($pageId);

    $retData = <<<F1

<hr>
<p>Чтобы принять участие в инвестировании в этот проект заполните форму:</p>
<form id="croudinvest1" method="post" onsubmit="return false;">
    <div>
        <label for="firstName1">Имя: <input type="text" name="first_name" id="firstName1" minlength="2" maxlength="32" required="required"></label>
    </div>
    <div>
        <label for="lastName1">Фамилия: <input type="text" name="last_name" id="lastName1" minlength="2" maxlength="32" required="required"></label>
    </div>
    <div>
        <label for="email1">Email: <input type="email" name="email" id="email1" minlength="6" maxlength="255" required="required"></label>
    </div>    
    <div>
        <label for="phone1">Телефон: <input type="tel" name="phone" id="phone1" minlength="9" maxlength="32" required="required"></label>
    </div>
    <div>
        <label for="planInvest1">Планирую инвестировать, $: <input type="number" name="plan_to_invest" id="planInvest1" value="0" required="required"></label>
    </div>
    <div>
        <label for="additionalInfo1">Получить дополнительную информацию: <input type="checkbox" name="additional_info" id="additionalInfo1" value="1"></label>
    </div>
    <div>
        <input type="hidden" name="page_id" value="{$pageId}">
        <input type="submit" value="Отправить заявку">
    </div>
</form>

F1;

    return $retData;
}

function submitForm1($data, $db)
{
    parse_str($data['data'], $formData);
    $msg = __FUNCTION__ . ' Form data: ' . var_export($formData, true);
    l_m($msg);

    if (isset($formData['page_id']) && !empty($formData['page_id'])) {
        $pageId = intval($formData['page_id']);
        if ($pageId > 0) {
            $firstName = $db->escape($formData['first_name']);
            $lastName = $db->escape($formData['last_name']);
            $email = $db->escape($formData['email']);
            $phone = $db->escape($formData['phone']);
            $planToInvest = $db->escape($formData['plan_to_invest']);
            $additionalInfo = $db->escape($formData['additional_info']);
            $pubDate = (new \DateTime())->format('Y-m-d H:i:s');
            $pubAt = $db->escape($pubDate);
            $status = 1;

            $sql = "INSERT INTO `croudinvesting` " .
                " SET `first_name` = '{$firstName}', " .
                " `last_name` = '{$lastName}', " .
                " `email` = '{$email}', " .
                " `phone` = '{$phone}', " .
                " `plan_to_invest` = '{$planToInvest}', " .
                " `additional_info` = '{$additionalInfo}', " .
                " `published` = '{$pubAt}', " .
                " `created` = '{$pubAt}', " .
                " `updated` = '{$pubAt}', " .
                " `status` = '{$status}', " .
                " `page_id` = '{$pageId}'";

            $msg = __FILE__ . ' +' . __LINE__ . ' SQL: ' . $sql . PHP_EOL;
            l_m( $msg );

            $r99 = $db->query($sql);
            $msg = __FILE__ . ' +' . __LINE__ . ' Insert db result: ' . var_export($r99, true) . PHP_EOL;
            l_m( $msg );

            $retData = '<p>Спасибо. Ваша заявка добавлена в базу.</p>';
        } else {
            $retData = '<p>Возникла ошибка. Ваша заявка не может быть добавлена в базу.</p>';
        }
    }

    return $retData;
}

function showInvestStatus($data, $db)
{
    if (!isset($data['post_id']) || empty($data['post_id'])) {
        $msg = __FILE__ . ' +' . __LINE__ . ' Empty post_id: ' . var_export($data['post_id'], true) . PHP_EOL;
        l_m( $msg );

        $retData = '';
        return $retData;
    }

    $postId = intval($data['post_id']);
    $sql = "SELECT * FROM `croudinvesting_status` WHERE `page_id` = '{$postId}'";
    $msg = __FILE__ . ' +' . __LINE__ . ' Select SQL: ' . $sql . PHP_EOL;
    l_m( $msg );

    $r98 = $db->query($sql);
    $msg = __FILE__ . ' +' . __LINE__ . ' Select db result data: ' . var_export($r98, true) . PHP_EOL;
    l_m( $msg );

    if (!isset($r98[0], $r98[0]['invest_amount'], $r98[0]['invest_attracted'], $r98[0]['num_investors'], $r98[0]['date_end'])
        || empty($r98[0])) {
        $msg = __FILE__ . ' +' . __LINE__ . ' Empty no project data found in db: ' . var_export($r98, true) . PHP_EOL;
        l_m( $msg );

        $retData = '';
        return $retData;
    }

    $invAmt = $r98[0]['invest_amount'];
    $invAttr = $r98[0]['invest_attracted'];
    $numInv = $r98[0]['num_investors'];
    $invLeft = $invAmt - $invAttr;
    $minInv = $r98[0]['min_investment'];
    // $daysLeft = $r98[0]['date_end'];
    $earlier = new DateTime('now');
    $later = new DateTime($r98[0]['date_end']);
    $daysLeft = $later->diff($earlier)->format("%a");

    $retData =<<<RD

<hr>
<h4>Краудинвестинг</h4>
<p>Требуемые инвестиции, $: {$invAmt}</p>
<p>Привлечено инвестиций, $: {$invAttr}</p>
<p>Количество инвесторов: {$numInv}</p>
<p>Осталось привлечь, $: {$invLeft}</p>
<p>Минимальная инвестиция, $: {$minInv}</p> 
<p>До окончания сбора инвестиций, дней: {$daysLeft}</p>

RD;

    return $retData;
}

function croudAdminIndex($data, $db)
{
    $tableData = '';

    $sql = "SELECT * FROM `croudinvesting_status`";
    $msg = __FILE__ . ' +' . __LINE__ . ' Select SQL: ' . $sql . PHP_EOL;
    l_m( $msg );

    $r97 = $db->query($sql);
    $msg = __FILE__ . ' +' . __LINE__ . ' Select db result data: ' . var_export($r97, true) . PHP_EOL;
    l_m( $msg );

    foreach ($r97 as $d9) {
        $editUri = '?/edit/' . $d9['id'];
        $tableData .=<<<TD
    <tr>
        <td><a href="{$editUri}">{$d9['id']}</a></td>
        <td><a href="{$editUri}">{$d9['page_id']}</a></td>
        <td>{$d9['invest_amount']}</td>
        <td>{$d9['invest_attracted']}</td>
        <td>{$d9['num_investors']}</td>
        <td>{$d9['invest_remains']}</td>
        <td>{$d9['min_investment']}</td>
        <td>{$d9['days_left']}</td>
    </tr>
TD;

    }

    $retData =<<<RD

<table>
   <thead>
      <tr>
        <td>ID</td>
        <td>Название</td>
        <td>Требуемые инвестиции, $</td>
        <td>Привлечено инвестиций, $</td>
        <td>Количество инвесторов</td>
        <td>Осталось привлечь, $</td>
        <td>Минимальная инвестиция, $</td>
        <td>До окончания сбора инвестиций, дней</td>
      </tr>
    </thead>
    <tbody>
      {$tableData}
    </tbody>
</table>

RD;

    return $retData;
}

function croudAdminEdit($data, $db)
{
    $msg = __FUNCTION__ . ' +' . __LINE__ . ' $data: ' . var_export($data, true) . '; $db: ' . var_export($db, true);
    l_m($msg);

    if (isset($data['id']) && !empty($data['id'])) { // edit
        $id = intval($data['id']);
        $sql = "SELECT * FROM `croudinvesting_status` WHERE `id` = '{$id}'";
        // $msg = __FILE__ . ' +' . __LINE__ . ' Select SQL: ' . $sql . PHP_EOL;
        // l_m( $msg );

        $r95 = $db->query($sql);
        // $msg = __FILE__ . ' +' . __LINE__ . ' Select db result data: ' . var_export($r95, true) . PHP_EOL;
        // l_m( $msg );

        /**
         * @example:
         * 'id' => '2',
         * 'page_id' => '23554',
         * 'invest_amount' => '1000000',
         * 'invest_attracted' => '0',
         * 'num_investors' => '0',
         * 'invest_remains' => '1000000',
         * 'min_investment' => '100000',
         * 'days_left' => '60',
         * 'date_start' => '2021-08-16 00:00:00',
         * 'date_end' => '2021-10-15 00:00:00'
         */
        $form =<<< EF

<form id="edit_croud1" method="post">
<div>
    <label for="pageId">ID проекта *:
        <input type="text" name="page_id" id="pageId" value="{$r95[0]['page_id']}" required="required">
    </label>
</div>
<div>
    <label for="investAmount">Требуемые инвестиции, $ *:
        <input type="number" name="invest_amount" id="investAmount" value="{$r95[0]['invest_amount']}" required="required">
    </label>
</div>
<div>
    <label for="investAttracted">Привлечено инвестиций, $ *:
        <input type="number" name="invest_attracted" id="investAttracted" value="{$r95[0]['invest_attracted']}" required="required">
    </label>
</div>
<div>
    <label for="numInvestors">Количество инвесторов:
        <input type="number" name="num_investors" id="numInvestors" value="{$r95[0]['num_investors']}">
    </label>
</div>
<div>
    <label for="investRemains">Осталось привлечь, $:
        <input type="number" name="invest_remains" id="investRemains" value="{$r95[0]['invest_remains']}">
    </label>
</div>
<div>
    <label for="investRemains">Минимальная инвестиция, $ *:
        <input type="number" name="min_investment" id="investRemains" value="{$r95[0]['min_investment']}" required="required">
    </label>
</div>
<div>
    <label for="daysLeft">До окончания сбора инвестиций, дней:
        <input type="number" name="days_left" id="daysLeft" value="{$r95[0]['days_left']}">
    </label>
</div>
<div>
    <label for="dateStart">Дата начала:
        <input type="text" name="date_start" id="dateStart" value="{$r95[0]['date_start']}">
    </label>
</div>
<div>
    <label for="dateEnd">Дата окончания:
        <input type="text" name="date_end" id="dateEnd" value="{$r95[0]['date_end']}">
    </label>
</div>
<input type="hidden" name="id" value="{$id}">
<div>
    <input type="submit" value="Сохранить">
</div>
</form>

EF;
        // $msg .= '<code>' . var_export($r95, true) . '</code>';

    } else { // add

        $form =<<< EF

<form id="edit_croud1" method="post">
<div>
    <label for="pageId">ID проекта *:
        <input type="text" name="page_id" id="pageId" value="" required="required">
    </label>
</div>
<div>
    <label for="investAmount">Требуемые инвестиции, $ *:
        <input type="number" name="invest_amount" id="investAmount" value="" required="required">
    </label>
</div>
<div>
    <label for="investAttracted">Привлечено инвестиций, $ *:
        <input type="number" name="invest_attracted" id="investAttracted" value="" required="required">
    </label>
</div>
<div>
    <label for="numInvestors">Количество инвесторов:
        <input type="number" name="num_investors" id="numInvestors" value="">
    </label>
</div>
<div>
    <label for="investRemains">Осталось привлечь, $:
        <input type="number" name="invest_remains" id="investRemains" value="">
    </label>
</div>
<div>
    <label for="investRemains">Минимальная инвестиция, $ *:
        <input type="number" name="min_investment" id="investRemains" value="" required="required">
    </label>
</div>
<div>
    <label for="daysLeft">До окончания сбора инвестиций, дней:
        <input type="number" name="days_left" id="daysLeft" value="">
    </label>
</div>
<div>
    <label for="dateStart">Дата начала:
        <input type="text" name="date_start" id="dateStart" value="">
    </label>
</div>
<div>
    <label for="dateEnd">Дата окончания:
        <input type="text" name="date_end" id="dateEnd" value="">
    </label>
</div>
<input type="hidden" name="id" value="0">
<div>
    <input type="submit" value="Сохранить">
</div>
</form>

EF;
    }

$retData =<<< RD

 <div class="edit-form-container">{$form}</div>
 <div>* - поля обязательны к заполнению</div>

RD;

    return $retData;
}

function croudEditSubmit($data, $db)
{
    // $retData = '<code>' . var_export($data, true) . '</code>';
    $retData = '';

    parse_str($data['data'], $formData);
    $msg = __FUNCTION__ . ' Form data: ' . var_export($formData, true);
    l_m($msg);

    if (isset($formData['id']) && !empty($formData['id'])) { // update
        $id = intval($formData['id']);

        if ($id > 0) {
            $pageId = intval($formData['page_id']);
            $investAmount = intval($formData['invest_amount']);
            $investAttracted = intval($formData['invest_attracted']);
            $numInvestors = intval($formData['num_investors']);
            $investRemains = intval($formData['invest_remains']);
            $minInvestment = intval($formData['min_investment']);
            $daysLeft = intval($formData['days_left']);
            $dateStart = $db->escape($formData['date_start']);
            $dateEnd = $db->escape($formData['date_end']);

            $query = "UPDATE `croudinvesting_status` SET " .
                " `page_id` = '{$pageId}', " .
                " `invest_amount` = '{$investAmount}', " .
                " `invest_attracted` = '{$investAttracted}', " .
                " `num_investors` = '{$numInvestors}', " .
                " `invest_remains` = '{$investRemains}', " .
                " `min_investment` = '{$minInvestment}', " .
                " `days_left` = '{$daysLeft}', " .
                " `date_start` = '{$dateStart}', " .
                " `date_end` = '{$dateEnd}' " .
                " WHERE `id` = '{$id}'";

            $r93 = $db->query($query);
            $msg = __FILE__ . ' +' . __LINE__ . ' Update db result: ' . var_export($r93, true) . PHP_EOL;
            l_m( $msg );

            if ($r93) {
                $retData = '<p>Изменения сохранены успешно. Перейти <a href="/admin/croudinvesting">к списку проектов</a>.</p>';
            }
        }
    } else { // insert
        $pageId = intval($formData['page_id']);
        $investAmount = intval($formData['invest_amount']);
        $investAttracted = intval($formData['invest_attracted']);
        $numInvestors = intval($formData['num_investors']);
        $investRemains = intval($formData['invest_remains']);
        $minInvestment = intval($formData['min_investment']);
        $daysLeft = intval($formData['days_left']);
        $dateStart = $db->escape($formData['date_start']);
        $dateEnd = $db->escape($formData['date_end']);

        $query = "INSERT INTO `croudinvesting_status` SET " .
            " `page_id` = '{$pageId}', " .
            " `invest_amount` = '{$investAmount}', " .
            " `invest_attracted` = '{$investAttracted}', " .
            " `num_investors` = '{$numInvestors}', " .
            " `invest_remains` = '{$investRemains}', " .
            " `min_investment` = '{$minInvestment}', " .
            " `days_left` = '{$daysLeft}', " .
            " `date_start` = '{$dateStart}', " .
            " `date_end` = '{$dateEnd}' ";

        $r91 = $db->query($query);
        $msg = __FILE__ . ' +' . __LINE__ . ' Insert db result: ' . var_export($r91, true) . PHP_EOL;
        l_m( $msg );

        if ($r91) {
            $retData = '<p>Форма добавлена в базу успешно. Перейти <a href="/admin/croudinvesting">к списку проектов</a>.</p>';
        }
    }

    return $retData;
}


require_once realpath(__DIR__ . '/../bootstrap.php');


$app_name = trim(file_get_contents(__DIR__ . '/../app_id'));
$app = new Skynar\Application($app_name, realpath(__DIR__ . '/../'), __DIR__);
try {
    $app->init();
} catch (Throwable $e) {
    echo $app->getService('template')->renderException($e);
}
//
$resHmtl = '';
//
if (!empty($_REQUEST)) {
    require_once app()->getPath() . '/cli/lib/db.class.php';
    $cfg = app()->getService('config')->get('app')->db;
    //
    $msg = __FILE__ . ' +' . __LINE__ . ' $cfg: ' . var_export($cfg, true);
    l_m($msg);
    //
    if ($_SERVER['SERVER_NAME'] != 'inventure.com.ua') {
        // adjust db settings for dev environment
        $cfg['host'] = '127.0.0.1';
        $cfg['dbname'] = 'inventure_dev';
        $cfg['user'] = 'inventure_dev';
        $cfg['password'] = '[[)sq5J0mXKZ5x2E';
    }
    //
    $msg = __FILE__ . ' +' . __LINE__ . ' $cfg: ' . var_export($cfg, true);
    l_m($msg);
    //
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
    //
    $msg = __FILE__ . ' +' . __LINE__ . ' $_SERVER: ' . var_export($_SERVER, true);
    l_m($msg);
    //
    $msg = __FILE__ . ' +' . __LINE__ . ' $_REQUEST: ' . var_export($_REQUEST, true);
    l_m($msg);
    //
    $action = $_REQUEST['action'] ?? '';
    //
    switch ($action) {
        case 'form1':
            $resHmtl = renderForm1($_REQUEST['post_id']);
            break;
        case 'form1submit':
            $resHmtl = submitForm1($_REQUEST, $db);
            break;
        case 'showInvestStatus':
            $resHmtl = showInvestStatus($_REQUEST, $db);
            break;
        case 'croudAdminIndex':
            $resHmtl = croudAdminIndex($_REQUEST, $db);
            break;
        case 'croudAdminEdit':
            $resHmtl = croudAdminEdit($_REQUEST, $db);
            break;
        case 'croudEditSubmit':
            $resHmtl = croudEditSubmit($_REQUEST, $db);
            break;
        default:
            $resHmtl = '<p>It works.</p>';
            break;
    }
}
//
if (!headers_sent()) {
    header('Access-Control-Allow-Origin: *');
    header('Content-Type: text/html; charset=utf-8');
}
die($resHmtl);
