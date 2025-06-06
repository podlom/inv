<?php

/**
 * Created by PhpStorm
 * User: shtaras
 * Date: 10/29/19
 * Time: 14:51
 *
 * @author Taras Shkodenko <taras.shkodenko@gmail.com>
 */

require_once realpath(__DIR__.'/../bootstrap.php');
require_once 'lib/functions.php';


$app_name = trim(file_get_contents(__DIR__.'/../app_id'));
$app = new Skynar\Application($app_name, realpath(__DIR__.'/../'), __DIR__);
try {
    $app->init();
} catch (Throwable $e) {
    echo $app->getService('template')->renderException($e);
}

$msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . PHP_EOL .
    ' POST data: ' . var_export($_POST, true) . PHP_EOL .
    ' SERVER: ' . var_export($_SERVER, true) . PHP_EOL;

error_log($msg);

/**
 * @ts function _sendFormRequest($data) has moved to lib/functions.php
 */

function validateEmail($email)
{
    $result = false;
    if (!empty($email)) {
        if (filter_var($email, FILTER_VALIDATE_EMAIL)) {
            error_log( __FUNCTION__ . ' +' . __LINE__ . ' Email: ' . var_export($email, true) . ' looks like valid.' );
            $result = true;
            /*
            $a = explode('@', $email);
            $domain = $a[1];
            if ( checkdnsrr($domain . '.', 'ANY') ) {
                error_log( __FUNCTION__ . ' +' . __LINE__ . ' Validating email domain: ' . $domain );
                $result = true;
            } else {
                error_log( __FUNCTION__ . ' +' . __LINE__ . " Error: NO DNS Record found" );
            }
            */
        } else {
            error_log( __FUNCTION__ . ' +' . __LINE__ . ' Error: wrong email ' . var_export($email, true) );
        }
    }
    return $result;
}

/**
 * @example $data = array ('subscribe' => array (
 *  'firstname' => 'Тарас',
 *  'lastname' => 'Шкоденко',
 *  'company' => 'Do Digital Agency',
 *  'jobtitle' => 'Systems Architect',
 *  'email' => 'ts@doagency.net',
 *  'phone' => '0674464212',
 *  'lang' => array (
 *      0 => 'ru',
 *      1 => 'en',
 *  ),
 *  'ga_utm' => '{"data_source":"lbx_forms","ga":{"tid":"UA-42378215-1","cid":"60029967.1569834090"},"utm":{"typ":"typein","src":"(direct)","mdm":"(none)","cmp":"(none)","cnt":"(none)","trm":"(none)"},"src_title":"Direct"}',
 * ), );
 */

$validRequest = true;
$result = ['status' => $validRequest, 'errors' => []];

//
// @see: https://developers.google.com/recaptcha/docs/verify
/*
$postData = http_build_query(
    [
        'secret' => '6Le8bI8fAAAAAD9qs7jAslFEQMdO-IdX1s7fgEzF',
        'response' => $_POST['g-recaptcha-response'],
        // 'remoteip' => 'Optional. The user's IP address.',
    ]
);
$opts = [
    'http' =>
        [
            'method' => 'POST',
            'header' => 'Content-type: application/x-www-form-urlencoded',
            'content' => $postData,
        ],
];
$context = stream_context_create($opts);
$resReCaptcha = file_get_contents('https://www.google.com/recaptcha/api/siteverify', false, $context);
*/
if (isset($_POST['skip_captcha_validation']) && ($_POST['skip_captcha_validation'] == 1)) {
    $resCaptcha = true;
} else {
    $resCaptcha = _validateCloudflareCaptcha($_POST['cf-turnstile-response']);
}

// fix for firstname column
if (isset($_POST['subscribe']['name']) 
    && !empty($_POST['subscribe']['name'])
    && (!isset($_POST['subscribe']['firstname']) || empty($_POST['subscribe']['firstname']))
) {
    $_POST['subscribe']['firstname'] = $_POST['subscribe']['name'];
}

// set default language
if (!isset($_POST['subscribe']['lang']) || empty($_POST['subscribe']['lang'])) {
    $_POST['subscribe']['lang'][0] = 'ru';
}

if (!isset($_POST['subscribe'], $_POST['subscribe']['lang'])
    || empty($_POST['subscribe'])
    || empty($_POST['subscribe']['email'])
    || empty($_POST['subscribe']['firstname'])
    || empty($_POST['subscribe']['lang'])
) {
    $result['errors'][] = 'Ошибка в обязательных параметрах запроса';
    $result['status'] = $validRequest = false;

} elseif (validateEmail($_POST['subscribe']['email']) === false) {
    $result['errors'][] = 'Неправильный Email';
    $result['status'] = $validRequest = false;

} elseif (!isset($_POST['cf-turnstile-response']) || empty($_POST['cf-turnstile-response'])) {
    $result['errors'][] = 'Invalid or empty captcha';
    $result['status'] = $validRequest = false;

} elseif (!$resCaptcha) {
    $result['errors'][] = 'Cloudflare captcha check has failed';
    $result['status'] = $validRequest = false;

} elseif (
    ($_POST['subscribe']['email'] === 'friedenspfeifen@omggreatfoods.com')
    || ($_POST['subscribe']['email'] === 'hatty2001@murahpanel.com')
    || ($_POST['subscribe']['email'] === 'stevescan@24hinbox.com')
    || ($_POST['subscribe']['email'] === 'testing@example.com')
) {

    $result['errors'][] = 'User with email ' . $_POST['subscribe']['email'] . ' has been banned.';
    $result['status'] = $validRequest = false;

} else {

    $lastName = '';
    if (isset($_POST['subscribe']['lastname']) && !empty($_POST['subscribe']['lastname'])) {
        $lastName = $_POST['subscribe']['lastname'];
    }
    $company = '';
    if (isset($_POST['subscribe']['company']) && !empty($_POST['subscribe']['company'])) {
        $company = $_POST['subscribe']['company'];
    }
    $jobTitle = '';
    if (isset($_POST['subscribe']['jobtitle']) && !empty($_POST['subscribe']['jobtitle'])) {
        $jobTitle = $_POST['subscribe']['jobtitle'];
    }
    if (isset($_POST['subscribe']['job']) && !empty($_POST['subscribe']['job'])) {
        $jobTitle = $_POST['subscribe']['job'];
    }
    $phone = '';
    if (isset($_POST['subscribe']['phone']) && !empty($_POST['subscribe']['phone'])) {
        $phone = $_POST['subscribe']['phone'];
    }
    $gaUtm = '';
    if (isset($_POST['subscribe']['ga_utm']) && !empty($_POST['subscribe']['ga_utm'])) {
        $gaUtm = $_POST['subscribe']['ga_utm'];
    }
    $sFormData = serialize(array_merge([
        'email' => $_POST['subscribe']['email'],
        'firstname' => $_POST['subscribe']['firstname'],
        'lastname' => $lastName,
        'company' => $company,
        'jobtitle' => $jobTitle,
        'phone' => $phone,
        'lang' => $_POST['subscribe']['lang'],
        'ga_utm' => $gaUtm,
    ], [
        'REMOTE_ADDR' => $_SERVER['REMOTE_ADDR'],
        'HTTP_REFERER' => $_SERVER['HTTP_REFERER'],
        'HTTP_USER_AGENT' => $_SERVER['HTTP_USER_AGENT'],
    ]));
    $formData = array_merge(['formData' => $sFormData], ['formName' => 'subscribe', 'formUri' => $_SERVER['REQUEST_URI']]);
    $res = _sendFormRequest($formData);

    $result['status'] = $validRequest = true;

    require_once realpath(__DIR__ . '/../cli/lib/db.class.php');
    $cfg = app()->getService('config')->get('app')->db;
    error_log( __METHOD__ . ' +' . __LINE__ . ' $cfg: ' . print_r($cfg, true) );
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
        $email = $db->escape($_POST['subscribe']['email']);
        $session = app()->getService('session')->getSession();
        if (!($key = $session->get('form_key', false))) {
            $key = uniqid();
            // $session->set('form_key', $key);
        }
        $jsonAttrData = json_encode([
            'name' => trim($_POST['subscribe']['firstname'] . ' ' . $lastName),
            'company' => $company,
            'job' => $jobTitle,
            'phone' => $phone,
            'lang' => $_POST['subscribe']['lang'],
            '_token' => $key,
        ]);
        $attr = $db->escape($jsonAttrData);
        $query = "insert into Mail_Subscriber set email = '{$email}', status = 1, attr = '{$attr}', created = NOW(), updated = NOW()";
        $res10 = $db->query($query);
        if ($res10) {
            $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Inserted new Mail_Subscriber ' . PHP_EOL;
            error_log($msg);
        } else {
            $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Error inserting new Mail_Subscriber ' . PHP_EOL;
            error_log($msg);
        }
    } catch (\Exception $e) {
        $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' DB error: ' . $e->getMessage() . PHP_EOL;
        error_log($msg);
    }
}
if (!headers_sent()) {
    header("Content-type: application/json; charset=utf-8");
}
die(json_encode($result));
