<?php

/**
 * Created by PhpStorm
 * User: shtaras
 * Date: 2020-04-18
 * Time: 07:38
 *
 * @author Taras Shkodenko <ts@doagency.net>
 */

require_once dirname(__FILE__) . '/../vendor/autoload.php';


use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;
use Symfony\Component\Yaml\Yaml;


const MAX_PAGER_SIZE = 25;
const DEFAULT_LIMIT = 24;

function l_m($msg)
{
    $logFileName = dirname(__FILE__) . '/invest.log';
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
    if (($_SERVER['REMOTE_ADDR'] !== '185.11.28.184') // @ts 2021-01-18 ISP Best, Grand Villas, home
        && ($_SERVER['REMOTE_ADDR'] !== '178.214.193.98') // InVenture, Kyiv, office
        && ($_SERVER['REMOTE_ADDR'] !== '81.20.118.43') // Unit.City, Kyiv, office
        && ($_SERVER['REMOTE_ADDR'] !== '188.163.56.214') // 2020-09-08 ISP Kyivstar, Mariupol, home
    ) {
        // error_log(__FILE__ . ' +' . __LINE__ . ' ' . __FUNCTION__ . ' log to file is disabled for client IP: ' . $_SERVER['REMOTE_ADDR']);
        return false;
    } else {
        if (is_writeable($logFileName)) {
            error_log(date('r') . ' ' . $msg . PHP_EOL, 3, $logFileName);
        }
    }
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
    $uri = 'https://nh.leadbox.com.ua/hubspot/074bmom3utuln3yym6joh12dnl6ow6lltiark1ar';
    if ($useExternalConnector !== true) {
        $uri = 'https://dev.inventure.com.ua/hubspot.php?key=074bmom3utuln3yym6joh12dnl6ow6lltiark1ar';
    }
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
}

function sendMailForm($data, $recipient = 'info@inventure.ua', $subject = 'InVenture form submission')
{
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
    $appConfig = Yaml::parseFile( dirname(__FILE__) . '/../config/app.yml');
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
    $appConfig = Yaml::parseFile( dirname(__FILE__) . '/../config/app.yml');
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
        // Для Полного сопровождения
        $linkHref = 'https://drive.google.com/file/d/1VZdIpPBiaWrLwobZbKjPzMIiSKzmz-hz/view';
        if ($formType == 1) { // Для Рекламного подхода
            $linkHref = 'https://drive.google.com/file/d/1qiYiahSH65a88GP7VU2CMb3ZTKu3LGIn/view';
        }
        $textBody = 'Добрый день!
Благодарим Вас за обращение в InVenture.
В ответ на Ваш запрос, отправляем презентацию ' . $linkHref . ' с описанием услуг нашей компании.

Для заказа и уточнения информации, свяжитесь с менеджером:
Tel.: +38 097 772 72 92 (Viber, WhatsApp, Telegram)
E-mail: info@inventure.ua
';
        $htmlBody = '<p>Добрый день!</p>
<p>Благодарим Вас за обращение в InVenture.</p>
<p>В ответ на Ваш запрос, отправляем <a href="' . $linkHref . '">презентацию с описанием услуг</a> нашей компании.</p>
<br>
<p>Для заказа и уточнения информации, свяжитесь с менеджером:</p>
<p>Tel.: <a href="tel:+380977727292">+38 097 772 72 92</a> (Viber, WhatsApp, Telegram)</p>
<p>E-mail: <a href="mailto:info@inventure.ua">info@inventure.ua</a></p>
';
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
$lang = 'ru';
$urlLangPrefix = '';
$sqlPath = '/investments';
if (!empty($_SERVER['HTTP_REFERER'])) {
    $urlPath = parse_url($_SERVER['HTTP_REFERER'], PHP_URL_PATH);
    //
    $msg = __FILE__ . ' +' . __LINE__ . ' HTTP_REFERER PHP_URL_PATH: ' . var_export($urlPath, true);
    l_m($msg);
    //
    if (($urlPath === '/en/investments')
        || preg_match('%/en/investments/(.*)%s', $urlPath)
    ) {
        //
        $sqlPath = '/en/investments';
        // $sqlPath = $urlPath;
        $lang = 'en';
        // $urlLangPrefix = '/en';
        $urlLangPrefix = '/' . $lang;
    }
    //
    $msg = __FILE__ . ' +' . __LINE__ . ' $sqlPath: ' . var_export($sqlPath, true);
    l_m($msg);
    //
}
//
if (!empty($_REQUEST)) {
    require_once app()->getPath() . '/cli/lib/db.class.php';
    $cfg = app()->getService('config')->get('app')->db;
    //
    if ($_SERVER['SERVER_NAME'] != 'inventure.com.ua') {
        // adjust db settings for dev environment
        $cfg['host'] = '127.0.0.1';
        $cfg['dbname'] = 'inventure_dev';
        $cfg['user'] = 'inventure_dev';
        $cfg['password'] = '[[)sq5J0mXKZ5x2E';
    }
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
    $msg = __FILE__ . ' +' . __LINE__ . ' $_SERVER: ' . var_export($_SERVER, true) . ' $_GET: ' . var_export($_GET, true) . '; $_POST: ' . var_export($_POST, true) . '; $_REQUEST: ' . var_export($_REQUEST, true);
    l_m($msg);
    //
    if (isset($_POST, $_POST['sf_approach']) && is_array($_POST['sf_approach']) && !empty($_POST['sf_approach'])) { // Add investment proposal
        $sFormData = serialize($_POST['sf_approach']);
        $formData = array_merge(['formData' => $sFormData], ['formName' => 'sf_approach', 'formUri' => '/form/approach']);
        $rs9 = _sendFormRequest($formData, false);
        if ($rs9 !== false) {
            sendMailForm($_POST['sf_approach'], 'info@inventure.ua', 'InVenture form submission');
            //
            if (isset($_POST['sf_approach']['latel_deal_name']) && !empty($_POST['sf_approach']['latel_deal_name'])) {
                $formName = $_POST['sf_approach']['latel_deal_name'];
                if ($formName != 'Рекламное продвижение') {
                    $formType = 2;
                } else {
                    $formType = 1;
                }
            } else {
                $formName = 'Рекламное продвижение';
                $formType = 1;
            }
            if (isset($_POST['sf_approach']['email']) && !empty($_POST['sf_approach']['email'])) {
                sendAddInvPropMail($_POST['sf_approach'], $_POST['sf_approach']['email'], 'InVenture заполнена форма ' . $formName, $formType);
            }
        }
    }
    //
    if (isset($_POST, $_POST['sf_investor']) && is_array($_POST['sf_investor']) && !empty($_POST['sf_investor'])) { // Add investment proposal
        $sFormData = serialize($_POST);
        $formData = array_merge(['formData' => $sFormData], ['formName' => 'sf_investor', 'formUri' => '/form/investor']);
        $rs8 = _sendFormRequest($formData, false);
        if ($rs8 !== false) {
            sendMailForm($_POST['sf_investor'], 'info@inventure.ua', 'InVenture form submission');
        }
    }
    //
    if (isset($_POST, $_POST['sf_investment_callback']) && is_array($_POST['sf_investment_callback']) && !empty($_POST['sf_investment_callback'])) { // Add investment proposal
        $sFormData = serialize($_POST['sf_investment_callback']);
        $formData = array_merge(['formData' => $sFormData], ['formName' => 'sf_investment_callback', 'formUri' => '/form/investment_callback']);
        $rs7 = _sendFormRequest($formData, false);
        if ($rs7 !== false) {
            sendMailForm($_POST['sf_investment_callback'], 'info@inventure.ua', 'InVenture form submission');
        }
    }
    //
    if (isset($_POST, $_POST['sf_msb_form1']) && is_array($_POST['sf_msb_form1']) && !empty($_POST['sf_msb_form1'])) {
        if (!isset($_POST['sf_msb_form1']['latel_deal_name'])) {
            $_POST['sf_msb_form1']['latel_deal_name'] = 'MSB Callback';
        }
        $sFormData = serialize($_POST['sf_msb_form1']);
        $formData = array_merge(['formData' => $sFormData], ['formName' => 'sf_msb_form1', 'formUri' => '/form/msb_form1']);
        $rs6 = _sendFormRequest($formData, false);
        if ($rs6 !== false) {
            sendMailForm($_POST['sf_msb_form1'], 'yuriikantordrabkin1+rnrsnorabrmpbqizxyqs@boards.trello.com', 'Лид форма');
        }
    }
    //
    if (isset($_POST, $_POST['sf_msb_form2']) && is_array($_POST['sf_msb_form2']) && !empty($_POST['sf_msb_form2'])) {
        if (!isset($_POST['sf_msb_form2']['latel_deal_name'])) {
            $_POST['sf_msb_form2']['latel_deal_name'] = 'MSB Quiz';
        }
        $sFormData = serialize($_POST['sf_msb_form2']);
        $formData = array_merge(['formData' => $sFormData], ['formName' => 'sf_msb_form2', 'formUri' => '/form/msb_form2']);
        $rs5 = _sendFormRequest($formData, false);
        if ($rs5 !== false) {
            sendMailForm($_POST['sf_msb_form2'], 'yuriikantordrabkin1+rnrsnorabrmpbqizxyqs@boards.trello.com', 'Квиз');
        }
    }
    //
    if (isset($_REQUEST['action']) && ($_REQUEST['action'] == 'get')) { // Get data action
        if (isset($_REQUEST['href']) && !empty($_REQUEST['href'])) {
            $url2Parse = $_REQUEST['href'];
            $u1 = parse_url($url2Parse);
            // l_m(__FILE__ . ' +' . __LINE__ . ' parsed URL: ' . var_export($u1, true));
            parse_str($url2Parse, $p1);
            // l_m(__FILE__ . ' +' . __LINE__ . ' URL params: ' . var_export($p1, true));
            //
            $price2 = array_pop($p1);
            // l_m(__FILE__ . ' +' . __LINE__ . ' $price2: ' . var_export($price2, true) . '; other URL params: ' . var_export($p1, true));
            $price1 = array_pop($p1);
            // l_m(__FILE__ . ' +' . __LINE__ . ' $price1: ' . var_export($price1, true) . '; other URL params: ' . var_export($p1, true));
            $region = array_pop($p1);
            // l_m(__FILE__ . ' +' . __LINE__ . ' $region: ' . var_export($region, true) . '; other URL params: ' . var_export($p1, true));
            // $uregion = array_pop($p1);
            // l_m( __FILE__ . ' +' . __LINE__ . ' $uregion: ' . var_export($uregion, true) . '; other URL params: ' . var_export($p1, true) );
            $filter = array_pop($p1);
            // l_m(__FILE__ . ' +' . __LINE__ . ' $filter: ' . var_export($filter, true) . '; other URL params: ' . var_export($p1, true));
            $cat = array_pop($p1);
            // l_m(__FILE__ . ' +' . __LINE__ . ' $cat: ' . var_export($cat, true) . '; other URL params: ' . var_export($p1, true));
        }

        if (isset($_REQUEST['price1']) && !empty($_REQUEST['price1'])) {
            $price1 = intval($_REQUEST['price1']);
            l_m(__FILE__ . ' +' . __LINE__ . ' $price1: ' . var_export($price1, true));
        }

        if (isset($_REQUEST['price2']) && !empty($_REQUEST['price2'])) {
            $price2 = intval($_REQUEST['price2']);
            l_m(__FILE__ . ' +' . __LINE__ . ' $price2: ' . var_export($price2, true));
        }

        if (isset($_REQUEST['limit'])) {
            $limit = intval($_REQUEST['limit']);
            l_m(__FILE__ . ' +' . __LINE__ . ' $limit set to: ' . var_export($limit, true));
        } else {
            $limit = DEFAULT_LIMIT;
            l_m(__FILE__ . ' +' . __LINE__ . ' default $limit set to: ' . var_export($limit, true));
        }

        if (isset($_REQUEST['page'])) {
            $page = intval($_REQUEST['page']);
            if ($page > MAX_PAGER_SIZE) {
                $page = MAX_PAGER_SIZE;
            }
            $offset = ($page - 1) * $limit;
        } else {
            $page = 1;
            $offset = 0;
        }

        $minPrice = $minPriceSql = '';
        if (isset($p1['price1']) && !empty($p1['price1'])) {
            $minPrice = intval($p1['price1']);
            if ($minPrice >= 0) {
                $minPriceSql = ' AND p0_.attr NOT LIKE "%\"attr15\":\"\"%" ';
            }
        }
        $maxPrice = $maxPriceSql = '';
        if (isset($p1['price2']) && !empty($p1['price2'])) {
            $maxPrice = intval($p1['price2']);
            if ($maxPrice >= 0) {
                $maxPriceSql = ' AND p0_.attr NOT LIKE "%\"attr15\":\"\"%" ';
            }
        }
        if (isset($p1['price1']) && !empty($p1['price1']) && isset($p1['price2']) && !empty($p1['price2'])) {
            $minPrice = intval($p1['price1']);
            $maxPrice = intval($p1['price2']);
            if (($maxPrice > 0) && ($minPrice > 0)) {
                $maxPriceSql = ' AND p0_.attr NOT LIKE "%\"attr15\":\"\"%" ';
            }
        }
        $priceSql = '';
        if (!empty($minPriceSql)) {
            $priceSql = $minPriceSql;
        } elseif (!empty($maxPriceSql)) {
            $priceSql = $maxPriceSql;
        }
        if (!empty($price1) || !empty($price2)) {
            $priceSql = ' AND p0_.attr NOT LIKE "%\"attr15\":\"\"%" ';
        }
        l_m(__FILE__ . ' +' . __LINE__ . ' price SQL: ' . $priceSql . PHP_EOL);

        $fixPriceFilter = false;
        $parentCategoryWhere = '';
        $categoryMap = [
            'projects' => 7860,
            'business' => 7861,
            'realestate' => 7862,
            'land' => 7863,
            'offer' => 7864,
            'franchising' => 19303,
        ];
        //
        if (
            isset($p1['https://dev_inventure_com_ua/investments?filter'], $p1['https://dev_inventure_com_ua/investments?filter']['category'], $p1['https://dev_inventure_com_ua/investments?filter']['category']['parent'])
            || isset($p1['filter'], $p1['filter']['category'], $p1['filter']['category']['parent'])
        ) {
            if (
                isset($p1['https://dev_inventure_com_ua/investments?filter'], $p1['https://dev_inventure_com_ua/investments?filter']['category'], $p1['https://dev_inventure_com_ua/investments?filter']['category']['parent'])
                && is_array($p1['https://dev_inventure_com_ua/investments?filter']['category']) && !empty($p1['https://dev_inventure_com_ua/investments?filter']['category']['parent'])
            ) {
                if (isset($categoryMap[$p1['https://dev_inventure_com_ua/investments?filter']['category']['parent']]) && !empty($categoryMap[$p1['https://dev_inventure_com_ua/investments?filter']['category']['parent']])) {
                    $parentCategoryWhere .= ' AND p0_.parent_id = "' . $categoryMap[$p1['https://dev_inventure_com_ua/investments?filter']['category']['parent']] . '" ';
                }
            }
            if (isset($p1['filter'], $p1['filter']['category'], $p1['filter']['category']['parent']) && is_array($p1['filter']['category']) && !empty($p1['filter']['category']['parent'])) {
                if (isset($categoryMap[$p1['filter']['category']['parent']]) && !empty($categoryMap[$p1['filter']['category']['parent']])) {
                    if (!empty($parentCategoryWhere)) {
                        if ($p1['filter']['category']['parent'] == 'projects') {
                            $fixPriceFilter = true;
                        }
                        $parentCategoryWhere .= ' OR p0_.parent_id = "' . $categoryMap[$p1['filter']['category']['parent']] . '" ';
                    } else {
                        if ($p1['filter']['category']['parent'] == 'projects') {
                            $fixPriceFilter = true;
                        }
                        $parentCategoryWhere .= ' AND p0_.parent_id = "' . $categoryMap[$p1['filter']['category']['parent']] . '" ';
                    }
                }
            }
        }
        if (isset($_REQUEST['parent']) && !empty($_REQUEST['parent'])) {
            if (isset($categoryMap[$_REQUEST['parent']]) && !empty($categoryMap[$_REQUEST['parent']])) {
                $parentCategoryWhere .= ' AND p0_.parent_id = "' . $categoryMap[$_REQUEST['parent']] . '" ';
            } else {
                $parentCategoryWhere .= ' AND p0_.parent_id = "' . intval($_REQUEST['parent']) . '" ';
            }
        }
        if (
            isset($cat, $cat['category'], $cat['category']['parent'])
            && is_array($cat)
            && !empty($cat['category']['parent'])
        ) {
            if (isset($categoryMap[$cat['category']['parent']]) && !empty($categoryMap[$cat['category']['parent']])) {
                $parentCategoryWhere .= ' AND p0_.parent_id = "' . $categoryMap[$cat['category']['parent']] . '" ';
            } else {
                $parentCategoryWhere .= ' AND p0_.parent_id = "' . intval($cat['category']['parent']) . '" ';
            }
        }
        if (isset($region, $region['category'], $region['category']['parent']) && !empty($region['category']['parent'])) {
            if (isset($categoryMap[$region['category']['parent']]) && !empty($categoryMap[$region['category']['parent']])) {
                $parentCategoryWhere .= ' AND p0_.parent_id = "' . $categoryMap[$region['category']['parent']] . '" ';
            } else {
                $parentCategoryWhere .= ' AND p0_.parent_id = "' . intval($region['category']['parent']) . '" ';
            }
        }
        if (isset($_REQUEST['filter'], $_REQUEST['filter']['category'], $_REQUEST['filter']['category']['parent']) && !empty($_REQUEST['filter']['category']['parent'])) {
            if (isset($categoryMap[$_REQUEST['filter']['category']['parent']]) && !empty($categoryMap[$_REQUEST['filter']['category']['parent']])) {
                if ($_REQUEST['filter']['category']['parent'] == 'projects') {
                    $fixPriceFilter = true;
                }
                $parentCategoryWhere .= ' AND p0_.parent_id = "' . $categoryMap[$_REQUEST['filter']['category']['parent']] . '" ';
            } else {
                if ($_REQUEST['filter']['category']['parent'] == 'projects') {
                    $fixPriceFilter = true;
                }
                $parentCategoryWhere .= ' AND p0_.parent_id = "' . intval($_REQUEST['filter']['category']['parent']) . '" ';
            }
        }
        //
        if (empty($parentCategoryWhere)) {
            if (!empty($_SERVER['HTTP_REFERER'])) {
                $urlPath = parse_url($_SERVER['HTTP_REFERER'], PHP_URL_PATH);
                switch ($urlPath) {
                    case '/en/investments/business':
                        $parentCategoryWhere .= ' AND p0_.parent_id = "9779" ';
                        break;
                    case '/en/investments/projects':
                        $fixPriceFilter = true;
                        $parentCategoryWhere .= ' AND p0_.parent_id = "9778" ';
                        break;
                    case '/en/investments/realestate':
                        $parentCategoryWhere .= ' AND p0_.parent_id = "9780" ';
                        break;
                    case '/en/investments/land':
                        $parentCategoryWhere .= ' AND p0_.parent_id = "9781" ';
                        break;
                    case '/en/investments/offer':
                        $parentCategoryWhere .= ' AND p0_.parent_id = "9782" ';
                        break;
                    case '/en/investments/franchising':
                    case '/en/investments/en_franchising':
                        $parentCategoryWhere .= ' AND p0_.parent_id = "19304" ';
                        break;
                    case '/investments/projects':
                        $fixPriceFilter = true;
                        $parentCategoryWhere .= ' AND p0_.parent_id = "7860" ';
                        break;
                    case '/investments/business':
                        $parentCategoryWhere .= ' AND p0_.parent_id = "7861" ';
                        break;
                    case '/investments/realestate':
                        $parentCategoryWhere .= ' AND p0_.parent_id = "7862" ';
                        break;
                    case '/investments/land':
                        $parentCategoryWhere .= ' AND p0_.parent_id = "7863" ';
                        break;
                    case '/investments/offer':
                        $parentCategoryWhere .= ' AND p0_.parent_id = "7864" ';
                        break;
                    case '/investments/franchising':
                        $parentCategoryWhere .= ' AND p0_.parent_id = "19303" ';
                        break;
                }
            }
        }
        //
        l_m(__FILE__ . ' +' . __LINE__ . ' $parentCategoryWhere: ' . $parentCategoryWhere . PHP_EOL);
        l_m(__FILE__ . ' +' . __LINE__ . ' $fixPriceFilter: ' . var_export($fixPriceFilter, true) . PHP_EOL);
        //
        $filterRegionWhere = '';
        if (isset($p1['https://dev_inventure_com_ua/investments?filter'], $p1['https://dev_inventure_com_ua/investments?filter']['attr_10'])) {
            $filterRegionWhere = ' AND p0_.attr LIKE "%' . urldecode($p1['https://dev_inventure_com_ua/investments?filter']['attr_10']) . '%" ';
        }
        if (isset($region, $region['attr_10']) && !empty($region['attr_10'])) {
            $filterRegionWhere = ' AND p0_.attr LIKE "%' . urldecode($region['attr_10']) . '%" ';
        }
        if (isset($filter) && is_string($filter) && !empty($filter)) {
            $filterRegionWhere = ' AND p0_.attr LIKE "%' . urldecode($filter) . '%" ';
        }
        if (isset($_REQUEST['filter'], $_REQUEST['filter']['attr_10']) && !empty($_REQUEST['filter']['attr_10'])) {
            $decodedFilterVal = urldecode($_REQUEST['filter']['attr_10']);
            $p9 = strpos($decodedFilterVal, ', ');
            if ($p9 !== false) {
                $regionParts = explode(', ', $decodedFilterVal);
                if (is_array($regionParts) && !empty($regionParts)) {
                    if (count($regionParts) > 1) {
                        $filterRegionWhere .= ' AND ( ';
                        $s9 = '';
                        foreach ($regionParts as $reg9) {
                            $filterRegionWhere .= $s9 . ' p0_.attr LIKE "%' . $reg9 . '%" ';
                            $s9 = ' OR ';
                        }
                        $filterRegionWhere .= ' ) ';
                    } else {
                        $filterRegionWhere = ' AND p0_.attr LIKE "%' . $regionParts[0] . '%" ';
                    }
                }
            }
        }
        l_m(__FILE__ . ' +' . __LINE__ . ' $filterRegionWhere: ' . $filterRegionWhere . PHP_EOL);
        //
        $filterBranchWhere = '';
        if (
            isset($filter, $filter['attr_16'], $filter['attr_16'][0])
            && !empty($filter['attr_16'][0])
        ) {
            $filterBranchWhere = ' AND p0_.attr LIKE "%\"attr16\":[\"' . $filter['attr_16'][0] . '\"%" ';
        }
        if (
            isset($cat, $cat['attr_16'], $cat['attr_16'][0])
            && !empty($cat['attr_16'][0])
        ) {
            $filterBranchWhere = ' AND p0_.attr LIKE "%\"attr16\":[\"' . $cat['attr_16'][0] . '\"%" ';
        }
        //
        if (isset($_REQUEST['filter'], $_REQUEST['filter']['attr_16'], $_REQUEST['filter']['attr_16'][0])
            && (strlen($_REQUEST['filter']['attr_16'][0]) > 0)
        ) {
            $filterBranchWhere = ' AND p0_.attr LIKE "%\"attr16\":[\"' . intval($_REQUEST['filter']['attr_16'][0]) . '\"%" ';
        }
        l_m(__FILE__ . ' +' . __LINE__ . ' $filterBranchWhere: ' . $filterBranchWhere . PHP_EOL);
        //
        $sqlAndWherePub0 = '';
        $sqlOrderBy = 'p0_.published DESC';
        if (isset($_REQUEST['filter'], $_REQUEST['filter']['sort']) && !empty($_REQUEST['filter']['sort'])) {
            switch ($_REQUEST['filter']['sort']) {
                case 'views':
                    $sqlOrderBy = 'a3_.views DESC';
                    // $sqlAndWherePub0 = ' AND p0_.published BETWEEN NOW() - INTERVAL 30 DAY AND NOW() ';
                    $sqlAndWherePub0 = ' AND p0_.published BETWEEN NOW() - INTERVAL 180 DAY AND NOW() ';
                    break;
                case 'rating':
                    $sqlOrderBy = 'a3_.rating DESC';
                    break;
            }
            l_m(__FILE__ . ' +' . __LINE__ . ' $sqlOrderBy: ' . $sqlOrderBy . PHP_EOL);
        }
        //

        $minp = 9999999; // Минимальна цена инвестиций
        $num = $maxp = 0; // Максимальная цена инвестиций

        $query = "SELECT SQL_CALC_FOUND_ROWS p0_.id AS id, " .
            " p0_.h1 AS h1, " .
            " p0_.status AS status, " .
            " p0_.deleted AS deleted, " .
            " p0_.published AS published, " .
            " p0_.short_text AS short_text, " .
            " p0_.subpath AS subpath, " .
            " p0_.created AS created, " .
            " p0_.updated AS updated, " .
            " p0_.attr AS attr, " .
            " p0_.class AS class, " .
            " p0_.image_id AS image_id, " .
            " p2_.url AS image_url, " .
            " p0_.user_id AS user_id, " .
            " p0_.route_id AS route_id, " .
            " a3_.views AS views_1, " .
            " a3_.rating AS rating_2, " .
            " p0_.parent_id AS parent_id " .
            " FROM Page p0_ " .
            " INNER JOIN Routing r1_ ON p0_.route_id = r1_.id " .
            " LEFT JOIN PagePart p2_ ON p0_.image_id = p2_.id AND p2_.type IN ('4') " .
            " LEFT JOIN Analytics_Page a3_ ON p0_.id = a3_.page_id " .
            " WHERE (r1_.path LIKE '{$sqlPath}' AND p0_.status = 1 {$sqlAndWherePub0}) " .
            $priceSql .
            $parentCategoryWhere .
            $filterRegionWhere .
            $filterBranchWhere .
            // " AND p0_.class IN ('16') " .
            " ORDER BY {$sqlOrderBy} " .
            " LIMIT {$limit} OFFSET {$offset}";
        l_m(__FILE__ . ' +' . __LINE__ . ' SQL: ' . $query . PHP_EOL);
        $res2 = $db->query($query);
        // l_m( __FILE__ . ' +' . __LINE__ . ' Result: ' . var_export($res2, true) . PHP_EOL );
        $res4 = [];
        if (!empty($res2) && is_array($res2)) {
            foreach ($res2 as $a2) {
                //
                // l_m( __FILE__ . ' +' . __LINE__ . ' project data: ' . var_export($a2, true) . PHP_EOL );
                $j2 = json_decode($a2['attr'], true);
                // l_m( __FILE__ . ' +' . __LINE__ . ' project attributes: ' . var_export($j2, true) . PHP_EOL );
                //
                if (
                    isset($j2['attr16'], $j2['attr16'][0])
                    && !empty($j2['attr16'][0])
                    && isset($filter, $filter['attr_16'], $filter['attr_16'][0])
                    && !empty($filter['attr_16'][0])
                ) {
                    if ($j2['attr16'][0] != $filter['attr_16'][0]) {
                        l_m(__FILE__ . ' +' . __LINE__ . ' Skip item with wrong branch: ' . var_export($j2['attr16'][0], true) . '; filter value: ' . var_export($filter['attr_16'][0], true));
                        continue;
                    }
                }
                //
                if (
                    isset($j2['attr10'], $j2['attr10']['loc'])
                    && !empty($j2['attr10']['loc'])
                    && isset($p1['https://dev_inventure_com_ua/investments?filter'], $p1['https://dev_inventure_com_ua/investments?filter']['attr_10'])
                ) {
                    $p0 = mb_strpos($j2['attr10']['loc'], $p1['https://dev_inventure_com_ua/investments?filter']['attr_10']);
                    if ($p0 !== false) {
                        // filter region matches
                    } else {
                        l_m(__FILE__ . ' +' . __LINE__ . ' Skip item with wrong location: ' . var_export($j2['attr10']['loc'], true) . '; loc filter: ' . var_export($p1['https://dev_inventure_com_ua/investments?filter']['attr_10'], true));
                        continue;
                    }
                }
                //
                if (
                    !isset($j2['attr15'])
                    && (!empty($minPrice) || !empty($maxPrice))
                ) {
                    l_m(__FILE__ . ' +' . __LINE__ . ' Skip item with empty price then minPrice: ' . var_export($minPrice, true) . '; maxPrice: ' . var_export($maxPrice, true));
                    continue;
                }
                //
                $priceStr = 'Договорная';
                if ($lang === 'en') {
                    $priceStr = 'Negotiable';
                }
                //
                if (isset($j2['attr15']) && !empty($j2['attr15'])) {
                    $priceStr = '$' . number_format($j2['attr15'], 0, ',', ' ');
                    //
                    if (isset($price1, $price2, $j2['attr15'])) {
                        l_m(__FILE__ . ' +' . __LINE__ . ' price1: ' . var_export($price1, true) . '; price: ' . var_export($j2['attr15'], true) . '; price2: ' . var_export($price2, true));
                    }
                    if ($fixPriceFilter) {
                        if (!empty($price1)) {
                            if (intval($j2['attr15']) < intval($price1) || intval($j2['attr34']) < intval($price1) ) {
                                l_m(__FILE__ . ' +' . __LINE__ . ' Skip item min price1: ' . var_export($price1, true) . '; project price: ' . var_export($j2['attr15'], true));
                                continue;
                            }
                        }
                        if (!empty($price2)) {
                            if (intval($j2['attr15']) > intval($price2) || intval($j2['attr34']) > intval($price2)) {
                                l_m(__FILE__ . ' +' . __LINE__ . ' Skip item max price2: ' . var_export($price2, true) . '; project price: ' . var_export($j2['attr15'], true));
                                continue;
                            }
                        }
                    } else {
                        if (!empty($price1)) {
                            if (intval($j2['attr15']) < intval($price1)) {
                                l_m(__FILE__ . ' +' . __LINE__ . ' Skip item min price1: ' . var_export($price1, true) . '; project price: ' . var_export($j2['attr15'], true));
                                continue;
                            }
                        }
                        if (!empty($price2)) {
                            if (intval($j2['attr15']) > intval($price2)) {
                                l_m(__FILE__ . ' +' . __LINE__ . ' Skip item max price2: ' . var_export($price2, true) . '; project price: ' . var_export($j2['attr15'], true));
                                continue;
                            }
                        }
                    }
                }
                //
                $imgUrl = '/img/resize.375.225/images/noThumb.jpg';
                if (isset($a2['image_url']) && !empty($a2['image_url'])) {
                    $imgUrl = $a2['image_url'];
                }
                //
                $placeHtml = '';
                if (isset($p1['filter'], $p1['filter']['attr_10']) && ($p1['filter']['attr_10'] == 'Украина')) {
                    $placeHtml .= '<img src="/i/ukraine.png">';
                }
                if (isset($a2['attr_10'], $j2['attr_10']['parts']) && !empty($j2['attr_10']['parts'])) {
                    $placeHtml .= ' ' . implode(', ', $j2['attr_10']['parts']);
                }
                //
                $categoryHtml = '';
                if (isset($a2['parent_id']) && !empty($a2['parent_id'])) {
                    if ($a2['parent_id'] == '7860') {
                        $categoryHtml = '<a href="' . $urlLangPrefix . '/investments/projects"><img src="/i/projects.png" alt="">';
                        if ($lang === 'ru') { $categoryHtml .= 'Инвестиционные проекты и стартапы в Украине'; } else { $categoryHtml .= 'Investment Projects and Startups'; }
                        $categoryHtml .= '</a>';
                    } elseif ($a2['parent_id'] == '7861') {
                        $categoryHtml = '<a href="' . $urlLangPrefix . '/investments/business"><img src="/i/business.png" alt="">';
                        if ($lang === 'ru') { $categoryHtml .= 'Продажа бизнеса в Украине | продать бизнес'; } else { $categoryHtml .= 'Business for Sale'; }
                        $categoryHtml .= '</a>';
                    } elseif ($a2['parent_id'] == '7862') {
                        $categoryHtml = '<a href="' . $urlLangPrefix . '/investments/realestate"><img src="/i/realestate.png" alt="">';
                        if ($lang === 'ru') { $categoryHtml .= 'Коммерческая недвижимость в Украине'; } else { $categoryHtml .= 'Commercial Property'; }
                        $categoryHtml .= '</a>';
                    } elseif ($a2['parent_id'] == '7863') {
                        $categoryHtml = '<a href="' . $urlLangPrefix . '/investments/land"><img src="/i/land.png" alt="">';
                        if ($lang === 'ru') { $categoryHtml .= 'Земельные участки в Украине'; } else { $categoryHtml .= 'Land'; }
                        $categoryHtml .= '</a>';
                    } elseif ($a2['parent_id'] == '7864') {
                        $categoryHtml = '<a href="' . $urlLangPrefix . '/investments/offer"><img src="/i/offer.png" alt="">';
                        if ($lang === 'ru') { $categoryHtml .= 'Инвесторы в Украине: найти инвестора | поиск инвестора'; } else { $categoryHtml .= 'Investor Offers'; }
                        $categoryHtml .= '</a>';
                    } elseif ($a2['parent_id'] == '19303') {
                        $categoryHtml = '<a href="' . $urlLangPrefix . '/investments/franchising"><img src="/i/business.png" alt="">';
                        if ($lang === 'ru') { $categoryHtml .= 'Франчайзинг и франшизы в Украине'; } else { $categoryHtml .= 'Franchising'; }
                        $categoryHtml .= '</a>';
                    }
                }
                //
                $dateFormatted = DateTime::createFromFormat('Y-m-d H:i:s', $a2['published'])->format('d.m.y');
                //
                $isSold = 0;
                $soldHtml = '';
                if (isset($j2['attr58']) && ($j2['attr58'] == 1)) {
                    if ($lang === 'ru') {
                        if (($a2['parent_id'] == 7860)
                            || ($a2['parent_id'] == 19303)
                            || ($a2['parent_id'] == 7864)
                        ) {
                            $soldHtml = '<div class="previewstatus preview__status" style="width:155px;">';
                            $soldHtml .= 'Реализовано';
                        } else {
                            $soldHtml = '<div class="previewstatus preview__status">';
                            $soldHtml .= 'Продано';
                        }
                    } else {
                        $soldHtml = '<div class="previewstatus preview__status">';
                        $soldHtml .= 'Sold';
                    }
                    $soldHtml .= '</div>';
                    $isSold = 1;
                }
                //
                $resHmtl .= '<a href="' . $urlLangPrefix . '/investments/' . $a2['subpath'] . '"  class="cards__item project-' . $num . '">
                    <div class="cards__img-wrapper mb-2 parent_id-' . $a2['parent_id'] . ' lang-' . $lang . ' is-sold-' . $isSold . '">' . $soldHtml . '
                        <img class="cards__img lazyimg" data-src="' . $imgUrl . '" alt="' . $a2['h1'] . '" src="' . $imgUrl . '">
                    </div>
                    <div class="opacity-75 text-sm w-full cards__meta pt-0 mt-0">' . $dateFormatted . '</div>
                    <h2 class="cards__title mt-0" itemprop="headline">' . $a2['h1'] . '</h2>

                    <div class="cards__meta flex justify-between mt-auto opacity-75 text-sm">
                        <div class="price-tag cards__date text-sm">' . $priceStr . '</div>
                        <div class="cards__meta-wrapper text-sm">
                            <div class="cards__meta-stat">
                                <svg width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M13.9631 5.36967C13.871 5.08618 13.6195 4.88548 13.3232 4.85867L9.28184 4.49177L7.68466 0.752449C7.56674 0.477725 7.29842 0.300415 6.99977 0.300415C6.70112 0.300415 6.4327 0.477725 6.31553 0.752449L4.71835 4.49177L0.67632 4.85867C0.38002 4.88602 0.129115 5.08672 0.0364013 5.36967C-0.0557786 5.65315 0.0293516 5.96408 0.253446 6.16062L3.30841 8.83939L2.40766 12.8067C2.34175 13.0984 2.45498 13.4 2.69701 13.575C2.82711 13.6695 2.97996 13.7167 3.13335 13.7167C3.26515 13.7167 3.39707 13.6817 3.51488 13.6112L6.99977 11.5275L10.484 13.6112C10.7396 13.7639 11.061 13.7499 11.3025 13.575C11.5446 13.4 11.6578 13.0984 11.5919 12.8067L10.6911 8.83939L13.7461 6.16062C13.9701 5.96408 14.0553 5.65379 13.9631 5.36967Z" fill="#808080"/>
                                </svg>
                                <div>' . intval($a2['rating_2']) . '</div>
                            </div>
                            <div class="cards__meta-stat">
                                <svg width="16" height="11" viewBox="0 0 16 11" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M8 0.0910645C2.61053 0.0910645 0 5.51478 0 5.51478C0 5.51478 2.59368 10.9385 8 10.9385C13.4063 10.9385 16 5.51478 16 5.51478C16 5.51478 13.3895 0.0910645 8 0.0910645ZM8 9.70889C5.67579 9.70889 3.80631 7.82238 3.80631 5.51478C3.80631 3.19033 5.69263 1.32066 8 1.32066C10.3074 1.32066 12.1937 3.20717 12.1937 5.51478C12.1937 7.83922 10.3242 9.70889 8 9.70889Z" fill="#808080"/>
                                    <path d="M9.97239 4.74104C9.31555 4.74104 8.77659 4.20209 8.77659 3.54525C8.77659 3.34314 8.82712 3.14104 8.92818 2.97262C8.64186 2.87157 8.32186 2.8042 8.00186 2.8042C6.50291 2.8042 5.27344 4.01683 5.27344 5.51577C5.27344 7.01472 6.48607 8.2442 8.00186 8.2442C9.50081 8.2442 10.7134 7.03156 10.7134 5.51577C10.7134 5.19577 10.6629 4.87577 10.545 4.58946C10.3934 4.69051 10.1913 4.74104 9.97239 4.74104Z" fill="#808080"/>
                                </svg>
                                <div>' . intval($a2['views_1']) . '</div>
                            </div>
                        </div>
                    </div>
                </a>';

/*
            $j2 = json_decode($a2['attr'], true);
            if (isset($j2['attr15'])) { // Price attribute found
                if (!empty($minPrice) && intval($j2['attr15']) >= $minPrice) {
                    if (intval($j2['attr15']) > $maxp) {
                        $maxp = intval($j2['attr15']);
                    }
                    if (intval($j2['attr15']) < $minp) {
                        $minp = intval($j2['attr15']);
                    }
                    $res4[] = $a2;
                    continue;
                }
                if (!empty($maxPrice) && intval($j2['attr15']) <= $maxPrice) {
                    if (intval($j2['attr15']) > $maxp) {
                        $maxp = intval($j2['attr15']);
                    }
                    if (intval($j2['attr15']) < $minp) {
                        $minp = intval($j2['attr15']);
                    }
                    $res4[] = $a2;
                }
            } else { // No price attribute found

            }
*/
                $res4[] = $a2;
                $num++;
            }
        }
        //
        l_m(__FILE__ . ' +' . __LINE__ . ' $res4: ' . var_export($res4, true));
        $query = "SELECT FOUND_ROWS()";
        l_m(__FILE__ . ' +' . __LINE__ . ' SQL: ' . $query);
        $res3 = $db->query($query);
        l_m(__FILE__ . ' +' . __LINE__ . ' Result: ' . var_export($res3, true));
        //
        if (
            isset($_REQUEST['type'])
            && ($_REQUEST['type'] == 'json')
        ) {
            $result = [
                'data' => $res4,
                // 'total' => intval($res3[0]['FOUND_ROWS()']),
                'total' => count($res4),
                'limit' => $limit,
                'page' => $page,
                'minp' => $minp,
                'maxp' => $maxp,
            ];
            l_m(__FILE__ . ' +' . __LINE__ . ' JSON result: ' . var_export($result, true));
            if (!headers_sent()) {
                header('Access-Control-Allow-Origin: *');
                header("Content-type: application/json; charset=utf-8");
            }
            die(json_encode($result));
        }
    } elseif (isset($_REQUEST['action']) && ($_REQUEST['action'] == 'set')) { // Set data action
        // l_m( __FILE__ . ' +' . __LINE__ );
        if (!empty($_REQUEST['path'])) {
            $p2 = explode('/', $_REQUEST['path']);
            // l_m( __FILE__ . ' +' . __LINE__ . ' $p2: ' . var_export($p2, true) );
            $path = array_pop($p2);
            $query = "SELECT * FROM Page WHERE `subpath` = '{$path}'";
            // l_m( __FILE__ . ' +' . __LINE__ . ' SQL: ' . $query );
            $r99 = $db->query($query);
            // l_m( __FILE__ . ' +' . __LINE__ . ' $r99: ' . var_export($r99, true) );
            if (isset($r99[0]['id'])) {
                $query = "SELECT * FROM PagePart WHERE `page_id` = '{$r99[0]['id']}' AND `name` = 'content' LIMIT 1";
                // l_m( __FILE__ . ' +' . __LINE__ . ' SQL: ' . $query );
                $r98 = $db->query($query);
                // l_m( __FILE__ . ' +' . __LINE__ . ' $r98: ' . var_export($r98, true) );
                if (isset($r98[0]['id'])) {
                    $newText = $db->escape($_REQUEST['data']);
                    $query = "UPDATE PagePart SET `text` = '{$newText}' WHERE id = '{$r98[0]['id']}'";
                    // l_m( __FILE__ . ' +' . __LINE__ . ' SQL: ' . $query );
                    $r97 = $db->query($query);
                    // l_m( __FILE__ . ' +' . __LINE__ . ' $r97: ' . var_export($r97, true) );
                    if ($r97 === true) {
                        $resHmtl .= '<p class="success">Изменения сохранены</p>';
                    }
                }
            }
        }
    }
}
//
if (!headers_sent()) {
    header('Access-Control-Allow-Origin: *');
    header('Content-Type: text/html; charset=utf-8');
}
die($resHmtl);
