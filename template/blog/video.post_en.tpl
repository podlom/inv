{extends 'Page.view'}
{block 'config'}
{if !$page}{$page = $post}{/if}
{/block}
{block 'breadcrumbs'}
    <div class="clearfix border-bottom">
        <h2>Video</h2>
    </div>
{/block}
{block 'content'}
    {block 'post.head'}
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
    <div class="wrapper">
        <div class="row" itemscope itemtype="http://schema.org/articleBody">
            <div class="box-shadow"></div>
            <iframe itemscope itemtype="http://schema.org/ImageObject" class="video-iframe video-content" src="//www.youtube.com/embed/{$post->printAttr("55")}" frameborder="0" allowfullscreen></iframe> 
           </div>   
    </div>
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
                {block 'map'}
                    {$loc = $post->getAttr(10)}
                    {if $loc.lat && $loc.lng}
                    <div class="viewbox-cnt-body m_b-20" id="eventMapBlock">
                        <h2>Карта</h2>
                        <div id="google_map"></div>
                    </div>
                    {script_code require="jquery,google_maps_api"}
                    {script 'google_maps_api'}
                    loader.on('google_maps',function(){
                        map = new google.maps.Map($('#google_map')[0], {
                                zoom: 14,
                                center: new google.maps.LatLng({number_format($loc.lat,5,'.','')}, {number_format($loc.lng,5,'.','')}),
                                mapTypeId: google.maps.MapTypeId.ROADMAP,
                                mapTypeControl: false,
                                rotateControl: false,
                                streetViewControl: false,
                        });
                        marker = new google.maps.Marker({
                            map: map,
                            position: new google.maps.LatLng({number_format($loc.lat,5,'.','')}, {number_format($loc.lng,5,'.','')})
                        });
                    });
                    {/script_code}
                {/if}
                {/block}
             </div>  
           </div>   
    </div>
    <div class="columns" id="newsComments">
        <h2>Comments</h2>
        {include 'inc/disqus'}
    </div>
{/block}