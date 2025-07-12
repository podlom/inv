{* 1. Поточний URI без query-параметрів *}
{assign var="currentPath" value=$smarty.server.REQUEST_URI|replace:$querystr:''}

{* 2. Визначаємо, чи це головна сторінка мови (тільки /, /uk, /en) *}
{assign var="isRoot" value=0}
{if $currentPath == "/" || $currentPath == "/uk" || $currentPath == "/en"}
    {assign var="isRoot" value=1}
{/if}

{* 3. Видаляємо мовний префікс (uk|en) із початку URI *}
{assign var="basePath" value=$currentPath|regex_replace:"^/(uk|en)(/|$)":"\/"}
{assign var="basePath" value=$basePath|regex_replace:"^/":""}

{* 4. Формуємо базові посилання *}
{assign var="hrefDefault" value="https://{$smarty.server.HTTP_HOST}"}
{assign var="hrefUk" value="https://{$smarty.server.HTTP_HOST}/uk"}
{assign var="hrefEn" value="https://{$smarty.server.HTTP_HOST}/en"}

{* 5. Якщо не головна сторінка — додаємо підшлях до hreflang-посилань *}
{if !$isRoot && $basePath != ""}
    {assign var="hrefDefault" value=$hrefDefault|cat:"/"|cat:$basePath}
    {assign var="hrefUk" value=$hrefUk|cat:"/"|cat:$basePath}
    {assign var="hrefEn" value=$hrefEn|cat:"/"|cat:$basePath}
{/if}

{* 6. Canonical *}
<link rel="canonical" href="https://{$smarty.server.HTTP_HOST}{$currentPath}" />
<link rel="alternate" hreflang="x-default" href="{$hrefDefault}" />
<link rel="alternate" hreflang="en" href="{$hrefEn}" />
<link rel="alternate" hreflang="uk" href="{$hrefUk}" />
