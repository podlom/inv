<?php

/**
 * Created by PhpStorm.
 * User: Taras
 * Date: 16.08.2018
 * Time: 14:54
 *
 * @author Taras Shkodenko <taras@shkodenko.com>
 */

/**
 * Default UA phone number normalization function
 * @param string $str
 * @return string
 */
function normalizePhoneNumber($str)
{
    $phoneNumber = preg_replace("/\D/", '', $str);
    $len = strlen($phoneNumber);
    if ($len > 10) {
        $cutLen = $len - 10;
        $phoneNumber = substr($phoneNumber, $cutLen);
    }
    return $phoneNumber;
}

/**
 * International phone number normalization function
 * @param string $str
 * @return string
 */
function normalizePhoneNumberInternational($str)
{
    $phoneNumber = preg_replace("/\D/", '', $str);
    return $phoneNumber;
}

function logMsg($msg, $logFileName = null, $logParams = [])
{
    $echoLogMsg = $storeLog = false;
    if (isset($logParams['echoLogMsg'])) {
        $echoLogMsg = $logParams['echoLogMsg'];
    }
    if (isset($logParams['storeLog'])) {
        $storeLog = $logParams['storeLog'];
    }
    if ($storeLog) {
        if (is_null($logFileName)) {
            $errorLogFile = dirname( dirname(__FILE__) ) . '/logs/errors_' . date('Y-m-d') . '.log';
        } else {
            $errorLogFile = $logFileName;
        }
        if (!file_exists($errorLogFile)) {
            touch($errorLogFile);
            chmod($errorLogFile, 0666);
        }
        error_log($msg, 3, $errorLogFile);
    }
    if ($echoLogMsg) {
        echo $msg . PHP_EOL;
    }
}

function sanitizeDealName($name)
{
    $name = str_replace('-', ' ', $name);
    $name = preg_replace('/ {2,}/', ' ', $name);
    return trim($name);
}

function jsonDecodeUtmData($str)
{
    $oData = new \stdClass();
    $jData = json_decode($str, true);
    if (!is_null($jData)) {
        if (isset($jData['utm']['source'])) {
            $oData->src = $jData['utm']['source'];
        } elseif (isset($jData['utm']['src'])) {
            $oData->src = $jData['utm']['src'];
        } else {
            $oData->src = '-';
        }
        if (isset($jData['utm']['medium'])) {
            $oData->mdm = $jData['utm']['medium'];
        } elseif (isset($jData['utm']['mdm'])) {
            $oData->mdm = $jData['utm']['mdm'];
        } else {
            $oData->mdm = '-';
        }
        if (isset($jData['utm']['campaign'])) {
            $oData->cmp = $jData['utm']['campaign'];
        } elseif (isset($jData['utm']['cmp'])) {
            $oData->cmp = $jData['utm']['cmp'];
        } else {
            $oData->cmp = '-';
        }
        if (isset($jData['utm']['term'])) {
            $oData->trm = $jData['utm']['term'];
        } elseif (isset($jData['utm']['trm'])) {
            $oData->trm = $jData['utm']['trm'];
        } else {
            $oData->trm = '-';
        }
        if (isset($jData['utm']['content'])) {
            $oData->cnt = $jData['utm']['content'];
        } elseif (isset($jData['utm']['cnt'])) {
            $oData->cnt = $jData['utm']['cnt'];
        } else {
            $oData->cnt = '-';
        }
    }
    return json_encode($oData);
}

function jsonDecodeUtmDataOld($str)
{
    $oData = new \stdClass();
    //
    /* $lbxCurrent = '';
    $cookies = explode('; ', $str);
    foreach ($cookies as $n9 => $c9) {
        if (preg_match('|^lbx_current=|', $c9)) {
            $c8 = explode('=', $c9);
            $lbxCurrent = urldecode($c8[1]);
        }
    } */
    //
    $jData = json_decode($str, true);
    if (!is_null($jData)) {
        if (isset($jData['utm']['source'])) {
            $oData->src = $jData['utm']['source'];
        } else {
            $oData->src = '-';
        }
        //
        if (isset($jData['utm']['medium'])) {
            $oData->mdm = $jData['utm']['medium'];
        } else {
            $oData->mdm = '-';
        }
        //
        if (isset($jData['utm']['campaign'])) {
            $oData->cmp = $jData['utm']['campaign'];
        } else {
            $oData->cmp = '-';
        }
        //
        if (isset($jData['utm']['term'])) {
            $oData->trm = $jData['utm']['term'];
        } else {
            $oData->trm = '-';
        }
        //
        if (isset($jData['utm']['content'])) {
            $oData->cnt = $jData['utm']['content'];
        } else {
            $oData->cnt = '-';
        }
    }
    return json_encode($oData);
}

function getSslPage($url)
{
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_HEADER, false);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_REFERER, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $result = curl_exec($ch);
    curl_close($ch);
    return [
        'httpCode' => $httpCode,
        'result' => $result,
    ];
}

function postApiRequest(string $url, array $data)
{
    // $headers[] = "Accept:application/json";
    $headers[] = "Content-Type:application/json";
    // Curl options
    $curl = curl_init();
    curl_setopt($curl, CURLOPT_URL, $url);
    // curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query($data));
    curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($data));
    // curl_setopt($curl, CURLOPT_HEADER, false);
    // curl_setopt($curl, CURLOPT_COOKIEFILE, $this->getCookieJarFile());
    // curl_setopt($curl, CURLOPT_COOKIEJAR, $this->getCookieJarFile());
    curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
    $out = curl_exec($curl);
    $code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
    curl_close($curl);
    //
    if (is_string($out)) {
        $result = json_decode($out, true);
    } else {
        $result = ['state' => 'error', 'code' => $code];
    }
    //
    return $result;
}

function decodeGaUtm(string $str)
{
    $resultData = [];
    if (!empty($str)) {
        $resultData = json_decode($str, true);
    }
    return $resultData;
}
