{* 1. Поточний URI без query-параметрів *}
{assign var="currentPath" value=$smarty.server.REQUEST_URI|replace:$querystr:''}

{* 2. Чи це головна сторінка мови? (/, /uk, /en) *}
{assign var="isRoot" value=0}
{if $currentPath == "/"}
    {assign var="isRoot" value=1}
{elseif $currentPath == "/uk"}
    {assign var="isRoot" value=1}
{elseif $currentPath == "/en"}
    {assign var="isRoot" value=1}
{/if}

{* 3. Отримаємо шлях без мовного префікса *}
{assign var="basePath" value=$currentPath|regex_replace:"^/(uk|en)(/|$)":"\/"}
{assign var="basePath" value=$basePath|regex_replace:"^/":""}

{* 4. Формуємо базові посилання *}
{assign var="hrefDefault" value="https://{$smarty.server.HTTP_HOST}"}
{assign var="hrefUk" value="https://{$smarty.server.HTTP_HOST}/uk"}
{assign var="hrefEn" value="https://{$smarty.server.HTTP_HOST}/en"}

{if $isRoot neq 1 and $basePath != ""}
    {assign var="hrefDefault" value=$hrefDefault|cat:"/"|cat:$basePath}
    {assign var="hrefUk" value=$hrefUk|cat:"/"|cat:$basePath}
    {assign var="hrefEn" value=$hrefEn|cat:"/"|cat:$basePath}
{/if}

{* 5. hreflang *}
<link rel="alternate" hreflang="x-default" href="{$hrefDefault}" />
<link rel="alternate" hreflang="en" href="{$hrefEn}" />
<link rel="alternate" hreflang="uk" href="{$hrefUk}" />
