<?php

namespace Tinyurl;


use Skynar\Controller\CrudController;
use Skynar\Module\AbstractModule;


class Module extends AbstractModule
{
	protected function loadController(string $name)
    {
		if ($name == 'redirect') {
			return new IndexController;
		} elseif ($name == 'admin') {
			return new CrudController(Link::class, [
				'layout' => 'Core.admin_layout'
			]);
		}
	}

	public function id_to_url($id, $suburl=null)
    {
		$c = $this->findOneController('redirect');
		if (strlen($suburl) > 0) {
			return $c->url('subindex', ['url' => base_convert($id,10,36), 'suburl'=>$suburl]);
		}
		return $c->url('index', ['url' => base_convert($id,10,36)]);
	}

}