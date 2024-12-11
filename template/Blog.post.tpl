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
    {* <div class="clearfix border-bottom">
        <h1><a href="{$blog->getPath()}">{$blog->getTitle()}</a></h1>
    </div> *}
{/block}

<!-- @ts template/Blog.post.tpl +24 -->
{block 'utm'}
    {if !$user && $sm}
        {$user = $sm->getUser()}
    {/if}
    {if $user && $user->canAccess('Page.publish')}
        <div class="wrapper">
            <div class="box-shadow"></div>
            <div class="viewbox-cnt-body m_b-20">
                <h6>Генератор UTM. Выберите из списка канал трафика:</h6>
                <ul class="inline-list share-btn blog-post">
                    <li>
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
            </div>
        </div>
    {/if}
{/block}

{block 'breadcrumbs'}{/block} 
{* {block 'breadcrumbs'}
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
{/block} *}
{block 'content'}
{script src="/js/ui.js" async="" require="jquery,google_maps_api" name="ui_js" }
<div itemprop="mainEntity" {block 'page.scope'}itemtype="http://schema.org/Article"{/block} itemscope>
    {include 'partial/post' parent="post"}

    {block 'map'}
        {#mod Attribute}
        {$loc = $post->getAttr(10)}
        {if $loc.lat && $loc.lng}
        <div style="position: relative;" class="mt-6">
            <div class="box-shadow box-shadow2"></div>
            <div class="map" id="eventMapBlock" itemprop="contentLocation" itemscope itemtype="http://schema.org/Place">
                <h2 class="section__title">{if $lang === 'ru'}Расположение{else}Location{/if}</h2>
                <div class="post__map mt-4" id="google_map" itemprop="maps"></div>
            </div>
        </div>
        {if $lang === 'en'}
            {script_code require="jquery,google_maps_api_en" name="gmapinitinblog"}
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
        {else}
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

        {/if}
        {#/mod}
    {/block}
    {block 'contacts'}
    <section class="contact-form {if $request->getPathInfo()|strpos:'/tools/events' === 0}contact-form--white mb-4 mt-4{/if}">
        <h2 class="section__title contact-form__title">
            {if $lang === 'ru'}Контакты{else}Contacts{/if}
        </h2>


{script src="https://www.google.com/recaptcha/api.js" name="google_recaptcha_api"}
{script_code name="grecaptchainitinblogcontact"}

    console.log('+141 Google reCaptcha JavaScript API init');

    function onContact19Subm(token)
    {
        console.log('+145 token: ' + token);
        document.getElementById("contact-form-19").submit();
    }

{/script_code}

        <form method="post" action="/invest.php" onsubmit="return false;" class="contact-form__form" id="contact-form-19">
            <input required type="hidden" name="sf_investment_callback[ga_utm]" value="">
            <input type="hidden" name="sf_investment_callback[url]" value="">

        {#mod Attribute}{if $post->getAttr(5) && $post->getAttr(4) && $post->getAttr(3)}
            <div class="contact-form__info">
                <img src="{if $post->getAttr(63)}{$post->getAttr(63)}{else}/i/no-photo.png{/if}" class="contact-form__photo">
                <h3 class="contact-form__name  mb-1 text-md">
                    {$post->getAttr(5)}
                </h3>
                <a class="contacts__text-link contact-form__link" href="mailto:{$post->getAttr(4)}">{$post->getAttr(4)}</a>
                <a class="contacts__text-link contact-form__link" href="tel:{preg_replace('![^\+0-9]!', '',$post->getAttr(3))}">{$post->getAttr(3)}</a>
            </div>
        {else}{#/mod}
            <div class="contact-form__info">
                <img src="/images/alex-photo.jpg" class="contact-form__photo">
                <h3 class="contact-form__name  mb-1 text-md">
                    {if $lang=='en'}Alex{else}Алексей{/if}
                </h3>
                <a class="contacts__text-link contact-form__link" href="mailto:info@inventure.ua">info@inventure.ua</a>
                <a class="contacts__text-link contact-form__link" href="tel:+380977727292">+38 097 772 72 92</a>
            </div>
        {#mod Attribute}{/if}{#/mod}
            <div class="contact-form__block">
                <h3 class="contact-form__subtitle">
                    {if $lang === 'ru'}Свяжитесь со мной!{elseif $lang === 'uk'} Зв'яжіться зі мною! {else}Connect with us!{/if}
                </h3>
                <div class="contact-form__inputs">
                    <div class="contact-form__item">
                        <label class="contact-form__label">
                            {if $lang === 'ru'}Имя{elseif $lang === 'uk'} Імʼя {else}First name{/if}
                        </label>
                        <input required type="text" name="sf_investment_callback[firstname]" class="contact-form__input">
                    </div>
                    <div class="contact-form__item">
                        <label class="contact-form__label">
                            
                            {if $lang === 'ru'}Фамилия{elseif $lang === 'uk'} Прізвище {else}Last name{/if}
                        </label>
                        <input required type="text" name="sf_investment_callback[lastname]" class="contact-form__input">
                    </div>
                    <div class="contact-form__item">
                        <label class="contact-form__label">
                            E-mail
                        </label>
                        <input required name="sf_investment_callback[email]" type="email"  class="contact-form__input">
                    </div>
                    <div class="contact-form__item">
                        <label class="contact-form__label">
                            {if $lang === 'ru'}Телефон{elseif $lang === 'uk'} Телефон {else}Mobile phone{/if}
                        </label>
                        <input required id="phone" name="sf_investment_callback[tel]" type="text" placeholder="+380" class="contact-form__input">
                        <span id="error-msg" class="hide"></span>
                    </div>
                    <div class="contact-form__captcha-block">
                        <!-- The following line controls and configures the Turnstile widget. -->
                        <div class="cf-turnstile" data-sitekey="0x4AAAAAAA16EgKzQUTvZdcv" data-theme="light" data-size="flexible" data-action="submit"></div>
                        <!-- end. -->
                    </div>
                </div>

{literal}
<script>

    console.log('+210 init');

    function onSubmit(token)
    {
        console.log('+214 token: ' + token);
        document.getElementById("contact-form-19").submit();
    }

</script>
{/literal}

                <button type="submit" class="contact-form__btn btn w-full btn--blue">
                    {if $lang == 'ru'}Отправить{elseif $lang == 'uk'}Відправити{else}Submit{/if}
                </button>
            </div>
        </form>

        <div id="msg-sent-19" class="text-center contact-form__sent_message invisible">
            <h3 class="contact-form__subtitle">
                {if $lang === 'ru'}Сообщение отправлено. Спасибо.{elseif $lang === 'uk'} Повідомлення відправлено. Дякуємо.{else}Message sent. Thank you.{/if}
            </h3>
        </div>
        {literal}
            <script>

                const url1 = window.location.href;
                console.log('+238 url1: ' + url1);
                console.log('+239 typeof(url1): ' + typeof(url1));
                if ((typeof(url1) == 'string') && url1.includes('contactSent=')) {
                    console.log('+239 URL contains: contactSent=');
                    // document.getElementById("msg-sent-19").style.visibility = 'visible';
                    document.getElementById("msg-sent-19").classList.remove("invisible");
                } else {
                    console.log('+243 URL does string or does not contains: contactSent=');
                }

            </script>
        {/literal}

    </section>

    <div class="invest-ad">
        <div class="invest-ad__title-wrapper">
            <svg width="26" height="26" viewBox="0 0 26 26" fill="none" xmlns="http://www.w3.org/2000/svg">
                <g clip-path="url(#clip0)">
                <path d="M25.9691 1.94095C25.9127 0.908166 25.0914 0.0868805 24.0586 0.0305133C21.9746 -0.0833383 17.8967 0.0274157 13.9973 2.04429C12.0094 3.07251 9.9071 4.81578 8.22934 6.82713C8.20867 6.85191 8.18856 6.87684 8.16804 6.90167L4.36047 7.1958C3.73372 7.24424 3.17549 7.57275 2.82885 8.09701L0.231188 12.0261C-0.0317061 12.4237 -0.073499 12.9213 0.119317 13.3571C0.312185 13.793 0.708481 14.0968 1.17948 14.1698L4.38738 14.6666C4.37606 14.729 4.36468 14.7913 4.35427 14.8537C4.24748 15.4925 4.45913 16.1493 4.92053 16.6106L9.38888 21.079C9.77141 21.4616 10.2883 21.6725 10.818 21.6725C10.927 21.6725 11.0367 21.6635 11.1459 21.6452C11.2083 21.6348 11.2706 21.6235 11.3329 21.6121L11.8298 24.8201C11.9028 25.2911 12.2065 25.6874 12.6423 25.8803C12.8237 25.9605 13.0156 26.0001 13.2066 26.0001C13.4749 26 13.7413 25.9219 13.9735 25.7684L17.9025 23.1707C18.4268 22.824 18.7553 22.2658 18.8036 21.6391L19.0977 17.8316C19.1226 17.8111 19.1476 17.791 19.1723 17.7703C21.1837 16.0925 22.9271 13.9902 23.9552 12.0023C25.9722 8.10275 26.0828 4.02476 25.9691 1.94095V1.94095ZM17.0623 21.8999L13.304 24.3847L12.8197 21.2584C14.4081 20.7914 15.9795 20.0434 17.4765 19.0413L17.2849 21.5217C17.2729 21.6764 17.1918 21.8143 17.0623 21.8999V21.8999ZM10.4661 20.0018L5.9977 15.5334C5.8837 15.4194 5.83099 15.2592 5.85684 15.1048C5.98968 14.3105 6.19611 13.5543 6.45164 12.8419L13.1562 19.5465C12.3006 19.8529 11.5343 20.0357 10.8947 20.1427C10.7401 20.1684 10.5801 20.1158 10.4661 20.0018V20.0018ZM4.47782 8.71472L6.95818 8.52312C5.95606 10.0201 5.20806 11.5914 4.74102 13.1799L1.61472 12.6957L4.09965 8.93724C4.18527 8.80775 4.32314 8.72665 4.47782 8.71472V8.71472ZM18.1966 16.6003C16.966 17.6268 15.7715 18.3692 14.6705 18.9064L7.09285 11.3288C7.79658 9.89147 8.65544 8.69461 9.39918 7.80299C10.9518 5.9416 12.8829 4.33585 14.6972 3.39741C18.276 1.54628 22.0466 1.4466 23.9756 1.55161C24.231 1.56553 24.434 1.7686 24.448 2.02398C24.5531 3.95306 24.4532 7.72357 22.6021 11.3024C21.6637 13.1167 20.058 15.0477 18.1966 16.6003Z" fill="black"/>
                <path d="M17.81 11.9971C18.7851 11.997 19.7606 11.6258 20.5029 10.8835C21.2223 10.1641 21.6184 9.20773 21.6184 8.19048C21.6184 7.17323 21.2223 6.21681 20.5029 5.4975C19.018 4.0125 16.6018 4.0126 15.117 5.4975C14.3976 6.21681 14.0015 7.17323 14.0015 8.19048C14.0015 9.20773 14.3977 10.1641 15.117 10.8835C15.8595 11.626 16.8345 11.9972 17.81 11.9971ZM16.1941 6.57467C16.6396 6.12917 17.2247 5.90644 17.8099 5.90644C18.3951 5.90644 18.9802 6.12917 19.4257 6.57467C19.8573 7.00626 20.0949 7.58009 20.0949 8.19043C20.0949 8.80077 19.8573 9.37465 19.4257 9.80624C18.5348 10.6972 17.085 10.6971 16.194 9.80624C15.7625 9.37465 15.5248 8.80082 15.5248 8.19048C15.5248 7.58014 15.7625 7.00626 16.1941 6.57467Z" fill="black"/>
                <path d="M0.777318 21.4264C0.972268 21.4264 1.16722 21.3521 1.3159 21.2033L3.80281 18.7163C4.10029 18.4189 4.10029 17.9366 3.80281 17.6391C3.50539 17.3416 3.02307 17.3416 2.72559 17.6391L0.238732 20.126C-0.0587441 20.4235 -0.0587441 20.9058 0.238732 21.2033C0.38742 21.352 0.582369 21.4264 0.777318 21.4264V21.4264Z" fill="black"/>
                <path d="M6.08159 19.9184C5.78416 19.6209 5.30184 19.6209 5.00437 19.9184L0.223107 24.6997C-0.0743691 24.9972 -0.0743691 25.4795 0.223107 25.777C0.371846 25.9257 0.566744 26 0.761693 26C0.956643 26 1.15159 25.9257 1.30028 25.7769L6.08154 20.9956C6.37906 20.6982 6.37906 20.2159 6.08159 19.9184V19.9184Z" fill="black"/>
                <path d="M7.28326 22.1977L4.79635 24.6846C4.49887 24.9821 4.49887 25.4644 4.79635 25.7619C4.94509 25.9106 5.14004 25.985 5.33493 25.985C5.52983 25.985 5.72483 25.9106 5.87352 25.7619L8.36043 23.2749C8.6579 22.9775 8.6579 22.4952 8.36043 22.1977C8.063 21.9002 7.58068 21.9002 7.28326 22.1977Z" fill="black"/>
                </g>
                <defs>
                <clipPath id="clip0">
                <rect width="26" height="26" fill="white"/>
                </clipPath>
                </defs>
            </svg>

            <h2 class="invest-ad__title">
                {if $lang === 'ru'}
                    Привлечение инвестиций, продажа бизнеса и коммерческой недвижимости в Украине
                {elseif $lang === 'uk'}
                    Залучення інвестицій, продаж бізнесу та комерційної нерухомості в Україні
                {else}
                    Services for Raising Capital & Sell a Business
                {/if}
            </h2>
        </div>
        <div class="invest-ad__wrapper">
            <a href="tel:+380977727292" class="invest-ad__link-wrapper invest-ad__link-wrapper--tel">
                <div  class="invest-ad__link">+38 097 772 72 92</div>
                <div class="invest-ad__caption">{if $lang == 'en'}From 9:00 to 18:00{elseif $lang == 'uk'}З 9:00 до 18:00{else}С 9:00 до 18:00{/if}</div>
            </a>
            <a href="mailto:info@inventure.ua" class="invest-ad__link-wrapper invest-ad__link-wrapper--mail">
                <div  class="invest-ad__link">info@inventure.ua</div>
                <div class="invest-ad__caption">{if $lang == 'en'}Advertising placement{elseif $lang == 'uk'}З питань розміщення{else}По вопросам размещения{/if}</div>
            </a>
            <a href="/add-inv-prop" class="btn w-full btn--blue invest-ad__btn">
                {if $lang === 'ru'}Узнать подробности{elseif $lang === 'uk'}Дізнатися більше{else}Learn more{/if}
            </a>
        </div>
    </div>

    {/block}
    {block 'croudinvest'}
        <section class="croudinvest">
            <!-- @ts:croudinvest -->
            <div id="croud_stat1"></div>
            <div id="croud_form1"></div>
        </section>

    {/block}
    {* block 'comment'}
    <div id="newsComments">
        <h2>Комментарии</h2>
        {include 'inc/disqus'}
    </div>
    {/block *}
</div>
{/block}


{* 
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
        </div> *}