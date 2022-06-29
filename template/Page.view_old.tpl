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
{if !$page}{$page = $category}{/if}
{if !$page}{$page = $rubric}{/if}
{if !$page}{$page = $blog}{/if}
{block 'config'}{/block}

{assign "isFullView" value=($request->getPathInfo() == '/add-inv-prop' || $request->getPathInfo() == '/digest-social' || $request->getPathInfo() == '/en/add-inv-prop' || $request->getPathInfo() == '/investor' || $request->getPathInfo() == '/en/investor')}
{assign "isInvestmentsPage" value=($request->getPathInfo() == '/investments')}

<div itemscope itemtype="http://schema.org/WebPage" class="{block 'page.class'}grid-container {if $request->getPathInfo() == '/investor' || $request->getPathInfo() == '/en/investor' || $request->getPathInfo() == '/uk/investor'}investor-form{else}the_post{/if}{/block}">

    <div class="grid-x grid-margin-x">
        <div class="{if $isFullView}large-12{else}large-9{/if} medium-12 cell">
            {block 'page.title'}
            <div class="{if $isFullView}section__title{else}clearfix border-bottom{/if}">
                {content $editable part="title" tag="h1" attrs=['itemprop'=>'headline']}
            </div>
            {/block}
            {block 'breadcrumbs'}
            <div class="clearfix">
                <ul class="breadcrumbs-box">
                    <li><a href="/">{site_name()}</a></li>
                    <li class="current">{$page->getH1()|truncate:75:" ..."|trim}</li>
                </ul>
            </div>
            {/block}
            {block 'menu'}{/block}
            {block 'filter'}{/block}
            {block 'content'}
            <div class="wrapper" itemprop="mainEntity" {block 'page.scope'}itemtype="http://schema.org/CreativeWork"{/block} itemscope>
                {if !$isFullView}<div class="box-shadow"></div>{/if}
                <div class="viewbox-cnt-body m_b-20">
                    {block 'content.text'}
                        {content $editable attr=['class'=>'the_post_content', 'itemprop'=>'text']}
                    {/block}
                </div>
            </div>
            {/block}
        </div>
        {if !$isFullView}
            <div class="cell large-3 medium-12">
                {block 'aside.top'}
                <aside class="sidebar">
                {if $isInvestmentsPage}

                <form action="/investments" id="invest-filter" class="filter__wrapper">
                        <div class="filter__selectors">
                        <div class="filter__title"><span>Фильтрация</span>  
                        <div class="filter__heading-filter toggle-filter">
                            <i class="fa fa-close" aria-hidden="true"></i>
                        </div>
                    </div>
                    <div class="filter__selector">
                    <label class="filter__row" for="">
                        <span class="filter__label">Тип</span>
                        <select class="" id="filter__type" name="filter[category][parent]" multiple="multiple">
                            <option value="projects">Инвестиционные проекты и стартапы</option>
                            <option value="business">Продажа бизнеса</option>
                            <option value="realestate">Недвижимость</option>
                            <option value="land">Земля</option>
                            <option value="franchising">Франчайзинг</option>
                            <option value="offer">Предложения инвесторов</option>
                        </select>
                    </label>
                    </div>
                    
                    <div class="filter__selector">
                    <label class="filter__row" for="">
                        <span class="filter__label">Отрасль</span>
                        <select class="" id="branch" name="filter[attr_16][0]" multiple="multiple">
                            <option value="0">Сельское хозяйство</option>
                            <option value="16">Пищевая промышленность</option>
                            <option value="1">Добывающая промышленность</option>
                            <option value="12">Металлургия и металлообработка</option>
                            <option value="11">Машиностроение и производство электрооборудования</option>
                            <option value="23">Нефтехимическая промышленность</option>
                            <option value="8">Деревообработка и целлюлозно-бумажная промышленность</option>
                            <option value="20">Текстильная промышленность</option>
                            <option value="4">Строительство и недвижимость</option>
                            <option value="22">Финансовая деятельность</option>
                            <option value="6">Бизнес услуги</option>
                            <option value="21">Транспорт и складское хозяйство</option>
                            <option value="19">ИТ и Телекоммуникации</option>
                            <option value="18">Розничная торговля</option>
                            <option value="14">Оптовая торговля</option>
                            <option value="10">Искусство, развлечения, спорт и отдых</option>
                            <option value="2">Энергообеспечение</option>
                            <option value="3">Водообеспечение и переработка отходов</option>
                            <option value="24">Инновации и высокие технологии</option>
                            <option value="7">Государственное управление</option>
                            <option value="17">Гостиницы и общественное питание</option>
                            <option value="9">Здравоохранение и социальная помощь</option>
                            <option value="5">Потребительские услуги</option>
                            <option value="13">Образование</option>
                            <option value="15">Организации и ассоциации</option>
                        </select>
                    </label>
                    </div>
                    
                    <div class="filter__selector">
                        <label  class="filter__row" for="">
                            <span class="filter__label">Регион</span>
                            <select name="filter[attr_10]" id="regions" multiple="multiple">
                            <option value="Kiev">Киев</option>
                            <option value="Ukraine">Украина</option>
                            <option value="SNG">СНГ</option>
                            <option value="Central and Western Europe">Центральная и Восточная Европа</option>
                            <option value="Eastern Europe">Западная Европа</option>
                            <option value="USA">США</option>
                            <option value="Asia">Азия</option>
                            </select>
                        </label>
                    </div>
                        
                    <div class="filter__selector filter__selector--price">
                        <label  class="filter__row" for="">
                        <span class="filter__label">Цена от</span>
                        <select name="price1" class="multiple-select" data-single="true">
                            <option selected value="">0 $</option>
                            <option value="10000">10 000 $</option>
                            <option value="50000">50 000 $</option>
                            <option value="100000">100 000 $</option>
                            <option value="250000">250 000 $</option>
                            <option value="500000">500 000 $</option>
                            <option value="1000000">1 000 000 $</option>
                            <option value="5000000">5 000 000 $</option>
                            <option value="5000000+">5 000 000+ $</option>
                        </select>
                        </label>
                        <label  class="filter__row" for="">
                        <span class="filter__label">До</span>
                        <select name="price2" class="multiple-select" data-single="true">
                            <option value="10000">10 000 $</option>
                            <option value="50000">50 000 $</option>
                            <option value="100000">100 000 $</option>
                            <option value="250000">250 000 $</option>
                            <option value="500000">500 000 $</option>
                            <option value="1000000">1 000 000 $</option>
                            <option value="5000000">5 000 000 $</option>
                            <option selected value="">5 000 000+ $</option>
                        </select>
                        </label>
                    </div>
                    </div>
                    <button class="newsletter__button newsletter__button--darken">Фильтровать</button>
                </form>
                {/if}


                {if $lang == 'en'}
                    <a href="/en/investor" class="invest_btn">invest</a>
                {else}
                    <a href="/investor" class="invest_btn">инвестировать</a>
                {/if}
                {if $lang == 'en'}
                    <a href="/en/add-inv-prop" class="invest_btn invest_btn1">find an investor</a>
                {else}
                    <a href="/add-inv-prop" class="invest_btn invest_btn1">найти инвестора</a>
                {/if}
                {/block}
                {block 'aside.subscribe'}
                    
                    {if $lang == 'en'}
                        <div class="newsletter-side">
                          <div class="box-shadow"></div>
                          <img src="/images/newsletter-icon.svg" alt="" class="newsletter-side__img">
                          <div class="newsletter-side__heading">
                            Subscribe to our Newsletter
                        </div>
                          <button class="newsletter-side__button open_popup">Subscribe</button>
                        </div>

                    {else}
                        {* <div class="newsletter-side">
                          <div class="box-shadow"></div>
                          <img src="/images/newsletter-icon.svg" alt="" class="newsletter-side__img">
                          <div class="newsletter-side__heading">Хотите получать нашу ежемесячную рассылку?</div>
                          <button class="newsletter-side__button open_popup">Подписаться</button>
                        </div> *}
                        {load_digests}
        
                        {assign var=digest value=$digests|@end} 
                        
                        <form action="/!Mail" class="subscription__form sidebar">
                            <a href="{$digest->getUrl()}">
                                <img src="{if $digest->getImage()}{$digest->getImage()->thumbup(120,170)->getUrl()}{else}/img/thumbup.120.170/images/newsletters/{$digest->getPubDate()->format('Y-n')}.png{/if}" alt="" class="subscription__img">
                            <a>
                            <div class="subscription__tablet">
                                    <a href="/analytics/digest" class="subscription__title">
                                        Инвестиционный дайджест InVenture
                                    </a>
                                </div>
                            <div class="subscription__row">
                                <label>
                                    Имя
                                </label>
                                <input name="subscribe[firstname]" type="text" class="subscription__input" required>
                            </div>
                            <div class="subscription__row">
                                <label>
                                    Фамилия
                                </label>
                                <input name="subscribe[lastname]" type="text" class="subscription__input" required>
                            </div>
                            <div class="subscription__row">
                                <label>
                                    Компания
                                </label>
                                <input name="subscribe[company]" type="text" class="subscription__input" required>
                            </div>
                            <div class="subscription__row">
                                <label>
                                    Должность
                                </label>
                                <input name="subscribe[job]" type="text" class="subscription__input" required>
                            </div>
                            <div class="subscription__row">
                                <label>
                                        E-mail
                                </label>
                                <input name="subscribe[email]" type="email" class="subscription__input" required>
                            </div>
                            <div class="subscription__row">
                                <label>
                                        Номер телефона
                                </label>
                                <div class="pageviev-form">
                                <input name="subscribe[phone]" type="text" class="subscription__input" id="phone2" data-plugin-inputmask="inputmask_5de8d519" required>
                                <span id="valid-msg2" class="hide">✓ Valid</span>
                                <span id="error-msg2" class="hide"></span>
                                <script>
                                var input2 = document.querySelector("#phone2");
                                window.intlTelInput(input2, {
                                dropdownContainer: document.body,
                                utilsScript: "/js/utils.js",
                                });
                                </script>
                                </div>
                            </div>
                            <div class="subscription__check-block">
                                <div class="subscription__check-item" onclick="changeCheckBox('ru')">
                                    <div id="check-box-ru"  class="subscription__check-box subscription__check-box--active">
                                            <svg width="14" height="11" viewBox="0 0 14 11" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <path fill-rule="evenodd" clip-rule="evenodd" d="M12.933 1.13796C12.5104 0.677973 11.8087 0.677973 11.3861 1.13796L5.16652 7.89884L2.62286 5.10422C2.1843 4.65292 1.49855 4.65292 1.05999 5.12158C0.64535 5.59024 0.64535 6.33663 1.06796 6.81397L4.34521 10.3637L4.39306 10.4244C4.82364 10.9017 5.51737 10.9017 5.94795 10.4244L12.933 2.82167C13.3557 2.35301 13.3557 1.59794 12.933 1.13796Z" fill="white"/>
                                            </svg>
                                    </div>
                                    <span class="subscription__check-label">
                                            Русский
                                    </span>
                                    <input type="checkbox" value="ru" name="subscribe[lang][]" id="check-ru" checked="true" hidden>
                                </div>
                                <div onclick="changeCheckBox('en')" class="subscription__check-item">
                                        <div id="check-box-en" class="subscription__check-box">
                                                <svg width="14" height="11" viewBox="0 0 14 11" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                    <path fill-rule="evenodd" clip-rule="evenodd" d="M12.933 1.13796C12.5104 0.677973 11.8087 0.677973 11.3861 1.13796L5.16652 7.89884L2.62286 5.10422C2.1843 4.65292 1.49855 4.65292 1.05999 5.12158C0.64535 5.59024 0.64535 6.33663 1.06796 6.81397L4.34521 10.3637L4.39306 10.4244C4.82364 10.9017 5.51737 10.9017 5.94795 10.4244L12.933 2.82167C13.3557 2.35301 13.3557 1.59794 12.933 1.13796Z" fill="white"/>
                                                </svg>
                                        </div>
                                        <span class="subscription__check-label">
                                                Английский
                                        </span>
                                    <input type="checkbox" value="en" name="subscribe[lang][]" id="check-en" hidden>
                                </div>
                            </div>
                            <input name="subscribe[ga_utm]" hidden type="hidden">
                            <button type="submit" class="subscription__button g-recaptcha зage-view-old" data-sitekey="6Le8bI8fAAAAAFT1lTrt6gL31hrhm8mFfc4nKmbX" data-callback="submitDigest">
                                    Подписаться
                            </button>
                        </form>
                    {/if}

                {/block}
                {block 'aside.banner'}
                    <div class="advertising" id="advertising">
                        <div class="box-shadow"></div>
                        {#mod Widget}
                        {widget_slot 'main (370x450)' size=[370,450]}
                        {widget_slot 'post_2 (370x450)' size=[370,450]}
                        {widget_slot 'post_6 (370x450)' size=[370,450]}
                        {widget_slot 'post_7 (370x450)' size=[370,450]}
                        {widget_slot 'post_8 (370x450)' size=[370,450]}
                        {#/mod}
                    </div>
                {/block}
                </aside>
            </div>
        {/if}
    </div>
</div>


{if !$isFullView}
    <div class="dark_bg"></div>
    <div class="my_popup ">
      {#mod Mail}
            
          <div class="my_popup__wrapper">
            {if $lang == 'en'}
                <h5>Fill in the contact details to receive the monthly newsletter!</h5>
            {else}
                <h5>Заполните, пожалуйста, ваши контактные данные, чтобы получать ежемесячную рассылку!</h5>
            {/if}
              
              <i class="fa fa-close"></i>
              {subscribe}
          </div>
      {#/mod}
    </div>
{/if}
