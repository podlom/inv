{* prefilter=off *}

{* 1. Поточний URI без query-параметрів *}
{assign var="currentPath" value=$smarty.server.REQUEST_URI|replace:$querystr:''}

{* 2. Визначаємо мовний префікс (uk, en) *}
{assign var="langPrefix" value=""}
{if $currentPath|strpos:'/uk' == 0}
    {assign var="langPrefix" value="uk"}
{elseif $currentPath|strpos:'/en' == 0}
    {assign var="langPrefix" value="en"}
{/if}

{* 3. Витягаємо внутрішній шлях без мовного префіксу *}
{assign var="pathWithoutLang" value=$currentPath|regex_replace:"^/(uk|en)",""}

{* 4. Canonical *}
<link rel="canonical" href="https://inventure.com.ua{$pathWithoutLang}" />

{* 5. Формування hreflang URLів з locale_data *}
{#mod 'Locale'}
{locale_data}
{foreach $locale_data as $langCode => $data}
    {if $data && $data.url}
        <link rel="alternate" hreflang="{$langCode}" href="{$data.url}" />
    {/if}
{/foreach}
{#/mod}

{* 6. Додаємо також x-default для пошукових систем *}
<link rel="alternate" hreflang="x-default" href="https://inventure.com.ua{$pathWithoutLang}" />
