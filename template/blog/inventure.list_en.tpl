{* prefilter=off *}
{extends 'Blog.blog'}
{block 'page.class' append} inventure_list{/block}
{block 'config'}
{$links = [
    '/en/investments/projects'=>'Investment Projects and Startups',
    '/en/investments/business'=>'Business for Sale',
    '/en/investments/realestate'=>'Commercial Property',
    '/en/investments/land'=>'Land',
    '/en/investments/en_franchising'=>'Franchising',
    '/en/investments/offer'=>'Investor Offers'

]}
{$sorts = [
    ['', 'Latest'],
    ['views', 'Popular'],
    ['rating', 'Featured']
]}
{/block}
{block 'breadcrumbs'}{/block}
{block 'nav' append}
{$f = $request->query->get('filter')}
<ul class="tabs">
    {foreach $sorts as $s}
    <li class="tabs-title {if $f.sort==$s.0}is-active{/if}"><a href="?{if $s.0}filter[sort]={$s.0}{/if}">{$s.1}</a><li>
    {/foreach}
</ul>
{/block}
{block 'posts'}
<div class="auto-height">
     <article id="cards__list" class="cards"></article>
</div>
{/block}

<div data-append="sort" class="section__title-categories pt-0 mb-2 pb-0 flex flex-row justify-between items-center">
    {* <h1 class="pr-4">Инвестиционные предложения</h1> *}
    <ul class="sort desktop-only text-xs">
        {$f = $request->query->get('filter')}
        {foreach $sorts as $s}
            {if $s}
                <li class="sort__item {if $f.sort==$s.0}sort__item--active{/if}"><a href="?{if $s.0}filter[sort]={$s.0}{/if}">{$s.1}</a><li>
            {/if}
        {/foreach}
    </ul>
</div>
{block 'breadcrumbs'}{/block}
{block 'nav' append}
{* {$f = $request->query->get('filter')}
<ul class="tabs">
    {foreach $sorts as $s}
        {if $s}
            <li class="tabs-title {if $f.sort==$s.0}is-active{/if}"><a href="?{if $s.0}filter[sort]={$s.0}{/if}">{$s.1}</a><li>
        {/if}
    {/foreach}
</ul> *}
{/block}
{block 'posts'}
    <article id="cards__list" class="cards"></article>
{/block}
