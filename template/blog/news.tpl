{* prefilter=off *}
{extends 'Blog.post'}
{block 'main' append}
<div class="title_read_also">
    <h2><a href="tools/events">{if $lang=='en'}Related posts{else}Читайте также{/if}</a></h2>
</div>
<article class="grid-container read_also">
    <div class="grid-margin-x grid-x">
    {similar_posts $post 4}
        <div class="cell small-12 medium-6">
            <div class="news_inv">
                <div class="img">
                    <a href="{$lent->getPath()}" >
                        <img src="/img/thumbup.236.170{$lent->getImage()->getUrl()}" alt='{$lent->getTitle()}' />
                    </a>
                </div>
                <div class="content">
                    <h5><a href="{$lent->getPath()}" >{$lent->getH1()}</h5>
                    <div class="category">
                    {if $lent->getParent()}
                        <a href="{$lent->getParent()->getPath()}"><img src="/i/folded-newspaper.png" alt="" />{$lent->getParent()->getH1()}</a>
                    {/if}
                    </div>
                </div>
            </div>
        </div>
    {/similar_posts}
    </div>
</article>
{/block}
{block 'contacts'}{/block}