<?php

(PHP_SAPI !== 'cli' || isset($_SERVER['HTTP_USER_AGENT'])) && die('CLI only' . PHP_EOL);

/**
 * CLI Tool to Add rel="nofollow" to external links
 * @author Taras Shkodenko <taras.shkodenko@gmail.com>
 */

require_once 'lib/db.class.php';

try {
    require_once 'config' . DIRECTORY_SEPARATOR . 'inv-prod-settings.php';
    $db = new DB(INV_PROD_DBHOST, INV_PROD_DBUSER, INV_PROD_DBPASS, INV_PROD_DBNAME);

    $db->query("SET collation_connection = utf8_unicode_ci");
    $db->query("SET NAMES utf8");
    $db->query("SET CHARACTER SET utf8");
    $db->query("SET @@collation_server = utf8_unicode_ci");

    $query = "
        SELECT pp.*, p.h1 as page_title
        FROM `PagePart` AS pp
        LEFT JOIN `Page` AS p ON p.id = pp.page_id
        WHERE (pp.`text` LIKE '%<a%' 
            AND pp.`text` LIKE '%href=\"http%' 
            AND pp.`text` NOT LIKE '%href=\"mailto:%' 
            AND pp.`text` NOT LIKE '%rel=\"nofollow\"%')
        ORDER BY rand()
        LIMIT 0, 1
    ";

    echo date('r') . ' SQL: ' . $query . PHP_EOL;

    $results = $db->query($query);

    if (!empty($results) && is_array($results)) {
        foreach ($results as $row) {
            $original = $row['text'];
            echo date('r') . ' Original: ' . PHP_EOL . $original . PHP_EOL;

            $newText = preg_replace_callback(
                '#<a\s+([^>]*?href="https?://[^"]+"[^>]*)>#i',
                function ($match) {
                    $aTag = $match[1];

                    // Отримаємо URL
                    if (preg_match('/href="([^"]+)"/i', $aTag, $hrefMatch)) {
                        $url = $hrefMatch[1];

                        // Якщо це inventure.com.ua — пропускаємо
                        $host = parse_url($url, PHP_URL_HOST);
                        if ($host && preg_match('/(^|\.)inventure\.com\.ua$/i', $host)) {
                            return '<a ' . $aTag . '>';
                        }
                    }

                    // Якщо є rel – додаємо nofollow
                    if (stripos($aTag, 'rel=') !== false) {
                        return preg_replace_callback(
                            '/rel=["\']([^"\']*)["\']/i',
                            function ($relMatch) {
                                $rels = preg_split('/\s+/', $relMatch[1]);
                                if (!in_array('nofollow', $rels)) {
                                    $rels[] = 'nofollow';
                                }
                                return 'rel="' . implode(' ', array_unique($rels)) . '"';
                            },
                            '<a ' . $aTag . '>'
                        );
                    } else {
                        return '<a ' . $aTag . ' rel="nofollow">';
                    }
                },
                $original
            );

            if ($newText !== $original) {
                echo date('r') . ' Modified: ' . PHP_EOL . $newText . PHP_EOL;

                $safeText = $db->escape($newText); // екранування, якщо потрібно
                $updateQuery = "UPDATE `PagePart` SET `text` = '{$safeText}' WHERE `id` = {$row['id']}";
                echo date('r') . ' Update SQL: ' . $updateQuery . PHP_EOL;
                // $db->query($updateQuery);
            }
        }
    }

} catch (\Exception $e) {
    die(date('r') . ' Fatal error: ' . $e->getMessage() . PHP_EOL);
}
