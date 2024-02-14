<?php

// Функція для створення XML-структури для головного файлу sitemap.xml
function createSitemapIndex() {
    $sitemapIndex = new SimpleXMLElement('<?xml version="1.0" encoding="UTF-8"?><sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"></sitemapindex>');

    // Додати посилання на кожен окремий файл sitemap
    $sitemaps = ["sitemap-uk.xml", "sitemap-en.xml", "sitemap-ru.xml"];
    foreach ($sitemaps as $sitemap) {
        $sitemapNode = $sitemapIndex->addChild('sitemap');
        $sitemapNode->addChild('loc', 'https://inventure.com.ua/' . $sitemap);
        $sitemapNode->addChild('lastmod', date('c')); // Поточна дата та час
    }

    // Зберегти XML у файл
    $sitemapIndex->asXML('sitemap.xml');
}

// Викликати функцію для створення головного файлу sitemap.xml
createSitemapIndex();
