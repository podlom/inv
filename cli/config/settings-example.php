<?php

/**
 * Created by PhpStorm.
 * User: Taras
 * Date: 18.05.2023
 * Time: 19:14
 *
 * Version: 2023-05-18 19:14
 *
 * @author Taras Shkodenko <taras@shkodenko.com>
 */

date_default_timezone_set("Europe/Kiev");

define('DBHOST', 'localhost');
define('DBUSER', 'dbUser');
define('DBPASS', 'dbPass');
define('DBNAME', 'dbName');


global $settings;

$settings = [
    '23' => [
	'hubspot' => [
		   'api_key' => 'apiKey-for-InVenture-Prod',    // HubSpot API key for InVenture production
	   ],
	   'google_offline_source' => 'UA-42378215-1',
    ],
];
