{* 1. Поточний URI без query-параметрів *}
{assign var="currentPath" value=$smarty.server.REQUEST_URI|replace:$querystr:''}

{* Визначаємо мовний префікс (uk, en) *}
{assign var="langPrefix" value=""}
{if $currentPath|strpos:'/uk' == 0}
    {assign var="langPrefix" value="uk"}
{elseif $currentPath|strpos:'/en' == 0}
    {assign var="langPrefix" value="en"}
{/if}

{* Витягаємо внутрішній шлях без мовного префіксу *}
{assign var="pathWithoutLang" value=$currentPath|regex_replace:"^/(uk|en)",""}

{* Canonical *}
<link rel="canonical" href="https://{$smarty.server.HTTP_HOST}{$currentPath}" />

{* Формування hreflang URLів — додаємо внутрішній шлях без мови *}
{assign var="alt_default" value="https://inventure.com.ua"|cat:$pathWithoutLang}
{assign var="alt_en" value="https://inventure.com.ua/en"|cat:$pathWithoutLang}
{assign var="alt_uk" value="https://inventure.com.ua/uk"|cat:$pathWithoutLang}

<link rel="alternate" hreflang="x-default" href="{$alt_default}" />
<link rel="alternate" hreflang="en" href="{$alt_en}" />
<link rel="alternate" hreflang="uk" href="{$alt_uk}" />
