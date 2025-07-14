{* 1. Поточний URI без query-параметрів *}
{assign var="currentPath" value=$smarty.server.REQUEST_URI|replace:$querystr:''}

{* Canonical — завжди як є *}
<link rel="canonical" href="https://{$smarty.server.HTTP_HOST}{$currentPath}" />