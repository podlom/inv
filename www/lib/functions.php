<?php

/**
 * Created by PhpStorm.
 * User: Taras
 * Date: 16.08.2018
 * Time: 14:54
 * Modified: 2024-03-18 09:40
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

function increment_page_param(string $url) : string
{
    // Розділити URL на шлях та параметри
    $parts = parse_url($url);
    $query = isset($parts['query']) ? $parts['query'] : '';
    parse_str($query, $params);

    // Перевірити, чи існує параметр 'page'
    if (isset($params['page'])) {
        // Збільшити значення параметра 'page' на 1
        $params['page']++;

        // Побудувати новий рядок запиту
        $new_query = http_build_query($params);

        // Побудувати новий URL
        $new_url = $parts['path'] . '?' . $new_query;

        // Перевірити, чи є які-небудь інші параметри та додати їх до нового URL, якщо так
        if (isset($parts['fragment'])) {
            $new_url .= '#' . $parts['fragment'];
        }

        return $new_url;
    }

    // Якщо параметр 'page' не знайдено, повернути той самий URL
    return $url;
}

function l_m($msg)
{
    // Do not log on prod by default
    if ($_SERVER['SERVER_NAME'] === 'inventure.com.ua') {
        // error_log(__FILE__ . ' +' . __LINE__ . ' ' . __FUNCTION__ . ' log to file is disabled for production env: ' . $_SERVER['SERVER_NAME']);
        return false;
    }

    $logFileName = dirname(__FILE__) . '/' . date('Y-m-d_H-i') . '_' . bin2hex(random_bytes(7)) . '.log';
    if (!file_exists($logFileName)) {
        touch($logFileName);
        chmod($logFileName, 0666);
    }
    // IP: 193.0.217.7 - Kyiv - Volodymyra Ivasyuka 24-a
    // IP: 176.37.192.192 - Kyiv - Rollhouse cafe
    // IP: 31.43.103.143 - 2024-03-18 - Kyiv - Feelin cafe
    if (is_writeable($logFileName) && isset($_SERVER['HTTP_CF_CONNECTING_IP']) && ($_SERVER['HTTP_CF_CONNECTING_IP'] == '193.0.217.7')) {
        error_log(date('r') . ' ' . $msg . PHP_EOL, 3, $logFileName);
    }

    // Do not log if client IP does not match list below
    if (($_SERVER['REMOTE_ADDR'] !== '185.11.28.246') // @ts 2021-02-25; ISP Best; Grand Villas; home
        && ($_SERVER['REMOTE_ADDR'] !== '178.214.193.98') // InVenture office; Kyiv
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

function build_pager($currentPage = 1, $maxPages, $numPagerLinks = 5)
{
    // Base URL construction from the HTTP referer
    $parsedUrl = parse_url($_SERVER['HTTP_REFERER']);
    $baseUrl = $parsedUrl['scheme'] . '://' . $parsedUrl['host'] . $parsedUrl['path'];

    // Parse query string and update current page
    parse_str(parse_url($_SERVER['HTTP_REFERER'], PHP_URL_QUERY), $vars);
    if (isset($vars['page'])) {
        $currentPage = (int)$vars['page'];
    }

    // Pagination HTML
    $pagerHtml = '<ul class="pagination mb-10">';

    // Previous page link
    if ($currentPage > 1) {
        $vars['page'] = $currentPage - 1;
        $pagerHtml .= buildPagerLink($baseUrl, $vars, '<svg width="7" height="13" viewBox="0 0 7 13" fill="none" xmlns="http://www.w3.org/2000/svg"><path opacity="0.8" d="M6.25 12.25L0.75 6.75L6.25 1.25" stroke="black" stroke-linecap="round" stroke-linejoin="round"></path></svg>'); // Replace with actual SVG
    }

    // Page number links
    $startPage = max(1, $currentPage - floor($numPagerLinks / 2));
    $endPage = min($maxPages, $startPage + $numPagerLinks - 1);

    for ($page = $startPage; $page <= $endPage; $page++) {
        $vars['page'] = $page;
        $class = ($page == $currentPage) ? 'current' : '';
        $pagerHtml .= buildPagerLink($baseUrl, $vars, $page, $class);
    }

    // Next page link
    if ($currentPage < $maxPages) {
        $vars['page'] = $currentPage + 1;
        $pagerHtml .= buildPagerLink($baseUrl, $vars, '<svg width="7" height="13" viewBox="0 0 7 13" fill="none" xmlns="http://www.w3.org/2000/svg"><path opacity="0.8" d="M0.75 1.25L6.25 6.75L0.75 12.25" stroke="black" stroke-linecap="round" stroke-linejoin="round"></path></svg>'); // Replace with actual SVG
    }

    $pagerHtml .= '</ul>';
    return $pagerHtml;
}

function buildPagerLink($baseUrl, $vars, $label, $class = '')
{
    $href = htmlspecialchars($baseUrl . '?' . http_build_query($vars));
    return "<li class=\"$class\"><a href=\"$href\">$label</a></li>";
}

/*
function ucmp($a, $b) {
    if ($a == $b) {
        return 0;
    }
    return ($a < $b) ? -1 : 1;
}
*/

