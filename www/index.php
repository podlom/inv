<?php

// @ts 2022-07-16 old debug IPs: 95.158.38.121
if ($_SERVER['REMOTE_ADDR'] == '91.237.27.42') {
  define('SKYNAR_DEBUG_SQL', true);
}


function ipInfo($ip = NULL, $purpose = "location", $deep_detect = TRUE) {
  $output = NULL;
  if (filter_var($ip, FILTER_VALIDATE_IP) === FALSE) {
      $ip = $_SERVER["REMOTE_ADDR"];
      if ($deep_detect) {
          if (filter_var(@$_SERVER['HTTP_X_FORWARDED_FOR'], FILTER_VALIDATE_IP))
              $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
          if (filter_var(@$_SERVER['HTTP_CLIENT_IP'], FILTER_VALIDATE_IP))
              $ip = $_SERVER['HTTP_CLIENT_IP'];
      }
  }
  $purpose    = str_replace(array("name", "\n", "\t", " ", "-", "_"), NULL, strtolower(trim($purpose)));
  $support    = array("country", "countrycode", "state", "region", "city", "location", "address");
  $continents = array(
      "AF" => "Africa",
      "AN" => "Antarctica",
      "AS" => "Asia",
      "EU" => "Europe",
      "OC" => "Australia (Oceania)",
      "NA" => "North America",
      "SA" => "South America"
  );
  if (filter_var($ip, FILTER_VALIDATE_IP) && in_array($purpose, $support)) {
      $ipdat = @json_decode(file_get_contents("http://www.geoplugin.net/json.gp?ip=" . $ip));
      if (@strlen(trim($ipdat->geoplugin_countryCode)) == 2) {
          switch ($purpose) {
              case "location":
                  $output = array(
                      "city"           => @$ipdat->geoplugin_city,
                      "state"          => @$ipdat->geoplugin_regionName,
                      "country"        => @$ipdat->geoplugin_countryName,
                      "country_code"   => @$ipdat->geoplugin_countryCode,
                      "continent"      => @$continents[strtoupper($ipdat->geoplugin_continentCode)],
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
      }
  }
  return $output;
}

/*

if ($_SERVER['REQUEST_URI'] == '/') {
  $country = ipInfo($_SERVER['REMOTE_ADDR'], 'country');
  if ($country == 'Ukraine') {
      header('Location: /uk');
  }
}

*/

require_once realpath(__DIR__.'/../bootstrap.php');

$app_name = trim(file_get_contents(__DIR__.'/../app_id'));

$app = new Skynar\Application($app_name, realpath(__DIR__.'/../'), __DIR__);
try{
$app->init();
$app->run();

} catch (Throwable $e){
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

