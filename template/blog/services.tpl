   {extends 'Page.view'}
          {block 'breadcrumbs'}
    <div class="clearfix border-bottom">
        <h2>Инвестиционные услуги</h2>
    </div>
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
                    {$post->getImage()->thumbup(350,254)}
                </a>
            </div>
            <div id="thumbBig" class="reveal-modal large medium" data-reveal>
                <img itemprop="image" src="{$post->getImage()->getUrl()}" alt='{$post->getTitle()}' itemscope itemtype="http://schema.org/ImageObject"/>
                <p><b>{$post->getTitle()}</b></p>
                <a class="close-reveal-modal">&#215;</a>
            </div>
        {/block}
        </div>
        <div class="medium-{$post_head_size.1|default:7} columns">
            <div class="viewbox-cnt attr-in">
                            <div class="hint m_b-10">
                            {block 'post.meta'}
                                {block 'post.publish'}<time class="time">{$post->getPublished()->format('d.m.y')}</time>{/block}
                                {block 'post.views'}<img src="/i/views.png" /><span class="number">{$post->getViews()+1}</span>{/block}
                            {/block}
                            </div>
                            <h3>{$post->getH1()}</h3>
                            {block 'description'}
                                <ul class="list_attr">
                                    <li>{$post->getShortText()|truncate:200:"  ..."}</li>
                                </ul>
                            {/block}
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
                </div>
                {block 'post.images'}
                    {if count($post->getImages())>1}
                        <div  class="viewbox-cnt-body m_b-20" id="photosContent">
                            <h2>Галерея</h2>
                            <section id="newsThumb">
                                {foreach $post->getImages() as $idx=>$image}
                                    {if $image != $post->getImage()}
                                        <a href="#" data-reveal-id="{concat('thumbSmall_',$image->getId())}">
                                            {$image->thumbup(310,225)->setAttr('itemprop','image')}
                                        </a>
                                        <div id="{concat('thumbSmall_',$image->getId())}" class="reveal-modal large medium" data-reveal>
                                            {$image->setAttr('itemprop','image')}
                                            <p><b>{$post->getTitle()}</b></p><a class="close-reveal-modal">&#215;</a>
                                        </div>
                                    {/if}
                                {/foreach}
                            </section>
                            <div class="owl-carousel js-gallery news_slider">
                                {foreach $post->getImages() as $idx=>$image}
                                    {if $image != $post->getImage()}
                                        <div class="item">
                                            <div class="photo">
                                                <a href="#" data-reveal-id="{concat('thumbSmall_',$image->getId())}">
                                                    {$image->thumbup(310,225)->setAttr('itemprop','image')}
                                                </a>
                                            </div>
                                            <div id="{concat('thumbSmall_',$image->getId())}" class="reveal-modal large medium" data-reveal>
                                                {$image->setAttr('itemprop','image')}
                                                <p><b>{$post->getTitle()}</b></p><a class="close-reveal-modal">&#215;</a>
                                            </div>
                                        </div>
                                    {/if}
                                {/foreach}
                            </div>
                        </div>
                    {/if}
                {/block}
                {block 'post.contacts'}{/block}
             </div>  
           </div> 	
    </div>
    <div class="columns" id="newsComments">
        <h2>Комментарии</h2>
        {include 'inc/disqus'}
    </div>
{/block}