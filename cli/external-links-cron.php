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
            echo date('r') . ' Original: ' . var_export($original, true) . PHP_EOL;

            $doc = new DOMDocument('1.0', 'UTF-8');
            libxml_use_internal_errors(true);
            // Конвертуємо для DOMDocument (HTML без <html><body>)
            $html = mb_convert_encoding($original, 'HTML-ENTITIES', 'UTF-8');
            $doc->loadHTML('<meta http-equiv="Content-Type" content="text/html; charset=utf-8">' . $html, LIBXML_HTML_NOIMPLIED | LIBXML_HTML_NODEFDTD);
            libxml_clear_errors();

            $anchors = $doc->getElementsByTagName('a');
            foreach ($anchors as $a) {
                $href = $a->getAttribute('href');
                if (stripos($href, 'http://') === 0 || stripos($href, 'https://') === 0) {
                    $rel = $a->getAttribute('rel');
                    $relValues = preg_split('/\s+/', $rel, -1, PREG_SPLIT_NO_EMPTY);
                    if (!in_array('nofollow', $relValues)) {
                        $relValues[] = 'nofollow';
                        $a->setAttribute('rel', implode(' ', array_unique($relValues)));
                    }
                }
            }

            $newHtml = $doc->saveHTML();
            $newHtml = str_replace('<meta http-equiv="Content-Type" content="text/html; charset=utf-8">', '', $newHtml);

            if ($original !== $newHtml) {
                echo date('r') . ' Modified:' . PHP_EOL . var_export($newHtml, true) . PHP_EOL;

                // Збереження в базу
                $safeText = $db->escape($newHtml); // або використати prepared statement
                $updateQuery = "UPDATE `PagePart` SET `text` = '{$safeText}' WHERE `id` = {$row['id']}";
                echo date('r') . ' Update SQL: ' . $updateQuery . PHP_EOL;
                // $db->query($updateQuery);
            }
        }
    }

} catch (\Exception $e) {
    die(date('r') . ' Fatal error: ' . $e->getMessage() . PHP_EOL);
}
