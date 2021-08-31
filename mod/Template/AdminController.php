<?php

namespace Template;


use Blog\Post;
use Skynar\Controller\AbstractController;
use Skynar\Event\GenericEvent;
use Skynar\Exception\InvalidArgument;
use Skynar\Exception\PageException;
use Skynar\Form\Form;
use Skynar\Form\Input;
use Symfony\Component\Filesystem\Filesystem;


/**
 * 
 */
class AdminController extends AbstractController
{
	public function getResponse($request)
	{
		if($request->headers->get('Content-Type')=='text/json;charset=UTF-8'){
            $request->request->replace(json_decode($request->getContent(), true));
        }
        $response = parent::getResponse($request);
        $response->layout = 'Core.admin_layout';
        return $response;
	}

	public function onInit()
	{
		$this->addRoute('index', '');
		$this->addRoute('edit', 'edit/{name}');
	}

	public function index($request)
	{
		$response = $request->getResponse();
		$response->items = $this->getTemplateList();
		// debug($tpls);
	}

	public function getTemplateList()
	{
		$dir = $this->getModule()->getApp()->getPath().'/template';
		$files = new \RecursiveDirectoryIterator($dir);
		$tpls = [];
		$fs = new Filesystem;
		foreach($files as $file){
			if ($file->getExtension() != 'tpl'){
				continue;
			}
			$name = $fs->makePathRelative($file->getPathname(), $dir);
			$name = rtrim($name, '/');
			$tpls[$name] = new TplInfo(['name'=>$name, 'path'=>$file->getPathname(), 'mtime'=>$file->getMtime()]);
		}
		return $tpls;
	}

	public function edit($request)
	{
	    // require_once '/home/devinv/d/w/dev.inventure.com.ua/cli/lib/db.class.php';
        require_once app()->getPath() . '/cli/lib/db.class.php';
        $cfg = app()->getService('config')->get('app')->db;
        // error_log( __METHOD__ . ' +' . __LINE__ . ' $cfg: ' . print_r($cfg, true) );
        try {
            $db = new \DB($cfg['host'], $cfg['user'], $cfg['password'], $cfg['dbname']);
            $query = "SET collation_connection = utf8_unicode_ci";
            $res0 = $db->query($query);
            $query = "SET NAMES " . $cfg['charset'];
            $res1 = $db->query($query);
            $query = "SET CHARACTER SET " . $cfg['charset'];
            $res2 = $db->query($query);
            $query = "set @@collation_server = utf8_unicode_ci";
            $res3 = $db->query($query);
        } catch (\Exception $e) {
            $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Fatal error: ' . $e->getMessage() . PHP_EOL;
            die($msg);
        }
	    //
        // debug(1);
        //
        error_log(__METHOD__ . ' +' . __LINE__ . ' GET data: ' . var_export($_GET, true));
        error_log(__METHOD__ . ' +' . __LINE__ . ' POST data: ' . var_export($_POST, true));
        //
        $response = $request->getResponse();
        //
        $backUrl = $request->query->get('back');
        error_log(__METHOD__ . ' +' . __LINE__ . ' $backUrl: ' . var_export($backUrl, true));
        //
        $copyTplFile = '';
        $copyTpl = $request->query->get('copy_tpl');
        //
        $tpl = $request->attributes->get('name', 'Auth.register');
        // error_log( __METHOD__ . ' +' . __LINE__ . ' tpl: ' . var_export($tpl, true) );
        $path = $this->getModule()->getApp()->getPath().'/template';
        // error_log( __METHOD__ . ' +' . __LINE__ . ' path: ' . var_export($path, true) );
        list($tpl_mod, $tpl_name) = explode('.', $tpl);
        error_log( __METHOD__ . ' +' . __LINE__ . ' $tpl_mod: ' . var_export($tpl_mod, true) );
        error_log( __METHOD__ . ' +' . __LINE__ . ' $tpl_name: ' . var_export($tpl_name, true) );
        //
        $mailingId = 0;
        if (preg_match('|mailing_(\d+)|', $tpl_name, $m3)) {
            if (isset($m3[1])) {
                $mailingId = $m3[1];
            }
        }
        error_log( __METHOD__ . ' +' . __LINE__ . ' $mailingId: ' . var_export($mailingId, true) );
        $query = "select * from email_template where id = '{$mailingId}'";
        $res10 = $db->query($query);
        // error_log( __METHOD__ . ' +' . __LINE__ . ' Get email template result: ' . var_export($res10, true) );
        //
        $templateText = '';
        if (empty($res10)) { // setup base email template
            error_log( __METHOD__ . ' +' . __LINE__ . ' Email template for mailing id: ' . var_export($mailingId, true ). ' was not found. ' );
            //
            if (isset($_GET['copy_tpl']) && ($_GET['copy_tpl'] == 'digest')) { // digest email template
                $query = "select * from base_email_template where id = '3'";
                $res11 = $db->query($query);
                // error_log( __METHOD__ . ' +' . __LINE__ . ' Get base email template result: ' . var_export($res11, true) );
                // $res11[0]['id'];
                // $res11[0]['text'];
                if (isset($res11[0]['parent_template_id']) && $res11[0]['parent_template_id'] > 0) {
                    $query = "select * from base_email_template where id = '{$res11[0]['parent_template_id']}'";
                    $res12 = $db->query($query);
                    // error_log( __METHOD__ . ' +' . __LINE__ . ' Get parent base email template result: ' . var_export($res12, true) );
                    // $res12[0]['text'];
                    $templateText = str_replace('{$text}', $res11[0]['text'], $res12[0]['text']);
                    $query = "insert into email_template set id = '{$mailingId}', `name` = '', `type` = '', mailing_id = '{$mailingId}', parent_template_id = '{$res11[0]['id']}', text = '" . $db->escape($templateText) . "', status = 1, created = NOW(), updated = NOW()";
                    $db->query($query);
                }
            } else { // newsletter email template
                $query = "select * from base_email_template where id = '2'";
                $res11 = $db->query($query);
                // error_log( __METHOD__ . ' +' . __LINE__ . ' Get base email template result: ' . var_export($res11, true) );
                // $res11[0]['id'];
                // $res11[0]['text'];
                if (isset($res11[0]['parent_template_id']) && $res11[0]['parent_template_id'] > 0) {
                    $query = "select * from base_email_template where id = '{$res11[0]['parent_template_id']}'";
                    $res12 = $db->query($query);
                    // error_log( __METHOD__ . ' +' . __LINE__ . ' Get parent base email template result: ' . var_export($res12, true) );
                    // $res12[0]['text'];
                    $templateText = str_replace('{$text}', $res11[0]['text'], $res12[0]['text']);
                    $query = "insert into email_template set id = '{$mailingId}', `name` = '', `type` = '', mailing_id = '{$mailingId}', parent_template_id = '{$res11[0]['id']}', text = '" . $db->escape($templateText) . "', status = 1, created = NOW(), updated = NOW()";
                    $db->query($query);
                }
            }
        } else { // load existing template text from db
            $templateText = $res10[0]['text'];
            error_log( __METHOD__ . ' +' . __LINE__ . ' Set email template text from DB. ' );
        }
        //
        /*
        $fs = new Filesystem;
        $file = $path.'/'.$tpl.'.tpl';
        error_log( __METHOD__ . ' +' . __LINE__ . ' $file: ' . var_export($file, true) );
        if (!file_exists($file)) {
            throw new PageException(404, $file);
        }
        //
        $srcTplFile = $path . '/Mail.mailing_default.tpl';
        if (file_exists($srcTplFile)) {
            error_log( __METHOD__ . ' +' . __LINE__ . ' File: ' . $srcTplFile . ' exists. ' );
            if (copy($srcTplFile, $file)) {
                error_log( __METHOD__ . ' +' . __LINE__ . ' Copied: ' . $srcTplFile . ' to: ' . $file );
            }
        }
        */
        //
        /* if (!empty($copyTpl)) {
            error_log( __METHOD__ . ' +' . __LINE__ . ' $copyTpl: ' . var_export($copyTpl, true) );
            if ($copyTpl == 'digest') {
                $copyTplFile = $path . '/Mail.mailing_default_digest.tpl';
            } elseif ($copyTpl == 'newsletter') {
                $copyTplFile = $path . '/Mail.mailing_default_newsletter.tpl';
            }
            // error_log( __METHOD__ . ' +' . __LINE__ . ' $copyTplFile: ' . var_export($copyTplFile, true) );
            if (file_exists($copyTplFile)) {
                copy($copyTplFile, $file);
            }
        } */
        //
        if ($request->isMethod('PUT')) {
            if (!is_dir(dirname($path))) {
                $fs->mkdir(dirname($path));
            }
            $tmpfile = $this->_put_temp_file($request);
            // error_log( __METHOD__ . ' +' . __LINE__ . ' $tmpfile: ' . var_export($tmpfile, true) );
            if(!$tmpfile)
                throw new PageException(400, 'Invalid upload');
            try{
                $html = $this->_test_tpl($tmpfile, $tpl);
                $response->setContent($html);
            } catch (InvalidArgument $e){
                //silent skip if no test data
                $response->setContent($this->getService('template')->renderException($e)); //
            } catch (\Throwable $t){
                unlink($tmpfile);
                throw $t;
            }
            $fs->rename($tmpfile, $file, true);
            return $response;
        } elseif($request->isMethod('POST')) {
            $makeRedirect = false;
            error_log( __METHOD__ . ' +' . __LINE__ . ' $makeRedirect: ' . var_export($makeRedirect, true) );
            //
            // $text = $request->query->post('page[content][text]');
            // $text = $request->query->get('page[content][text]');
            //
            $textContent = '';
            if (isset($_POST['page'], $_POST['page']['content'], $_POST['page']['content']['text'])
                && !empty($_POST['page']['content']['text'])
            ) { // Replace email template text & variables
                $textContent = $_POST['page']['content']['text'];
                // $emailTextOld = file_get_contents($file);
                $emailTextOld = $templateText;
                //
                if (preg_match('|{$text}|m', $templateText)) {
                    $emailTextOld = str_replace('{$text}', '<!-- text -->' . $textContent . '<!-- /text -->', $emailTextOld);
                } else {
                    $emailTextOld = $textContent;
                }
                //
                if (preg_match('|/admin/template/edit/|m', $emailTextOld)) {
                    $emailTextOld = str_replace('/admin/template/edit/', '', $emailTextOld);
                }
                //
                if (preg_match('|{* prefilter=off *}|m', $emailTextOld)) {
                    $emailTextOld = str_replace('{* prefilter=off *}', '', $emailTextOld);
                }
                //
                if (preg_match('|&lt;!doctype html&gt;|m', $emailTextOld)) {
                    $emailTextOld = str_replace('&lt;!doctype html&gt;', '', $emailTextOld);
                }
                //
                if (preg_match('|{literal}|m', $emailTextOld)) {
                    $emailTextOld = str_replace('{literal}', '', $emailTextOld);
                }
                //
                if (preg_match('|{/literal}|m', $emailTextOld)) {
                    $emailTextOld = str_replace('{/literal}', '', $emailTextOld);
                }
                //
                if (preg_match_all('|src="(.*)"|Uim', $emailTextOld, $m1)) {
                    error_log( __METHOD__ . ' +' . __LINE__ . ' Found all email template src matches: ' . var_export($m1, true) );
                    if (!empty($m1[1]) && is_array($m1[1])) {
                        foreach ($m1[1] as $k1 => $v1) {
                            if (substr($v1, 0, 1) == '/') {
                                $v2 = site_protocol() . '://' . site_host() . $v1;
                                error_log( __METHOD__ . ' +' . __LINE__ . ' Fixed src from: ' . var_export($v1, true) . ' to: ' . var_export($v2, true) );
                                $emailTextOld = str_replace($v1, $v2, $emailTextOld);
                                break;
                            }
                        }
                    }
                }
                // href="/analytics/digest"
                if (preg_match_all('|href="(.*)"|Uim', $emailTextOld, $m9)) {
                    error_log( __METHOD__ . ' +' . __LINE__ . ' Found all email template src matches: ' . var_export($m9, true) );
                    if (!empty($m9[1]) && is_array($m9[1])) {
                        foreach ($m9[1] as $k9 => $v9) {
                            if (substr($v9, 0, 1) == '/') {
                                $v8 = site_protocol() . '://' . site_host() . $v9;
                                error_log( __METHOD__ . ' +' . __LINE__ . ' Fixed src from: ' . var_export($v9, true) . ' to: ' . var_export($v8, true) );
                                $emailTextOld = str_replace($v9, $v8, $emailTextOld);
                            }
                        }
                    }
                }
                //
                if (preg_match_all('|style="background:\s?url\((.*)\)|Uim', $emailTextOld, $m2)) {
                    error_log( __METHOD__ . ' +' . __LINE__ . ' Found all email template src matches: ' . var_export($m2, true) );
                    if (!empty($m2[1]) && is_array($m2[1])) {
                        foreach ($m2[1] as $k2 => $v2) {
                            if (substr($v2, 0, 1) == '/') {
                                $v3 = site_protocol() . '://' . site_host() . $v2;
                                error_log( __METHOD__ . ' +' . __LINE__ . ' Fixed src from: ' . var_export($v2, true) . ' to: ' . var_export($v3, true) );
                                $emailTextOld = str_replace($v2, $v3, $emailTextOld);
                                break;
                            }
                        }
                    }
                }
                //
                $emailTextOld = str_replace(site_protocol() . '://' . site_protocol() . '://', site_protocol() . '://', $emailTextOld);
                $emailTextOld = str_replace(site_protocol() . '://' . site_host() . site_protocol() . '://' . site_host(), site_protocol() . '://' . site_host(), $emailTextOld);
                //
                $emailTextNew = str_replace('recipient-&gt;getName', 'recipient->getName', $emailTextOld);
                //
                // error_log(__METHOD__ . ' +' . __LINE__ . ' $emailTextNew: ' . var_export($emailTextNew, true));
                // Save template edits
                // file_put_contents($file, $emailTextNew);
                $query = "update email_template set text = '"  . $db->escape($emailTextNew) . "', updated = NOW() where id = '{$mailingId}'";
                $res13 = $db->query($query);
                if ($res13) {
                    error_log( __METHOD__ . ' +' . __LINE__ . ' Updated email template text in db for mailing id: ' . var_export($mailingId, true) );
                }
                //
                if (isset($backUrl) && !empty($backUrl)) {
                    if (preg_match('|(/admin/mail/mailing/\d+)|', $backUrl, $m0)) {
                        $makeRedirect = true;
                        $backUrl = $m0[1];
                        error_log( __METHOD__ . ' +' . __LINE__ . ' $makeRedirect: ' . var_export($makeRedirect, true) );
                    }
                }
            }
            //
            // update config
            $cfg = $this->getService('config')->get('Mail', 'mailing');
            $data = $cfg->{$tpl_name};
            if (!isset($data['from'])) {
                $data['from'] = null;
            }
            foreach ($data as $key => $value) {
                if ($value === false) {
                    continue;
                }
                if ($request->request->has($key)) {
                    $new_val = $request->request->get($key);
                    if (in_array($key, ['subject', 'from']) && is_string($new_val)) {
                        $data[$key]=$new_val;
                    } elseif (in_array($key, ['to', 'cc', 'bcc']) && is_array($new_val)) {
                        foreach ($new_val as $email => $name) {
                            if (filter_var($email, FILTER_VALIDATE_EMAIL) == false) {
                                throw new PageException(400, 'Invalid Email');
                            }
                        }
                        $data[$key] = $new_val;
                    }
                } elseif (in_array($key, ['to', 'cc', 'bcc'])) {
                    $data[$key] = [];
                }
            }
            $cfg->{$tpl_name} = $data;
            $cfg->save();
            $response->result = $data;
            //
            if ($makeRedirect) {
                error_log( __METHOD__ . ' +' . __LINE__ . ' Making redirect to: ' . var_export($backUrl, true) );
                return $this->redirect($backUrl);
            }
            //
            error_log( __METHOD__ . ' +' . __LINE__ . ' No redirect. ' );
            //
            $entity = new \Blog\Post;
            if ($entity instanceof Post) {
                $content = new \Page\Content;
                $content->setName('content');
                $content->setText($emailTextNew);
                $entity->addPart($content);
            }
            $form = \Page\AdminController::getEditForm($entity, $request, false);
            $response->form = $form;
            //
            return $response;
            //
        } elseif ($request->isMethod('GET')) { // View template
            error_log( __METHOD__ . ' +' . __LINE__ . ' $tpl: ' . print_r($tpl, true) ); // +224 $tpl: Mail.mailing_52
            if (mb_substr($tpl,0,13)=='Mail.mailing_') {
                $cfg = $this->getService('config')->get('Mail', 'mailing');
                $response->config = $cfg->{$tpl_name};
            }
            $response->tplfile = $this->getService('template')->findFile($tpl);
            if (!$response->tplfile) {
                touch($path);
                $response->tplfile = $path;
            }
            try {
                $response->result = $this->_test_tpl($response->tplfile, $tpl);
            } catch (\Throwable $e) {
                $response->result = $this->getService('template')->renderException($e);
            }
            //
            /*
            if ($copyTpl == 'digest') {
                $copyTplFile = $path . '/Mail.mailing_default_digest.tpl';
            } elseif ($copyTpl == 'newsletter') {
                $copyTplFile = $path . '/Mail.mailing_default_newsletter.tpl';
            } else {
                $copyTplFile = $file;
            }
            $emailTextNew = file_get_contents($copyTplFile);
            if (preg_match('|<body>(.*)</body>|imU', $emailTextNew, $m2)) {
                if (isset($m2[1]) && !empty($m2[1])) {
                    $emailTextNew = $m2[1];
                }
            }
            // $response->emailTextNew = $emailTextNew;
            */
            $response->emailTextNew = $templateText;
            //
            // $response->tplname = $tpl_alias;
            //
            $entity = new \Blog\Post;
            if ($entity instanceof Post) {
                $content = new \Page\Content;
                $content->setName('content');
                $content->setText($templateText);
                $entity->addPart($content);
            }
            $form = \Page\AdminController::getEditForm($entity, $request, false);
            $response->form = $form;
            //
            return $response;
        }
	}

    protected function _put_temp_file($request)
    {
        // отключаем ограничение по времени
        set_time_limit(0);
        ignore_user_abort(true);
        /* PUT данные приходят в потоке ввода stdin */
        $putdata = fopen("php://input", "rb");
        //размер блока для чтения/записи
        $chank_size = 128*1024; //128kb
        $conntent_length = 0;
        /* Открываем файл на чтение */
        $tmpfile = tempnam(sys_get_temp_dir(), 'skynar-upload-');
        $fp = fopen($tmpfile, 'wb');
        /* Читаем 1 KB данных за один раз и пишем в файл */
        while ( ( $data = fread($putdata, $chank_size) ) && ($conntent_length <= $request->server->get('CONTENT_LENGTH')) && !connection_aborted())
          $conntent_length += fwrite($fp, $data);
            /* Закрываем потоки */
        fclose($fp);
        fclose($putdata);
        //move file to its location
        if($request->server->get('CONTENT_LENGTH') == $conntent_length){
            return $tmpfile;
        } else {
            unlink($tmpfile);
            return false;
        }
    }


    protected function _test_tpl($file, $tpl_name){
    	$event = new GenericEvent(['data'=>null, 'template'=>$tpl_name, 'layout'=>null]);
    	$this->getService('event')->dispatch('template.data', $event);
    	$data = $event->get('data');
    	
    	/*
        if($tpl_mod=='Auth'){
            if($tpl_name=='register' || $tpl_name=='restore'){
                $user = $this->getService('session')->getUser();
                $code = 'TEST_'. bin2hex(random_bytes(4));
                $data= [
                    'user'=>$user,
                    'code'=>$code,
                    'url'=>full_link('/someurl?email='.urlencode($user->getEmail()).'&code='.$code),
                ];
            }
        } elseif($tpl_mod=='Mail'){
            $m = [];
            if(preg_match('|mailing_(\d)+|e', $tpl_name, $m)){
                $mailing = \Mail\Mailing::getRepository()->find($m[1]);
                $recipient = current($this->getService('doctrine')->getQueryBuilder()
                    ->select('r')
                    ->from(\Mail\Recipient::class, 'r')
                    ->where('r.mailing = :m')
                    ->getQuery()
                    ->setParameter('m', $mailing)
                    ->setMaxResults(1)
                    ->getResult());
                if(!$recipient){
                    $recipient = new \Mail\Recipient;
                    $recipient->setName('No_recipients_imported_name');
                    $recipient->setEmail('no_recipients_imported_email@gmail.com');
                }
                $data = [
                    'mailing' => $mailing,
                    'recipient'=>$recipient,
                ];
            }
        }*/
        if(!$data){
            throw new InvalidArgument(p('No test data for template {0}',[$tpl_name]));
        }
        $html = $this->getService('template')->render($file, $data, false);
        if($event->get('layout')){
        	$data['content'] = $html;
        	$html = $this->getService('template')->render($event->get('layout'), $data, false);
        }
        return $html;
    }
}