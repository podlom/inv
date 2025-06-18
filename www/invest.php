<?php

/**
 * Created by PhpStorm
 * User: shtaras
 * Date: 2020-04-18
 * Time: 07:38
 * Updated: 2025-05-27 18:21
 *
 * @author Taras Shkodenko <taras.shkodenko@gmail.com>
 */

require_once 'lib/functions.php';
require_once dirname(__FILE__) . '/../vendor/autoload.php';
require_once realpath(__DIR__ . '/../bootstrap.php');


use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;
use Symfony\Component\Yaml\Yaml;


// const MAX_PAGER_SIZE = 25;
const DEFAULT_LIMIT = 24;


$app_name = trim(file_get_contents(__DIR__ . '/../app_id'));
$app = new Skynar\Application($app_name, realpath(__DIR__ . '/../'), __DIR__);
try {
    $app->init();
} catch (Throwable $e) {
    echo $app->getService('template')->renderException($e);
}

$debugSql = 0;
$resHmtl = '';
$lang = 'ru';
$urlLangPrefix = '';
$sqlPath = '/investments';
if (!empty($_SERVER['HTTP_REFERER'])) {
    $urlPath = parse_url($_SERVER['HTTP_REFERER'], PHP_URL_PATH);

    $msg = __FILE__ . ' +' . __LINE__ . ' HTTP_REFERER PHP_URL_PATH: ' . var_export($urlPath, true);
    l_m($msg);
    
    
    $parentCategoryId = getParentCategoryIdByHref($urlPath);
    l_m(__FILE__ . ' +' . __LINE__ . ' $parentCategoryId: ' . var_export($parentCategoryId, true) . PHP_EOL);


    if (($urlPath === '/en/investments')
        || preg_match('%/en/investments/(.*)%s', $urlPath)
    ) {
        $sqlPath = '/en/investments';
        $lang = 'en';
        $urlLangPrefix = '/' . $lang;
    }
    elseif (($urlPath === '/uk/investments')
        || preg_match('%/uk/investments/(.*)%s', $urlPath)
    ) {
        $sqlPath = '/uk/investments';
        $lang = 'uk';
        $urlLangPrefix = '/' . $lang;
    }
    $msg = __FILE__ . ' +' . __LINE__ . ' $sqlPath: ' . var_export($sqlPath, true);
    l_m($msg);
}

$msg = __FILE__ . ' +' . __LINE__ . ' $lang: ' . var_export($lang, true);
l_m($msg);

if (!empty($_REQUEST)) {
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

    $msg = __FILE__ . ' +' . __LINE__ . ' $_SERVER: ' . var_export($_SERVER, true) . ' $_GET: ' . var_export($_GET, true) . '; $_POST: ' . var_export($_POST, true) . '; $_REQUEST: ' . var_export($_REQUEST, true);
    l_m($msg);

    if (isset($_POST, $_POST['subscribe']) && is_array($_POST['subscribe']) && !empty($_POST['subscribe'])) { // Mail subscribe form handler
        $resHmtl = addMailSubscriber($_POST, $db);
        if (!headers_sent()) {
            header('Access-Control-Allow-Origin: *');
            header('Content-Type: text/html; charset=utf-8');
        }
        die($resHmtl);
    }

    if (isset($_POST, $_POST['sf_approach']) && is_array($_POST['sf_approach']) && !empty($_POST['sf_approach'])) { // Add investment proposal
        $sFormData = serialize($_POST['sf_approach']);
        $formData = array_merge(['formData' => $sFormData], ['formName' => 'sf_approach', 'formUri' => '/form/approach']);
        $rs9 = _sendFormRequest($formData, false);
        if ($rs9 !== false) {
            sendMailForm($_POST['sf_approach'], 'info@inventure.ua', 'InVenture form submission');

            if (isset($_POST['sf_approach']['latel_deal_name']) && !empty($_POST['sf_approach']['latel_deal_name'])) {
                $formName = $_POST['sf_approach']['latel_deal_name'];
                if ($formName != 'Рекламное продвижение') {
                    $formType = 2;
                } else {
                    $formType = 1;
                }
            } else {
                $formName = 'Рекламное продвижение';
                $formType = 1;
            }
            if (isset($_POST['sf_approach']['email']) && !empty($_POST['sf_approach']['email'])) {
                sendAddInvPropMail($_POST['sf_approach'], $_POST['sf_approach']['email'], 'InVenture заполнена форма ' . $formName, $formType);
            }
        }
    }

    if (isset($_POST, $_POST['sf_investor']) && is_array($_POST['sf_investor']) && !empty($_POST['sf_investor'])) { // Add investment proposal

        l_m(__FILE__ . ' +' . __LINE__ . ' @ts original $_POST: ' . var_export($_POST, true));

        if (
            ($_POST['sf_investor']['email'] == 'friedenspfeifen@omggreatfoods.com')
            || ($_POST['sf_investor']['email'] == 'hatty2001@murahpanel.com')
            || ($_POST['sf_investor']['email'] == 'stevescan@24hinbox.com')
            || ($_POST['sf_investor']['email'] == 'testing@example.com')
        ) {
            l_m(__FILE__ . ' +' . __LINE__ . ' @ts banned user with request data: ' . var_export($_POST['sf_investor'], true));
            die('User with email ' . $_POST['sf_investor']['email'] . ' has been banned.');
        }

        $sFormData = serialize($_POST);
        $formData = array_merge(['formData' => $sFormData], ['formName' => 'sf_investor', 'formUri' => '/form/investor']);
        $rs8 = _sendFormRequest($formData, false);
        if ($rs8 !== false) {
            if (isset($_POST['skip_captcha_validation']) && ($_POST['skip_captcha_validation'] == 1)) {
                $cloudflareCaptchaValid = true;
            } else {
                $cloudflareCaptchaValid = _validateCloudflareCaptcha($_POST['cf-turnstile-response']);
            }
            if ($cloudflareCaptchaValid) {
                sendMailForm($_POST['sf_investor'], 'info@inventure.ua', 'InVenture form submission');
            }
        }
    }

    if (
        isset($_REQUEST, $_REQUEST['sf_investment_callback'])
        && is_array($_REQUEST['sf_investment_callback'])
        && !empty($_REQUEST['sf_investment_callback'])
    ) { // Add investment proposal

        l_m(__FILE__ . ' +' . __LINE__ . ' @ts original $_REQUEST: ' . var_export($_REQUEST, true));

        if (
            ($_REQUEST['sf_investment_callback']['email'] == 'friedenspfeifen@omggreatfoods.com')
            || ($_REQUEST['sf_investment_callback']['email'] == 'hatty2001@murahpanel.com')
            || ($_REQUEST['sf_investment_callback']['email'] == 'stevescan@24hinbox.com')
            || ($_REQUEST['sf_investment_callback']['email'] == 'testing@example.com')
        ) {
            l_m(__FILE__ . ' +' . __LINE__ . ' @ts banned user with $_REQUEST: ' . var_export($_REQUEST, true));
            die('User with email ' . $_REQUEST['sf_investment_callback']['email'] . ' has been banned.');
        }

        // [ Added extra SPAM protection for first and last name fields
        // Fetch the first name from the request
        $firstName = $_REQUEST['sf_investment_callback']['firstname'] ?? '';
        $filteredFirstName = filterNameValueForHubspot($firstName);
        $_REQUEST['sf_investment_callback']['firstname'] = $filteredFirstName;
        //
        $lastName = $_REQUEST['sf_investment_callback']['lastname'] ?? '';
        $filteredLastName = filterNameValueForHubspot($lastName);
        $_REQUEST['sf_investment_callback']['lastname'] = $filteredLastName;
        // ]
        l_m(__FILE__ . ' +' . __LINE__ . ' @ts fixed $_REQUEST: ' . var_export($_REQUEST, true));

        $sFormData = serialize($_REQUEST['sf_investment_callback']);
        $formData = array_merge(['formData' => $sFormData], ['formName' => 'sf_investment_callback', 'formUri' => '/form/investment_callback']);
        $rs7 = _sendFormRequest($formData, false);
        if ($rs7 !== false) {
            if (isset($_REQUEST['skip_captcha_validation']) && ($_REQUEST['skip_captcha_validation'] == 1)) {
                $cloudflareCaptchaValid = true;
            } else {
                $cloudflareCaptchaValid = _validateCloudflareCaptcha($_REQUEST['cf-turnstile-response']);
            }
            if ($cloudflareCaptchaValid) {
                sendMailForm($_REQUEST['sf_investment_callback'], 'info@inventure.ua', 'InVenture form submission');
            }

            if (!empty($_SERVER['HTTP_REFERER'])) {
                $p99 = strpos($_SERVER['HTTP_REFERER'], '?');
                l_m(__FILE__ . ' +' . __LINE__ . ' $p99: ' . var_export($p99, true));

                $redirectTo = $_SERVER['HTTP_REFERER'];
                if ($p99 !== false) {
                    $redirectTo .= '&contactSent=1#contact-form-19';
                } else {
                    $redirectTo .= '?contactSent=1#contact-form-19';
                }

                l_m(__FILE__ . ' +' . __LINE__ . ' Make reirect to: ' . var_export($redirectTo, true));
                die('<meta http-equiv="refresh" content="2; url=' . $redirectTo . '">');
            }
        }
    }

    if (isset($_POST, $_POST['sf_msb_form1']) && is_array($_POST['sf_msb_form1']) && !empty($_POST['sf_msb_form1'])) {
        if (!isset($_POST['sf_msb_form1']['latel_deal_name'])) {
            $_POST['sf_msb_form1']['latel_deal_name'] = 'MSB Callback';
        }
        $sFormData = serialize($_POST['sf_msb_form1']);
        $formData = array_merge(['formData' => $sFormData], ['formName' => 'sf_msb_form1', 'formUri' => '/form/msb_form1']);
        $rs6 = _sendFormRequest($formData, false);
        if ($rs6 !== false) {
            sendMailForm($_POST['sf_msb_form1'], 'yuriikantordrabkin1+rnrsnorabrmpbqizxyqs@boards.trello.com', 'Лид форма');
        }
    }

    if (isset($_POST, $_POST['sf_msb_form2']) && is_array($_POST['sf_msb_form2']) && !empty($_POST['sf_msb_form2'])) {
        if (!isset($_POST['sf_msb_form2']['latel_deal_name'])) {
            $_POST['sf_msb_form2']['latel_deal_name'] = 'MSB Quiz';
        }
        $sFormData = serialize($_POST['sf_msb_form2']);
        $formData = array_merge(['formData' => $sFormData], ['formName' => 'sf_msb_form2', 'formUri' => '/form/msb_form2']);
        $rs5 = _sendFormRequest($formData, false);
        if ($rs5 !== false) {
            sendMailForm($_POST['sf_msb_form2'], 'yuriikantordrabkin1+rnrsnorabrmpbqizxyqs@boards.trello.com', 'Квиз');
        }
    }

    if (isset($_REQUEST['action']) && ($_REQUEST['action'] == 'get')) { // Get data action
        if (isset($_REQUEST['debugSql']) && $_REQUEST['debugSql'] == 1) {
            $debugSql = 1;
        }

        if (isset($_REQUEST['href']) && !empty($_REQUEST['href'])) {
            $url2Parse = $_REQUEST['href'];
            $u1 = parse_url($url2Parse);
            // l_m(__FILE__ . ' +' . __LINE__ . ' parsed URL: ' . var_export($u1, true));
            parse_str($url2Parse, $p1);
            // l_m(__FILE__ . ' +' . __LINE__ . ' URL params: ' . var_export($p1, true));
            //
            $price2 = array_pop($p1);
            // l_m(__FILE__ . ' +' . __LINE__ . ' $price2: ' . var_export($price2, true) . '; other URL params: ' . var_export($p1, true));
            $price1 = array_pop($p1);
            // l_m(__FILE__ . ' +' . __LINE__ . ' $price1: ' . var_export($price1, true) . '; other URL params: ' . var_export($p1, true));
            $region = array_pop($p1);
            // l_m(__FILE__ . ' +' . __LINE__ . ' $region: ' . var_export($region, true) . '; other URL params: ' . var_export($p1, true));
            // $uregion = array_pop($p1);
            // l_m( __FILE__ . ' +' . __LINE__ . ' $uregion: ' . var_export($uregion, true) . '; other URL params: ' . var_export($p1, true) );
            $filter = array_pop($p1);
            // l_m(__FILE__ . ' +' . __LINE__ . ' $filter: ' . var_export($filter, true) . '; other URL params: ' . var_export($p1, true));
            $cat = array_pop($p1);
            // l_m(__FILE__ . ' +' . __LINE__ . ' $cat: ' . var_export($cat, true) . '; other URL params: ' . var_export($p1, true));
        }

        if (isset($_REQUEST['price1']) && !empty($_REQUEST['price1'])) {
            $price1 = intval($_REQUEST['price1']);
            l_m(__FILE__ . ' +' . __LINE__ . ' $price1: ' . var_export($price1, true));
        }

        if (isset($_REQUEST['price2']) && !empty($_REQUEST['price2'])) {
            $price2 = intval($_REQUEST['price2']);
            l_m(__FILE__ . ' +' . __LINE__ . ' $price2: ' . var_export($price2, true));
        }

        if (isset($_REQUEST['limit'])) {
            $limit = intval($_REQUEST['limit']);
            l_m(__FILE__ . ' +' . __LINE__ . ' $limit set to: ' . var_export($limit, true));
        } else {
            $limit = DEFAULT_LIMIT;
            l_m(__FILE__ . ' +' . __LINE__ . ' default $limit set to: ' . var_export($limit, true));
        }

        if (isset($_REQUEST['page'])) {
            $page = intval($_REQUEST['page']);
            /* if ($page > MAX_PAGER_SIZE) {
                $page = MAX_PAGER_SIZE;
            } */
            $offset = ($page - 1) * $limit;
        } else {
            $page = 1;
            $offset = 0;
        }

        $priceSql = '';
		$minPrice = isset($p1['price1']) && is_numeric($p1['price1']) ? (int) $p1['price1'] : null;
		$maxPrice = isset($p1['price2']) && is_numeric($p1['price2']) ? (int) $p1['price2'] : null;
		$conditions = [];
		if (!is_null($minPrice)) {
			$conditions[] = "CAST(JSON_UNQUOTE(JSON_EXTRACT(p0_.attr, '$.attr15')) AS UNSIGNED) >= {$minPrice}";
		}
		if (!is_null($maxPrice)) {
			$conditions[] = "CAST(JSON_UNQUOTE(JSON_EXTRACT(p0_.attr, '$.attr15')) AS UNSIGNED) <= {$maxPrice}";
		}
		if (!empty($conditions)) {
			// Загальна умова з перевіркою на наявність значення
			$priceSql = " AND JSON_UNQUOTE(JSON_EXTRACT(p0_.attr, '$.attr15')) IS NOT NULL AND JSON_UNQUOTE(JSON_EXTRACT(p0_.attr, '$.attr15')) != ''";
			$priceSql .= ' AND ' . implode(' AND ', $conditions);
		}

        $categoryMap = [
            'projects' => 7860,
            'business' => 7861,
            'realestate' => 7862,
            'land' => 7863,
            'offer' => 7864,
            'franchising' => 19303,
        ];
        if ($lang == 'uk') {
            $categoryMap = [
                'projects' => 25261,
                'business' => 25262,
                'realestate' => 25264,
                'land' => 25265,
                'offer' => 25266,
                'franchising' => 25267,
            ];
        } elseif ($lang == 'en') {
            $categoryMap = [
                'projects' => 9778,
                'business' => 9779,
                'realestate' => 9780,
                'land' => 9781,
                'offer' => 9782,
                'franchising' => 19304,
                'en_franchising' => 19304,
            ];
        }
        l_m(__FILE__ . ' +' . __LINE__ . ' $categoryMap: ' . var_export($categoryMap, true) . PHP_EOL);

        $fixPriceFilter = false;
        $parentCategoryWhere = '';

        if (isset($_REQUEST['parent']) && !empty($_REQUEST['parent'])) {
            if (isset($categoryMap[$_REQUEST['parent']]) && !empty($categoryMap[$_REQUEST['parent']])) {
                $parentCategoryWhere .= ' AND p0_.parent_id = "' . $categoryMap[$_REQUEST['parent']] . '" ';
            } else {
                $parentCategoryWhere .= ' AND p0_.parent_id = "' . intval($_REQUEST['parent']) . '" ';
            }
        }

        if (
            isset($cat, $cat['category'], $cat['category']['parent'])
            && is_array($cat)
            && !empty($cat['category']['parent'])
        ) {
            if (isset($categoryMap[$cat['category']['parent']]) && !empty($categoryMap[$cat['category']['parent']])) {
                $parentCategoryWhere .= ' AND p0_.parent_id = "' . $categoryMap[$cat['category']['parent']] . '" ';
            } else {
                $parentCategoryWhere .= ' AND p0_.parent_id = "' . intval($cat['category']['parent']) . '" ';
            }
        }
        if (isset($region, $region['category'], $region['category']['parent']) && !empty($region['category']['parent'])) {
            if (isset($categoryMap[$region['category']['parent']]) && !empty($categoryMap[$region['category']['parent']])) {
                $parentCategoryWhere .= ' AND p0_.parent_id = "' . $categoryMap[$region['category']['parent']] . '" ';
            } else {
                $parentCategoryWhere .= ' AND p0_.parent_id = "' . intval($region['category']['parent']) . '" ';
            }
        }
        if (isset($_REQUEST['filter'], $_REQUEST['filter']['category'], $_REQUEST['filter']['category']['parent']) && !empty($_REQUEST['filter']['category']['parent'])) {
            if (isset($categoryMap[$_REQUEST['filter']['category']['parent']]) && !empty($categoryMap[$_REQUEST['filter']['category']['parent']])) {
                if ($_REQUEST['filter']['category']['parent'] == 'projects') {
                    $fixPriceFilter = true;
                }
                $parentCategoryWhere .= ' AND p0_.parent_id = "' . $categoryMap[$_REQUEST['filter']['category']['parent']] . '" ';
            } else {
                if ($_REQUEST['filter']['category']['parent'] == 'projects') {
                    $fixPriceFilter = true;
                }
                $parentCategoryWhere .= ' AND p0_.parent_id = "' . intval($_REQUEST['filter']['category']['parent']) . '" ';
            }
        }

        if (empty($parentCategoryWhere)) {
            if (!empty($parentCategoryId)) {
                $parentCategoryWhere .= ' AND p0_.parent_id = "' . $parentCategoryId . '" ';
            }
        }
        l_m(__FILE__ . ' +' . __LINE__ . ' $parentCategoryWhere: ' . $parentCategoryWhere . PHP_EOL);
        l_m(__FILE__ . ' +' . __LINE__ . ' $fixPriceFilter: ' . var_export($fixPriceFilter, true) . PHP_EOL);

        $filterRegionWhere = '';
        
        if (isset($region, $region['attr_10']) && !empty($region['attr_10'])) {
            $filterRegionWhere = ' AND p0_.attr LIKE "%' . urldecode($region['attr_10']) . '%" ';
        }
        if (isset($filter) && is_string($filter) && !empty($filter)) {
            $filterRegionWhere = ' AND p0_.attr LIKE "%' . urldecode($filter) . '%" ';
        }
        if (isset($_REQUEST['filter'], $_REQUEST['filter']['attr_10']) && !empty($_REQUEST['filter']['attr_10'])) {
            $decodedFilterVal = urldecode($_REQUEST['filter']['attr_10']);
            $p9 = strpos($decodedFilterVal, ', ');
            if ($p9 !== false) {
                $regionParts = explode(', ', $decodedFilterVal);
                if (is_array($regionParts) && !empty($regionParts)) {
                    if (count($regionParts) > 1) {
                        $filterRegionWhere .= ' AND ( ';
                        $s9 = '';
                        foreach ($regionParts as $reg9) {
                            $filterRegionWhere .= $s9 . ' p0_.attr LIKE "%' . $reg9 . '%" ';
                            $s9 = ' OR ';
                        }
                        $filterRegionWhere .= ' ) ';
                    } else {
                        $filterRegionWhere = ' AND p0_.attr LIKE "%' . $regionParts[0] . '%" ';
                    }
                }
            }
        }
        l_m(__FILE__ . ' +' . __LINE__ . ' $filterRegionWhere: ' . $filterRegionWhere . PHP_EOL);

        $filterSoldWhere = '';
        if (isset($_REQUEST['is_sold']) && ($_REQUEST['is_sold'] == '1')) {
            $filterSoldWhere = ' AND p0_.`attr` LIKE \'%"attr58":"1"%\' ';
        }

        $filterBranchWhere = '';		
		$values = [];
		if (!empty($_REQUEST['filter']['attr_16'])) {
			foreach ($_REQUEST['filter']['attr_16'] as $v) {
				$v = trim($v);
				if ($v !== '' && is_numeric($v)) {
					$values[] = (int) $v;
				}
			}
		} elseif (!empty($filter['attr_16'])) {
			foreach ($filter['attr_16'] as $v) {
				$v = trim($v);
				if ($v !== '' && is_numeric($v)) {
					$values[] = (int) $v;
				}
			}
		}
		if (!empty($values)) {
			$jsonConditions = array_map(fn($val) =>
				"JSON_CONTAINS(JSON_EXTRACT(p0_.attr, '$.attr16'), '\"{$val}\"')", $values
			);

			$filterBranchWhere = ' AND (' . implode(' OR ', $jsonConditions) . ')';
		}
        l_m(__FILE__ . ' +' . __LINE__ . ' $filterBranchWhere: ' . $filterBranchWhere . PHP_EOL);

        $sqlAndWherePub0 = '';
        $sqlOrderBy = 'p0_.published DESC';
        if (isset($_REQUEST['filter'], $_REQUEST['filter']['sort']) && !empty($_REQUEST['filter']['sort'])) {
            switch ($_REQUEST['filter']['sort']) {
                case 'views':
                    $sqlOrderBy = 'a3_.views DESC';
                    // $sqlAndWherePub0 = ' AND p0_.published BETWEEN NOW() - INTERVAL 30 DAY AND NOW() ';
                    $sqlAndWherePub0 = ' AND p0_.published BETWEEN NOW() - INTERVAL 180 DAY AND NOW() ';
                    break;
                case 'rating':
                    $sqlOrderBy = 'a3_.rating DESC';
                    break;
            }
            l_m(__FILE__ . ' +' . __LINE__ . ' $sqlOrderBy: ' . $sqlOrderBy . PHP_EOL);
        }

        $minp = 9999999; // Минимальна цена инвестиций
        $num = $maxp = 0; // Максимальная цена инвестиций

        $query = "SELECT SQL_CALC_FOUND_ROWS p0_.id AS id, " .
            " p0_.h1 AS h1, " .
            " p0_.status AS status, " .
            " p0_.deleted AS deleted, " .
            " p0_.published AS published, " .
            " p0_.short_text AS short_text, " .
            " p0_.subpath AS subpath, " .
            " p0_.created AS created, " .
            " p0_.updated AS updated, " .
            " p0_.attr AS attr, " .
            " p0_.class AS class, " .
            " p0_.image_id AS image_id, " .
            " p2_.url AS image_url, " .
            " p0_.user_id AS user_id, " .
            " p0_.route_id AS route_id, " .
            " a3_.views AS views_1, " .
            " a3_.rating AS rating_2, " .
            " p0_.parent_id AS parent_id " .
            " FROM Page p0_ " .
            " INNER JOIN Routing r1_ ON p0_.route_id = r1_.id " .
            " LEFT JOIN PagePart p2_ ON p0_.image_id = p2_.id AND p2_.type IN ('4') " .
            " LEFT JOIN Analytics_Page a3_ ON p0_.id = a3_.page_id " .
            " WHERE (r1_.path LIKE '{$sqlPath}' AND p0_.status = 1 {$sqlAndWherePub0}) " .
            $priceSql .
            $parentCategoryWhere .
            $filterRegionWhere .
            $filterBranchWhere .
            $filterSoldWhere .
            // " AND p0_.class IN ('16') " .
            " ORDER BY {$sqlOrderBy} " .
            " LIMIT {$limit} OFFSET {$offset}";

        if ($debugSql) {
            debugSql(__FILE__ . ' +' . __LINE__ . ' SQL: ' . $query . PHP_EOL);
        }

        $res2 = $db->query($query);
        $res4 = [];

        if (!empty($res2) && is_array($res2)) {
            foreach ($res2 as $a2) {
                $j2 = json_decode($a2['attr'], true);

                if (
                    isset($j2['attr16'], $j2['attr16'][0])
                    && !empty($j2['attr16'][0])
                    && isset($filter, $filter['attr_16'], $filter['attr_16'][0])
                    && !empty($filter['attr_16'][0])
                ) {
                    if ($j2['attr16'][0] != $filter['attr_16'][0]) {
                        l_m(__FILE__ . ' +' . __LINE__ . ' Skip item with wrong branch: ' . var_export($j2['attr16'][0], true) . '; filter value: ' . var_export($filter['attr_16'][0], true));
                        continue;
                    }
                }

                if (
                    !isset($j2['attr15'])
                    && (!empty($minPrice) || !empty($maxPrice))
                ) {
                    l_m(__FILE__ . ' +' . __LINE__ . ' Skip item with empty price then minPrice: ' . var_export($minPrice, true) . '; maxPrice: ' . var_export($maxPrice, true));
                    continue;
                }

                $priceStr = 'Договорная';
                if ($lang === 'en') {
                    $priceStr = 'Negotiable';
                } elseif ($lang == 'uk') {
                    $priceStr = 'Договірна';
                }

                if (isset($j2['attr15']) && !empty($j2['attr15'])) {
                    $priceStr = '$' . number_format($j2['attr15'], 0, ',', ' ');

                    if (isset($price1, $price2, $j2['attr15'])) {
                        l_m(__FILE__ . ' +' . __LINE__ . ' price1: ' . var_export($price1, true) . '; price: ' . var_export($j2['attr15'], true) . '; price2: ' . var_export($price2, true));
                    }
                    if ($fixPriceFilter) {
                        if (!empty($price1)) {
                            if (intval($j2['attr15']) < intval($price1) || intval($j2['attr34']) < intval($price1) ) {
                                l_m(__FILE__ . ' +' . __LINE__ . ' Skip item min price1: ' . var_export($price1, true) . '; project price: ' . var_export($j2['attr15'], true));
                                continue;
                            }
                        }
                        if (!empty($price2)) {
                            if (intval($j2['attr15']) > intval($price2) || intval($j2['attr34']) > intval($price2)) {
                                l_m(__FILE__ . ' +' . __LINE__ . ' Skip item max price2: ' . var_export($price2, true) . '; project price: ' . var_export($j2['attr15'], true));
                                continue;
                            }
                        }
                    } else {
                        if (!empty($price1)) {
                            if (intval($j2['attr15']) < intval($price1)) {
                                l_m(__FILE__ . ' +' . __LINE__ . ' Skip item min price1: ' . var_export($price1, true) . '; project price: ' . var_export($j2['attr15'], true));
                                continue;
                            }
                        }
                        if (!empty($price2)) {
                            if (intval($j2['attr15']) > intval($price2)) {
                                l_m(__FILE__ . ' +' . __LINE__ . ' Skip item max price2: ' . var_export($price2, true) . '; project price: ' . var_export($j2['attr15'], true));
                                continue;
                            }
                        }
                    }
                }

                $imgUrl = '/img/resize.375.225/images/noThumb.jpg';
                if (isset($a2['image_url']) && !empty($a2['image_url'])) {
                    $imgUrl = $a2['image_url'];
                }

                $placeHtml = '';
                if (isset($p1['filter'], $p1['filter']['attr_10']) && ($p1['filter']['attr_10'] == 'Украина')) {
                    $placeHtml .= '<img src="/i/ukraine.png">';
                }
                if (isset($a2['attr_10'], $j2['attr_10']['parts']) && !empty($j2['attr_10']['parts'])) {
                    $placeHtml .= ' ' . implode(', ', $j2['attr_10']['parts']);
                }

                $categoryHtml = '';
                if (isset($a2['parent_id']) && !empty($a2['parent_id'])) {
                    if ($a2['parent_id'] == '7860') {
                        $categoryHtml = '<a href="' . $urlLangPrefix . '/investments/projects"><img src="/i/projects.png" alt="">';
                        if ($lang === 'ru') { $categoryHtml .= 'Инвестиционные проекты и стартапы в Украине'; } else { $categoryHtml .= 'Investment Projects and Startups'; }
                        $categoryHtml .= '</a>';
                    } elseif ($a2['parent_id'] == '7861') {
                        $categoryHtml = '<a href="' . $urlLangPrefix . '/investments/business"><img src="/i/business.png" alt="">';
                        if ($lang === 'ru') { $categoryHtml .= 'Продажа бизнеса в Украине | продать бизнес'; } else { $categoryHtml .= 'Business for Sale'; }
                        $categoryHtml .= '</a>';
                    } elseif ($a2['parent_id'] == '7862') {
                        $categoryHtml = '<a href="' . $urlLangPrefix . '/investments/realestate"><img src="/i/realestate.png" alt="">';
                        if ($lang === 'ru') { $categoryHtml .= 'Коммерческая недвижимость в Украине'; } else { $categoryHtml .= 'Commercial Property'; }
                        $categoryHtml .= '</a>';
                    } elseif ($a2['parent_id'] == '7863') {
                        $categoryHtml = '<a href="' . $urlLangPrefix . '/investments/land"><img src="/i/land.png" alt="">';
                        if ($lang === 'ru') { $categoryHtml .= 'Земельные участки в Украине'; } else { $categoryHtml .= 'Land'; }
                        $categoryHtml .= '</a>';
                    } elseif ($a2['parent_id'] == '7864') {
                        $categoryHtml = '<a href="' . $urlLangPrefix . '/investments/offer"><img src="/i/offer.png" alt="">';
                        if ($lang === 'ru') { $categoryHtml .= 'Инвесторы в Украине: найти инвестора | поиск инвестора'; } else { $categoryHtml .= 'Investor Offers'; }
                        $categoryHtml .= '</a>';
                    } elseif ($a2['parent_id'] == '19303') {
                        $categoryHtml = '<a href="' . $urlLangPrefix . '/investments/franchising"><img src="/i/business.png" alt="">';
                        if ($lang === 'ru') { $categoryHtml .= 'Франчайзинг и франшизы в Украине'; } else { $categoryHtml .= 'Franchising'; }
                        $categoryHtml .= '</a>';
                    }
                }

                $dateFormatted = DateTime::createFromFormat('Y-m-d H:i:s', $a2['published'])->format('d.m.y');

                $isSold = 0;
                $soldHtml = '';
                if (isset($j2['attr58']) && ($j2['attr58'] == 1)) {
                    if ($lang === 'ru') {
                        if (($a2['parent_id'] == 7860) // 7860 | Инвестиционные проекты и стартапы в Украине
                            || ($a2['parent_id'] == 19303) // 19303 | Франчайзинг и франшизы в Украине
                            || ($a2['parent_id'] == 7864) // 7864 | Найти инвестора в Украине: ищу инвестора / поиск инвесторов
                        ) {
                            $soldHtml = '<div class="previewstatus preview__status" style="width:155px;">';
                            $soldHtml .= 'Реализовано';
                        } else {
                            $soldHtml = '<div class="previewstatus preview__status">';
                            $soldHtml .= 'Продано';
                        }
                    } elseif ($lang === 'uk') {
                        $soldHtml = '<div class="previewstatus preview__status">';
                        $soldHtml .= 'Продано';
                    } else {
                        $soldHtml = '<div class="previewstatus preview__status">';
                        $soldHtml .= 'Sold';
                    }
                    $soldHtml .= '</div>';
                    $isSold = 1;
                }

                $isChecked = 0;
                $checkedHtml = '';
                if (isset($j2['attr73']) && ($j2['attr73'] == 1)) {
                    if ($lang === 'ru') {
                        $checkedHtml = '<div class="ts-status-preview verified__status">';
                        $checkedHtml .= 'Проверено';
                    } elseif ($lang === 'uk') {
                        $checkedHtml = '<div class="ts-status-preview verified__status">';
                        $checkedHtml .= 'Перевірено';
                    } else {
                        $checkedHtml = '<div class="ts-status-preview verified__status">';
                        $checkedHtml .= 'Verified';
                    }
                    $checkedHtml .= '</div>';
                    $isChecked = 1;
                }
                
                $nextPageLink = '/invest.php?action=get&limit=23&page=' . ($page + 1);
                $isLast = $num === count($res2) - 1;
                $nextPageRequest = $isLast ? 'hx-get="' . $nextPageLink . '" hx-trigger="revealed" hx-indicator="#spinner" hx-swap="afterend"' : '';

                $resHmtl .= '<a href="' . $urlLangPrefix . '/investments/' . $a2['subpath'] . '"  class="cards__item project-' . $num . '" ' . $nextPageRequest . '>
                    <div class="cards__img-wrapper mb-2 parent_id-' . $a2['parent_id'] . ' lang-' . $lang . ' is-sold-' . $isSold . ' is-checked-' . $isChecked . '"> 
                    <div class="badges-wrapper">' .
                        $soldHtml .
                        $checkedHtml .
                    '</div>
                        <img class="cards__img lazyload" data-src="' . $imgUrl . '" alt="' . $a2['h1'] . '" src="' . $imgUrl . '">
                    </div>
                    <div class="opacity-75 text-sm w-full cards__meta pt-0 mt-0">' . $dateFormatted . '</div>
                    <h2 class="cards__title mt-0" itemprop="headline">' . $a2['h1'] . '</h2>

                    <div class="cards__meta flex justify-between mt-auto opacity-75 text-sm">
                        <div class="price-tag cards__date text-sm">' . $priceStr . '</div>
                        <div class="cards__meta-wrapper text-sm">
                            <div class="cards__meta-stat">
                                <svg width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M13.9631 5.36967C13.871 5.08618 13.6195 4.88548 13.3232 4.85867L9.28184 4.49177L7.68466 0.752449C7.56674 0.477725 7.29842 0.300415 6.99977 0.300415C6.70112 0.300415 6.4327 0.477725 6.31553 0.752449L4.71835 4.49177L0.67632 4.85867C0.38002 4.88602 0.129115 5.08672 0.0364013 5.36967C-0.0557786 5.65315 0.0293516 5.96408 0.253446 6.16062L3.30841 8.83939L2.40766 12.8067C2.34175 13.0984 2.45498 13.4 2.69701 13.575C2.82711 13.6695 2.97996 13.7167 3.13335 13.7167C3.26515 13.7167 3.39707 13.6817 3.51488 13.6112L6.99977 11.5275L10.484 13.6112C10.7396 13.7639 11.061 13.7499 11.3025 13.575C11.5446 13.4 11.6578 13.0984 11.5919 12.8067L10.6911 8.83939L13.7461 6.16062C13.9701 5.96408 14.0553 5.65379 13.9631 5.36967Z" fill="#808080"/>
                                </svg>
                                <div>' . intval($a2['rating_2']) . '</div>
                            </div>
                            <div class="cards__meta-stat">
                                <svg width="16" height="11" viewBox="0 0 16 11" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M8 0.0910645C2.61053 0.0910645 0 5.51478 0 5.51478C0 5.51478 2.59368 10.9385 8 10.9385C13.4063 10.9385 16 5.51478 16 5.51478C16 5.51478 13.3895 0.0910645 8 0.0910645ZM8 9.70889C5.67579 9.70889 3.80631 7.82238 3.80631 5.51478C3.80631 3.19033 5.69263 1.32066 8 1.32066C10.3074 1.32066 12.1937 3.20717 12.1937 5.51478C12.1937 7.83922 10.3242 9.70889 8 9.70889Z" fill="#808080"/>
                                    <path d="M9.97239 4.74104C9.31555 4.74104 8.77659 4.20209 8.77659 3.54525C8.77659 3.34314 8.82712 3.14104 8.92818 2.97262C8.64186 2.87157 8.32186 2.8042 8.00186 2.8042C6.50291 2.8042 5.27344 4.01683 5.27344 5.51577C5.27344 7.01472 6.48607 8.2442 8.00186 8.2442C9.50081 8.2442 10.7134 7.03156 10.7134 5.51577C10.7134 5.19577 10.6629 4.87577 10.545 4.58946C10.3934 4.69051 10.1913 4.74104 9.97239 4.74104Z" fill="#808080"/>
                                </svg>
                                <div>' . intval($a2['views_1']) . '</div>
                            </div>
                        </div>
                    </div>
                </a>';

/*
            $j2 = json_decode($a2['attr'], true);
            if (isset($j2['attr15'])) { // Price attribute found
                if (!empty($minPrice) && intval($j2['attr15']) >= $minPrice) {
                    if (intval($j2['attr15']) > $maxp) {
                        $maxp = intval($j2['attr15']);
                    }
                    if (intval($j2['attr15']) < $minp) {
                        $minp = intval($j2['attr15']);
                    }
                    $res4[] = $a2;
                    continue;
                }
                if (!empty($maxPrice) && intval($j2['attr15']) <= $maxPrice) {
                    if (intval($j2['attr15']) > $maxp) {
                        $maxp = intval($j2['attr15']);
                    }
                    if (intval($j2['attr15']) < $minp) {
                        $minp = intval($j2['attr15']);
                    }
                    $res4[] = $a2;
                }
            } else { // No price attribute found

            }
*/
                $res4[] = $a2;
                $num++;
            }
        }

        l_m(__FILE__ . ' +' . __LINE__ . ' $res4: ' . var_export($res4, true));
        $query = "SELECT FOUND_ROWS()";
        l_m(__FILE__ . ' +' . __LINE__ . ' SQL: ' . $query);
        $res3 = $db->query($query);
        l_m(__FILE__ . ' +' . __LINE__ . ' Result: ' . var_export($res3, true));

        if (
            isset($_REQUEST['type'])
            && ($_REQUEST['type'] == 'json')
        ) {
            $result = [
                'data' => $res4,
                // 'total' => intval($res3[0]['FOUND_ROWS()']),
                'total' => count($res4),
                'limit' => $limit,
                'page' => $page,
                'minp' => $minp,
                'maxp' => $maxp,
            ];
            l_m(__FILE__ . ' +' . __LINE__ . ' JSON result: ' . var_export($result, true));
            if (!headers_sent()) {
                header('Access-Control-Allow-Origin: *');
                header("Content-type: application/json; charset=utf-8");
            }
            die(json_encode($result));
        }
    } elseif (isset($_REQUEST['action']) && ($_REQUEST['action'] == 'set')) { // Set data action
        if (!empty($_REQUEST['path'])) {
            $p2 = explode('/', $_REQUEST['path']);
            $path = array_pop($p2);
            $query = "SELECT * FROM Page WHERE `subpath` = '{$path}'";
            $r99 = $db->query($query);
            if (isset($r99[0]['id'])) {
                $query = "SELECT * FROM PagePart WHERE `page_id` = '{$r99[0]['id']}' AND `name` = 'content' LIMIT 1";
                $r98 = $db->query($query);
                if (isset($r98[0]['id'])) {
                    $newText = $db->escape($_REQUEST['data']);
                    $query = "UPDATE PagePart SET `text` = '{$newText}' WHERE id = '{$r98[0]['id']}'";
                    $r97 = $db->query($query);
                    if ($r97 === true) {
                        $resHmtl .= '<p class="success">Изменения сохранены</p>';
                    }
                }
            }
        }
    }
}

if (!headers_sent()) {
    header('Access-Control-Allow-Origin: *');
    header('Content-Type: text/html; charset=utf-8');
}
die($resHmtl);
