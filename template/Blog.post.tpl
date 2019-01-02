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
{$rubrics = $post->getRubrics()}
{$breadcrumbs = array_filter([$blog, $category,$rubrics[0]])}
<ul class="breadcrumbs-box" itemprop="breadcrumb" itemscope itemtype="https://schema.org/BreadcrumbList">
    <li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem" style="display:none">
        <meta itemprop="position" content="0">
        <a href="/" itemprop="item">
            <span itemprop="name">{site_name()}</span>
        </a>
    </li>
{foreach $breadcrumbs as $item}
    <li {if $item@last}style="display:none;"{elseif $item@index ==count($breadcrumbs)-2}class="current"{/if} itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
        <meta itemprop="position" content="{$item@index+1}">
        <a href="{$item->getPath()}" itemprop="item">
            <span itemprop="name">{$item->geth1()|truncate:75:" ..."}</span>
        </a>
    </li>
{/foreach}
</ul>
{/block}
{block 'content'}
<div itemprop="mainEntity" {block 'page.scope'}itemtype="http://schema.org/Article"{/block} itemscope>
    {include 'partial/post'}
    {block 'main'}
    <div class="wrapper">
        <div class="box-shadow"></div>
        <div class="viewbox-cnt-body m_b-20">
            {block 'post.content'}
                {content $post attr=['class'=>'the_post_content','itemprop'=>'articleBody']}
            {/block}
            <ul class="inline-list share-btn">
                <li><span class='st_facebook_hcount' displayText='Facebook'></span></li>
                <li><span class='st_twitter_hcount' displayText='Tweet'></span></li>
                <li><span class='st_linkedin_hcount' displayText='LinkedIn'></span></li>
                <li><span class='st_googleplus_hcount' displayText='Google +'></span></li>
            </ul>
        </div>
    </div>
    <div class="wrapper">
        <div class="box-shadow"></div>
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
    {/block}
    {block 'map'}
        {#mod Attribute}
        {$loc = $post->getAttr(10)}
        {if $loc.lat && $loc.lng}
        <div style="position: relative;">
            <div class="box-shadow box-shadow2"></div>
            <div class="map" id="eventMapBlock"itemprop="contentLocation" itemscope itemtype="http://schema.org/Place">
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
                    <p><b>{if $lang=='en'}Name{else}Имя{/if}:</b> {$post->getAttr(5)}</p>
                    <p><b>E-Mail:</b> <a href="mailto:{$post->getAttr(5)}">{$post->getAttr(4)}</a></p>
                    <p><b>{if $lang=='en'}Phone{else}Телефон{/if}:</b> <a href="tel:{$post->getAttr(3)}">{$post->getAttr(3)}</a></p>
                    </div>

                {else}{#/mod}

                    <div class="avatar"><img src="/i/no-photo.png" alt=""></div>
                    <div class="data_contacts">
                        <p><b>{if $lang=='en'}Name{else}Имя{/if}:</b> {if $lang=='en'}Alex Oleynikov{else}Алексей Олейников{/if}</p>
                        <p><b>E-Mail:</b> <a href="mailto:info@inventure.ua">info@inventure.ua</a></p>
                        <p><b>{if $lang=='en'}Phone{else}Телефон{/if}:</b> <a href="tel:+380677136571">+38(067)713-65-71</a></p>
                    </div>

                {#mod Attributes}{/if}{#/mod}
            </div>
        </div>
    </div>
    {/block}
    {block 'comment'}
    <div id="newsComments">
        <h2>Комментарии</h2>
        {include 'inc/disqus'}
    </div>
    {/block}
</div>
{/block}
