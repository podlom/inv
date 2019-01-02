{* prefilter=off *}
{extends 'Page.view'}
{block 'page.title'}
<div class="clearfix border-bottom">
    <h2>{$blog->getTitle('content')}</h2>
</div>
{/block}
{block 'breadcrumbs'}
    <div class="clearfix">
        <ul class="breadcrumbs-box" itemprop="breadcrumb" itemscope>
        {$bc = array_filter([$blog, $category, $rubric, $post])}
        {foreach $bc as $bi}
            {if $bi@last}
                <li class="current">{$bi->getTitle()|truncate:75:" ..."}</li>
            {else}
                <li><a href="{$bi->getPath()}">{$bi->getTitle()|truncate:75:" ..."}</a></li>
            {/if}
        {/foreach}
        </ul>
    </div>
{/block}
{block 'content'}
    {block 'nav'}
    {if $links}
        <nav>
          {foreach $links as $url=>$name}
            <a href="{$url}"{if $request->getPathInfo()===$url} class="active"{/if}>{$name}</a>{if !$name@last} | {/if}
          {/foreach}
        </nav>
        {block 'nav.category'}
        <div class="mobile_category">
          {if $category}
          <a href="#">{$category->getH1()}</a><i class="fa fa-chevron-right"></i><i class="fa fa-chevron-down"></i>
          {else}
          <a href="#">Категории</a><i class="fa fa-chevron-right"></i><i class="fa fa-chevron-down"></i>
          {/if}
          <ul>
          {foreach $links as $url=>$name}
            {if $category && $category->getPath() != $url}
            <li><a href="{$url}">{$name}</a></li>
            {/if}
          {/foreach}
          </ul>
        </div>
        {/block}
        {/if}
    {/block}
    {block 'content.text'}
        {block 'posts'}
        <div class="the_list" itemprop="mainEntity" itemscope itemtype="https://schema.org/ItemList">
            {foreach $posts as $idx=>$post}
            <div itemprop="itemListElement" itemscope itemtype="http://schema.org/Article">
                <meta itemprop="position" content="{$idx}">
                {include 'partial/post'}
            </div>
            {/foreach}
        </div>
        {/block}
        {block 'pagination'}
            <ul class="pagination">
                {foreach $posts->getPagination()->getLinks() as $a}
                    <li class="{$a->getAttr('class')}">{$a->setAttr('class', '')}</li>
                {/foreach}
            </ul>
        {/block}
    {/block}
{/block}
{block 'main' append}
{block seo}
<div class="seo-box">
    <div class="large-3 medium-3 columns">
        {content $blog 'seo' tag="h2" new=1}
    </div>
    <div class="large-9 medium-9 columns text">
        {content $blog 'seo_text' new=1}
    </div>
</div>
{/block}
{/block}