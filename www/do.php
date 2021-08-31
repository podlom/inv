<?php
define( 'SKYNAR_DEBUG', true);
define('QWEB_DEBUG', true);

//phpinfo();exit;
//загружаем  хелпер
require_once realpath(realpath(__DIR__).'/../cms/actual/global.php');
//загружаем приложение и запускаем
//error_reporting(E_ALL);
$app = new Skynar\Application('inventure#dev', realpath(__DIR__.'/../'));
$app->init();

debug([url_fix('https://beta.inventure.com.ua/upload/ces 2018 UA/заглавная.jpg'), url_fix('/upload/ces 2018 UA/заглавная.jpg')]);
/*
install payments
$ac = $app->getService('doctrine')
	->getEntityManager()
	->getClassMetadata('Skynar\Module\AbstractController');
$ac->discriminatorMap['Payment.AdminController'] = 'Payment\\AdminController';
$ac->discriminatorMap['Payment.UserController'] = 'Payment\\UserController';
$app->getService('module')->install('Payment');
$app->getService('module')->install('Liqpay');
$app->getService('module')->updateEvents('BulletinBoard');*/
/*
$attr = \Core\Attribute\Type::getRepository()->find(16);

$keys = array_keys($attr->getOption('data'));

$keys[8]='Деревообработка';

$data = array_combine($keys, $attr->getOption('data'));

$attr->setOption('data', $data);

$attr->save(1);

debug($data);

// */

//$app->getService('module')->updateEvents('Blog');
//$b = new tool\Bcrypt();
//$app->compileStyle();
//$app->init();
//$app->getService('doctrine')->createDatabase();

//$cfg = $app->getService('config')->get('app');
//*
//debug($app->getService('doctrine')->getCOnnection()->query('SELECT NOW()')->fetchAll());
//$mod = $app->getService('module');
//$mod->install('Locale');
//$app->getService('module')->updateEvents('Locale');
//debug('up');
$app->getService('cache')->flushAll();
$app->getService('doctrine')->updateDatabase();
$app->getService('doctrine')->generateProxy();
debug(1);
/*
foreach($mod->getActiveModules() as $name)
    $mod->updateEvents($name);

/*
if(is_mod('Analytics'))
    $app->getService('analytics')->create();
if(is_mod('Sphinx'))
    $app->getService('module')->getModule('Sphinx')->buildConfig();
*/

//$app->getService('module')->install('Rating');
//*/
/*
$app->getService('module')->install('Auth');
$app->getService('module')->install('Sphinx');
$app->getService('module')->install('Page');
$app->getService('module')->install('Metadata');
$app->getService('module')->install('Blog');
$app->getService('module')->install('Attribute');
$app->getService('module')->install('Redirect');
$app->getService('module')->install('Digest');
$app->getService('module')->install('Widget');
$app->getService('module')->install('Poll');
//*/
// *
$u = Auth\User::getRepository()->findOneByEmail('dev@feelgoodlabs.com');
if(!$u)
    $u = new auth\user();
//$u->setEmail('gopak@skynar.co');
//$u->setName('Sergey');
$u->setPasswd('2343243');
$u->setStatus(0);
$roles = Auth\Access\Role::getRepository()->findByName(['access','content','settings','development','user']);
foreach($roles as $role)
    $u->addRole($role);
$u->save(1);
//*/

$app->run();

