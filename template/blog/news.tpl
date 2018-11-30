{* prefilter=off *}
{extends 'Page.view'}
{block 'breadcrumbs'}
    <div class="clearfix border-bottom">
        <h2>Новости</h2>
    </div>
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
                <li class="current"><a href="{$category->getPath()}">{$category->getTitle()}</a></li>
            {/if}
        {/if}
        </ul>
{/block}
{block 'content'}
    {block 'post.head'}
    <div style="position: relative;">
    <div class="box-shadow"></div>
    <div class="row m_b-20 auto-height">
        <div class="medium-{$post_head_size.0|default:5} columns photo-in">
        {block 'post.image'}
            <div id="newsThumb">
                <a href="#" data-reveal-id="thumbBig">
                    {if $post->hasImage()}{$post->getImage()->thumbup(350,254)}{else}<img src="/skynar/images/no_image.svg">{/if}
                </a>
            </div>
            <div id="thumbBig" class="reveal-modal large medium" data-reveal>
                <img itemprop="image" src="{if $post->hasImage()}{$post->getImage()->getUrl()}{else}/skynar/images/no_image.svg{/if}" alt='{$post->getTitle()}' itemscope itemtype="http://schema.org/ImageObject"/>
                <p><b>{$post->getTitle()}</b></p>
                <a class="close-reveal-modal">&#215;</a>
            </div>
        {/block}
        </div>
        <div class="medium-{$post_head_size.1|default:7} columns">
            <div class="viewbox-cnt attr-in">
                            <div class="hint m_b-10">
                            {block 'post.meta'}
                                {block 'post.publish'}<time class="time" itemprop="datePublished">{$post->getPublished()->format('d.m.y')}</time>{/block}
                                {block 'post.views'}<img src="/i/views.png" /><span class="number">{$post->getViews()+1}</span>{/block}
                                {block 'post.rubric'}
                                {$r=$post->getRubrics()}
                                {if substr($blog->getPath(),0,5) == '/news' && $r.0}
                                    <img src="/i/folded-newspaper.png" />{$r.0->getH1()}
                                {/if}
                                {/block}
                            {/block}
                            </div>
                            <div class="author" itemprop="author">{block 'post.author'}
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
</div>
    {/block}
    <div class="wrapper">
        <div class="row" itemscope itemtype="http://schema.org/articleBody">
          	<div class="box-shadow"></div>
            <div class="columns">
                <div class="viewbox-cnt-body m_b-20" itemprop="text">
                    {block 'post.content'}
                        {content $post}
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
       <div class="row">
            <div class="box-shadow"></div>
            <div class="columns">
                {block 'post.images'}
                    {if count($post->getImages())>1}
                        <div  class="" id="photosContent">
                            <h2>Галерея</h2>
                            <section id="newsThumb">
                                <ul class="pgwSlideshow">
                                {foreach $post->getImages() as $idx=>$image}
                                    {if $image != $post->getImage()}
                                         <li>{$image->setAttr('itemprop','image')}</li>
                                    {/if}
                                {/foreach}
                                </ul>
                            </section>
                        </div>
                    {/if}
                {/block}
            </div>
        </div>
    </div>
    <div class="title_read_also">
        <h2><a href="tools/events">читайте также</a></h2>
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
    <div class="columns" id="newsComments">
        <h2>Комментарии</h2>
        {include 'inc/disqus'}
    </div>
{/block}
