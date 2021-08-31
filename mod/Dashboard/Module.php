<?php

namespace Dashboard;


use Skynar\Module\AbstractModule;
use Dashboard\Dashboard;


class Module extends AbstractModule
{
    protected function loadController(string $name)
    {
        if ($name === 'admin') {
            return new AdminController(Dashboard::class);
        }
    }

    public function dashboard($id, $params = [], $render = true)
    {
        $params = new ArrayHelper($params);
        $cache_name = 'dashboard.' . $id . ($params->get('target')?'.'.$params->get('target'):'');
        $assets_manager = $this->getService('assets');
        $cache = $this->getService('cache')->fetch($cache_name);
        if ($cache) {
            $assets = $cache[0];
            $data = $cache[1];
        } else {
            $dashboard = \Dashboard\Dashboard::getRepository()->find($id);
            if($dashboard){
                $data = $dashboard->getData($params);
                $assets = $dashboard->getAssets();
            } else {
                $data = null;
                $assets = null;
            }
        }
        $params = new ArrayHelper($params);
        //!T add event to parse params
        $data['options'] = $params;

        $this->getService('cache')->save($cache_name, [$assets, $data], 3600);

        if ($render && !isset($data['template'])) {
            return '<!-- unable to load dashboard -->';
        }
        if ($assets) {
            foreach ((array)$assets as $asset) {
                if (is_string($asset))
                    $assets_manager->add('js', $asset);
                else {
                    if ($asset instanceof \Skynar\Assets\Style) {
                        $assets_manager->add('css', $asset->getUrl(), true);
                    } else {
                        throw new \Skynar\Exception\InvalidArgument(t('Unexpected asset type {0}', [get_class($asset)]));
                    }
                }
            }
        }
        $data['session'] = $this->getService('session')->getSession();
        $data['value'] = $data['session']->get($cache_name);
        $data['target'] = $params->get('target');
        $p['data'] = $params->get('data');

        if ($render) {
            return $this->getService('template')->render($data['template'], $data);
        }
        return $data;
    }
}