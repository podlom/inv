<?php

namespace Tinyurl;


use Skynar\Module\SmartyHelper;


class Smarty extends SmartyHelper
{
    public function tinyurl($params, $smarty)
    {
        $url = $params[0] ?? $params['url'] ?? false;
        $action = $params[1] ?? $params['action'] ?? 'mail.view';
        $suburl = $params[2] ?? $params['suburl'] ?? null;
        if(!$url){
            return '#no-url';
        }
        $cache_name = 'mail.link.url:'.$url;
        $cached = $this->getService('cache')->fetch($cache_name);
        if ($cached) {
            return full_link($this->getService('module')->getModule('Tinyurl')->id_to_url($cached, $suburl));
        }
        $links = Link::getRepository()->findBy(['action'=>$action,'url'=>$url]);
        if(count($links)){
            $link = current($links);
        } else {
            $link = new Link;
            $link->setAction($action);
            $link->setUrl($url);
            $link->save(1);
        }
        $this->getService('cache')->save($cache_name, $link->getId(), 360);
        return full_link($this->getService('module')->getModule('Tinyurl')->id_to_url($link->getId(), $suburl));
    }
}