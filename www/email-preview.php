<?php

/**
 * Created by PhpStorm
 * User: shtaras
 * Date: 10/25/19
 * Time: 12:54
 *
 * @author Taras Shkodenko <ts@doagency.net>
 */

function trMonthName($name)
{
    return str_replace([
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
    ], [
        'Января',
        'Февраля',
        'Марта',
        'Апреля',
        'Мая',
        'Июня',
        'Июля',
        'Августа',
        'Сентября',
        'Октября',
        'Ноября',
        'Декабря',
    ], $name);
}

function trMonthName2($name)
{
    return str_replace([
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
    ], [
        'Январь',
        'Февраль',
        'Март',
        'Апрель',
        'Май',
        'Июнь',
        'Июль',
        'Август',
        'Сентябрь',
        'Октябрь',
        'Ноябрь',
        'Декабрь',
    ], $name);
}

function getInvestmentOffers($db, $id)
{
    $result = '';
    $id = intval($id);
    $query = "SELECT * FROM `email_template_data` WHERE parent_template_id = '{$id}'";
    $res0 = $db->query($query);
    if (is_array($res0) && !empty($res0)) {
        error_log( __FUNCTION__ . ' +' . __LINE__ . ' Result: ' . print_r($res0, true) );
        $query = "SELECT * FROM `base_email_template` WHERE id = 4";
        $res1 = $db->query($query);
        if (is_array($res1) && !empty($res1)) {
            error_log( __FUNCTION__ . ' +' . __LINE__ . ' Result: ' . print_r($res1, true) );

            $d0 = unserialize($res0[0]['data']);
            error_log( __FUNCTION__ . ' +' . __LINE__ . ' Unserialized data: ' . print_r($d0, true) );
            if (isset($d0, $d0['inv']) && is_array($d0['inv']) && !empty($d0['inv'])) {
                foreach ($d0['inv'] as $k9 => $a9) {
                    $result .= $res1[0]['text'];
                    $result = str_replace([
                        '{$img}',
                        '{$title}',
                        '{$region}',
                        '{$price}',
                        '{$url}',
                    ], [
                        $a9['img'],
                        $a9['title'],
                        $a9['region'],
                        $a9['price'],
                        $a9['url'],
                    ], $result);
                }
            }
        }
    }
    return $result;
}

require_once realpath(__DIR__.'/../bootstrap.php');


$app_name = trim(file_get_contents(__DIR__.'/../app_id'));
$app = new Skynar\Application($app_name, realpath(__DIR__.'/../'), __DIR__);
try {
    $app->init();
} catch (Throwable $e) {
    echo $app->getService('template')->renderException($e);
}

$id = 0;
if (isset($_GET['id']) && !empty($_GET['id'])) {
    $id = $_GET['id'];
}
if (!empty($id)) {
    // require_once realpath(__DIR__.'/../cli/lib/db.class.php');
    require_once app()->getPath() . '/cli/lib/db.class.php';
    $cfg = app()->getService('config')->get('app')->db;
    error_log( __FILE__ . ' +' . __LINE__ . ' $cfg: ' . print_r($cfg, true) );
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
        //
        $query = "select * from `email_template` where id = '{$id}'";
        $res10 = $db->query($query);
        if (isset($res10[0], $res10[0]['text']) && !empty($res10[0]['text'])) {
            $fileData = $res10[0]['text'];
            //
            $siteFullUrlPrefix = site_protocol() . '://' . site_host();
            //
            $mailTemplateData = str_replace('{$recipient-&gt;getName()|default:' . "'" . 'Dear friend' . "'" . '}', 'Dear friend', $fileData);
            $mailTemplateData = str_replace('{$recipient->getName()|default:' . "'" . 'Dear friend' . "'" . '}', 'Dear friend', $fileData);
            $mailTemplateData = str_replace('{$date1}', trMonthName( date('d F Y', time()) ), $mailTemplateData);
            $mailTemplateData = str_replace('{$date2}', trMonthName2( date('F Y', time()) ), $mailTemplateData);
            $mailTemplateData = str_replace('{$digest_link}', $siteFullUrlPrefix . '/upload/digest/InVenture%20Investment%20Digest%20(' . date('F%20Y', time()) . ').pdf', $mailTemplateData);
            $mailTemplateData = str_replace('{$download_digest_link}', $siteFullUrlPrefix . '/upload/digest/InVenture%20Investment%20Digest%20(' . date('F%20Y', time()) . ').pdf', $mailTemplateData);
            $mailTemplateData = str_replace('{$pixel}', '', $mailTemplateData);
            $mailTemplateData = str_replace('{* prefilter=off *}', '', $mailTemplateData);
            $mailTemplateData = str_replace('{literal}', '', $mailTemplateData);
            $mailTemplateData = str_replace('{/literal}', '', $mailTemplateData);
            $mailTemplateData = str_replace('/admin/template/edit/', '', $mailTemplateData);
            $mailTemplateData = str_replace('{$investment_offers}', getInvestmentOffers($db, $id), $mailTemplateData);
            $mailTemplateData = str_replace($siteFullUrlPrefix . $siteFullUrlPrefix, $siteFullUrlPrefix, $mailTemplateData);
            $mailTemplateData = str_replace(site_protocol() . '://' . site_protocol() . '://', site_protocol() . '://', $mailTemplateData);
            $mailTemplateData = preg_replace('|(\{\*(\.*)\*\})|mU', '', $mailTemplateData);
            $mailTemplateData = str_replace('{$text}', 'Текст email сообщения будет тут', $mailTemplateData);
            $mailTemplateData = str_replace('{$unsubscribe1}', '<a href="' . $siteFullUrlPrefix . '/unsub.php?id=43&amp;email=your@email.com' . '" style="color:#707c8b;padding-bottom:5px;border-bottom:1px solid #ccc;text-decoration:none" target="_blank">отписаться от рассылки</a>', $mailTemplateData);
            //
            echo $mailTemplateData;
        } else {
            echo 'Error: template was not found in DB!';
        }
    } catch (\Exception $e) {
        $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Fatal error: ' . $e->getMessage() . PHP_EOL;
        die($msg);
    }
}