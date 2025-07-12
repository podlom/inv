{* Поточний URI без query-параметрів *}
{assign var="currentPath" value=$smarty.server.REQUEST_URI|replace:$querystr:''}

{* Видаляємо мовний префікс (uk|en) із початку URI *}
{assign var="basePath" value=$currentPath|regex_replace:"^/(uk|en)(/|$)":"\/"}

{* Видаляємо зайвий початковий слеш, якщо є *}
{assign var="basePath" value=$basePath|regex_replace:"^/":""}

{* Формуємо посилання *}
{assign var="hrefDefault" value="https://inventure.com.ua"}
{assign var="hrefUk" value="https://inventure.com.ua/uk"}
{assign var="hrefEn" value="https://inventure.com.ua/en"}

{if $basePath != ""}
    {assign var="hrefDefault" value=$hrefDefault|cat:"/"|cat:$basePath}
    {assign var="hrefUk" value=$hrefUk|cat:"/"|cat:$basePath}
    {assign var="hrefEn" value=$hrefEn|cat:"/"|cat:$basePath}
{/if}

{* Canonical: завжди як є, без query-параметрів *}
<link rel="canonical" href="https://{$smarty.server.HTTP_HOST}{$currentPath}" />
<link rel="alternate" hreflang="x-default" href="{$hrefDefault}" />
<link rel="alternate" hreflang="en" href="{$hrefEn}" />
<link rel="alternate" hreflang="uk" href="{$hrefUk}" />
