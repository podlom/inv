<?php


namespace Dashboard;


use Doctrine\ORM\Mapping as ORM;
use Skynar\Controller\CrudController;
use Skynar\Http\Response\HtmlResponse;


class AdminController extends CrudController
{
    public function onInit()
    {
        parent::onInit();
    }

    public function getResponse($request)
    {
        $response = parent::getResponse($request);
        if ($response instanceof HtmlResponse && $response->layout == null) {
            $response->layout = 'Core.admin_layout';
        }
        return $response;
    }

    public function getAssets()
    {
        return [new \Skynar\Assets\Style('/assets/Poll/style.css'), 'ui'];
    }
}