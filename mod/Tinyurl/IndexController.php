<?php

namespace Tinyurl;

use Skynar\Controller\AbstractController;
use Skynar\Event\GenericEvent;
use Skynar\Exception\PageException;

class IndexController extends AbstractController{


	public function onInit()
	{
		$this->addRoute('index', '{url}', ['requirements'=>['url'=>'[a-z0-9]+']]);
		$this->addRoute('subindex', '{suburl}_{url}', ['requirements'=>['url'=>'[a-z0-9]+'], 'action'=>'index']);
	}

	public function index($request)
	{
		$url = $request->attributes->get('url');
		$link = Link::getRepository()->find(base_convert($url, 36, 10));
		$qb = $this->getService('doctrine')->getQueryBuilder();
		$qb->update(Link::class, 'l')
        	->set('l.clicks','l.clicks + 1')
        	->where('l.id = :lid')
        	->setParameter('lid', $link->getId())
        	->getQuery()
        	->execute();
		if(!$link)
			throw new PageException(404);
		$e = new GenericEvent(['link'=>$link, 'request'=>$request, 'response'=>$this->redirect($link->getUrl())]);
		$this->getService('event')->dispatch('tinyurl.request', $e);
		return $e->get('response');
	}

}