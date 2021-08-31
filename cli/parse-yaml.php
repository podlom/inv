<?php
/**
 * Created by PhpStorm.
 * User: Taras
 * Date: 26.08.2020
 * Time: 16:14
 *
 * @author Taras Shkodenko <taras@shkodenko.com>
 * @see https://symfony.com/doc/current/components/yaml.html
 */

require_once dirname(__FILE__) . '/../vendor/autoload.php';


use Symfony\Component\Yaml\Yaml;


$appConfig = Yaml::parseFile( dirname(__FILE__) . '/../config/app.yml');
echo var_export($appConfig, true) . PHP_EOL;