<?php

/**
 * Created by PhpStorm
 * User: shtaras
 * Date: 2025-06-10
 * Time: 16:45
 * Updated: 2025-06-10 16:45
 *
 * @author Taras Shkodenko <taras.shkodenko@gmail.com>
 */

require_once 'lib/functions.php';
require_once dirname(__FILE__) . '/../vendor/autoload.php';
require_once realpath(__DIR__ . '/../bootstrap.php');

$app_name = trim(file_get_contents(__DIR__ . '/../app_id'));
$app = new Skynar\Application($app_name, realpath(__DIR__ . '/../'), __DIR__);
try {
    $app->init();
} catch (Throwable $e) {
    echo $app->getService('template')->renderException($e);
}

$resHmtl = '';
$lang = 'ru';
$limit = 34;
$offset = 0;
$sqlOrderBy = ' r0_.id ';
$h2 = '<span>Вот что говорят<br></span><span>о нас клиенты</span>';
$h3 = 'Отзывы наших клиентов — лучшее свидетельство нашей эффективности в сопровождении сделок продажи бизнеса, коммерческой недвижимости и привлечения инвестиций';

$msg = __FILE__ . ' +' . __LINE__ . ' $lang: ' . var_export($lang, true);
l_m($msg);

if (!empty($_REQUEST))
{
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

    if (isset($_REQUEST['lang']) && !empty($_REQUEST['lang']) && in_array($_REQUEST['lang'], ['ru', 'uk', 'en']))
    {
		$lang = $_REQUEST['lang'];
		$sqlAndWhereLang = ' AND r0_.lang = "' . $lang . '" ';
    }

    if ($lang == 'en') {
        $h2 = '<span>What Our Clients Say</span>';
        $h3 = 'Proven Results, Trusted by Clients! Our clients&apos; testimonials reflect the quality of our deal advisory in business exits, commercial real estate, and capital raising';
    } elseif ($lang == 'uk') {
        $h2 = '<span>Ось що кажуть<br></span><span>про нас клієнти</span>';
        $h3 = 'Відгуки наших клієнтів — найкраще свідчення нашої ефективності у супроводженні угод продажу бізнесу, комерційної нерухомості та залучення інвестицій';
    }

    if (isset($_REQUEST['action']) && ($_REQUEST['action'] == 'get')) 
    { // Get data action

    	$query = "SELECT SQL_CALC_FOUND_ROWS r0_.id AS id, " .
            " r0_.image_url AS image_url, " .
            " r0_.category AS category, " .
            " r0_.first_name AS first_name, " .
            " r0_.last_name AS last_name, " .
            " r0_.company AS company, " .
            " r0_.job AS job, " .
            " r0_.rtext AS rtext, " .
            " r0_.facebook_url AS facebook_url, " .
            " r0_.linkedin_url AS linkedin_url, " .
            " r0_.published AS published, " .
            " r0_.created AS created, " .
            " r0_.updated AS updated, " .
            " r0_.status AS status, " .
            " r0_.lang AS lang " .

            " FROM `review` r0_ " .
            " WHERE (r0_.status = 1 {$sqlAndWhereLang}) " .
            " ORDER BY {$sqlOrderBy} " .
            " LIMIT {$limit} OFFSET {$offset}";
        l_m(__FILE__ . ' +' . __LINE__ . ' SQL: ' . $query . PHP_EOL);
        $res911 = $db->query($query);
        // l_m( __FILE__ . ' +' . __LINE__ . ' Result: ' . var_export($res911, true) . PHP_EOL );

        if (!empty($res911) && is_array($res911))
        {
            $resHmtl .= '<section>' .
                '<div class="mx-auto mb-6 md:mb-8" data-aria-hidden="true" aria-hidden="true">' .
                    '<div class="container mx-auto flex items-end justify-between">' .
                        '<div class="flex flex-col"><h2 class="text-3xl md:text-4xl leading-none font-bold max-w-xs">' . $h2 .'</h2>' .
                            '<p class="max-w-lg mt-6 text-muted-foreground">' . $h3 . '</p>' .
                        '</div>' .
                    '</div>' .
                '</div>';

            foreach ($res911 as $a1)
            {
				$resHmtl .= '<div class="relative " data-aria-hidden="true" aria-hidden="true"><div class="relative mb-4 md:mb-8" role="region" aria-roledescription="carousel"><div class="overflow-hidden"><div class="flex mx-5 sm:mx-[calc((100vw-640px)/2+24px)] md:mx-[calc((100vw-768px)/2+24px)] lg:mx-[calc((100vw-1024px)/2+28px)] xl:mx-[calc((100vw-1280px)/2+28px)] 2xl:mx-[calc((100vw-96rem)/2+24px)]" style="transform: translate3d(-3200px, 0px, 0px);"><div role="group" aria-roledescription="slide" class="min-w-0 shrink-0 grow-0 basis-full max-w-[320px] pr-[20px] lg:max-w-[360px] pl-0">' .
						'<div class="group relative h-full max-w-full overflow-hidden ">' .
							'<div class="rounded-lg border text-card-foreground shadow-sm max-w-md mx-auto h-full bg-white/50 backdrop-blur-xl border-[#ECEEF0] transition-shadow duration-300"><div class="p-4 lg:p-6 h-full flex flex-col">' .
								'<div class="mb-4"><p class="text-gray-700 text-base leading-relaxed line-clamp-5">' . $a1['rtext'] . '</p><button class="text-[#286080] flex items-center gap-2 hover:text-[#286080]/80 text-sm font-medium mt-2 transition-colors focus:outline-none focus:ring-2 focus:ring-[#286080]/20 rounded">Читати повністю<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-arrow-right size-4" aria-hidden="true"><path d="M5 12h14"></path><path d="m12 5 7 7-7 7"></path></svg></button></div>' . 
									'<div class="w-full h-px bg-gray-200 mb-4"></div>' . 
										'<div class="mt-auto flex items-center space-x-4">' . 
											'<div class="flex-shrink-0"><img alt="' . $a1['first_name'] . ' ' . $a1['last_name'] . ' profile" class="w-16 h-16 rounded-full object-cover border-2 border-gray-200" src="' . $a1['image_url'] . '"></div>' . 
												'<div class="grid"><h3 class="text-lg font-semibold text-gray-900 leading-none truncate ">' . $a1['first_name'] . ' ' . $a1['last_name'] . '</h3><p class="text-sm text-gray-600 truncate ">' . $a1['job'] . ', ' . $a1['company'] . '</p>' .
												'<div class="flex space-x-2 mt-1.5"><a href="' . $a1['facebook_url'] . '" target="_blank" rel="noopener noreferrer" class="inline-flex items-center justify-center size-5 hover:opacity-80 transition-opacity"><img alt="Facebook" src="data:image/svg+xml,%3csvg%20xmlns=\'http://www.w3.org/2000/svg\'%20viewBox=\'0%200%2036%2036\'%20fill=\'url(%23a)\'%20height=\'40\'%20width=\'40\'%3e%3cdefs%3e%3clinearGradient%20x1=\'50%25\'%20x2=\'50%25\'%20y1=\'97.078%25\'%20y2=\'0%25\'%20id=\'a\'%3e%3cstop%20offset=\'0%25\'%20stop-color=\'%230062E0\'%20/%3e%3cstop%20offset=\'100%25\'%20stop-color=\'%2319AFFF\'%20/%3e%3c/linearGradient%3e%3c/defs%3e%3cpath%20d=\'M15%2035.8C6.5%2034.3%200%2026.9%200%2018%200%208.1%208.1%200%2018%200s18%208.1%2018%2018c0%208.9-6.5%2016.3-15%2017.8l-1-.8h-4l-1%20.8z\'%20/%3e%3cpath%20fill=\'%23FFF\'%20d=\'m25%2023%20.8-5H21v-3.5c0-1.4.5-2.5%202.7-2.5H26V7.4c-1.3-.2-2.7-.4-4-.4-4.1%200-7%202.5-7%207v4h-4.5v5H15v12.7c1%20.2%202%20.3%203%20.3s2-.1%203-.3V23h4z\'%20/%3e%3c/svg%3e"></a>' . 
											'</div>' .
										'</div>'.
									'</div>'.
								'</div>'.
							'</div>' . 
						'</div>' .
					'</div>';

            }
            $resHmtl .= '</section>';

        }
    }
}

if (!headers_sent())
{
    header('Access-Control-Allow-Origin: *');
    header('Content-Type: text/html; charset=utf-8');
}
die($resHmtl);
