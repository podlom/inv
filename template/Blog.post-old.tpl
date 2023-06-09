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
        <h2><a href="{$blog->getPath()}">{$blog->getTitle()}</a></h2>
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
    <li {if $item@last || $item@first}style="display:none;"{elseif $item@index ==count($breadcrumbs)-2}class="current"{/if} itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
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
    {include 'partial/post' parent="post"}
    {block 'main'}
    <div class="wrapper">
        <div class="box-shadow"></div>
        <div class="viewbox-cnt-body m_b-20">
            {block 'post.content'}
                {content $post attr=['class'=>'the_post_content','itemprop'=>'articleBody']}
            {/block}
            <ul class="inline-list share-btn blog-post">
                <li><span class='st_facebook_hcount' displayText='Facebook'></span></li>
                <li><span class='st_twitter_hcount' displayText='Tweet'></span></li>
                <li><span class='st_linkedin_hcount' displayText='LinkedIn'></span></li>

                <!-- @ts template/Blog.post.tpl +58 -->

                {if !$user && $sm}
                    {$user = $sm->getUser()}
                {/if}

                {if $user && $user->canAccess('Page.publish')}
                    <li><span class="st_get_utm_url" displayText="Генератор UTM"></span>
                        <select name="utm-list" class="copySelect">
                            <option value=""> -- Оберіть канал трафіку -- </option>
                            <option value="https://inventure.com.ua{if $page}{$page->getPath()}{else}{if $post}{$post->getPath()}{$post->getPath()}{else}{$blog->getPath()}{/if}{/if}?utm_source=facebook&utm_medium=cpc">Facebook Ads</option>
                            <option value="https://inventure.com.ua{if $page}{$page->getPath()}{else}{if $post}{$post->getPath()}{$post->getPath()}{else}{$blog->getPath()}{/if}{/if}?utm_source=investor&utm_medium=email">Email</option>
                            <option value="https://inventure.com.ua{if $page}{$page->getPath()}{else}{if $post}{$post->getPath()}{$post->getPath()}{else}{$blog->getPath()}{/if}{/if}?utm_source=digest&utm_medium=pdf">Digest</option>
                            <option value="https://inventure.com.ua{if $page}{$page->getPath()}{else}{if $post}{$post->getPath()}{$post->getPath()}{else}{$blog->getPath()}{/if}{/if}?utm_source=telegram&utm_medium=channel">Telegram</option>
                            <option value="https://inventure.com.ua{if $page}{$page->getPath()}{else}{if $post}{$post->getPath()}{$post->getPath()}{else}{$blog->getPath()}{/if}{/if}?utm_source=google&utm_medium=cpc">Google Ads</option>
                            <option value="https://inventure.com.ua{if $page}{$page->getPath()}{else}{if $post}{$post->getPath()}{$post->getPath()}{else}{$blog->getPath()}{/if}{/if}?utm_source=instagram&utm_medium=cpc">Instagram Ads</option>
                            <option value="https://inventure.com.ua{if $page}{$page->getPath()}{else}{if $post}{$post->getPath()}{$post->getPath()}{else}{$blog->getPath()}{/if}{/if}?utm_source=linkedin&utm_medium=cpc">LinkedIn Ads</option>
                            <option value="https://inventure.com.ua{if $page}{$page->getPath()}{else}{if $post}{$post->getPath()}{$post->getPath()}{else}{$blog->getPath()}{/if}{/if}?utm_source=linkedin&utm_medium=referral">LinkedIn</option>
                            <option value="https://inventure.com.ua{if $page}{$page->getPath()}{else}{if $post}{$post->getPath()}{$post->getPath()}{else}{$blog->getPath()}{/if}{/if}?utm_source=instagram&utm_medium=referral">Instagram</option>
                        </select>
                    </li>
                {/if}

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
            <div class="map" id="eventMapBlock" itemprop="contentLocation" itemscope itemtype="http://schema.org/Place">
                <h2>Карта</h2>
                <div><div id="google_map" itemprop="maps"></div></div>
            </div>
        </div>
        {script_code require="jquery,google_maps_api" name="gmapinitinblog"}
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
        <div class="contacts-wrap">
        {block 'contacts.inner'}
            <div class="contacts" id="contactsBlock">
            <div class="box-shadow box-shadow1"></div>
                <h2>Контакты</h2>
                <div class="contacts1"> 
                    {#mod Attribute}{if $post->getAttr(5) && $post->getAttr(4) && $post->getAttr(3)}

                        <div class="avatar">
                            {if $post->getAttr(63)}
                                <img src="{$post->getAttr(63)}" alt="">
                            {else}
                                <img src="/i/no-photo.png" alt="">
                            {/if}
                        </div>
                        <div class="data_contacts">
                        <p><b>{if $lang=='en'}Name{else}Имя{/if}:</b> {$post->getAttr(5)}</p>
                        <p><b>E-Mail:</b> <a href="mailto:{$post->getAttr(4)}">{$post->getAttr(4)}</a></p>
                        <p><b>{if $lang=='en'}Phone{else}Телефон{/if}:</b> <a href="tel:{preg_replace('![^\+0-9]!', '',$post->getAttr(3))}">{$post->getAttr(3)}</a></p>
                        </div>

                    {else}{#/mod}

                        <div class="avatar"><img src="/images/alex-photo.jpg" alt=""></div>
                        <div class="data_contacts">
                            <p><b>{if $lang=='en'}Name{else}Имя{/if}:</b> {if $lang=='en'}Alex{else}Алексей{/if}</p>
                            <p><b>E-Mail:</b> <a href="mailto:info@inventure.ua">info@inventure.ua</a></p>
                            <p><b>{if $lang=='en'}Phone{else}Телефон{/if}:</b> <a href="tel:+380977727292">+38 097 772 72 92</a></p>
                        </div>

                    {#mod Attribute}{/if}{#/mod}
                </div>
            </div>
        {/block}
        </div>
    {/block}
    {* block 'comment'}
    <div id="newsComments">
        <h2>Комментарии</h2>
        {include 'inc/disqus'}
    </div>
    {/block *}
</div>
{/block}
