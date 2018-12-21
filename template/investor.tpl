{extends 'Page.view'}
{block 'breadcrumbs'}{/block}
{block 'content.text' append}
    <div class="form-default">
    	{if $lang=='ru'}{form 'investor'}{else}{form 'investor_en'}{/if}
    </div>
{/block}
