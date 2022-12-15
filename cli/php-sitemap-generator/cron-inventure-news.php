<?php

include "vendor/autoload.php";

$yourSiteUrl = 'https://inventure.com.ua';

// Setting the current working directory to be output directory
// for generated sitemaps (and, if needed, robots.txt)
// The output directory setting is optional and provided for demonstration purposes.
// The generator writes output to the current directory by default.
$outputDir = getcwd();

// $generator = new \Icamys\SitemapGenerator\SitemapGenerator($yourSiteUrl, $outputDir);

// Create a compressed sitemap
// $generator->enableCompression();

// Determine how many urls should be put into one file;
// this feature is useful in case if you have too large urls
// and your sitemap is out of allowed size (50Mb)
// according to the standard protocol 50000 urls per sitemap
// is the maximum allowed value (see http://www.sitemaps.org/protocol.html)
// $generator->setMaxUrlsPerSitemap(50000);

// Set the sitemap file name
// $generator->setSitemapFileName("news-sitemap.xml");

// Set the sitemap index file name
// $generator->setSitemapIndexFileName("news-sitemap-index.xml");

$saveNewSitemap = false;

$sitemapXml = '<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
        xmlns:news="http://www.google.com/schemas/sitemap-news/0.9">';

// For each language
$langs = ['en', 'uk', 'ru'];
foreach ($langs as $lang) {
    $newsFileName = 'news_' . $lang . '.txt';
    if (file_exists($newsFileName)) {
        $fileData = file_get_contents($newsFileName);
        if (!empty($fileData)) {
            $newsData = unserialize($fileData);
            if (is_array($newsData) && !empty($newsData)) {
                foreach ($newsData as $n1) {
                    $lastMod = new DateTime();
                    if (isset($n1['lastmod']) && !empty($n1['lastmod'])) {
                        $lastMod = new DateTime($n1['lastmod']);
                    }
                    // $location = str_replace($yourSiteUrl . $yourSiteUrl, $yourSiteUrl, $n1['loc']);
                    $location = $yourSiteUrl . $n1['loc'];
                    // $generator->addURL($location, $lastMod, null, null, null);
                    $sitemapXml .= '  <url>
   <loc>' . $location . '</loc>
   <news:news>
   <news:publication>
     <news:name>' . $n1['h1'] . '</news:name>
     <news:language>' . $lang . '</news:language>
   </news:publication>
   <news:publication_date>' . $lastMod->format('Y-m-d') . '</news:publication_date>
     <news:title>' . $n1['h1'] . '</news:title>
    </news:news>
  </url>';
                    $saveNewSitemap = true;
                }
            }
        }
    }
}
$sitemapXml .= '</urlset>';
if ($saveNewSitemap && file_put_contents($outputDir . '/news-sitemap.xml', $sitemapXml)) {
    echo ' Wrote news sitemap to file: ' . $outputDir . '/news-sitemap.xml' . PHP_EOL;
}

// Flush all stored urls from memory to the disk and close all necessary tags.
// $generator->flush();

// Move flushed files to their final location. Compress if the option is enabled.
// $generator->finalize();

// Update robots.txt file in output directory or create a new one
// $generator->updateRobots();

// Submit your sitemaps to Google, Yahoo, Bing and Ask.com
// $generator->submitSitemap();