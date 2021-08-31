<?php
/**
 * @package Skynar
 * @version 0.1
 * @link http://skynar.co/
 * @author Evgen Pochekuev <themastir@gmail.com>
 * @copyright 2009-2015
 */

namespace Tinyurl;


use Skynar\Module\Installer as Base;


class Installer extends Base
{
    public function install()
    {
        $core = $this->getHelper('core');
        $core->route('redirect', '/u', $core::ROUTE_WILDCARD);
        $core->route('admin', '/admin/tinyurl', $core::ROUTE_WILDCARD);
    }

    public function update($version)
    {
        $core = $this->getHelper('core');
    	if (version_compare($version, '0.1.1', '<')) {
        	$core->route('admin', '/admin/tinyurl', $core::ROUTE_WILDCARD);
    	}
        return true;
    }
}
