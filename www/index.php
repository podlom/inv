<?php

// Updated by @ts 2024-07-04 16:07

// @ts 2022-07-16 old debug IPs: 95.158.38.121
// @ts 2022-08-03 Chernivtsi, Lva Tolstogo str.10, fl.5 static IP: 91.237.27.42
if ($_SERVER['HTTP_CF_CONNECTING_IP'] == '91.237.27.42') {
    error_log(__FILE__ . ' +' . __LINE__);
    define('SKYNAR_DEBUG_SQL', true);
}


function ipInfo(string $ip = null, string $purpose = 'location', bool $deep_detect = true): array
{
    $output = [];

    if (!filter_var($ip, FILTER_VALIDATE_IP)) {
        $ip = $_SERVER['REMOTE_ADDR'];
        if ($deep_detect) {
            if (isset($_SERVER['HTTP_X_FORWARDED_FOR']) && filter_var($_SERVER['HTTP_X_FORWARDED_FOR'], FILTER_VALIDATE_IP)) {
                $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
            }
            if (isset($_SERVER['HTTP_CLIENT_IP']) && filter_var($_SERVER['HTTP_CLIENT_IP'], FILTER_VALIDATE_IP)) {
                $ip = $_SERVER['HTTP_CLIENT_IP'];
            }
        }
    }
    $output['ip'] = $ip;

    $purpose = strtolower(trim($purpose));
    $support = ['country', 'countrycode', 'state', 'region', 'city', 'location', 'address'];
    $continents = [
        'AF' => 'Africa',
        'AN' => 'Antarctica',
        'AS' => 'Asia',
        'EU' => 'Europe',
        'OC' => 'Australia (Oceania)',
        'NA' => 'North America',
        'SA' => 'South America'
    ];

    if (filter_var($ip, FILTER_VALIDATE_IP) && in_array($purpose, $support)) {
        $ipdat = @json_decode(file_get_contents("http://www.geoplugin.net/json.gp?ip=" . $ip));
        if (isset($ipdat->geoplugin_countryCode) && strlen($ipdat->geoplugin_countryCode) == 2) {
            switch ($purpose) {
                case "location":
                    $output = array_merge($output, [
                        "city" => @$ipdat->geoplugin_city,
                        "state" => @$ipdat->geoplugin_regionName,
                        "country" => @$ipdat->geoplugin_countryName,
                        "country_code" => @$ipdat->geoplugin_countryCode,
                        "continent" => @$continents[strtoupper($ipdat->geoplugin_continentCode)],
                        "continent_code" => @$ipdat->geoplugin_continentCode
                    ]);
                    break;
                case "address":
                    $address = array($ipdat->geoplugin_countryName);
                    if (@strlen($ipdat->geoplugin_regionName) >= 1)
                        $address[] = $ipdat->geoplugin_regionName;
                    if (@strlen($ipdat->geoplugin_city) >= 1)
                        $address[] = $ipdat->geoplugin_city;
                    $output = array_merge($output, implode(", ", array_reverse($address)));
                    break;
                case "city":
                    $output = array_merge($output, ['city' => @$ipdat->geoplugin_city]);
                    break;
                case "state":
                    $output = array_merge($output, ['state' => @$ipdat->geoplugin_regionName]);
                    break;
                case "region":
                    $output = array_merge($output, ['region' => @$ipdat->geoplugin_regionName]);
                    break;
                case "country":
                    $output = array_merge($output, ['country' => @$ipdat->geoplugin_countryName]);
                    break;
                case "countrycode":
                    $output = array_merge($output, ['countrycode' => @$ipdat->geoplugin_countryCode]);
                    break;
            }
            return $output;
        }
    }

    return $output;
}

// Redirect home page
if ($_SERVER['REQUEST_URI'] == '/') {
    $ipData = ipInfo($_SERVER['HTTP_CF_CONNECTING_IP'], 'country');
    // if country is Ukraine to Ukraininan website version
    if (isset($ipData['country']) && ($ipData['country'] == 'Ukraine')) {
        header('Location: /uk');
    }
}


require_once realpath(__DIR__ . '/../bootstrap.php');

$app_name = trim(file_get_contents(__DIR__ . '/../app_id'));

$app = new Skynar\Application($app_name, realpath(__DIR__ . '/../'), __DIR__);
try {
    $app->init();
    $app->run();

} catch (Throwable $e) {
    echo $app->getService('template')->renderException($e);
}
//$b = new tool\Bcrypt();

//$app->compileStyle();
//$app->init();
//$app->getService('doctrine')->createDatabase();
/*
$app->getCache()->deleteAll();
$app->updateModels();
$app->db()->updateDatabase();
$app->db()->generateProxy();
//$em = app()->db()->getEntityManager();
//*/

