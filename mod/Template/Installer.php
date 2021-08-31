<?php
/**
 * @package Skynar
 * @version 0.1
 * @link http://skynar.co/
 * @author Evgen Pochekuev <themastir@gmail.com>
 * @copyright 2009-2015
 */


namespace Template;

use Skynar\Module\Installer as Base;

class Installer extends Base{

   public function install(){
        //$this->datadir('page');
        $core = $this->getHelper('core');
        $core->route('template', '/admin/template', $core::ROUTE_WILDCARD);
    }

    /**
     * @return boolean
     */
    public function update($version){
        /** EXAMPLE
        if(version_compare($version, '0.1', '<=')){

            $this->permission('create', 'allow page creation', ['content', 'moderator', 'developer']);
            $this->permission('publish', 'allow page publication', ['content', 'moderator', 'developer']);
            $this->permission('moderate', 'allow edit not owned pages', ['moderator', 'developer']);

        }

        if(version_compare($version, '0.6.12', '<=')){
            $this->updateDatabase();
        }
        if(version_compare($version, '0.7', '<=')){
            $this->updateEvents();
        } */
        return true;
    }


}
