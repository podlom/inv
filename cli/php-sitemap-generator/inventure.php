<?php

include "vendor/autoload.php";

$yourSiteUrl = 'https://inventure.com.ua';
echo ' yourSiteUrl: ' . var_export($yourSiteUrl, true) . PHP_EOL;

$langs = ['en', 'uk', 'ru'];
$langUrlPrefix = $lang = $defaultLang = '';
if (!empty($argv[1])) {
    echo ' arg lang: ' . var_export($argv[1], true) . PHP_EOL;

    if (!in_array($argv[1], $langs)) {
        $langUrlPrefix = $lang = $defaultLang;
    } else {
        $langUrlPrefix = $lang = $argv[1];
    }
} else {
    $langUrlPrefix = $lang = $defaultLang = 'uk';
}
echo ' selected lang: ' . var_export($lang, true) . PHP_EOL;
if ($langUrlPrefix == 'ru') {
    $langUrlPrefix = '';
} else {
    $langUrlPrefix = '/' . $langUrlPrefix;
}
echo ' langUrlPrefix: ' . var_export($langUrlPrefix, true) . PHP_EOL;

// Setting the current working directory to be output directory
// for generated sitemaps (and, if needed, robots.txt)
// The output directory setting is optional and provided for demonstration purposes.
// The generator writes output to the current directory by default.
$outputDir = getcwd();

$generator = new \Icamys\SitemapGenerator\SitemapGenerator($yourSiteUrl, $outputDir);

// Create a compressed sitemap
$generator->enableCompression();

// Determine how many urls should be put into one file;
// this feature is useful in case if you have too large urls
// and your sitemap is out of allowed size (50Mb)
// according to the standard protocol 50000 urls per sitemap
// is the maximum allowed value (see http://www.sitemaps.org/protocol.html)
$generator->setMaxUrlsPerSitemap(50000);

// Set the sitemap file name
$generator->setSitemapFileName("sitemap-{$lang}.xml");

// Set the sitemap index file name
$generator->setSitemapIndexFileName("sitemap-index-{$lang}.xml");

// Add alternate languages if needed
/* $alternates = [
    ['hreflang' => 'uk', 'href' => $yourSiteUrl . "/uk"],
    ['hreflang' => 'en', 'href' => $yourSiteUrl . "/en"],
]; */

/**
 * @param $urlPrefix
 * @param $uri
 * @return string[][]
 */
function getAlternates($urlPrefix, $uri, $currentLang = 'ru')
{
    if (!empty($uri)) {
        if ($currentLang !== 'ru') {
            $len = strlen($uri);
            if ($len >= 3) {
                $uri = substr($uri, 3, $len);
            }
        }

        switch ($currentLang) {
            case 'ru':
                return [
                    ['hreflang' => 'uk', 'href' => $urlPrefix . "/uk" . $uri],
                    ['hreflang' => 'en', 'href' => $urlPrefix . "/en" . $uri],
                ];
                break;
            case 'uk':
                return [
                    ['hreflang' => 'ru', 'href' => $urlPrefix . $uri],
                    ['hreflang' => 'en', 'href' => $urlPrefix . "/en" . $uri],
                ];
                break;
            case 'en':
                return [
                    ['hreflang' => 'ru', 'href' => $urlPrefix . $uri],
                    ['hreflang' => 'uk', 'href' => $urlPrefix . "/uk" . $uri],
                ];
                break;
        }
    }

    switch ($currentLang) {
        case 'ru':
            return [
                ['hreflang' => 'uk', 'href' => $urlPrefix . "/uk"],
                ['hreflang' => 'en', 'href' => $urlPrefix . "/en"],
            ];
            break;
        case 'uk':
            return [
                ['hreflang' => 'ru', 'href' => $urlPrefix],
                ['hreflang' => 'en', 'href' => $urlPrefix . "/en"],
            ];
            break;
        case 'en':
            return [
                ['hreflang' => 'ru', 'href' => $urlPrefix],
                ['hreflang' => 'uk', 'href' => $urlPrefix . "/uk"],
            ];
            break;
    }

    return [
        ['hreflang' => 'uk', 'href' => $urlPrefix . "/uk"],
        ['hreflang' => 'en', 'href' => $urlPrefix . "/en"],
    ];
}

// Add url components: `path`, `lastmodified`, `changefreq`, `priority`, `alternates`
// Instead of storing all urls in the memory, the generator will flush sets of added urls
// to the temporary files created on your disk.
// The file format is 'sm-{index}-{timestamp}.xml'
// $generator->addURL('/path/to/page/', new DateTime(), 'always', 0.5, $alternates);

$changeFrequencyDefault = 'always';
$priorityDefault = 0.5;

$changeFrequencyConfig = [
    '/add-inv-prop' => 'never',
    '/investor' => 'never',
    '/politika-konfidencialnosti' => 'never',
];
echo ' $changeFrequencyConfig: ' . var_export($changeFrequencyConfig, true) . PHP_EOL;

$generator->addURL($langUrlPrefix . '/', new DateTime(), $changeFrequencyDefault, $priorityDefault, getAlternates($yourSiteUrl, '', $lang));

$uri = [
    $langUrlPrefix . '/investments',
    $langUrlPrefix . '/news',
    $langUrlPrefix . '/analytics',
    $langUrlPrefix . '/about',
    $langUrlPrefix . '/about/advertising',
    $langUrlPrefix . '/investor',
    $langUrlPrefix . '/analytics/digest',
    // $langUrlPrefix . '/about/mediapartner',
    // $langUrlPrefix . '/about/team',
    $langUrlPrefix . '/tools/hr',
    $langUrlPrefix . '/about/contacts',
    $langUrlPrefix . '/about/faq',
    // $langUrlPrefix . '/project',
    // $langUrlPrefix . '/votes',
    // $langUrlPrefix . '/tools/calculator',
    $langUrlPrefix . '/tools/events',
    $langUrlPrefix . '/tools/video',
    $langUrlPrefix . '/add-inv-prop',
    $langUrlPrefix . '/tools/library',
    $langUrlPrefix . '/tools/database',
    $langUrlPrefix . '/analytics/we-invest-in-ukraine',
    $langUrlPrefix . '/analytics/formula',
    $langUrlPrefix . '/analytics/articles',
    $langUrlPrefix . '/analytics/investments',
    $langUrlPrefix . '/news/realestate',
    $langUrlPrefix . '/news/stock',
    $langUrlPrefix . '/news/banking',
    $langUrlPrefix . '/news/government',
    $langUrlPrefix . '/news/startup',
    $langUrlPrefix . '/news/investments',
    $langUrlPrefix . '/politika-konfidencialnosti',
];

if (!empty($uri)) {
    foreach ($uri as $u1) {
        echo ' Processing ' . $u1 . PHP_EOL;
        $changeFrequency = $changeFrequencyDefault;
        if (isset($changeFrequencyConfig[$u1])) {
            $changeFrequency = $changeFrequencyConfig[$u1];
        }
        echo ' $changeFrequency: ' . var_export($changeFrequency, true) . PHP_EOL;
        $priority = $priorityDefault;
        $generator->addURL($u1, new DateTime(), $changeFrequency, $priority, getAlternates($yourSiteUrl, $u1, $lang));
    }
}


// @ts 2024-02-13 process only one language
// foreach ($langs as $lang) {

$newsFileName = 'all_published_news_' . $lang . '.txt';
if (file_exists($newsFileName)) {
    $fileData = file_get_contents($newsFileName);
    if (!empty($fileData)) {
        $newsData = unserialize($fileData);
        if (is_array($newsData) && !empty($newsData)) {
            foreach ($newsData as $n1) {
                $changeFrequency = $changeFrequencyDefault;
                if (isset($n1['changefreq']) && !empty($n1['changefreq'])) {
                    $changeFrequency = $n1['changefreq'];
                }
                $priority = $priorityDefault;
                if (isset($n1['priority']) && !empty($n1['priority'])) {
                    $priority = $n1['priority'];
                }
                $lastMod = new DateTime();
                if (isset($n1['lastmod']) && !empty($n1['lastmod'])) {
                    $lastMod = new DateTime($n1['lastmod']);
                }
                $location = str_replace($yourSiteUrl . $yourSiteUrl, $yourSiteUrl, $n1['loc']);
                $generator->addURL($location, $lastMod, $changeFrequency, $priority, null);
            }
        }
    }
}
// @ts 2022-12-27 include all published analytics
$analyticsFileName = 'all_published_analytics_' . $lang . '.txt';
if (file_exists($analyticsFileName)) {
    $fileData = file_get_contents($analyticsFileName);
    if (!empty($fileData)) {
        $newsData = unserialize($fileData);
        if (is_array($newsData) && !empty($newsData)) {
            foreach ($newsData as $n1) {
                $changeFrequency = $changeFrequencyDefault;
                if (isset($n1['changefreq']) && !empty($n1['changefreq'])) {
                    $changeFrequency = $n1['changefreq'];
                }
                $priority = $priorityDefault;
                if (isset($n1['priority']) && !empty($n1['priority'])) {
                    $priority = $n1['priority'];
                }
                $lastMod = new DateTime();
                if (isset($n1['lastmod']) && !empty($n1['lastmod'])) {
                    $lastMod = new DateTime($n1['lastmod']);
                }
                $location = str_replace($yourSiteUrl . $yourSiteUrl, $yourSiteUrl, $n1['loc']);
                $generator->addURL($location, $lastMod, $changeFrequency, $priority, null);
            }
        }
    }
}

// }
// @ts 2024-02-13 process only one language


// Flush all stored urls from memory to the disk and close all necessary tags.
$generator->flush();

// Move flushed files to their final location. Compress if the option is enabled.
$generator->finalize();

// Update robots.txt file in output directory or create a new one
$generator->updateRobots();

// Submit your sitemaps to Google, Yahoo, Bing and Ask.com
$generator->submitSitemap();