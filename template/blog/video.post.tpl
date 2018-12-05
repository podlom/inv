{extends 'Blog.post'}
{block 'main' prepend}
<div class="wrapper">
    <div class="row" itemscope itemtype="http://schema.org/articleBody">
        <div class="box-shadow"></div>
        <iframe class="video-iframe video-content" itemscope itemtype="http://schema.org/ImageObject" src="//www.youtube.com/embed/{$post->printAttr("55")}" frameborder="0" allowfullscreen></iframe>
       </div>
</div>
{/block}
{block 'post.preview'}
<div style="position: relative;">
<div class="box-shadow"></div>
<div class="row m_b-20 auto-height">
        <div class="viewbox-cnt attr-in">
            <div class="hint m_b-10">
            {block 'post.meta'}
                {block 'post.publish'}<time class="time">{$post->getPublished()->format('d.m.y')}</time>{/block}
                {block 'post.views'}<img src="/i/views.png" /><span class="number">{$post->getViews()+1}</span>{/block}
                {block 'post.rubric'}
                {$r=$post->getRubrics()}
                {if substr($blog->getPath(),0,5) == '/news' && $r.0}
                    <img src="/i/folded-newspaper.png" />{$r.0->getH1()}
                {/if}
                {/block}
            {/block}
            </div>
            <div class="author">{block 'post.author'}
                    {if $post->getAttr(1)}<img src="/i/pers.png" alt="" />
                        {if $post->getAttr(2)}
                            <a href="{$post->getAttr(2)}">{$post->getAttr(1)}</a>
                        {else}
                            {$post->getAttr(1)}
                        {/if}
                    {/if}
                {/block}</div>
            <h3>{$post->getH1()}</h3>
            {block 'description'}
                <ul class="list_attr">
                    <li>{$post->getShortText()|truncate:200:"  ..."}</li>
                </ul>
            {/block}
            <div class="row">
                <div class="columns">
                    <ul class="inline-list share-btn">
                        <li><span class='st_facebook_hcount' displayText='Facebook'></span></li>
                        <li><span class='st_twitter_hcount' displayText='Tweet'></span></li>
                        <li><span class='st_linkedin_hcount' displayText='LinkedIn'></span></li>
                        <li><span class='st_googleplus_hcount' displayText='Google +'></span></li>
                    </ul>
                </div>
            </div>
        </div>
</div>
</div>
{/block}