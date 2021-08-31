<?php

namespace Template;

use Skynar\Module\AbstractModule;

/**
 * 
 */
class Module extends AbstractModule
{
	

	protected function loadController(string $name)
	{
		if($name == 'template'){
			return new AdminController;
		}
	}

}