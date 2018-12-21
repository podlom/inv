{* prefilter=off *}
{extends 'Page.view'}
{block 'page.title'}
<div class="clearfix border-bottom">
    <h2>{$blog->getTitle()}</h2>
</div>
{/block}
{block 'breadcrumbs'}
    <div class="clearfix">
        <ul class="breadcrumbs-box">
        {if $blog}
            {if !$post && !$rubric && !$category}
                <li class="current">{$blog->getTitle()}</li>
            {else}
                <li><a href="{$blog->getPath()}">{$blog->getTitle()}</a></li>
            {/if}
        {/if}
        {if $category}
            {if !$post && !$rubric}
                <li class="current">{$category->getTitle()}</li>
            {else}
                <li><a href="{$category->getPath()}">{$category->getTitle()}</a></li>
            {/if}
        {/if}
        {if $rubric}
        {if !$post}
                <li class="current">{$rubric->getTitle()}</li>
            {else}
                <li><a href="{$rubric->getPath()}">{$rubric->getTitle()}</a></li>
            {/if}
        {/if}
        {if $post}<li class="current">{$post->getH1()|truncate:75:" ..."}</li>{/if}
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
            {foreach $posts as $post}
                {include 'partial/post'}
            {/foreach}
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