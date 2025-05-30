<?php
/**
 * Created by PhpStorm
 * User: shtaras
 * Date: 01/02/20
 * Time: 12:21
 * Modified: 2025-05-30 14:48
 *
 * @author Taras Shkodenko <taras.shkodenko@gmail.com>
 */

use Auth\Access\Role;
use Auth\User;


require_once realpath(__DIR__.'/../bootstrap.php');


$app_name = trim(file_get_contents(__DIR__.'/../app_id'));
$app = new Skynar\Application($app_name, realpath(__DIR__.'/../'), __DIR__);
try {
    $app->init();
} catch (Throwable $e) {
    echo $app->getService('template')->renderException($e);
}

if (!empty($_POST)) {
    require_once app()->getPath() . '/cli/lib/db.class.php';
    $cfg = app()->getService('config')->get('app')->db;

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

    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' POST data: ' . var_export($_POST, true);
    error_log( $msg );

    if (isset($_POST['action'])
        && ($_POST['action'] == 'set')
    ) { // Update attr data
        /**
         * @example: $data = [ action: set, attr: phone, user_id: 15, value: 0674464212 ];
         */
        $attrValue = trim($_POST['value']);
        $attrName = trim($_POST['attr']);
        $userId = intval($_POST['user_id']);
        //
        $query = "SELECT * FROM `Auth_User` WHERE `id` = '{$userId}'";
        $res10 = $db->query($query);
        $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Got db result: ' . var_export($res10, true);
        error_log( $msg );
        //
        $res12 = false;
        if (!empty($res10) && isset($res10, $res10[0], $res10[0]['attr'])) {
            if (!empty($res10[0]['attr'])) {
                $oJsonData = json_decode($res10[0]['attr'], true);
                $newJsonData = $oJsonData;
                $newJsonData[$attrName] = $attrValue;
            } else {
                $newJsonData = [];
                $newJsonData[$attrName] = $attrValue;
            }
            $newAttr = $db->escape(json_encode($newJsonData));
            $query = "UPDATE `Auth_User` SET `attr` = '{$newAttr}', `status` = '0' WHERE `id` = '{$userId}'";
            $res12 = $db->query($query);
        }
        if (!headers_sent()) {
            header('Content-Type: text/plain; charset=utf-8');
        }
        echo $res12;
        //
    } elseif (isset($_POST['action'])
        && ($_POST['action'] == 'get')
    ) { // Get attr data
        $attrName = trim($_POST['attr']);
        $userId = intval($_POST['user_id']);
        //
        $query = "SELECT * FROM `Auth_User` WHERE `id` = '{$userId}'";
        $res14 = $db->query($query);
        // $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Got db result: ' . var_export($res14, true);
        // error_log( $msg );
        //
        $res13 = '';
        if (!empty($res14) && isset($res14, $res14[0], $res14[0]['attr'])) {
            if (!empty($res14[0]['attr'])) {
                $jData = json_decode($res14[0]['attr'], true);
                if (($jData !== false)
                    && isset($jData[$attrName])
                ) {
                    $res13 = $jData[$attrName];
                }
            }
        }
        if (!headers_sent()) {
            header('Content-Type: text/plain; charset=utf-8');
        }
        $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' $attrName: ' . var_export($attrName, true) . ' . Result: ' . var_export($res13, true);
        error_log( $msg );
        echo $res13;
    } elseif (isset($_POST['action'])
        && ($_POST['action'] == 'register')
    ) { // Register new manager
        $res14 = '';
        $userEmail = $db->escape(trim($_POST['email'])); // TODO: validate email
        $userPass = $db->escape($_POST['pass']); // TODO: validate password rules ?
        //
        $query = "SELECT * FROM `Auth_User` WHERE `email` = '{$userEmail}'";
        $res15 = $db->query($query);
        $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Find user by email ' . var_export($userEmail, true) . ' . Result: ' . var_export($res15, true);
        error_log( $msg );
        //
        if (empty($res15)) { // register new user
            $user = new User;
            $user->setName('');
            $user->set('job', 'Manager');
            $user->setEmail($userEmail);
            $user->setStatus(User::STATUS_ACTIVE);
            $user->addRole(app()->getService('doctrine')->ref(Role::class, 'user'));
            $user->addRole(app()->getService('doctrine')->ref(Role::class, 'manager'));
            $user->setPasswd($userPass);
            $user->save(1);
            $res14 = 'Пользователь с email ' . $userEmail . ' и паролем ' . $userPass . ' успешно зарегистрирован';
        } elseif (is_array($res15) && isset($res15, $res15[0], $res15[0]['id'])) { // error: existing user
            $res14 = 'Ошибка: пользователь с таким email ' . $userEmail . ' уже зарегистрирован. <a href="/admin/user/edit/' . $res15[0]['id'] . '">Редактировать его профиль</a>?';
        }
        //
        if (!headers_sent()) {
            header('Content-Type: text/plain; charset=utf-8');
        }
        echo $res14;
    } elseif (isset($_POST['action'])
        && ($_POST['action'] == 'check_manager')
    ) { // Check manager in session
        $user = app()->getService('session')->getUser();
        if (!empty($user)) {
            app()->getService('session')->checkUser();
            $userId = intval($user->getId());
            $query = "SELECT * FROM `user_role` WHERE `user_id` = '{$userId}'";
            $res16 = $db->query($query);
            if (is_array($res16) && !empty($res16)) {
                foreach ($res16 as $n9 => $ur) {
                    if ($ur['role_id'] == 'manager') {
                        $query = "SELECT * FROM `Auth_User` WHERE `id` = '{$userId}'";
                        $res17 = $db->query($query);
                        //
                        $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Manager DB data: ' . var_export($res17, true);
                        error_log( $msg );
                        //
                        if (!empty($res17) && isset($res17, $res17[0])) {
                            // echo json_encode($res17[0]);
                            $resData = [
                                'email' => $res17[0]['email'],
                                'name' => $res17[0]['name'],
                            ];
                            if (!empty($res17[0]['attr'])) {
                                $attr = json_decode($res17[0]['attr'], true);
                                if (isset($attr['phone'])) {
                                    $resData['phone'] = $attr['phone'];
                                }
                            }
                            if (!empty($res17[0]['image_id'])) {
                                $imgId = $res17[0]['image_id'];
                                $query = "SELECT `url` FROM `PagePart` WHERE `id` = '{$imgId}'";
                                $res22 = $db->query($query);
                                if (!empty($res22) && isset($res22, $res22[0], $res22[0]['url'])) {
                                    $resData['avatar'] = $res22[0]['url'];
                                }
                            }
                            //
                            $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Resp data: ' . var_export($resData, true);
                            error_log( $msg );
                            //
                            if (!headers_sent()) {
                                header('Content-Type: text/plain; charset=utf-8');
                            }
                            echo json_encode($resData);
                        }
                    }
                }
            }
        }
    } elseif (isset($_POST['action'])
        && ($_POST['action'] == 'check_if_superadmin')
    ) { // TODO: Check admin in session
        // return HTML select options with manager contacts
        $user = app()->getService('session')->getUser();
        if (!empty($user)) {
            app()->getService('session')->checkUser();
            $userId = intval($user->getId());
            $query = "SELECT * FROM `user_role` WHERE `user_id` = '{$userId}'";
            //
            $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' SQL: ' . var_export($query, true);
            error_log( $msg );
            //
            $res16 = $db->query($query);
            //
            $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Got db data: ' . var_export($res16, true);
            error_log( $msg );
            //
            if (is_array($res16) && !empty($res16)) {
                foreach ($res16 as $n9 => $ur) {
                    //
                    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' User role data: ' . var_export($ur, true);
                    error_log( $msg );
                    //
                    if ($ur['role_id'] == 'admin') {
                        if (!headers_sent()) {
                            header('Content-Type: text/plain; charset=utf-8');
                        }
                        echo 1;
                    }
                }
            }
            if (!headers_sent()) {
                header('Content-Type: text/plain; charset=utf-8');
            }
            echo 0;
        }
    } elseif (isset($_POST['action'])
        && ($_POST['action'] == 'check_admin')
    ) { // TODO: Check admin in session
        // return HTML select options with manager contacts
        $user = app()->getService('session')->getUser();
        if (!empty($user)) {
            app()->getService('session')->checkUser();
            $userId = intval($user->getId());
            $query = "SELECT * FROM `user_role` WHERE `user_id` = '{$userId}'";
            //
            $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' SQL: ' . var_export($query, true);
            error_log( $msg );
            //
            $res16 = $db->query($query);
            //
            $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Got db data: ' . var_export($res16, true);
            error_log( $msg );
            //
            if (is_array($res16) && !empty($res16)) {
                foreach ($res16 as $n9 => $ur) {
                    //
                    $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' User role data: ' . var_export($ur, true);
                    error_log( $msg );
                    //
                    if ($ur['role_id'] == 'admin') {
                        $query = "SELECT au.* FROM `Auth_User` au WHERE au.`id` IN (SELECT user_id FROM `user_role` WHERE role_id = 'manager') AND au.`status` = 0";
                        $res18 = $db->query($query);
                        if (!empty($res18) && is_array($res18)) {
                            $res19 = '<div class="row"><label>Выбрать контакты ответственного менеджера: <select id="adm_mgr1" name="adm_mgr1"><option value=""></option>';
                            foreach ($res18 as $m9) {
                                $res19 .= '<option value="' . $m9['id'] . '">' . $m9['name'] . '</option>';
                            }
                            $res19 .= '</select></label></div>';
                            if (!headers_sent()) {
                                header('Content-Type: text/html; charset=utf-8');
                            }
                            echo $res19;
                        }
                    }
                }
            }
        }
    } elseif (isset($_POST['action'])
        && ($_POST['action'] == 'admin_get_manager_contacts')
    ) { // TODO: Check admin in session
        // return HTML select options with manager contacts
        $user = app()->getService('session')->getUser();
        if (!empty($user)) {
            app()->getService('session')->checkUser();
            $userId = intval($user->getId());
            $query = "SELECT * FROM `user_role` WHERE `user_id` = '{$userId}'";
            $res16 = $db->query($query);
            if (is_array($res16) && !empty($res16)) {
                foreach ($res16 as $n9 => $ur) {
                    if ($ur['role_id'] == 'admin') {
                        $managerId = intval($_POST['manager_id']);
                        $query = "SELECT au.* FROM `Auth_User` au WHERE au.`id` = '{$managerId}'";
                        $res20 = $db->query($query);
                        if (!empty($res20)) {
                            $resData = [
                                'email' => $res20[0]['email'],
                                'name' => $res20[0]['name'],
                            ];
                            if (!empty($res20[0]['attr'])) {
                                $attr = json_decode($res20[0]['attr'], true);
                                if (isset($attr['phone'])) {
                                    $resData['phone'] = $attr['phone'];
                                }
                            }
                            if (!empty($res20[0]['image_id'])) {
                                $imgId = $res20[0]['image_id'];
                                $query = "SELECT `url` FROM `PagePart` WHERE `id` = '{$imgId}'";
                                $res21 = $db->query($query);
                                if (!empty($res21) && isset($res21, $res21[0], $res21[0]['url'])) {
                                    $resData['avatar'] = $res21[0]['url'];
                                }
                            }
                            //
                            $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Resp data: ' . var_export($resData, true);
                            error_log( $msg );
                            //
                            if (!headers_sent()) {
                                header('Content-Type: text/plain; charset=utf-8');
                            }
                            echo json_encode($resData);
                        }
                    }
                }
            }
        }
    } elseif (isset($_POST['action'])
        && ($_POST['action'] == 'set_status')
    ) { // Save manager status
        $attrValue = intval($_POST['value']);
        $userId = intval($_POST['user_id']);
        //
        $query = "SELECT * FROM `Auth_User` WHERE `id` = '{$userId}'";
        $res22 = $db->query($query);
        $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Got db result: ' . var_export($res22, true);
        error_log( $msg );
        //
        $res23 = false;
        if (!empty($res22) && isset($res22, $res22[0], $res22[0]['status'])) {
            $query = "UPDATE `Auth_User` SET `status` = '0' WHERE `id` = '{$userId}'";
            $res23 = $db->query($query);
        }
        if (!headers_sent()) {
            header('Content-Type: text/plain; charset=utf-8');
        }
        echo $res23;
    } elseif (isset($_POST['action'])
        && ($_POST['action'] == 'auth_as_superadmin')
    ) { // Check if current user has role superadmin
        $user = app()->getService('session')->getUser();
        if (!empty($user)) {
            app()->getService('session')->checkUser();
            $userId = intval($user->getId());
            $query = "SELECT * FROM `user_role` WHERE `user_id` = '{$userId}'";
            $res24 = $db->query($query);
            $res25 = false;
            if (is_array($res24) && !empty($res24)) {
                foreach ($res24 as $n9 => $ur) {
                    if ($ur['role_id'] == 'admin') {
                        $res25 = true;
                        break;
                    }
                }
            }
            if (!headers_sent()) {
                header('Content-Type: text/plain; charset=utf-8');
            }
            $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' $res25: ' . var_export($res25, true);
            error_log( $msg );
            echo $res25;
        }
    } elseif (isset($_POST['action'])
        && ($_POST['action'] == 'free_memory')
    ) { // Request free server memory

        $res91 = false;
        $restartServerFile = '/home/inventure/data/server-memory/restart.txt';
        if (touch($restartServerFile)) {
            $res91 = 'Free memory requested at: ' . date('Y-m-d H:i');
        }

        $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' $res91: ' . var_export($res91, true);
        error_log( $msg );

        if (!headers_sent()) {
            header('Content-Type: text/plain; charset=utf-8');
        }
        echo $res91;

    } elseif (isset($_POST['action'])
        && ($_POST['action'] == 'check_slug')
    ) { // Check page slug to be uniq
        $res27 = true;
        $currUrl = $db->escape(trim($_POST['value']));
        $pageId = $db->escape(trim($_POST['page_id']));
        //
        if (empty($currUrl) || $pageId === 'add') {
            $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Can`t use empty URL or wrong page id value: ' . var_export($pageId, true);
            error_log( $msg );
            //
            $res27 = false;
            if (!headers_sent()) {
                header('Content-Type: text/plain; charset=utf-8');
            }
            echo $res27;
        }
        //
        if ($pageId !== 'add') {
            $query = "SELECT * FROM `Page` WHERE `subpath` = '{$currUrl}' AND `id` <> '{$pageId}'";
        } else {
            $query = "SELECT * FROM `Page` WHERE `subpath` = '{$currUrl}'";
        }
        //
        $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' SQL: ' . $query;
        error_log( $msg );
        //
        $res26 = $db->query($query);
        //
        $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' DB result: ' . var_export($res26, true);
        error_log( $msg );
        //
        if (isset($res26, $res26[0]) && is_array($res26[0]) && (count($res26[0]) > 0)) {
            $res27 = false;
        }
        if (!headers_sent()) {
            header('Content-Type: text/plain; charset=utf-8');
        }
        //
        $msg = date('r') . ' ' . __FILE__ . ' +' . __LINE__ . ' Return result: ' . var_export($res27, true);
        error_log( $msg );
        //
        echo $res27;
    }
}
