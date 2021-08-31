<?php

require_once 'config' . DIRECTORY_SEPARATOR . 'settings.php';
require_once 'lib' . DIRECTORY_SEPARATOR . 'functions.php';
require_once 'lib' . DIRECTORY_SEPARATOR . 'db.class.php';


$logParams = ['echoLogMsg' => false, 'storeLog' => true];
$errorLogFile = dirname(__FILE__) . '/logs/hubspot_' . date('Y-m-d') . '.log';
$msg = date('r') . ' Got request data $_SERVER: ' . var_export($_SERVER, 1) . '; $_GET: ' . var_export($_GET, 1) . '; $_POST: ' . var_export($_POST, 1) . '; $_REQUEST: ' . var_export($_REQUEST, 1) . '; $_COOKIE: ' . var_export($_COOKIE, 1) . PHP_EOL;
logMsg($msg, $errorLogFile, $logParams);

$key = '';
if (preg_match('|^/hubspot/(.*)|', $_SERVER['REQUEST_URI'], $m)) {
    $p1 = strpos($m[1], '&');
    if ($p1 !== false) {
        $key = substr($m[1], 0, $p1);
    } else {
        $key = $m[1];
    }
    // $msg = date('r') . ' Found key in $_SERVER["REQUEST_URI"]: ' . var_export($m, 1) . PHP_EOL;
    // logMsg($msg, $errorLogFile, $logParams);
} elseif (isset($_GET['key'])) {
    $key = $_GET['key'];
    // $msg = date('r') . ' Found key in $_GET["key"]: ' . var_export($_GET, 1) . PHP_EOL;
    // logMsg($msg, $errorLogFile, $logParams);
}

if (empty($key) || (strlen($key) < 40)) {
    // $msg = date('r') . ' No valid key found in $_GET: ' . var_export($_GET, 1) . PHP_EOL;
    // logMsg($msg, $errorLogFile);
    die('1001: Invalid license key');
} else {
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
    $key = $db->escape($key);
    // TODO: also check key expiration date
    $query = "SELECT `id`, COUNT(`key`) AS key_valid FROM `web_key` WHERE `key` = '{$key}' AND `is_active` = '1'";
    // $msg = date('r') . ' SQL query: ' . $query . PHP_EOL;
    // logMsg($msg, $errorLogFile, $logParams);
    //
    $res0 = $db->query($query);
    // $msg = date('r') . ' Got result data: ' . var_export($res0, 1) . PHP_EOL;
    // logMsg($msg, $errorLogFile, $logParams);
    if ($res0[0]['key_valid'] == 1) {
        $server = $db->escape(serialize($_SERVER));
        // $data = $db->escape(serialize($_POST));
        if (isset($_SERVER["HTTP_CONTENT_TYPE"])
            && !empty($_SERVER["HTTP_CONTENT_TYPE"])
            && preg_match('|application/json|Uim', $_SERVER["HTTP_CONTENT_TYPE"])
        ) {
            $allData = json_decode(file_get_contents('php://input'), true);
            // $msg = __FILE__ . ' +' . __LINE__ . ' ' . date('r') . ' JSON data: ' . var_export($allData, 1) . PHP_EOL;
            // logMsg($msg, $errorLogFile, $logParams);
            //
            $data = $db->escape(serialize($allData));
        } else {
            $data = $db->escape(serialize($_POST));
        }
        $query = "INSERT INTO `hubspot` SET `key_id` = '{$res0[0]['id']}', `received` = NOW(), `data` = '{$data}', `status` = 'new', `server` = '{$server}'";
        $msg = 'Executing SQL: ' . $query . PHP_EOL;
        logMsg($msg, $errorLogFile, $logParams);
        $res = $db->query($query);
        $msg = 'Got result: ' . var_export($res, 1) . PHP_EOL;
        logMsg($msg, $errorLogFile, $logParams);
    } else {
        die('1002: Invalid license key');
    }
    echo '200: OK';
}
