{* 1. Поточний URI без query-параметрів *}
{assign var="currentPath" value=$smarty.server.REQUEST_URI|replace:$querystr:''}

{* Визначаємо мовний префікс *}
{assign var="langPrefix" value=""}
{if $currentPath|strpos:'/uk' == 0}
    {assign var="langPrefix" value="uk"}
{elseif $currentPath|strpos:'/en' == 0}
    {assign var="langPrefix" value="en"}
{/if}

{* Витягаємо шлях без мовного префіксу (напр. /news/123) *}
{assign var="pathWithoutLang" value=$currentPath|regex_replace:'/^\/(uk|en)(\/.*)?$/':'$2'}

{* Canonical — завжди як є *}
<link rel="canonical" href="https://{$smarty.server.HTTP_HOST}{$currentPath}" />

{* hreflang-посилання *}
<link rel="alternate" hreflang="x-default" href="https://{$smarty.server.HTTP_HOST}{$pathWithoutLang}" />
<link rel="alternate" hreflang="en" href="https://{$smarty.server.HTTP_HOST}/en{$pathWithoutLang}" />
<link rel="alternate" hreflang="uk" href="https://{$smarty.server.HTTP_HOST}/uk{$pathWithoutLang}" />
