<?php

require_once dirname(__FILE__) . '/../../vendor/autoload.php';
require_once realpath(__DIR__ . '/../../bootstrap.php');

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;
use Symfony\Component\Yaml\Yaml;
use Dotenv\Dotenv;

/**
 * Created by PhpStorm.
 * User: Taras
 * Date: 16.08.2018
 * Time: 14:54
 *
 * Updated: 2025-06-17 16:38
 *
 * @author Taras Shkodenko <taras.shkodenko@gmail.com>
 */

function l_m(string $msg)
{
    $dotenv = Dotenv::createImmutable(dirname(__DIR__, 2));
    $dotenv->load();

    $debugIp = $_ENV['DEBUG_IP']; // use debug IP value from env or default one if env is not set

    if (empty($debugIp)) { // Do not log any data if debug IP is empty
        return false;
    } else {
        error_log(__METHOD__ . ' +' . __LINE__ . ' $debugIp: ' . var_export($debugIp, true));
    }

    // Do not log on prod by default
    // if ($_SERVER['SERVER_NAME'] === 'inventure.com.ua') {
        // error_log(__FILE__ . ' +' . __LINE__ . ' ' . __FUNCTION__ . ' log to file is disabled for production env: ' . $_SERVER['SERVER_NAME']);
        // return false;
    // }

    // $logFileName = dirname(__FILE__) . '/' . date('Y-m-d_H-i') . '_' . bin2hex(random_bytes(7)) . '.log';
    // $logFileName = realpath(__DIR__ . '/../../log') . '/' . date('Y-m-d_H-i') . '_l_m.log';
    $logFileName = realpath(__DIR__ . '/../../log') . '/' . date('Y-m-d_H') . '__l_m.log';
    if (!file_exists($logFileName))
    {
        touch($logFileName);
        @chmod($logFileName, 0664);
    }
    if (is_writeable($logFileName) && isset($_SERVER['HTTP_CF_CONNECTING_IP']) && ($_SERVER['HTTP_CF_CONNECTING_IP'] == $debugIp))
    {
        error_log(date('r') . ' ' . $msg . PHP_EOL, 3, $logFileName);
    }

    // Do not log if client IP does not match list below
    if (($_SERVER['REMOTE_ADDR'] !== '185.11.28.246') // @ts 2021-02-25; ISP Best; Grand Villas; home
        && ($_SERVER['REMOTE_ADDR'] !== '178.214.193.98') // InVenture office; Kyiv
        && ($_SERVER['REMOTE_ADDR'] !== '82.193.120.77') // Kyiv - cafe Kombinat - Volodymyra Ivasyuka ave. 24-a
    ) {
        // error_log(__FILE__ . ' +' . __LINE__ . ' ' . __FUNCTION__ . ' log to file is disabled for client IP: ' . $_SERVER['REMOTE_ADDR']);
        return false;
    } else {
        if (is_writeable($logFileName)) {
            error_log(date('r') . ' ' . $msg . PHP_EOL, 3, $logFileName);
        }
    }
}

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

function build_pager($maxPages, $currentPage = 1, $numPagerLinks = 5)
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

function _validateGoogleReCaptcha($googleReCapchaResponse)
{
    // $appConfig = Yaml::parseFile( dirname(__FILE__) . '/../config/app.yml');
    $cfg = app()->getService('config')->get('app')->google_recaptcha;
    $googleReCaptchaSecret = $cfg['secret_key'];

    // @see: https://developers.google.com/recaptcha/docs/verify
    $postData = http_build_query([
        'secret' => $googleReCaptchaSecret,
        'response' => $googleReCapchaResponse,
        // 'remoteip' => 'Optional. The user's IP address.',
    ]);
    $opts = ['http' =>
        [
            'method' => 'POST',
            'header' => 'Content-type: application/x-www-form-urlencoded',
            'content' => $postData,
        ],
    ];
    $context = stream_context_create($opts);
    $result = file_get_contents('https://www.google.com/recaptcha/api/siteverify', false, $context);

    l_m(__FILE__ . ' +' . __LINE__ . ' $result: ' . var_export($result, true));

    $r97 = json_decode($result, true);
    if (isset($r97["success"]) && ($r97["success"] == true)) {
        return true;
    }

    return false;
}

function _sendFormRequest($data, $useExternalConnector = true)
{
    l_m(__FUNCTION__ . ' +' . __LINE__ . ' sending data to HubSpot CRM: ' . var_export($data, 1));
    //
    if (isset($data['formData']) && !empty($data['formData'])) {
        if (preg_match('/Плис/ui', $data['formData'])
            || preg_match('/плис/ui', $data['formData'])
            || preg_match('/EVP/ui', $data['formData'])
            || preg_match('/Плис Евгений/ui', $data['formData'])
            || preg_match('/Евгений Плис/ui', $data['formData'])
        ) {
            l_m(__FUNCTION__ . ' +' . __LINE__ . ' Stopped sending SPAM to HubSpot CRM');
            return false;
        }
    }
    //
    /*
    $uri = 'https://nh.leadbox.com.ua/hubspot/074bmom3utuln3yym6joh12dnl6ow6lltiark1ar';
    if ($useExternalConnector !== true) {
        $uri = 'https://dev.inventure.com.ua/hubspot.php?key=074bmom3utuln3yym6joh12dnl6ow6lltiark1ar';
        $uri = 'https://inventure.com.ua/hubspot.php?key=074bmom3utuln3yym6joh12dnl6ow6lltiark1ar';
    }
    */
    $uri = 'https://inventure.com.ua/hubspot.php?key=074bmom3utuln3yym6joh12dnl6ow6lltiark1ar';
    l_m(__FUNCTION__ . ' +' . __LINE__ . ' Sending request to: ' . var_export($uri, 1));
    //
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $uri);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); // On dev server only!
    //
    // curl_setopt($ch, CURLOPT_ENCODING, 'UTF-8');
    //
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
    $resCode = curl_errno($ch);
    $result = curl_exec($ch);
    l_m(__FUNCTION__ . ' +' . __LINE__ . ' request result: ' . var_export($result, 1));
    if ($result === false) {
        if (curl_error($ch)) {
            l_m(__FUNCTION__ . ' +' . __LINE__ . ' curl error: ' . var_export(curl_error($ch), 1));
        }
        if ($resCode !== 0) {
            l_m(__FUNCTION__ . ' +' . __LINE__ . ' HTTP error code: ' . var_export($resCode, 1));
        }
    }

    return $result;
}

function sendMailForm($data, $recipient = 'info@inventure.ua', $subject = 'InVenture form submission')
{
    // l_m(__FUNCTION__ . ' +' . __LINE__ . " Message could not be sent. Temporary disabled because of SPAM attack");
    // return true;

    $inputLabel = [
        'firstname' => 'Имя',
        'lastname' => 'Фамилия',
        'company' => 'Компания',
        'job' => 'Должность',
        'email' => 'Email',
        'manager' => 'Заказать звонок от менеджера',
        'phone' => 'Номер телефона',
        'tel' => 'Номер телефона',
        'name' => 'Имя',
        'price' => 'Требуемые инвестиции / Цена $',
        'region' => 'Регион',
        'text' => 'Текст',
    ];
    $types = [
        '0' => 'Сельское хозяйство',
        '1' => 'Пищевая промышленность',
        '2' => 'Добывающая промышленность',
        '3' => 'Металлургия и металлообработка',
        '4' => 'Машиностроение и производство электрооборудования',
        '5' => 'Нефтехимическая промышленность',
        '6' => 'Фармацевтическая промышленность',
        '7' => 'Деревообработка и целлюлозно-бумажная промышленность',
        '8' => 'Текстильная промышленность',
        '9' => 'Строительство и недвижимость',
        '10' => 'Финансовая деятельность',
        '11' => 'Оптовая и розничная торговля',
        '12' => 'Бизнес услуги',
        '13' => 'Транспорт и складское хозяйство',
        '14' => 'Телекоммуникации и связь',
        '15' => 'Искусство, развлечения, спорт и отдых',
        '16' => 'Электроэнергетика и топливная промышленность',
        '17' => 'Водообеспечение и переработка отходов',
        '18' => 'Информационные технологии и интернет проекты',
        '19' => 'Инновации и высокие технологии',
        '20' => 'Гостиницы и общественное питание',
        '21' => 'Здравоохранение и социальная помощь',
        '22' => 'Потребительские услуги',
        '23' => 'Образование',
        '24' => 'Организации и ассоциации',
    ];
    $stage = [
        '0' => 'Стартап (Startup / Seed)',
        '1' => 'Поздние стадии (Later Stage / Exit)',
        '2' => 'Стадия роста и расширения',
        '3' => 'Проблемные активы (Distressed Assets)',
    ];
    $profit = [
        '0' => '10-15%',
        '1' => '15-20%',
        '2' => '20-25%',
        '3' => '25-30%',
        '4' => 'Свыше 30%',
    ];
    $location = [
        '0' => 'Украина',
        '1' => 'СНГ',
        '2' => 'Центральная и Восточная Европа',
        '3' => 'Западная Европа',
        '4' => 'США',
        '5' => 'Азия',
    ];
    $strong = [
        '0' => 'Финансы',
        '1' => 'Управление',
        '2' => 'Связи',
        '3' => 'Технологии',
        '4' => 'Недвижимость',
    ];
    $size = [
        '0' => 'до $100 тыс.',
        '1' => 'от $100 тыс. до $500 тыс.',
        '2' => 'от 500 тыс. до $1 млн.',
        '3' => 'от $1 млн. до $5 млн.',
        '4' => 'от $5 млн. до $10 млн.',
        '5' => 'более $10 млн.',
    ];
    $inv = [
        '0' => 'Кредитование',
        '1' => 'Контрольный пакет (более 50% доли в бизнесе)',
        '2' => 'Сотрудничество',
        '3' => 'Миноритарный пакет (менее 50% доли в бизнесе)',
    ];
    $involvement = [
        '0' => 'Активное',
        '1' => 'Пассивное',
    ];
    $queryType = [
        '0' => 'Продажа бизнеса',
        '1' => 'Инвестиции в действующий бизнес',
        '2' => 'Инвестиции в стартап',
        '3' => 'Продажа коммерческой недвижимости',
        '4' => 'Реклама франшизы',
        '5' => 'Другое'
    ];

    l_m(__FUNCTION__ . ' +' . __LINE__ . ' sending email with data: ' . var_export($data, true) . PHP_EOL);
    $appConfig = Yaml::parseFile( dirname(__FILE__) . '/../../config/app.yml');
    if (!isset($appConfig['mail']) || !is_array($appConfig['mail']) || empty($appConfig['mail'])) {
        l_m(__FUNCTION__ . ' +' . __LINE__ . ' error in mail config!' . PHP_EOL);
        return false;
    }
    if (!isset($appConfig['google_recaptcha']) || !is_array($appConfig['google_recaptcha']) || empty($appConfig['google_recaptcha'])) {
        l_m(__FUNCTION__ . ' +' . __LINE__ . ' error in google_recaptcha config!' . PHP_EOL);
        return false;
    }

    $mail = new PHPMailer(true);
    try {
        $mail->isSMTP();
        $mail->Host       = $appConfig['mail']['host'];
        $mail->SMTPAuth   = true;
        $mail->Username   = $appConfig['mail']['user'];
        $mail->Password   = $appConfig['mail']['passwd'];
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;
        $mail->Port       = $appConfig['mail']['port'];
        //
        $mail->CharSet    = 'UTF-8';
        $mail->Encoding   = 'base64';
        //
        if (is_array($appConfig['mail']['from']) && !empty($appConfig['mail']['from'])) {
            foreach ($appConfig['mail']['from'] as $mailAddr => $mailName) {
                $mail->setFrom($mailAddr, $mailName);
            }
        }
        $mail->addAddress($recipient, 'Inventure');
        // $mail->addBCC('podlom@gmail.com'); // debug
        //
        $mail->isHTML(true); // Set email format to HTML
        //
        if (empty($subject)) {
            $subject = 'InVenture form submission';
        }
        $mail->Subject = $subject;
        //
        $htmlBody = $textBody = '';
        foreach ($data as $k1 => $v1) {
            $sep9 = $sep8 = $sep7 = $sep6 = $sep5 = $sep4 = $sep3 = $sep2 = $sep1 = $val1 = $key1 = '';
            if (is_array($v1)) {
                switch ($k1) {
                    case 'types':
                        foreach ($v1 as $k2 => $v2) {
                            if (isset($types[$k2])) {
                                $val1 .= $sep1 . $types[$k2];
                            } else {
                                $val1 .= var_export($v2, true);
                            }
                            $sep1 = ';';
                            $key1 = 'Приоритетные направления инвестирования';
                        }
                        break;
                    case 'stage':
                        foreach ($v1 as $k3 => $v3) {
                            if (isset($stage[$k3])) {
                                $val1 .= $sep2 . $stage[$k3];
                            } else {
                                $val1 .= var_export($v3, true);
                            }
                            $sep2 = ';';
                            $key1 = 'Стадии инвестирования';
                        }
                        break;
                    case 'profit':
                        foreach ($v1 as $k4 => $v4) {
                            if (isset($profit[$k4])) {
                                $val1 .= $sep3 . $profit[$k4];
                            } else {
                                $val1 .= var_export($v4, true);
                            }
                            $sep3 = ';';
                            $key1 = 'Планируемая доходность';
                        }
                        break;
                    case 'location':
                        foreach ($v1 as $k5 => $v5) {
                            if (isset($location[$k5])) {
                                $val1 .= $sep4 . $location[$k5];
                            } else {
                                $val1 .= var_export($v5, true);
                            }
                            $sep4 = ';';
                            $key1 = 'Регион';
                        }
                        break;
                    case 'strong':
                        foreach ($v1 as $k6 => $v6) {
                            if (isset($strong[$k6])) {
                                $val1 .= $sep5 . $strong[$k6];
                            } else {
                                $val1 .= var_export($v6, true);
                            }
                            $sep5 = ';';
                            $key1 = 'Сильные стороны';
                        }
                        break;
                    case 'size':
                        foreach ($v1 as $k7 => $v7) {
                            if (isset($size[$k7])) {
                                $val1 .= $sep6 . $size[$k7];
                            } else {
                                $val1 .= var_export($v7, true);
                            }
                            $sep6 = ';';
                            $key1 = 'Объемы инвестирования';
                        }
                        break;
                    case 'inv':
                        foreach ($v1 as $k8 => $v8) {
                            if (isset($inv[$k8])) {
                                $val1 .= $sep7 . $inv[$k8];
                            } else {
                                $val1 .= var_export($v8, true);
                            }
                            $sep7 = ';';
                            $key1 = 'Форма инвестирования';
                        }
                        break;
                    case 'involvement':
                        foreach ($v1 as $k9 => $v9) {
                            if (isset($involvement[$k9])) {
                                $val1 .= $sep8 . $involvement[$k9];
                            } else {
                                $val1 .= var_export($v9, true);
                            }
                            $sep8 = ';';
                            $key1 = 'Участие в проекте';
                        }
                        break;
                    case 'querytype':
                        foreach ($v1 as $k19 => $v19) {
                            if (isset($queryType[$k19])) {
                                $val1 .= $sep9 . $queryType[$k19];
                            } else {
                                $val1 .= var_export($v19, true);
                            }
                            $sep9 = ';';
                            $key1 = 'С чем связан ваш запрос';
                        }
                        break;
                    default:
                        $val1 = var_export($v1, true);
                        $key1 = $k1;
                        break;
                }
            } else {
                l_m(__FUNCTION__ . ' +' . __LINE__ . ' $k1: ' . var_export($k1, true));
                l_m(__FUNCTION__ . ' +' . __LINE__ . ' $v1: ' . var_export($v1, true));
                if (($k1 == 'name') && preg_match('|плис|ui', $v1) && preg_match('|евгений|ui', $v1)) {
                    l_m(__FUNCTION__ . ' +' . __LINE__ . ' Stopped sending SPAM');
                    return false;
                }
                if (isset($inputLabel[$k1])) {
                    $key1 = $inputLabel[$k1];
                } else {
                    $key1 = $k1;
                }
                $val1 = $v1;
            }
            $htmlBody .= '<strong>' . $key1 . ':</strong> ' . $val1 . '<br>' . PHP_EOL;
            $textBody .= $key1 . ': ' . $val1 . PHP_EOL;
        }
        $mail->Body    = $htmlBody;
        $mail->AltBody = $textBody;
        $mail->send();
        // l_m(__FUNCTION__ . ' +' . __LINE__ . ' Message has been sent');
        return true;
    } catch (Exception $e) {
        l_m(__FUNCTION__ . ' +' . __LINE__ . " Message could not be sent. Mailer Error: {$mail->ErrorInfo}");
        return false;
    }
}

function sendAddInvPropMail($data, $recipient = 'info@inventure.ua', $subject = 'InVenture form submission', $formType = 1)
{
    l_m(__FUNCTION__ . ' +' . __LINE__ . ' sending email with data: ' . var_export($data, true) . PHP_EOL);
    $appConfig = Yaml::parseFile( dirname(__FILE__) . '/../../config/app.yml');
    if (!isset($appConfig['mail']) || !is_array($appConfig['mail']) || empty($appConfig['mail'])) {
        l_m(__FUNCTION__ . ' +' . __LINE__ . ' error in mail config!' . PHP_EOL);
        return false;
    }

    $mail = new PHPMailer(true);
    try {
        $mail->isSMTP();
        $mail->Host       = $appConfig['mail']['host'];
        $mail->SMTPAuth   = true;
        $mail->Username   = $appConfig['mail']['user'];
        $mail->Password   = $appConfig['mail']['passwd'];
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;
        $mail->Port       = $appConfig['mail']['port'];
        //
        $mail->CharSet    = 'UTF-8';
        $mail->Encoding   = 'base64';
        //
        if (is_array($appConfig['mail']['from']) && !empty($appConfig['mail']['from'])) {
            foreach ($appConfig['mail']['from'] as $mailAddr => $mailName) {
                $mail->setFrom($mailAddr, $mailName);
            }
        }
        $mail->addAddress($recipient, 'Inventure');
        // $mail->addBCC('podlom@gmail.com'); // debug
        //
        $mail->isHTML(true); // Set email format to HTML
        //
        if (empty($subject)) {
            $subject = 'InVenture form submission';
        }
        $mail->Subject = $subject;
        //
        // TODO: get setting from admin
        // '/page-attr-data.php', {'action': 'get_setting', 'name': 'link_ind'} - Для Полного сопровождения
        // '/page-attr-data.php', {'action': 'get_setting', 'name': 'link_adv'} - Для Рекламного подхода
        //
        // $linkHref = 'https://drive.google.com/open?id=19Ax-vqbQ9fPFEfTloQ_9UzNAZBKIPPcu';
        // $linkHref = 'https://drive.google.com/file/d/1O8kFTEPX1kiOn0cXV-WCLTxHunkiTThj/view?usp=sharing';
        //
        $linkHref = 'https://drive.google.com/file/d/1dTvFAqPnFBYfYRf86J5wFy4UtgQ3xkcq/view?usp=sharing';
        if (($linkHref = getLink('link_ind')) == false) { // Для Полного сопровождения
            $linkHref = 'https://drive.google.com/file/d/1dTvFAqPnFBYfYRf86J5wFy4UtgQ3xkcq/view?usp=sharing';
        }
        if ($formType == 1) { // Для Рекламного подхода
            // $linkHref = 'https://drive.google.com/file/d/11uxZNhMDjBNRu93jmb913zqokNHGzIbU/view?usp=sharing';
            $linkHref = 'https://drive.google.com/file/d/1_6DUg9KUdUFQ6-RDT0o0buJ3XrX2YVre/view?usp=sharing';
            if (($linkHref = getLink('link_adv')) == false) {
                $linkHref = 'https://drive.google.com/file/d/1_6DUg9KUdUFQ6-RDT0o0buJ3XrX2YVre/view?usp=sharing';
            }
        }
        l_m(__FUNCTION__ . ' +' . __LINE__ . ' $linkHref: ' . var_export($linkHref, true));
        $textBody = 'Добрий день!
Дякуємо Вам за звернення до InVenture.
У відповідь на Ваш запит надсилаємо презентацію ' . $linkHref . ' з описом послуг нашої компанії.

Для замовлення послуг або уточнення інформації, зв\'яжіться будь-ласка з нашим менеджером:
Tel.: +38 097 772 72 92 (Viber, WhatsApp, Telegram)
E-mail: info@inventure.ua
';
        l_m(__FUNCTION__ . ' +' . __LINE__ . ' $textBody: ' . var_export($textBody, true));
        $htmlBody = '<p>Добрий день!</p>
<p>Дякуємо Вам за звернення до InVenture.</p>
<p>У відповідь на Ваш запит надсилаємо <a href="' . $linkHref . '">презентацію з описом послуг</a> нашої компанії.</p>
<br>
<p>Для замовлення послуг або уточнення інформації, зв\'яжіться будь-ласка з нашим менеджером:</p>
<p>Tel.: <a href="tel:+380977727292">+38 097 772 72 92</a> (Viber, WhatsApp, Telegram)</p>
<p>E-mail: <a href="mailto:info@inventure.ua">info@inventure.ua</a></p>
';
        l_m(__FUNCTION__ . ' +' . __LINE__ . ' $htmlBody: ' . var_export($htmlBody, true));
        //
        $mail->Body    = $htmlBody;
        $mail->AltBody = $textBody;
        $mail->send();
        l_m(__FUNCTION__ . ' +' . __LINE__ . ' Email has been sent');
        return true;
    } catch (Exception $e) {
        l_m(__FUNCTION__ . ' +' . __LINE__ . " Email could not be sent. Mailer Error: {$mail->ErrorInfo}");
        return false;
    }
}

function addMailSubscriber($data, $db)
{
    $retMsg = '';
    //
    l_m(__FUNCTION__ . ' +' . __LINE__ . ' POST data: ' . var_export($data, true));
    //
    if (isset($data['subscribe'], $data['subscribe']['email']) && !empty($data['subscribe']['email'])) {
        $email = $db->escape($data['subscribe']['email']);
        $query = "SELECT * FROM `Mail_Subscriber` WHERE `email` = '{$email}'";
        $res70 = $db->query($query);

        // $msg = __FILE__ . ' +' . __LINE__ . ' SQL: ' . $query . PHP_EOL;
        // l_m( $msg );

        $res69 = $db->query($query);

        // $msg = __FILE__ . ' +' . __LINE__ . ' Select db result: ' . var_export($res69, true) . PHP_EOL;
        // l_m( $msg );

        if (isset($res69[0]) && is_array($res69[0]) && !empty($res69[0])) {
            // $attrData = json_decode($res69[0]['attr']);
            // $msg = __FILE__ . ' +' . __LINE__ . ' JSON decoded attr data: ' . var_export($attrData, true) . PHP_EOL;
            // l_m( $msg );

            $retMsg = 'Спасибо. Ваш email уже был подписан на рассылку';
        } else {
            $attrData = $data['subscribe'];
            if (isset($attrData['email'])) {
                unset($attrData['email']);
            }
            if ((isset($attrData['firstname']) && !empty($attrData['firstname'])) || (isset($attrData['lastname']) && !empty($attrData['lastname']))) {
                @$name = $db->escape(trim($attrData['firstname'] . ' ' . $attrData['lastname']));
                if (!empty($name)) {
                    $attrData['name'] = $name;
                }
            }

            $msg = __FILE__ . ' +' . __LINE__ . ' $attrData: ' . var_export($attrData, true) . PHP_EOL;
            l_m( $msg );

            $attrData = $db->escape(json_encode($attrData));
            $crDate = $db->escape(date("Y-m-d H:i:s"));
            $query = "INSERT INTO `Mail_Subscriber` SET `email` = '{$email}', `status` = '1', `attr` = '{$attrData}', `created` = '{$crDate}', `updated` = '{$crDate}'";
            $res80 = $db->query($query);

            $msg = __FILE__ . ' +' . __LINE__ . ' SQL: ' . $query . PHP_EOL;
            l_m( $msg );

            if ($res80) {
                $retMsg = 'Спасибо. Вы успешно подписаны на рассылку';
            }
        }

    }

    l_m( $retMsg );
    return $retMsg;
}

function getLink($name = '')
{
    if (empty($name)) {
        return false;
    }
    $postData = http_build_query(
        [
            'action' => 'get_setting',
            'name' => $name,
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
    $resLink = file_get_contents('https://inventure.com.ua/page-attr-data.php', false, $context);
    l_m(__METHOD__ . ' +' . __LINE__ . ' $resLink: ' . var_export($resLink, true));
    return $resLink;
}

/**
 * Функція для фільтрації імені, дозволяє лише англійські, українські та російські символи
 *
 * @param string $originalName Оригінальне ім'я
 * @return string Виправлене ім'я
*/
function filterNameValueForHubspot($originalName)
{
    // Регулярний вираз для дозволених символів
    $allowedPattern = '/[^a-zA-ZА-Яа-яЁёІіЇїЄє]/u';

    // Видалення всіх символів, що не входять у дозволений діапазон
    $filteredName = preg_replace($allowedPattern, '', $originalName);

    // Обрізаємо зайві пробіли
    $filteredName = trim($filteredName);

    // Повертаємо відфільтроване ім'я
    return $filteredName;
}

function _validateCloudflareCaptcha(string $cloudflareCapchaResponse) : bool
{
    if (empty($cloudflareCapchaResponse)) {
        return false;
    }

    $cfg = app()->getService('config')->get('app')->cloudflare_captcha;
    $cloudflareCaptchaSecret = $cfg['secret_key'];

    // @see: https://developers.cloudflare.com/turnstile/get-started/server-side-validation/
    $postData = http_build_query([
        'secret' => $cloudflareCaptchaSecret,
        'response' => $cloudflareCapchaResponse,
    ]);
    $opts = ['http' =>
        [
            'method' => 'POST',
            'header' => 'Content-type: application/x-www-form-urlencoded',
            'content' => $postData,
        ],
    ];
    $context = stream_context_create($opts);
    $result = file_get_contents('https://challenges.cloudflare.com/turnstile/v0/siteverify', false, $context);

    l_m(__FILE__ . ' +' . __LINE__ . ' $result: ' . var_export($result, true));

    $r96 = json_decode($result, true);
    if (isset($r96["success"]) && ($r96["success"] == true)) {
        return true;
    }

    return false;
}

function getParentCategoryIdByHref(string $urlPath) : ?int
{
    $parentCategoryId = null;

    switch ($urlPath) {
        case '/en/investments/business':
            $parentCategoryId = 9779;
            break;
        case '/en/investments/projects':
            $parentCategoryId = 9778;
            break;
        case '/en/investments/realestate':
            $parentCategoryId = 9780;
            break;
        case '/en/investments/land':
            $parentCategoryId = 9781;
            break;
        case '/en/investments/offer':
            $parentCategoryId = 9782;
            break;
        case '/en/investments/franchising':
        case '/en/investments/en_franchising':
            $parentCategoryId = 19304;
            break;
        case '/investments/projects':
            $parentCategoryId = 7860;
            break;
        case '/investments/business':
            $parentCategoryId = 7861;
            break;
        case '/investments/realestate':
            $parentCategoryId = 7862;
            break;
        case '/investments/land':
            $parentCategoryId = 7863;
            break;
        case '/investments/offer':
            $parentCategoryId = 7864;
            break;
        case '/investments/franchising':
            $parentCategoryId = 19303;
            break;
        case '/uk/investments/projects':
            $parentCategoryId = 25261;
            break;
        case '/uk/investments/business':
            $parentCategoryId = 25262;
            break;
        case '/uk/investments/realestate':
            $parentCategoryId = 25264;
            break;
        case '/uk/investments/land':
            $parentCategoryId = 25265;
            break;
        case '/uk/investments/offer':
            $parentCategoryId = 25266;
            break;
        case '/uk/investments/franchising':
            $parentCategoryId = 25267;
            break;
    }

    return $parentCategoryId;
}

function debugSql(string $msg)
{
    $logFileName = realpath(__DIR__ . '/../../log') . '/debug_sql.log';

    if (!file_exists($logFileName))
    {
        touch($logFileName);
        @chmod($logFileName, 0664);
    }

    if (is_writeable($logFileName))
    {
        error_log(date('r') . ' ' . $msg . PHP_EOL, 3, $logFileName);
    }
}

function getDb()
{
    require_once app()->getPath() . '/cli/lib/db.class.php';
    $cfg = app()->getService('config')->get('app')->db;

    $db = new \DB($cfg['host'], $cfg['user'], $cfg['password'], $cfg['dbname']);

    $db->query("SET collation_connection = utf8_unicode_ci");
    $db->query("SET NAMES " . $cfg['charset']);
    $db->query("SET CHARACTER SET " . $cfg['charset']);
    $db->query("SET @@collation_server = utf8_unicode_ci");

    return $db;
}
