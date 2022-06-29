{extends 'Page.view'}
{block 'breadcrumbs'}{/block}
{block 'page.title'}{/block}

{assign "isNewStylesAvaible" value=($request->getPathInfo() === '/add-inv-prop' || $request->getPathInfo() === '/en/add-inv-prop' || $request->getPathInfo() === '/investor' || $request->getPathInfo() === '/en/investor' || $request->getPathInfo() === '/uk/investor' )}
{block 'content.text'}
    {if $isNewStylesAvaible}
        {include 'components/investor'}
    {else}
        <div class="form-default">
            {if $lang=='ru'}{form 'investor'}{else}{form 'investor_en'}{/if}
        </div>
    {/if}
    
{/block}
