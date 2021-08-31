<?php


namespace SeoText;


use Core\Route;
use Doctrine\ORM\Mapping as ORM;
use Page\ContentRegistry;
use Page\Image;
use Skynar\Controller\AbstractController;
use Skynar\Controller\CrudController;
use Skynar\DataSource;
use Skynar\DataSource\DqlProvider;
use Skynar\Event\GenericEvent;
use Skynar\Exception\PageException;
use Skynar\Form\Binder\CollectionBinder;
use Skynar\Form\Binder\MethodBinder;
use Skynar\Form\Binder\iBinder;
use Skynar\Form\Form;
use Skynar\Form\Input;
use Skynar\Form\Validator\Base;
use Skynar\Form\Validator\NonEmpty;
use Skynar\Form\Validator\TextLenght;
use Skynar\Form\Validator\iValidator;
use Skynar\Http\Response\HtmlResponse;
use Tag;
use model\PaginationUrlGenerator;
use model\paginator;
use ui\Input\SelectInput as Select;
use ui\Menu;
use ui\Pagination;


/**
 * SeoText
 * @ORM\Entity
 * @ORM\HasLifecycleCallbacks
 */
// class AdminController extends AbstractController
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

        app()->getService('assets')->add('js','tinymce');
        app()->getService('assets')->add('js','ui');

        $response = parent::getResponse($request);
        if ($response instanceof HtmlResponse && $response->layout == null) {
            $response->layout = 'Core.admin_layout';
        }
        return $response;
    }

    public function seotextIndex($request)
    {
        error_log( __METHOD__ . ' +' . __LINE__ );

        $request->attributes->set('action', 'index');
        $response = $this->subcontroller['seotext']->getResponse($request);
        $response->template = 'Seotext.index';
        $response->type = 'seotext';
        $response->pages = $response->items;
        return $response;
    }
}