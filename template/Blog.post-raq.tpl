{* prefilter=o *}
{extends 'Page.view'}
{if $post->hasImage()}
    {meta 'og:image' full_link($post->getImage()->getUrl()) property='og:image'}
{/if}
{meta 'og:url' full_link($post->getPath()) property='og:url' }
{meta 'og:title' html_entity_decode($post->getTitle()) property='og:title'}
{meta 'og:description' $post->getShortText() property='og:description'}

{script src="https://ws.sharethis.com/button/buttons.js" name="share_button"}
{script_code require="share_button"}
    stLight.options({
        publisher: "4251639a-288c-4b8a-a294-b65b62a0c7e1",
        doNotHash: false,
        doNotCopy: false,
        hashAddressBar: false,
        popup:true,
        servicePopup: true
    });
{/script_code}
{block 'config'}
{if !$page}{$page = $post}{/if}
{/block}
{block 'breadcrumbs'}
    <div class="clearfix border-bottom">
        <h2>{$blog->getTitle()}</h2>
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
    <div style="position: relative;" class="board-single">
        <div class="box-shadow"></div>
        <div class="grid-x m_b-20 auto-height">
            <div class="medium-{$post_head_size.0|default:5} cell photo-in">
            {block 'post.image'}
                {if $post->hasImage()}
                <div id="newsThumb">
                    <a href="#" data-reveal-id="thumbBig">
                        {$post->getImage()->thumbup(350,254)}
                    </a>
                </div>
                {/if}
                <div id="thumbBig" class="reveal-modal large medium" data-reveal>
                    {if $post->hasImage()}
                    <img itemprop="image" src="{$post->getImage()->getUrl()}" alt='{$post->getTitle()}' itemscope itemtype="http://schema.org/ImageObject"/>
                    {/if}
                    <p><b>{$post->getTitle()}</b></p>
                    <a class="close-reveal-modal">&#215;</a>
                </div>
            {/block}
            </div>
            <div class="medium-{$post_size.1|default:7} cell">
                <div class="viewbox-cnt attr-in">
                    <div class="hint m_b-10">
                    {block 'post.meta'}
                        <span>ID: {$post->getId()}</span>
                        {block 'post.publish'}<time class="time">{$post->getPublished()->format('d.m.y')}</time>{/block}
                    {if $post->getParent()}
                        {if $post->getParent()->getId() == 15088}
                            <a href="{$post->getParent()->getPath()}"><img src="/i/projects.png" alt="" class="category"/>{$post->getParent()->getH1()}</a>
                        {elseif $post->getParent()->getId() == 15089}
                            <a href="{$post->getParent()->getPath()}"><img src="/i/business.png" alt="" class="category"/>{$post->getParent()->getH1()}</a>
                        {elseif $post->getParent()->getId() == 15090}
                            <a href="{$post->getParent()->getPath()}"><img src="/i/realestate.png" alt="" class="category"/>{$post->getParent()->getH1()}</a>
                        {elseif $post->getParent()->getId() == 15091}
                            <a href="{$post->getParent()->getPath()}"><img src="/i/land.png" alt="" class="category"/>{$post->getParent()->getH1()}</a>
                        {elseif $post->getParent()->getId() == 15092}
                            <a href="{$post->getParent()->getPath()}"><img src="/i/offer.png" alt="" class="category"/>{$post->getParent()->getH1()}</a>
                        {else}
                            <span></span>
                        {/if}
                    {/if}
                    {/block}
                    </div>
                    <h3><a href="{$post->getPath()}">{$post->getH1()}</a></h3>
                    <div class="place">
                        <img src="/i/ukraine.png">{#mod Attributes}{if $post->hasAttr("10")} {$post->printAttr("10")}{/if}{#/mod}
                    </div>
                    <div class="price">
                    {if $post->getParent()}
                        {if $post->getParent()->getId() == 15089 || $post->getParent()->getId() == 15090 ||$post->getParent()->getId() == 15091}
                        <p><span style="font-weight: 700;">ЦЕНА</span> -
                            {if $post->getAttr("15")!=''} ${$post->printAttr("15")|number_format:0:'.':' '}{else}Договорная{/if}
                        </p>
                        {elseif $post->getParent()->getId() == 15088}
                        <p><span style="font-weight: 700;">ИНВЕСТИЦИИ</span> -
                            {if $post->hasAttr("15")} ${$post->printAttr("15")|number_format:0:'.':' '}{/if}
                        </p>
                        {elseif $post->getParent()->getId() == 15092}
                        <p><span style="font-weight: 700;">ИНВЕСТИЦИИ</span> -
                            {if $post->hasAttr("15")} ${$post->printAttr("15")|number_format:0:'.':' '}{/if}
                        </p>
                        {/if}
                      {/if}
                    </div>
                    <div class="row">
                        <div class="columns">
                            <ul class="inline-list share-btn">
                                <li><span class='st_facebook_hcount' st_url="https://inventure.com.ua{$post->getPath()}" displayText='Facebook'></span></li>
                                <li><span class='st_twitter_hcount' st_url="https://inventure.com.ua{$post->getPath()}" displayText='Tweet'></span></li>
                                <li><span class='st_linkedin_hcount' st_url="https://inventure.com.ua{$post->getPath()}" displayText='LinkedIn'></span></li>
                                <li><span class='st_googleplus_hcount' st_url="https://inventure.com.ua{$post->getPath()}" displayText='Google +'></span></li>
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
    {block 'map'}
        {#mod Attributes}
        {$loc = $post->getAttr(10)}
        {if $loc.lat && $loc.lng}
        <div style="position: relative;">
            <div class="box-shadow box-shadow2"></div>
            <div class="map" id="eventMapBlock" itemscope itemtype="http://schema.org/Place">
                <h2>Карта</h2>
                <div><div id="google_map" itemprop="maps"></div></div>
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
        {#/mod}
    {/block}
    <div style="position: relative;" id="contacts">
        <div class="box-shadow box-shadow1"></div>
        <div class="contacts">
            <h2>Контакты</h2>
            <div class="contacts1">
                {#mod Attributes}{if $post->getAttr(5) && $post->getAttr(4) && $post->getAttr(3)}

                    <div class="avatar"><img src="/i/no-photo.png" alt=""></div>
                    <div class="data_contacts">
                    <p><b>Имя:</b> {$post->getAttr(5)}</p>
                    <p><b>E-Mail:</b> <a href="mailto:{$post->getAttr(5)}">{$post->getAttr(4)}</a></p>
                    <p><b>Телефон:</b> <a href="tel:{$post->getAttr(3)}">{$post->getAttr(3)}</a></p>
                    </div>

                {else}{#/mod}

                    <div class="avatar"><img src="/i/no-photo.png" alt=""></div>
                    <div class="data_contacts">
                        <p><b>Имя:</b> Алексей Олейников</p>
                        <p><b>E-Mail:</b> <a href="mailto:info@inventure.ua">info@inventure.ua</a></p>
                        <p><b>Телефон:</b> <a href="tel:+380677136571">+38(067)713-65-71</a></p>
                    </div>

                {#mod Attributes}{/if}{#/mod}
            </div>
        </div>
    </div>
<div class="columns" id="newsComments">
    <h2>Комментарии</h2>
    {include 'inc/disqus'}
</div>
{/block}
