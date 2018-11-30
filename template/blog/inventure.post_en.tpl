   {extends 'Page.view'}
          {block 'breadcrumbs'}
    <div class="clearfix border-bottom">
        <h2>Investment proposals</h2>
    </div>
            <ul class="breadcrumbs-box">
        {if $blog}
            {if !$post && !$rubric && !$category}
                <li class="current">{$blog->getTitle()}</li>
            {else}
                <li class="current"><a href="{$blog->getPath()}">{$blog->getTitle()}</a></li>
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
                               <div class="reviews">{widget 6 target=$post->getId()}</div> {$post->getRating()|number_format:1}
                            {if $post->getParent()->getId() == 9778}
                                <a href="{$post->getParent()->getPath()}"><img src="/i/projects.png" alt="" />{$post->getParent()->getH1()}</a>
                            {elseif $post->getParent()->getId() == 9779}
                                <a href="{$post->getParent()->getPath()}"><img src="/i/business.png" alt="" />{$post->getParent()->getH1()}</a>
                            {elseif $post->getParent()->getId() == 9780}
                                <a href="{$post->getParent()->getPath()}"><img src="/i/realestate.png" alt="" />{$post->getParent()->getH1()}</a>
                            {elseif $post->getParent()->getId() == 9781}
                                <a href="{$post->getParent()->getPath()}"><img src="/i/land.png" alt="" />{$post->getParent()->getH1()}</a>
                            {elseif $post->getParent()->getId() == 9782}
                                <a href="{$post->getParent()->getPath()}"><img src="/i/offer.png" alt="" />{$post->getParent()->getH1()}</a>
                            {else}
                                <span></span>
                            {/if}
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
</div>
    {/block}
    <div style="position: relative; margin-bottom: 24px;">
        <div class="box-shadow"></div>
        <div class="tabs">
          <ul class="tabs__caption">
            <li class="active">Characteristic</li>
            {if count($post->getImages())>1}<a href="#photosContent">Gallery</a>{/if}
            <a href="#eventMapBlock">Location</a>
            <a href="#contacts">Contacts</a>
          </ul>

          <div class="tabs__content  active" id="panel1">
            {include concat('inc/investments/',$post->getParent()->getSubpath())}
          </div>
        </div>
    </div>
          <div class="wrapper" id="wrapper2">
        <div class="row" itemscope itemtype="http://schema.org/articleBody">
           <div class="box-shadow"></div>
            <div class="columns">
                <div class="viewbox-cnt-body m_b-20" itemprop="text" id="content_body">
                    {block 'post.content'}
                        {content $post}
                    {/block}
                </div>
            </div>
        </div>
            <div class="columns">
                    {block 'post.images'}
                    {if count($post->getImages())>1}
                        <div  class="" id="photosContent">
                            <h2>Gallery</h2>
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
                    <div style="position: relative;" id="contacts">
                    	<div class="box-shadow box-shadow1"></div>
	                    <div class="contacts">
	                        <h2>Contacts</h2>
                        <div class="contacts1">
	                        {if $post->getAttr(5) && $post->getAttr(4) && $post->getAttr(3)}

                                <div class="avatar"><img src="/i/no-photo.png" alt=""></div>
                                <div class="data_contacts">
                                <p><b>Name:</b> {$post->getAttr(5)}</p>
                                <p><b>E-Mail:</b> <a href="mailto:{$post->getAttr(5)}">{$post->getAttr(4)}</a></p>
                                <p><b>Tel:</b> <a href="tel:{$post->getAttr(3)}">{$post->getAttr(3)}</a></p>
                                </div>

                            {else}

                                <div class="avatar"><img src="/i/no-photo.png" alt=""></div>
                                <div class="data_contacts">
                                    <p><b>Name:</b> Алексей Олейников</p>
                                    <p><b>E-Mail:</b> <a href="mailto:info@inventure.ua">info@inventure.ua</a></p>
                                    <p><b>Tel:</b> <a href="tel:+380677136571">+38(067)713-65-71</a></p>
                                </div>

	                        {/if}
	                    </div>
					</div>
                </div>
                {block 'map'}
                    {$loc = $post->getAttr(10)}
                    {if $loc.lat && $loc.lng}
                    <div style="position: relative;">
                    	<div class="box-shadow box-shadow2"></div>
	                    <div class="map" id="eventMapBlock" itemscope itemtype="http://schema.org/Place">
	                        <h2>Map</h2>
	                        <div><div id="google_map"></div></div>
	                    </div>
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
    <div class="columns" id="newsComments">
        <h2>Comments</h2>
        {include 'inc/disqus'}
    </div>
{/block}