{* Поточний URI без query string *}
{assign var="currentPath" value=$smarty.server.REQUEST_URI|regex_replace:"/\?.*$":""}

{* Видаляємо мовний префікс з URI *}
{assign var="basePath" value=$currentPath|regex_replace:"^/uk/?":" "}
{assign var="basePath" value=$basePath|regex_replace:"^/en/?":" "}
{assign var="basePath" value=$basePath|trim}

{* Базові URL-и *}
{assign var="hrefDefault" value="https://{$smarty.server.HTTP_HOST}/?lang=ru"}
{assign var="hrefUk" value="https://{$smarty.server.HTTP_HOST}/uk"}
{assign var="hrefEn" value="https://{$smarty.server.HTTP_HOST}/en"}

{if $basePath != ""}
    {assign var="hrefDefault" value=$hrefDefault|cat:"/"|cat:$basePath}
    {assign var="hrefUk" value=$hrefUk|cat:"/"|cat:$basePath}
    {assign var="hrefEn" value=$hrefEn|cat:"/"|cat:$basePath}
{/if}

{* Canonical та hreflang теги *}
<link rel="canonical" href="https://{$smarty.server.HTTP_HOST}{$currentPath}" />
<link rel="alternate" hreflang="x-default" href="{$hrefDefault}" />
<link rel="alternate" hreflang="en" href="{$hrefEn}" />
<link rel="alternate" hreflang="uk" href="{$hrefUk}" />
