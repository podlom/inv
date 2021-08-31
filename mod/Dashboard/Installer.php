<?php
/**
 * @package Skynar
 * @version 0.1
 * @link http://skynar.co/
 * @author Taras Shkodenko <taras@shkodenko.com>
 * @copyright 2019
 */

namespace Dashboard;


use Skynar\Module\Installer as Base;


class Installer extends Base
{
    public function install()
    {
        $core = $this->getHelper('core');
        $core->route('admin', '/admin/dashboard', $core::ROUTE_WILDCARD);

        return true;
    }

    public function update($version)
    {
        return true;
    }
}
