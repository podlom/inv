<?php

(PHP_SAPI !== 'cli' || isset($_SERVER['HTTP_USER_AGENT'])) && die(' +' . __LINE__ . ' PHP Fatal Error: cli only usage allowed.' . PHP_EOL);

/**
 * Created by PhpStorm
 * User: podlo
 * Date: 2025-07-03
 * Time: 14:23
 * Updated: 2025-07-03 15:13
 *
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
        LIMIT 0, 5
    ";

    echo date('r') . ' SQL: ' . $query . PHP_EOL;

    $results = $db->query($query);
    if (!empty($results) && is_array($results)) {
        foreach ($results as $row) {
            echo date('r') . ' Original DB entry: ' . var_export($row, true) . PHP_EOL;

            $updatedText = $row['text'];

            $updatedText = preg_replace_callback(
                '#<a\s+([^>]*?)href="https?://[^"]+"([^>]*)>#i',
                function ($matches) use ($row) {
                    $beforeHref = $matches[1];
                    $afterHref = $matches[2];

                    // Знайдемо або додамо rel
                    if (preg_match('/rel\s*=\s*["\']([^"\']+)["\']/i', $beforeHref . $afterHref, $relMatch)) {
                        $existingRel = $relMatch[1];
                        $relParts = explode(' ', $existingRel);
                        if (!in_array('nofollow', $relParts)) {
                            $relParts[] = 'nofollow';
                        }
                        $newRel = 'rel="' . implode(' ', array_unique($relParts)) . '"';
                        $newTag = preg_replace('/rel\s*=\s*"[^"]*"/i', $newRel, "<a {$beforeHref}{$afterHref}>");
                    } else {
                        // rel не існує — додаємо rel="nofollow"
                        $newTag = "<a {$beforeHref} rel=\"nofollow\" {$afterHref}>";
                    }

                    return $newTag;
                },
                $updatedText
            );

            if ($updatedText !== $row['text']) {
                echo date('r') . ' Modified HTML: ' . PHP_EOL . $updatedText . PHP_EOL;

                // Розкоментуйте рядки нижче, щоб оновити БД
                $safeText = $db->escape($updatedText); // or use parameterized query if possible
                $updateQuery = "UPDATE `PagePart` SET `text` = '{$safeText}' WHERE `id` = {$row['id']}";
                echo date('r') . ' Update SQL: ' . $updateQuery . PHP_EOL;
                // $db->query($updateQuery);
            }
        }
    }

} catch (\Exception $e) {
    die(date('r') . ' Fatal error: ' . $e->getMessage() . PHP_EOL);
}
