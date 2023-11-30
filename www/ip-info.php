<?php

// @see: https://stackoverflow.com/questions/12553160/getting-visitors-country-from-their-ip

function ipInfo($ip = null, $purpose = 'location', $deep_detect = true) {
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
            $output = null;
            switch ($purpose) {
                // cases for each purpose
            }
            return $output;
        }
    }
    return null;
}

$ipToCheck = $_SERVER['REMOTE_ADDR'];
if (isset($_GET['ip']) && filter_var($_GET['ip'], FILTER_VALIDATE_IP)) {
    $ipToCheck = $_GET['ip'];
}

echo var_export(ipInfo($ipToCheck), true);
