<?php

include "vendor/autoload.php";

$yourSiteUrl = 'https://inventure.com.ua';

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
$generator->setSitemapFileName("sitemap.xml");

// Set the sitemap index file name
$generator->setSitemapIndexFileName("sitemap-index.xml");

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
function getAlternates($urlPrefix, $uri)
{
    if (!empty($uri)) {
        return [
            ['hreflang' => 'uk', 'href' => $urlPrefix . "/uk" . $uri],
            ['hreflang' => 'en', 'href' => $urlPrefix . "/en" . $uri],
        ];
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

$changeFrequencyConfig = [
    '/add-inv-prop' => 'never',
    '/investor' => 'never',
    '/politika-konfidencialnosti' => 'never',
];
echo ' $changeFrequencyConfig: ' . var_export($changeFrequencyConfig, true) . PHP_EOL;

$generator->addURL('/', new DateTime(), $changeFrequencyDefault, 0.5, getAlternates($yourSiteUrl, ''));

$uri = [
    '/investments',
    '/news',
    '/analytics',
    '/about',
    '/about/advertising',
    '/investor',
    '/analytics/digest',
    // '/about/mediapartner',
    // '/about/team',
    '/tools/hr',
    '/about/contacts',
    '/about/faq',
    // '/project',
    // '/votes',
    // '/tools/calculator',
    '/tools/events',
    '/tools/video',
    '/add-inv-prop',
    '/tools/library',
    '/tools/database',
    '/analytics/we-invest-in-ukraine',
    '/analytics/formula',
    '/analytics/articles',
    '/analytics/investments',
    '/news/realestate',
    '/news/stock',
    '/news/banking',
    '/news/government',
    '/news/startup',
    '/news/investments',
    '/politika-konfidencialnosti',
];

if (!empty($uri)) {
    foreach ($uri as $u1) {
        echo 'Processing ' . $u1 . PHP_EOL;
        $changeFrequency = $changeFrequencyDefault;
        if (isset($changeFrequencyConfig[$u1])) {
            $changeFrequency = $changeFrequencyConfig[$u1];
        }
        echo ' $changeFrequency: ' . var_export($changeFrequency, true) . PHP_EOL;
        $generator->addURL($u1, new DateTime(), $changeFrequency, 0.5, getAlternates($yourSiteUrl, $u1));
    }
}

// Flush all stored urls from memory to the disk and close all necessary tags.
$generator->flush();

// Move flushed files to their final location. Compress if the option is enabled.
$generator->finalize();

// Update robots.txt file in output directory or create a new one
$generator->updateRobots();

// Submit your sitemaps to Google, Yahoo, Bing and Ask.com
$generator->submitSitemap();