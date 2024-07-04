<?php

//
// Updated at 2024-07-04 15:28
//
// @see: https://stackoverflow.com/questions/12553160/getting-visitors-country-from-their-ip
//

function ipInfo(string $ip = null, string $purpose = 'location', bool $deep_detect = true): array
{
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
                case "location":
                    $output = array(
                        "city" => @$ipdat->geoplugin_city,
                        "state" => @$ipdat->geoplugin_regionName,
                        "country" => @$ipdat->geoplugin_countryName,
                        "country_code" => @$ipdat->geoplugin_countryCode,
                        "continent" => @$continents[strtoupper($ipdat->geoplugin_continentCode)],
                        "continent_code" => @$ipdat->geoplugin_continentCode
                    );
                    break;
                case "address":
                    $address = array($ipdat->geoplugin_countryName);
                    if (@strlen($ipdat->geoplugin_regionName) >= 1)
                        $address[] = $ipdat->geoplugin_regionName;
                    if (@strlen($ipdat->geoplugin_city) >= 1)
                        $address[] = $ipdat->geoplugin_city;
                    $output = implode(", ", array_reverse($address));
                    break;
                case "city":
                    $output = @$ipdat->geoplugin_city;
                    break;
                case "state":
                    $output = @$ipdat->geoplugin_regionName;
                    break;
                case "region":
                    $output = @$ipdat->geoplugin_regionName;
                    break;
                case "country":
                    $output = @$ipdat->geoplugin_countryName;
                    break;
                case "countrycode":
                    $output = @$ipdat->geoplugin_countryCode;
                    break;
            }
            return $output;
        }
    }

    return [];
}

//
// $ipToCheck = $_SERVER['REMOTE_ADDR'];
// 2024-07-04 Server with CloudFlare has different variable for client IP address
$ipToCheck = $_SERVER['HTTP_CF_CONNECTING_IP'];
// Use FILTER_VALIDATE_IP to validate and sanitize the input.
$userIP = filter_input(INPUT_GET, 'ip', FILTER_VALIDATE_IP);
if ($userIP) {
    $ipToCheck = $userIP;
}

echo var_export(ipInfo($ipToCheck), true);
