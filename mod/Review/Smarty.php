<?php
/**
 * Created by PhpStorm
 * User: shtaras
 * Date: 10/4/19
 * Time: 15:37
 *
 * @author Taras Shkodenko <ts@doagency.net>
 * @category   Skynar
 * @package    Blog
 * @copyright  2019 Taras Shkodenko.
 * @version    0.2
 */

namespace Review;


use Review\Review;
use Skynar\Module\SmartyHelper;


class Smarty
{
    const CACHE_ID_PREFIX = 'rlent';
    const TABLE_NAME = 'Review\Review';

    protected static $smarty_rlent_data = [];
    protected static $smarty_rlent_index = [];
    protected static $smarty_rcache = [];

    protected static function rlent_items($params)
    {
        // error_log( __METHOD__ . ' +' . __LINE__ . ' $params: ' . var_export($params, true));

        $count = isset($params[1]) ? (int)$params[1] : 10;
        if ($count < 1 || $count > 10000) $count = 10;
        // error_log( __METHOD__ . ' +' . __LINE__ . ' $count: ' . print_r($count, true));
        $path = $params[0];
        // error_log( __METHOD__ . ' +' . __LINE__ . ' $path: ' . print_r($path, true));
        $type = isset($params['table']) ? $params['table'] : self::TABLE_NAME;
        $select = 'p';
        if (isset($params['select_append'])) {
            $select .= ',' . $params['select_append'];
        }

        $orderBy = isset($params['order_by'])? $params['order_by'] : 'p.published DESC';
        $orders = explode(',', $orderBy);

        if ($params[0] == '/board') {
            $q = app()->getService('doctrine')->getQueryBuilder()
                ->select($select)
                ->from($type, 'p')
                ->leftJoin('p.image', 'i')
                ->where('p.status = :visible and p.published < CURRENT_TIMESTAMP()');
        } else {
            $q = app()->getService('doctrine')->getQueryBuilder()
                ->select($select)
                ->from($type, 'p')
                ->where('p.status = :visible');
            // ->where('c.path like :path and p.status = :visible and p.published < CURRENT_TIMESTAMP()');
        }
        if ($params['order_by']=='rand')
            $q->addSelect('RAND() as HIDDEN rand');

/*        if (isset($params['analytics']) && is_mod('Analytics'))
            $q->leftJoin('p.analytics', 'a'); */

        if (isset($params['category']))
            $q->andWhere('p.category = :category')
                ->setParameter('category', $params['category']);

        if (isset($params['where']))
            $q->andWhere($params['where']);

        foreach ($orders as $order) {
            $order = explode(' ', trim($order));
            $q->addOrderBy(
                $order[0],
                isset($order[1])?$order[1]:null
            );
        }
        $items = $q->getQuery()
            ->setParameter('visible', 1)
            ->setMaxResults($count)
            ->getResult();

        // error_log( __METHOD__ . ' +' . __LINE__ . ' $items: ' . print_r($items, true) . PHP_EOL );

        return $items;
    }

    public static function rlent_load($params, $smarty)
    {
        // error_log( date('r') . ' ' . __METHOD__ . ' $params: ' . print_r($params, true) );

        $name = isset($params['var']) ? $params['var'] : self::CACHE_ID_PREFIX;
        $items = self::rlent_items($params);

        // error_log( __METHOD__ . ' $items: ' . print_r($items, true) );

        $smarty->tpl_vars[$name] = new \Smarty_Variable($items, true);
    }

    public static function rlent($params, $content, $smarty, &$repeat)
    {
        // error_log(__METHOD__ . ' +' . __LINE__ . ' $params: ' . print_r($params, true));

        $name = isset($params['var']) ? $params['var'] : self::CACHE_ID_PREFIX;
        $count = isset($params[1]) ? (int)$params[1] : 10;
        if ($count < 1 || $count > 100) {
            $count = 10;
        }
        if ($content === null) {
            //первый вызов
            $trace = debug_backtrace(DEBUG_BACKTRACE_IGNORE_ARGS)[0];
            $cache_id = self::CACHE_ID_PREFIX . '.' . substr($trace['file'], strrpos($trace['file'], '/')+1).':'.$trace['line'].':'.$smarty->compiled->timestamp.$params[0];
            $cache = app()->getService('cache')->fetch($cache_id);
            if ($cache && !isset($params['analytics']) && !is_mod('Analytics')) {
                $repeat = false;
                return '<!-- ' . self::CACHE_ID_PREFIX . '_cache -->' . $cache . '<!-- /' . self::CACHE_ID_PREFIX . '_cache -->';
            }
            self::$smarty_rcache[] = ['id'=>$cache_id, 'data'=>'', 'lifetime'=>isset($params['cache_life_time'])?$params['cache_life_time']:0];

            $items = self::rlent_items($params);
            if (!$items) {
                return $repeat = false;
            }
            $count = count($items);

            self::$smarty_rlent_data[]=&$items;
            self::$smarty_rlent_index[]=1;

            $smarty->tpl_vars['loop'] = new \Smarty_Variable( [
                'total'=>$count,
                'index'=>($index = 1),
                'even'=>true,
                'odd'=>false,
                'first'=>true,
                'last'=>($count<2),
            ] );
        } else {
            //последний добавленнй массив
            $items = &self::$smarty_rlent_data[count(self::$smarty_rlent_data) - 1];
            $index = &self::$smarty_rlent_index[count(self::$smarty_rlent_data) - 1];
            $index++;
            $smarty->tpl_vars['loop']->value['index']= $index;
            $smarty->tpl_vars['loop']->value['even']=(bool)$index%2;
            $smarty->tpl_vars['loop']->value['odd']^=!(bool)$index%2;
            $smarty->tpl_vars['loop']->value['first']=false;
            $smarty->tpl_vars['loop']->value['last']=$index==count($items);
            self::$smarty_rcache[count(self::$smarty_rcache)-1]['data'] .= $content;
        }
        if (isset($items[$index-1])) {
            //назначаем новый элемент
            $smarty->tpl_vars[$name] = new \Smarty_Variable($items[$index-1], true);
            $repeat = true;
        } else {
            unset($smarty->tpl_vars['loop']);
            if (!(isset($params['analytics']) && is_mod('Analytics'))) {
                $trace = debug_backtrace(DEBUG_BACKTRACE_IGNORE_ARGS)[0];
                $cache_info = self::$smarty_rcache[count(self::$smarty_rcache) - 1];
                $cache = app()->getService('cache');
                $cache->save($cache_info['id'], $cache_info['data'], $cache_info['lifetime']);
                $cache->addTableRelation($cache_id, isset($params['table'])?$params['table']:'Blog\Post');

                foreach ($items as $item) {
                    $cache->addEntityRelation($cache_id, $item);
                }
                array_pop(self::$smarty_rcache);
            }
            array_pop(self::$smarty_rlent_data);
            array_pop(self::$smarty_rlent_index);
        }
        return $content;
    }
}