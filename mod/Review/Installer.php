<?php
/**
 * @package Skynar
 * @version 0.1
 * @link http://skynar.co/
 * @author Taras Shkodenko <ts@doagency.net>
 * @copyright 2019
 */

namespace Review;


use Skynar\Module\Installer as Base;


class Installer extends Base
{
    public function install()
    {
        $core = $this->getHelper('core');
        $core->route('admin', '/admin/review', $core::ROUTE_WILDCARD);

        return true;
    }

    public function update($version)
    {
        return true;
    }
}
