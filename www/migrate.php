<?php
define( 'SKYNAR_DEBUG', true);
define( 'SKYNAR_TIMING', true);

return 0;

require_once realpath(realpath(__DIR__).'/../cms/actual/global.php');
$app = new Skynar\Application('inventure#beta', realpath(__DIR__.'/../'), __DIR__);
set_time_limit(300);
try{
	$app->init();

	$conn = $app->getService('doctrine')->getConnection();
	//*
	//drop foreign keys
	$fq = $conn->prepare('SELECT TABLE_NAME, CONSTRAINT_NAME FROM information_schema.key_column_usage WHERE CONSTRAINT_SCHEMA = :db AND referenced_table_name IS NOT NULL;');
	$fq->execute(['db'=>$conn->getDatabase()]);
	while($row = $fq->fetch(PDO::FETCH_NUM)){
		$conn->query(p('ALTER TABLE `{0}` DROP FOREIGN KEY {1}', $row));
	}
	//drop indexes
	$q = $conn->prepare('SELECT table_name AS `Table`, index_name AS `Index` FROM information_schema.statistics WHERE table_schema = :db AND NON_UNIQUE = 1 GROUP BY 1,2');
	$q->execute(['db'=>$conn->getDatabase()]);
	while($row = $q->fetch(PDO::FETCH_NUM)){
		$conn->query(p('ALTER TABLE `{0}` DROP INDEX {1}', $row));
	}
	//rename tables
	foreach([
		'AnalyticsPage' => 'Analytics_Page',
		'AttributeType' => 'Core_Attribute',
		'AuthPermission' => 'Auth_Access_Permission',
		'AuthRole' => 'Auth_Access_Role',
		'AuthLogin' => 'Auth_Login',
		'auth_session' => 'Auth_Session',
		'AuthUser' => 'Auth_User',
		'BlacklistIP' => 'Blacklist_BanIP',
		'AttributeShema' => 'Core_Attribute_Schema',
		'AttributeType' => 'Core_Attribute_Type',
		'Subscriber' => 'Mail_Subscriber',
		'PaymentInvoice' => 'Payment_Invoice',
		'Payment' => 'Payment_Payment',
		'PaymentProduct' => 'Payment_Product',
		'role_permission' => 'permission_role',
		'PollVariant' => 'Poll_Variant',
		'PollVote' => 'Poll_Vote',
		'SkynarModule' => 'Routing',
		'AuthUserRoles' => 'user_role'
	] as $t1=>$t2){
		try{
			$conn->query(p('RENAME TABLE `{0}` TO `{1}`;',[$t1,$t2]));
		} catch (\Exception $e){
			debug($e, false);
		}
	}
	//run table updates
	//drop all permissions and system routing, we will create them later
	foreach([
		'set FOREIGN_KEY_CHECKS=0;',
		'DROP TABLE `user_role`, `permission_role`, `Auth_Access_Role`, `Auth_Access_Permission`',
		'ALTER TABLE Routing CHANGE class _old VARCHAR(255), ADD controller VARCHAR(255) NOT NULL, ADD module VARCHAR(255) NOT NULL',
		'ALTER TABLE Page CHANGE class _old VARCHAR(255), ADD class SMALLINT NOT NULL, CHANGE controller_id route_id INT DEFAULT NULL',
		'ALTER TABLE PagePart CHANGE type _old VARCHAR(255), ADD type SMALLINT NOT NULL, CHANGE string text LONGTEXT DEFAULT NULL',
		'ALTER TABLE Widget CHANGE class _old VARCHAR(255), ADD class SMALLINT NOT NULL',
		'ALTER TABLE Core_Attribute_Type CHANGE class _old VARCHAR(255), ADD class SMALLINT NOT NULL',
		'UPDATE `Routing` SET `lang` = NULL WHERE `lang` IN ("0", "")',
		'UPDATE `Routing` SET `module` = "Page", `controller` = "page" WHERE _old LIKE "Page.IndexController"',
		'UPDATE `Routing` SET `module` = "Redirect", `controller` = "index" WHERE _old LIKE "Redirect.IndexController"',
		'UPDATE `Routing` SET `module` = "Blog", `controller` = "index" WHERE _old LIKE "Blog.IndexController"',
		'UPDATE `Routing` SET `module` = "EventSort", `controller` = "index" WHERE _old LIKE "EventSort.IndexController"',
		'DELETE FROM `Routing` WHERE `controller` = ""',
		'set FOREIGN_KEY_CHECKS=1;'

	] as $q)
		$conn->query($q);
	$acl = $app->getService('security')->getAclProvider();
	foreach([\Core\Page::class=>'Page', \Core\PagePart::class=>'PagePart', \Widget\Widget::class=>'Widget', \Core\Attribute\Type::class=>'Core_Attribute_Type'] as $cls=>$table){
		$field = 'class';
		if($cls === \Core\PagePart::class){
			$field = 'type';
		}
		$upd = $conn->prepare('UPDATE `'.$table.'` SET `'.$field.'` = :id WHERE _old LIKE :old');
		//update old types
		foreach($acl->loadDiscriminatorMap($cls) as $id=>$name){
			$old = str_replace('\\', '.', $name);
			$map = [
				'Core.Image'=>'Page.Image',
				'Page.Content'=>'Page.PageContent',
				'Attribute.Type.StringType' => 'Attribute.Type.String',
			];
			if(isset($map[$old])){
				$old = $map[$old];
			}
			$upd->execute(['id'=>$id, 'old'=>$old]);
		}
	}
	$app->getService('doctrine')->updateDatabase(false);
	//goto update
	$cfg = $app->getService('config')->get('modules');
	$cfg->event = [];
	$cfg->helper = [];
	$cfg->modules = [];
	$cfg->save();
	$app->getService('cache')->flushAll();
	$app->getService('cache')->deleteAll();
	header('Location: '.full_link('/install.php'));
} catch (Throwable $e){
	echo $app->getService('template')->renderException($e);
}

echo 'ok';
