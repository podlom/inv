<?php
/**
 * @package Skynar
 * @version 0.1
 * @link http://skynar.co/
 * @author Taras Shkodenko <taras@shkodenko.com>
 * @copyright 2021
 */

namespace Croudinvesting;


use Skynar\Module\AbstractModule;
use Croudinvesting\Croudinvesting;


class Module extends AbstractModule
{
    const CACHE_PREFIX = 'croudinvesting';
    
    protected function loadController(string $name)
    {
        error_log( __METHOD__ . ' +' . __LINE__ );

        if ($name === 'admin') {
            return new AdminController(Croudinvesting::class);
        }
    }

    public function croudinvesting($id, $params = [], $render = true)
    {
        error_log( __METHOD__ . ' +' . __LINE__ . ' $id: ' . var_export($id, true) . '; $params: ' . var_export($params, true));

        $params = new ArrayHelper($params);
        $cache_name = self::CACHE_PREFIX . '.' . $id . ($params->get('target')?'.' . $params->get('target') : '');
        $assets_manager = $this->getService('assets');
        $cache = $this->getService('cache')->fetch($cache_name);
        if ($cache) {
            $assets = $cache[0];
            $data = $cache[1];
        } else {
            $croudInvesting = \Croudinvesting\Croudinvesting::getRepository()->find($id);
            if ($croudInvesting) {
                $data = $croudInvesting->getData($params);
                $assets = $croudInvesting->getAssets();
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
            return '<!-- unable to load review -->';
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