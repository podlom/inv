<div class="row">
    <div class="large-8 medium-8 columns" itemscope itemtype="http://schema.org/Article">
        <div class="clearfix">
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
                        <li><a href="{$category->getPath()}">{$category->getTitle()}</a></li>
                    {/if}
                {/if}
                {if $rubric}
                    {if !$post}
                        <li class="current">{$rubric->getTitle()}</li>
                    {else}
                        <li><a href="{$rubric->getPath()}">{$rubric->getTitle()}</a></li>
                    {/if}
                {/if}
                {if $post}<li class="current">{$post->getH1()|truncate:75:" ..."}</li>{/if}
            </ul>
        </div>
        <div class="row m_b-20 {if substr($post->getPath(),0,12) != '/tools/video'}auto-height{/if}">
            {if substr($post->getPath(),0,12) != '/tools/video'}
                <div class="{if substr($post->getPath(),0,14) == '/tools/experts'}large-2 medium-2{else}large-4 medium-4{/if} columns photo-in">
                    <div id="newsThumb">
                        <a href="#" data-reveal-id="thumbBig">
                            <img itemprop="image" src="{if substr($post->getPath(),0,14) == '/tools/experts'}/img/thumb.310.225{$post->getImage()->getUrl()}{else}/img/resize.310.225{$post->getImage()->getUrl()}{/if}" alt="{$post->getTitle()}" />
                        </a>
                        {if substr($post->getPath(),0,14) == '/tools/experts'}
                            <div class="text-center m_t-10">
                                <a class="blue_but" data-reveal-id="questionForm" data-expert-id="{$post->getId()}" href="#" >Задать вопрос</a>
                            </div>
                        {/if}
                    </div>
                    {if $controller->getPath()=='/investments'}<!-- div class="reviews">Голосовать: {widget 6 target=$post->getId()}</div -->{else}{/if}
                </div>
            {/if}
            <div class="{if substr($post->getPath(),0,12) != '/tools/video'}{if substr($post->getPath(),0,14) == '/tools/experts'}large-10 medium-10{else}large-8 medium-8{/if}{/if} columns">
                <div class="viewbox-cnt">
                    <div class="hint m_b-10">
                        {if substr($post->getPath(),0,14) != '/tools/experts' && substr($post->getPath(),0,9) != '/services' && substr($post->getPath(),0,12) != '/investments'}
                            <time class="time" itemprop="dateCreated">{$post->getPublished()->format('d.m.y')}</time>
                        {/if}
                        {if substr($post->getPath(),0,10) == '/analytics' ||  substr($post->getPath(),0,5) == '/news' ||  substr($post->getPath(),0,12) == '/tools/video'}
                            <img class="icon16 views" src="/i/-.gif" alt="" /><span class="number">{$post->getViews()+1}</span>
                            {if $post->getAttr(1)}
                                <img class="icon16 author" src="/i/-.gif" alt="" />
                                {if $post->getAttr(2)}
                                    <a href="{$post->getAttr(2)}">{$post->getAttr(1)}</a>
                                {else}
                                    {$post->getAttr(1)}
                                {/if}
                            {/if}
                        {/if}
                        {$r = $post->getRubrics()}
                        {if substr($post->getPath(),0,5) == '/news' && $r.0}
                            <img class="icon16 category" src="/i/-.gif" alt="" />{$r.0->getH1()}
                        {/if}
                        {if substr($post->getPath(),0,13) == '/tools/events'}
                            <img class="icon16 views" src="/i/-.gif" alt="" /><span class="number">{$post->getViews()}</span>
                        {/if}
                        {if substr($post->getPath(),0,12) == '/investments'}
                            <time class="time" itemprop="dateCreated">{$post->getPublished()->format('d.m.y')}</time>
                            <span>ID: {$post->getID()}&nbsp;&nbsp;</span>
                            <img class="icon16 views" src="/i/-.gif" alt="" /><span class="number">{$post->getViews()}</span>
                            <img class="icon16 attr" src="/i/-.gif" alt="" /><span class="number">{$post->getAttr(13)}</span>
                            <img class="icon16 rating" src="/i/-.gif" alt="" /><span class="number">{$post->getRating()|number_format:1}</span>
                            {if $post->getParent()}
                                <img class="icon16 category" src="/i/-.gif" alt="" />{$post->getParent()->getH1()}
                            {/if}
                        {/if}
                    </div>
                    <h1 class="h3" itemprop="name">{$post->getTitle()}</h1>
                    <div itemscope itemtype="http://schema.org/CreativeWork">
                        {block description}
                            <div itemprop="description">
                                <ul class="list_attr">
                                    {if substr($post->getPath(),0,14) == '/tools/experts'}
                                        <li class="m_b-15">{$post->getShortText()|nl2br}</li>
                                        {if $post->hasAttr("44")}<li><b>Компания:</b> {$post->getAttr("44")}</li>{/if}
                                        {if $post->hasAttr("45")}<li><b>Должность:</b> {$post->getAttr("45")}</span></li>{/if}
                                        {if $post->hasAttr("16")}<li><b>Сфера деятельности:</b> {$post->printAttr("16")}</span></li>{/if}
                                        {if $post->hasAttr("47")}<li><b>Работа в других компаниях:</b> {$post->getAttr("47")}</span></li>{/if}
                                    {elseif substr($post->getPath(),0,12) == '/tools/atlas'}
                                        <li>{if $post->printAttr(46)}<b>Тип инвестора:</b> {$post->printAttr(46)}</span>{/if}</li>
                                        {$s = $post->printAttr(57)}
                                        {if $s && $s.0 && $s.1}<li>{if $post->printAttr(52)}<b>Размер инвестицй:</b> от {$s.0} до {$s.1}{/if}</li>{/if}
                                        <li>{if $post->printAttr(53)}<b>Стадии инвестирования:</b> {$post->printAttr(53)}{/if}</li>
                                    {else}
                                    <li class="m_b-15">{$post->getShortText()}</li>
                                    {/if}
                                </ul>
                            </div>
                        {/block}
                        {* Project *}
                        {if $post->getParent() && $post->getParent()->getId() == 7860}
                            <ul class="list_attr">
                                {if $post->getAttr(16)}
                                    {$t = $post->printAttr(16)->getChilds()}
                                    <li><b>Отрасль:</b> {$t.0->getChilds()|array_pop}</li>
                                    {if $t.1}<li><b>Вид деятельности:</b> {$t.1->getChilds()|array_pop}</li>{/if}
                                {/if}
                                <li><b>Стадия проекта:</b> {$post->printAttr(32)}</li>
                                {if $post->getAttr(15) != 0}<li><b>Стоимость проекта:</b> {$post->getAttr(15)|number_format:0:'.':' '} USD</li>{/if}
                                {if $post->getAttr(34) != 0}<li><b>Требуемые инвестиции:</b> {$post->getAttr(34)|number_format:0:'.':' '} USD</li>{/if}
                                {if $post->hasAttr(33)}<li><b>Тип инвестиций:</b> {$post->printAttr(33)}</li>{/if}
                                {if $post->getAttr(35) != 0}<li><b>Предложение инвестору:</b> {$post->getAttr(35)}%</li>{/if}
                                {if $post->getAttr(36) != 0}<li><b>Окупаемость инвестиций, лет:</b> <span>{$post->getAttr(36)}</li>{/if}
                                {if $post->getAttr(37) != 0}<li><b>IRR:</b> {$post->getAttr(37)}%</li>{/if}
                                {if $post->getAttr(38) != 0}<li><b>NPV:</b> {$post->getAttr(38)|number_format:0:'.':' '} USD</li>{/if}
                            </ul>
                        {/if}
                        {* Business *}
                        {if $post->getParent() && $post->getParent()->getId() == 7861}
                            <ul class="list_attr">
                                {if $post->getAttr(16)}
                                    {$t = $post->printAttr(16)->getChilds()}
                                    <li><b>Отрасль:</b> {$t.0->getChilds()|array_pop}</li>
                                    {if $t.1}<li><b>Вид деятельности:</b> {$t.1->getChilds()|array_pop}</li>{/if}
                                {/if}
                                {if $post->getAttr(15) != 0}<li><b>Цена:</b> {$post->getAttr(15)|number_format:0:'.':' '} USD</li>{/if}
                                {if $post->getAttr(17) != 0}<li><b>Продажа доли бизнеса:</b> {$post->getAttr(17)}%</li>{/if}
                                {if $post->getAttr(18) != 0}<li><b>Срок существования, лет:</b> {$post->getAttr(18)}</li>{/if}
                                {if $post->getAttr(19) != 0}<li><b>Количество сотрудников:</b> {$post->getAttr(19)} чел.</li>{/if}
                                {if $post->getAttr(20) != 0}<li><b>Окупаемость бизнеса, лет:</b> {$post->getAttr(20)}</li>{/if}
                                {if $post->getAttr(21) != 0}<li><b>Оборот, за последний год:</b> {$post->getAttr(21)|number_format:0:'.':' '} USD</li>{/if}
                                {if $post->getAttr(22) != 0}<li><b>EBITDA, за последний год:</b> {$post->getAttr(22)|number_format:0:'.':' '} USD</li>{/if}
                                {if $post->getAttr(23) != 0}<li><b>Чистая прибыль, за последний год:</b> {$post->getAttr(23)|number_format:0:'.':' '} USD</li>{/if}
                            </ul>
                        {/if}
                        {* Realestate *}
                        {if $post->getParent() && $post->getParent()->getId() == 7862}
                            <ul class="list_attr">
                                <li><b>Тип недвижимости:</b> {$post->printAttr(39)}</li>
                                {if $post->getAttr(41) != 0}<li><b>Общая площадь недвижимости:</b> {$post->getAttr(41)} кв.м.</li>{/if}
                                {if $post->getAttr(15) != 0}<li><b>Цена:</b> {$post->getAttr(15)|number_format:0:'.':' '} USD</li>{/if}
                                {if $post->getAttr(42) != 0}<li><b>Площадь земельного участка:</b> {$post->getAttr(42)} га</li>{/if}
                                {if $post->getAttr(43) != 0}<li><b>Валовый доход недвижимости за последний год:</b> {$post->getAttr(43)|number_format:0:'.':' '} USD</li>{/if}
                                {if $post->getAttr(40) != 0}<li><b>Форма собственности земельного участка:</b> {$post->getAttr(40)}</li>{/if}
                            </ul>
                        {/if}
                        {* Land *}
                        {if $post->getParent() && $post->getParent()->getId() == 7863}
                            <ul class="list_attr">
                                <li><b>Целевое назначение земельного участка:</b> {$post->printAttr(24)}</li>
                                {if $post->getAttr(25) != 0}<li><b>Площадь земельного участка:</b> {$post->getAttr(25)} га</li>{/if}
                                {if $post->getAttr(15) != 0}<li><b>Стоимость продажи земельного участка:</b> {$post->getAttr(15)|number_format:0:'.':' '} USD</li>{/if}
                                {if $post->getAttr(26) != 0}<li><b>Коммуникации:</b> {$post->getAttr(26)}</li>{/if}
                                {if $post->hasAttr(27)}<li><b>Форма собственности:</b> {$post->printAttr(27)}</li>{/if}
                            </ul>
                        {/if}
                        {* Offer *}
                        {if $post->getParent() && $post->getParent()->getId() == 7864}
                            <ul class="list_attr">
                                {if $post->getAttr(16)}
                                    {$t = $post->printAttr(16)->getChilds()}
                                    <li><b>Отрасль:</b> {$t.0->getChilds()|array_pop}</li>
                                    {if $t.1}<li><b>Вид деятельности:</b> {$t.1->getChilds()|array_pop}</li>{/if}
                                {/if}
                                <li><b>Форма инвестирования:</b> {$post->printAttr(28)}</li>
                                <li><b>Тип инвестора:</b> {$post->printAttr(29)}</li>
                                {if $post->getAttr(30) != 0}<li><b>Минимальная сумма инвестиций:</b> {$post->getAttr(30)|number_format:0:'.':' '} USD</li>{/if}
                                {if $post->getAttr(31) != 0}<li><b>Максимальная сумма инвестиций:</b> {$post->getAttr(31)|number_format:0:'.':' '} USD</li>{/if}
                            </ul>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="columns">
                <ul class="inline-list share-btn">
                    <li><span class='st_vkontakte_hcount' displayText='Vkontakte'></span></li>
                    <li><span class='st_facebook_hcount' displayText='Facebook'></span></li>
                    <li><span class='st_twitter_hcount' displayText='Tweet'></span></li>
                    <li><span class='st_linkedin_hcount' displayText='LinkedIn'></span></li>
                    <li><span class='st_googleplus_hcount' displayText='Google +'></span></li>
                </ul>
            </div>
        </div>
        <div class="row" itemscope itemtype="http://schema.org/articleBody">
            <div class="columns">
                <div class="viewbox-cnt-body m_b-20" itemprop="text">
                    {if substr($post->getPath(),0,12) == '/tools/video'}
                        <iframe class="video-iframe video-content" src="//www.youtube.com/embed/{$post->printAttr("55")}" frameborder="0" allowfullscreen></iframe>
                    {/if}
                    {content $post}
                </div>
                {block after_content}{/block}
                {if substr($post->getPath(),0,14) != '/tools/experts' && substr($post->getPath(),0,9) != '/services' && substr($post->getPath(),0,13) != '/tools/atlas/' && substr($post->getPath(),0,16) != '/tools/database/'}
                    {if count($post->getImages())>1}
                        <div  class="viewbox-cnt-body m_b-20" id="photosContent">
                            <h2>Галерея</h2>
                            <section id="newsThumb">
                                {foreach $post->getImages() as $image key=$key++}
                                    {assign var=keys value='thumbSmall_'|cat:$key}
                                    {if $image != $post->getImage()}
                                        <a href="#" data-reveal-id="{$keys}">
                                            <img itemprop="image" src="{if substr($post->getPath(),0,14) == '/tools/experts'}/img/thumb.310.225{$image->getUrl()}{else}/img/resize.310.225{$image->getUrl()}{/if}" alt="{$post->getTitle()}" />
                                        </a>
                                    {/if}
                                {/foreach}
                            </section>
                        </div>
                    {/if}
                {/if}
                {if substr($post->getPath(),0,12) == '/investments'}
                    <div class="viewbox-cnt-body m_b-20">
                        <h2>Контакты</h2>
                        <ul class="list">
                        {if $post->getAttr(5) && $post->getAttr(4) && $post->getAttr(3)}
                            <li><b>Имя:</b> {$post->getAttr(5)}</li>
                            <li><b>E-Mail:</b> <a href="mailto:{$post->getAttr(5)}">{$post->getAttr(4)}</a></li>
                            <li><b>Телефон:</b> <a href="tel:{$post->getAttr(3)}">{$post->getAttr(3)}</a></li>
                        {else}
                            <li><b>Имя:</b> Алексей Олейников</li>
                            <li><b>E-Mail:</b> <a href="mailto:info@inventure.ua">info@inventure.ua</a></li>
                            <li><b>Телефон:</b> <a href="tel:+380677136571">+38(067)713-65-71</a></li>
                        {/if}
                        </ul>
                    </div>
                {/if}
                {$loc = $post->getAttr(10)}
                {if $loc.lat && $loc.lng}
                <div class="viewbox-cnt-body mt-6 m_b-20" id="eventMapBlock">
                    <h2>Расположение</h2>
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
                <div id="newsComments">
                    <h2>Комментарии</h2>
                    <div id="disqus_thread"></div>
                    <script type="text/javascript">
                        /* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
                        var disqus_shortname = 'inventure1'; // required: replace example with your forum shortname

                        /* * * DON'T EDIT BELOW THIS LINE * * */
                        (function() {
                            var dsq = document.createElement('script');
                            dsq.type = 'text/javascript';
                            dsq.async = true;
                            dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
                            (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
                        })();
                    </script>
                    <noscript>Please enable JavaScript to view the <a href="http://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
                    <a href="http://disqus.com" class="dsq-brlink">comments powered by <span class="logo-disqus">Disqus</span></a>
                </div>
            </div>
        </div>
    </div>
    <div class="large-4 medium-4 columns">
        <h4 class="right"><a href="/about/advertising"><img class="icon16 add-r" src="/i/-.gif" alt="">Разместить рекламу</a></h4>
        <div class="viewbox-cnt m_b-15">
            <div id="admixer_async_1283519614" class="banner-box-small"></div>
            <script type="text/javascript">
                window.admixZArr = (window.admixZArr || []);
                window.admixZArr.push({ z: 'df55cc56-7813-4d86-9255-da4a4b2ac11d', ph: 'admixer_async_1283519614'});
            </script>
        </div>
        <div class="viewbox-cnt m_b-15">
            <div id="admixer_async_33733653" class="banner-box-small"></div>
            <script type="text/javascript">
                window.admixZArr = (window.admixZArr || []);
                window.admixZArr.push({ z: 'a5dcdc85-8b36-4f87-8680-fd309c5a733f', ph: 'admixer_async_33733653'});
            </script>
        </div>
        <div class="viewbox-cnt m_b-15">
            <div class="banner-box-small">
                <div id="fb-root"></div>
                <script>(function(d, s, id) {
                  var js, fjs = d.getElementsByTagName(s)[0];
                  if (d.getElementById(id)) return;
                  js = d.createElement(s); js.id = id;
                  js.src = "//connect.facebook.net/ru_RU/sdk.js#xfbml=1&appId=1496357613960784&version=v2.0";
                  fjs.parentNode.insertBefore(js, fjs);
                }(document, 'script', 'facebook-jssdk'));</script>
                <div class="fb-like-box" data-href="https://www.facebook.com/inventure.com.ua" data-width="240px" data-height="420px" data-colorscheme="light" data-show-faces="true" data-header="false" data-stream="false" data-show-border="false"></div>
            </div>
        </div>
    </div>
</div>

<div id="thumbBig" class="reveal-modal large medium" data-reveal>
    <img itemprop="image" src="{$post->getImage()->getUrl()}" alt='{$post->getTitle()}' />
    <p><b>{$post->getTitle()}</b></p>
    <a class="close-reveal-modal">&#215;</a>
</div>
{if count($post->getImages())>1}
    {foreach $post->getImages() as $image key=$iKey++}
        {assign var=ketch value='thumbSmall_'|cat:$iKey}
        {if $image != $post->getImage()}
            <div id="{$ketch}" class="reveal-modal large medium" data-reveal>
                <img itemprop="image" src="{$image->getUrl()}" alt='{$post->getTitle()}' />
                <p><b>{$post->getTitle()}</b></p>
                <a class="close-reveal-modal">&#215;</a>
            </div>
        {/if}
    {/foreach}
{/if}
