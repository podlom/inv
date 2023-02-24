<?php

/**
 * Created by PhpStorm.
 * User: Taras
 * Date: 16.08.2018
 * Time: 14:05
 *
 * Version: 2023-02-24 21:12
 *
 * @author Taras Shkodenko <taras@shkodenko.com>
 */

date_default_timezone_set("Europe/Kiev");

define('DBHOST', 'localhost');
define('DBUSER', 'leadbox_u');
define('DBPASS', '5[(Rm0f}iZOzujat');
define('DBNAME', 'leadbox_db');

global $settings;

$settings = [
    '23' => [ // 074bmom3utuln3yym6joh12dnl6ow6lltiark1ar
	'hubspot' => [
	       // 'api_key' => 'a541de91-9b17-48f3-95f2-2d9715bca884',         // @ts dev
	       // 'api_key' => 'fe2ed9e5-a69f-430e-8056-ddef0ee7c77c',         // InVenture production old API Key
		   'api_key' => 'pat-na1-42969d3e-8acf-493b-8a02-b5d7b37a7309',    // InVenture production
	   ],
	   'google_offline_source' => 'UA-42378215-1',
    ],
];
