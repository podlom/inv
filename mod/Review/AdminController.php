<?php


namespace Review;


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

    public function reviewIndex($request)
    {
        error_log( __METHOD__ . ' +' . __LINE__ );

        $request->attributes->set('action', 'index');
        $response = $this->subcontroller['review']->getResponse($request);
        $response->template = 'Review.index';
        $response->type = 'review';
        $response->pages = $response->items;
        return $response;
    }
}