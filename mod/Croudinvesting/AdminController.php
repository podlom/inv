<?php
/**
 * @package Skynar
 * @version 0.1
 * @link http://skynar.co/
 * @author Taras Shkodenko <taras@shkodenko.com>
 * @copyright 2021
 */

namespace Croudinvesting;


use Doctrine\ORM\Mapping as ORM;
use Skynar\Controller\CrudController;
use Skynar\Http\Response\HtmlResponse;
use Skynar\DataSource;


class AdminController extends CrudController
{
    public function onInit()
    {
        error_log( __METHOD__ . ' +' . __LINE__ );

        parent::onInit();

        error_log( __METHOD__ . ' +' . __LINE__ );
    }

    public function getResponse($request)
    {
        error_log( __METHOD__ . ' +' . __LINE__ );

        $response = parent::getResponse($request);
        if ($response instanceof HtmlResponse && $response->layout == null) {
            $response->layout = 'Core.admin_layout';
        }
        return $response;
    }

    public function croudinvestingIndex($request)
    {
        error_log( __METHOD__ . ' +' . __LINE__ );

        $request->attributes->set('action', 'index');
        $response = $this->subcontroller['croudinvesting']->getResponse($request);
        $response->template = 'Croudinvesting.index';
        $response->type = 'croudinvesting';
        $response->pages = $response->items;
        return $response;
    }

    public function croudinvestingEdit($request)
    {
        error_log( __METHOD__ . ' +' . __LINE__ );

        $request->attributes->set('action', 'edit');
        $response = $this->subcontroller['croudinvesting']->getResponse($request);
        $response->template = 'Croudinvesting.edit';
        $response->type = 'croudinvesting';
        $response->pages = $response->items;
        return $response;
    }
}