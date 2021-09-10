<?php
/**
 * @package Skynar
 * @version 0.1
 * @link http://skynar.co/
 * @author Taras Shkodenko <taras@shkodenko.com>
 * @copyright 2021
 */

namespace Croudinvesting;


use Skynar\Module\Installer as Base;


class Installer extends Base
{
    public function install()
    {
        $core = $this->getHelper('core');
        $core->route('admin', '/admin/croudinvesting', $core::ROUTE_WILDCARD);

        return true;
    }

    public function update($version)
    {
        return true;
    }
}
