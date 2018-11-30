{extends 'Page.view'}
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
    {block 'posts'}
        {foreach $posts as $post}
            {block 'post'}
            <div class="row">
                <div class="box-shadow1"></div>
                <div class="auto-height">
                    <div class="medium-{$post_size.0|default:5} columns photo-in">
                        {block 'image'}
                        {if $post->getImage()}
                            <a href="{$post->getPath()}">
                                {$post->getImage()->thumbup(350,254)->lazy('data-original', '/i/310-225-load.gif')->addClass('lazy')}
                            </a>
                        {elseif substr($post->getPath(),0,14) == "/tools/video"}
                            <div>{$post->getAttr(55)}</div>
                        {else}
                            <a href="{$post->getPath()}">
                                <img src="/img/resize.375.225/images/noThumb.jpg" alt="{$post->getH1()}" />
                            </a>
                        {/if}
                        {/block}
                    </div>
                    <div class="medium-{$post_size.1|default:7} columns">
                        <div class="viewbox-cnt attr-in">
                            <div class="hint m_b-10">
                            {block 'post.meta'}
                                {block 'post.publish'}<time class="time">{$post->getPublished()->format('d.m.y')}</time>{/block}
                                {block 'post.views'}{#mod Analytics}<img class="icon16 views" src="/i/-.gif" alt="" /><span class="number">{$post->getViews()+1}</span>{#/mod}{/block}
                                {block 'post.author'}
                                    {#mod Attribute}
                                    {if $post->getAttr(1)}<img class="icon16 author" src="/i/-.gif" alt="" />
                                        {if $post->getAttr(2)}
                                            <a href="{$post->getAttr(2)}">{$post->getAttr(1)}</a>
                                        {else}
                                            {$post->getAttr(1)}
                                        {/if}
                                    {/if}
                                    {#/mod}
                                {/block}
                                {block 'post.rubric'}
                                {$r=$post->getRubrics()}
                                {if substr($blog->getPath(),0,5) == '/news' && $r.0}
                                    <a href="#"><img class="icon16 category-type" src="/i/-.gif" alt="" />{$r.0->getH1()}</a>
                                {/if}
                                {/block}
                            {/block}
                            </div>
                            <h3><a href="{$post->getPath()}">{$post->getH1()}</a></h3>
                            {block 'description'}
                                <ul class="list_attr">
                                    <li>{$post->getShortText()|truncate:300:"  ..."}</li>
                                </ul>
                            {/block}
                        </div>
                    </div>
                </div>
            </div>
            {/block}
        {/foreach}
    {/block}
    {block 'pagination'}
    <div class="row">
        <div class="columns">
            <ul class="pagination right">
                {foreach $posts->getPagination()->getLinks() as $a}
                    <li class="{$a->getAttr('class')}">{$a->setAttr('class', '')}</li>
                {/foreach}
            </ul>
        </div>
    </div>
    {/block}
{/block}
{block seo}
<div class="row">
    <div class="columns">
        <div class="seo-box">
            <div class="large-3 medium-3 columns">
                {content $blog 'seo' tag="h2" new=1}
            </div>
            <div class="large-9 medium-9 columns text">
                {content $blog 'seo_text' new=1}
            </div>
        </div>
    </div>
</div>
{/block}
