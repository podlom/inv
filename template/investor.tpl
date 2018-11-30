{extends 'Page.view'}
{block 'breadcrumbs'}
    <h1>{$page->getH1()|truncate:75:" ..."|trim}</h1>
{/block}
{block 'content'}
	<div class="box-shadow"></div>
	<div class="viewbox-cnt-body">
	    {content $page}
	    <div class="form-default">
	    	{if $lang=='ru'}{form 'investor'}{else}{form 'investor_en'}{/if}
	    </div>
	</div>
{/block}
