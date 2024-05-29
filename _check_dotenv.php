<?php

require 'vendor/autoload.php';


use Dotenv\Dotenv;


$dotenv = Dotenv::createImmutable(__DIR__);
$dotenv->load();

// DEBUG_IP
// echo 'Debug IP: ' . getenv('DEBUG_IP') . PHP_EOL;

// Або використовуйте $_ENV
echo 'Debug IP from Env: ' . $_ENV['DEBUG_IP'] . PHP_EOL;