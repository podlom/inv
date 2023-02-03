{block 'post.preview'}
{assign "isInvestmentsPost" value=($request->getPathInfo()|strpos:'/investments/')}
<div class="row post ">
    <div class="cards__labels mobile-only flex ml-2">
        {if $post->getAttr(64) == 1}
            <div data-tippy-content="{if $lang=='en'}{else}На правах рекламы{/if}" class="preview__post-type preview__post-type--red mr-2">Р</div>
        {/if}
        {if $post->getAttr(65)}
            <div data-tippy-content="{if $lang=='en'}{else}Эксклюзивный материал InVenture{/if}" class="preview__post-type mr-2">Э</div>
        {/if}
    </div>

{* post--card *}

  <div class="post__wrapper">
    <div class="post__preview">
        {include 'components/previews/default'}
    </div>
    
    <div class="post__container">
        <div class="line mb-6 mt-6 desktop-only"></div>
        <div class="post__content content pb-6">
            {block 'utm'}
                <!-- @ts template/partial/post.tpl +24 -->

                {if !$user && $sm}
                    {$user = $sm->getUser()}
                {/if}
                {if $user && $user->canAccess('Page.publish')}
                    <h6>Генератор UTM. Выберите из списка канал трафика:</h6>
                    <ul class="inline-list share-btn blog-post">
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
                    </ul>
                    <div class="line mb-6 mt-6 desktop-only"></div>
                {/if}
            {/block}

            {block 'post.content'}
                {content $post attr=['class'=>'the_post_content','itemprop'=>'articleBody']}
            {/block}

            {block 'post.author'}
                {if $post->getAttr(1)}
                    <div class="line mb-6 mt-6"></div>
                    <div class="author" itemprop="author" itemscope itemtype="http://schema.org/Organization">
                        <b>{if $lang=='en'}Source:{elseif $lang == 'uk'}Джерело:{else}Источник:{/if} </b>
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
        </div>

    </div>
  </div>



{block 'main'}
    <div class="wrapper">
        <div class="box-shadow"></div>
        {block 'post.images'}
            {if count($post->getImages())>1}
                <div class="preview__slider post-slider mt-4">
                    <div class="swiper-container gallery-top">
                    <div class="swiper-wrapper  mb-4">
                        {foreach $post->getImages() as $image }
                        <div class="swiper-slide">
                            <img class="swiper-lazy" data-src="/img/thumbup.600.400{($image->getUrl())}" alt="{$post->getH1()}">
                            <div class="swiper-lazy-preloader"></div>
                        </div> 
                        {/foreach}
                    </div>
                    <div class="swiper-button-next swiper-button-white"></div>
                    <div class="swiper-button-prev swiper-button-white"></div>
                    </div>
                    <div class="swiper-container gallery-thumbs mt-2">
                        <div class="swiper-wrapper">
                        {foreach $post->getImages() as $image }
                            <div class="swiper-slide">
                            <img class="swiper-lazy" data-src="/img/thumbup.236.170{($image->getUrl())}" alt="{$post->getH1()}">
                            <div class="swiper-lazy-preloader"></div>
                            </div> 
                        {/foreach}
                        </div>
                    </div>
                </div>
                <script>
                    function loadScript(src) {
                        return new Promise((resolve) => {
                        const script = document.createElement('script');
                        script.src = src;
                        script.type = 'text/javascript';
                        script.async = true;
                        script.onload = resolve;
                        document.body.appendChild(script);
                        });
                    }
                    loadScript('https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js').then(() => {
                        const galleryThumbs = new Swiper('.gallery-thumbs', {
                            spaceBetween: 10,
                            slidesPerView: 5,
                            freeMode: true,
                            watchSlidesVisibility: true,
                            watchSlidesProgress: true,
                            preloadImages: false,
                            lazy: true
                        });
                        const galleryTop = new Swiper('.gallery-top', {
                            slidesPerView: 1,
                            navigation: {
                                nextEl: '.swiper-button-next',
                                prevEl: '.swiper-button-prev',
                            },
                            thumbs: {
                                swiper: galleryThumbs
                            },
                            preloadImages: false,
                            lazy: true
                        });
                    })
                    
                </script>
            {/if}
        {/block}
    </div>
{/block}





{* <div style="position: relative; background-color: white;">
    <div class="box-shadow"></div>
    <div class="grid-x">
        <div class="medium-{$post_size.0|default:5} cell {$image_class}">
            {block 'image'}
                {if substr($post->getPath(),0,14) == "/tools/video"}
                    <div>{$post->getAttr(55)}</div>
                {elseif $post->getImage()}
                    {if $parent != 'post'}
                    <a href="{$post->getPath()}">
                        {$post->getImage()->thumb(350,254)->addClass('the_img')->setAttr('itemprop','image')}
                    </a>
                    {else}
                    {css "https://cdn.jsdelivr.net/gh/fancyapps/fancybox@3.5.6/dist/jquery.fancybox.min.css"}
                    {script name="fancybox" src="https://cdn.jsdelivr.net/gh/fancyapps/fancybox@3.5.6/dist/jquery.fancybox.min.js" require=['jquery']}
                    <a href="{$post->getImage()->getUrl()}" data-fancybox>
                        {$post->getImage()->thumbup(350,254)->addClass('the_img')->setAttr('itemprop','image')}
                    </a>
                    
                    {/if}
                {else}
                    <a href="{$post->getPath()}">
                        <img class="the_img" src="/img/resize.375.225/images/noThumb.jpg" alt="{$post->getH1()}"/>
                    </a>
                {/if}
            {/block}
        </div>
        <div class="medium-{$post_size.1|default:7} cell the_description_wrap">
            <div class="the_description">
                <div class="hint">
                {block 'post.meta'}
                    {block 'post.publish'}
                        <time class="time" itemprop="datePublished" content="{$post->getPublished()->format('c')}">{$post->getPublished()->format('d.m.y')}</time>
                    {/block}

                    {block 'post.views'}
                        <img src="/i/views.png" /><span class="number">{$post->getViews()+1}</span>
                    {/block}

                    {if !is_null($post->getParent()) && ( $post->getParent()->getId() == 7862 || $post->getParent()->getId() == 7864 || $post->getParent()->getId() == 19303 || $post->getParent()->getId() == 7861 || $post->getParent()->getId() == 7863 || $post->getParent()->getId() == 7860 || $post->getParent()->getId() == 15089 || $post->getParent()->getId() == 15091 || $post->getParent()->getId() == 15092 || $post->getParent()->getId() == 15090 || $post->getParent()->getId() == 15088 )}
                        {block 'post.id-num'}
                            <div class="id-number"><strong style="margin: 0 5px 0 0">ID:</strong> {$post->getId()}</div>
                        {/block}
                    {/if}

                    <!-- @ts template/partial/post.tpl +43 -->

                    {block 'post.reviews'}{/block}

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
                {block 'post.title'}<a href="{$post->getPath()}" itemprop="mainEntityOfPage url"><h3 itemprop="headline">{$post->getH1()}</h3></a>{/block}
                
                {block 'post.share'}
                    <ul class="inline-list share-btn partial-post">
                        {if !$user && $sm}
                            {$user = $sm->getUser()}

                            {if $user && $user->canAccess('Page.publish')}
                                <li><span class="st_get_utm_url" displayText="Генератор UTM"></span>
                                    <select name="utm-list" class="copySelect">
                                        <option value=""> -- Оберіть канал трафіку -- </option>
                                        <option value="https://inventure.com.ua{if $page}{$page->getPath()}{else}{if $post}{$post->getPath()}{/if}{/if}?utm_source=facebook&utm_medium=cpc">Facebook Ads</option>
                                        <option value="https://inventure.com.ua{if $page}{$page->getPath()}{else}{if $post}{$post->getPath()}{/if}{/if}?utm_source=investor&utm_medium=email">Email</option>
                                        <option value="https://inventure.com.ua{if $page}{$page->getPath()}{else}{if $post}{$post->getPath()}{/if}{/if}?utm_source=digest&utm_medium=pdf">Digest</option>
                                        <option value="https://inventure.com.ua{if $page}{$page->getPath()}{else}{if $post}{$post->getPath()}{/if}{/if}?utm_source=telegram&utm_medium=channel">Telegram</option>
                                        <option value="https://inventure.com.ua{if $page}{$page->getPath()}{else}{if $post}{$post->getPath()}{/if}{/if}?utm_source=google&utm_medium=cpc">Google Ads</option>
                                        <option value="https://inventure.com.ua{if $page}{$page->getPath()}{else}{if $post}{$post->getPath()}{/if}{/if}?utm_source=instagram&utm_medium=cpc">Instagram Ads</option>
                                        <option value="https://inventure.com.ua{if $page}{$page->getPath()}{else}{if $post}{$post->getPath()}{/if}{/if}?utm_source=linkedin&utm_medium=cpc">LinkedIn Ads</option>
                                        <option value="https://inventure.com.ua{if $page}{$page->getPath()}{else}{if $post}{$post->getPath()}{/if}{/if}?utm_source=linkedin&utm_medium=referral">LinkedIn</option>
                                        <option value="https://inventure.com.ua{if $page}{$page->getPath()}{else}{if $post}{$post->getPath()}{/if}{/if}?utm_source=instagram&utm_medium=referral">Instagram</option>
                                    </select>
                                </li>
                            {/if}
                        {/if}

                    </ul>
                {/block}
            </div>
        </div>
    </div>
    {block 'post.extras'}{/block}
   </div>
</div> *}
{/block}