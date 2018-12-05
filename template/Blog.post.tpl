{* prefilter=off *}
{extends 'Page.view'}
{block 'page.class' append} the_post{/block}
{block 'config'}
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
{if !$page}{$page = $post}{/if}
{/block}
{block 'page.title'}
<div class="clearfix border-bottom">
    <h2>{$blog->getTitle()}</h2>
</div>
{/block}
{block 'breadcrumbs'}
{$breadcrumbs = []}
{if $blog}
    {$breadcrumbs[$blog->getPath()]=$blog->getTitle()}
{/if}
{if $category}
    {$breadcrumbs[$category->getPath()]=$category->getTitle()}
{/if}
{if $rubric}
    {$breadcrumbs[$rubric->getPath()]=$rubric->getTitle()}
{/if}
{if $post}
    {$breadcrumbs[$post->getPath()]=$post->getTitle()}
{/if}
<ul class="breadcrumbs-box">
{foreach $breadcrumbs as $link=>$title}
    {if $title@last}
    <li class="current">{$title}</li>
    {else}
    <li><a href="{$link}">{$title}</a></li>
    {/if}
{/foreach}
</ul>
{/block}
{block 'content'}
    {include 'partial/post'}
    {block 'main'}
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
    {/block}
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
    {block 'contacts'}
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
    {/block}
    {block 'comment'}
    <div class="columns" id="newsComments">
        <h2>Комментарии</h2>
        {include 'inc/disqus'}
    </div>
    {/block}
{/block}
