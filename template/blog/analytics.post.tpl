{* prefilter=off *}
{extends 'Blog.post'}
{block 'main' append}
{block 'similar'}
<div class="title_read_also">
    <h2><a href="tools/events">{if $lang=='en'}Related posts{else}Читайте также{/if}</a></h2>
</div>
<article class="grid-container read_also">
    <div class="grid-margin-x grid-x">
    {similar_posts $post 4}
        <div class="cell small-12 medium-6">
            <a href="{$lent->getPath()}" class="news_inv">
                <div class="img">
                        <img src="/img/thumbup.236.170{$lent->getImage()->getUrl()}" alt='{$lent->getTitle()}' />
                </div>
                <div class="content">
                    <h5>
                        {$lent->getH1()}
                    </h5>
                </div>
            </a>
        </div>
    {/similar_posts}
    </div>
</article>
{/block}
{/block}
{block 'contacts'}{/block}