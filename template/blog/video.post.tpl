{extends 'Blog.post'}
{block 'main' prepend}
<div class="wrapper">
    <div class="the_video" itemscope itemtype="http://schema.org/articleBody">
        <div class="box-shadow"></div>
            <iframe class="video-iframe video-content" itemscope itemtype="http://schema.org/ImageObject" src="//www.youtube.com/embed/{$post->printAttr("55")}" frameborder="0" allowfullscreen></iframe>
       </div>
</div>
{/block}
{block 'post.preview'}
<div style="position: relative;">
    <div class="box-shadow"></div>
    <div class="m_b-20 auto-height">
        <div class="viewbox-cnt attr-in">
            <div class="hint">
                {block 'post.meta'}
                    {block 'post.publish'}<time class="time" itemprop="datePublished" content="{$post->getPublished()->format('c')}">{$post->getPublished()->format('d.m.y')}</time>{/block}
                    {block 'post.views'}<img src="/i/views.png" /><span class="number">{$post->getViews()+1}</span>{/block}
                    {block 'post.parent'}
                    {if $post->getParent()}
                        <a href="{$post->getParent()->getPath()}">
                            {if file_exists(concat($module->getApp()->getWebRoot(),'/i/',$post->getParent()->getSubpath(),'.png'))}
                                <img src="{concat('/i/',$post->getParent()->getSubpath(),'.png')}" alt="" class="category"/>
                            {else}
                                <img src="/i/folded-newspaper.png" alt="" />
                            {/if}
                            {$post->getParent()->getH1()}
                        </a>
                    {/if}
                    {/block}
                    {block 'post.meta.schema'}
                    <div itemprop="publisher" itemscope itemtype="http://schema.org/Organization">
                        <meta itemprop="url" content="https://inventure.ua/">
                        <meta itemprop="name" content="Inventure">
                        <div itemprop="logo" itemscope itemtype="http://schema.org/ImageObject">
                            <meta itemprop="url" content="https://inventure.com.ua/i/logo_header.png">
                        </div>
                    </div>
                    <meta itemprop="dateModified" content="{$post->getUpdated()->format('c')}">
                    {/block}
                {/block}
            </div>
            {block 'post.author'}
                {if $post->getAttr(1)}
                <div class="author" itemprop="author" itemscope itemtype="http://schema.org/Organization">
                    <img src="/i/pers.png" alt="" />
                    <span itemprop="name">
                        {if $post->getAttr(2)}
                            <a href="{$post->getAttr(2)}" itemprop="url">{$post->getAttr(1)}</a>
                        {else}
                            {$post->getAttr(1)}
                        {/if}
                    </span>
                </div>
                {else}
                    <div itemprop="author" itemscope itemtype="http://schema.org/Organization">
                        <meta itemprop="url" content="https://inventure.ua/">
                        <meta itemprop="name" content="Inventure">
                        <div itemprop="logo" itemscope itemtype="http://schema.org/ImageObject">
                            <meta itemprop="url" content="https://inventure.com.ua/i/logo_header.png">
                        </div>
                    </div>
                {/if}
            {/block}
            {block 'post.title'}<a href="{$post->getPath()}" itemprop="mainEntityOfPage url"><h3 itemprop="headline">{$post->getH1()}</h3></a>{/block}
            {block 'post.description'}
                <div itemprop="description" class="the_shorttext">{$post->getShortText()|truncate:200:"  ..."}</div>
            {/block}
            {block 'post.share'}
            <ul class="inline-list share-btn">
                <li><span class='st_facebook_hcount' displayText='Facebook'></span></li>
                <li><span class='st_twitter_hcount' displayText='Tweet'></span></li>
                <li><span class='st_linkedin_hcount' displayText='LinkedIn'></span></li>
                <li><span class='st_googleplus_hcount' displayText='Google +'></span></li>
            </ul>
            {/block}
        </div>
    </div>
</div>
{/block}