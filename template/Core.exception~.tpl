{if $response->getStatusCode() == 404}
<div class="row text-center error404">
    <img src="/i/error404.png" alt='404 error' message="{$content}" />
</div>
{elseif $response->getStatusCode() == 451}
<div class="row">
    <h1>Unavailable For Legal Reasons</h1>
    <div>
        Доступ к ресурсу заблокирован, для восстановления доступа обращайтесь <a href="mailto://info@inventure.ua">info@inventure.ua</a>
    </div>
</div>
{else}
<div class="row">
    <div class="callout alert">
	    {$current = $exception}
	    {$prev = null}
	    {for $n=0 to 5}
		    <h1>{get_class($current)}: {$current->getMessage()}</h1>
		    <h3>{$current->getFile()}:{$current->getLine()}</h3>
		    <div>{$current->getTraceAsString()|nl2br}</div>
		    {$prev = $current}
		    {$current = $prev->getPrevious()}
		    {if !$current || $prev === $current}
		    	{break}
		    {/if}
	    {/for}
	</div>
</div>
{/if}
