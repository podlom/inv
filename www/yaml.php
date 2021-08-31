<?php

/**
 * Created by PhpStorm
 * User: shtaras
 * Date: 10/25/19
 * Time: 16:43
 *
 * @author Taras Shkodenko <ts@doagency.net>
 */

require_once dirname(__FILE__) . '/../cms/actual/lib/vendor/Symfony/Component/Yaml/Exception/ExceptionInterface.php';
require_once dirname(__FILE__) . '/../cms/actual/lib/vendor/Symfony/Component/Yaml/Exception/RuntimeException.php';
require_once dirname(__FILE__) . '/../cms/actual/lib/vendor/Symfony/Component/Yaml/Exception/ParseException.php';
require_once dirname(__FILE__) . '/../cms/actual/lib/vendor/Symfony/Component/Yaml/Unescaper.php';
require_once dirname(__FILE__) . '/../cms/actual/lib/vendor/Symfony/Component/Yaml/Escaper.php';
require_once dirname(__FILE__) . '/../cms/actual/lib/vendor/Symfony/Component/Yaml/Parser.php';
require_once dirname(__FILE__) . '/../cms/actual/lib/vendor/Symfony/Component/Yaml/Inline.php';
require_once dirname(__FILE__) . '/../cms/actual/lib/vendor/Symfony/Component/Yaml/Dumper.php';
require_once dirname(__FILE__) . '/../cms/actual/lib/vendor/Symfony/Component/Yaml/Yaml.php';


use Symfony\Component\Yaml\Exception\ParseException;
use Symfony\Component\Yaml\Yaml;


error_log( __LINE__ . ' GET: ' . var_export($_GET, true) );
error_log( __LINE__ . ' POST: ' . var_export($_POST, true) );

$action = '';
if (isset($_GET['action']) && !empty($_GET['action'])) {
    $action = $_GET['action'];
}
if (isset($_POST['action']) && !empty($_POST['action'])) {
    $action = $_POST['action'];
}
if (!empty($action)) {
    $fileName = dirname(__FILE__) . '/../config/Mail.mailing.yml';
    switch ($action) {
        case 'get':
            $data = Yaml::parse( file_get_contents( $fileName ) );
            echo '<pre>' . var_export($data, true) . '</pre>';
            break;
        case 'set':
            $oldData = Yaml::parse( file_get_contents( $fileName ) );
            error_log( __LINE__ . ' Got old data: ' . var_export($oldData, true) );
            if (isset($oldData[ $_POST['mailing_id'] ])
                && isset($_POST['new_data'])
                && is_array($_POST['new_data'])
                && !empty($_POST['new_data'])
            ) {
                $newData = $oldData;
                $newData[ $_POST['mailing_id'] ] = $_POST['new_data'];
                file_put_contents($fileName, Yaml::dump($newData));
                error_log( __LINE__ . ' Written new data: ' . var_export($newData, true) . ' to config: ' . $fileName );
                echo '+200 OK';
            }
            break;
    }
}