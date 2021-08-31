{* prefilter=off *}
{* height: calc(100% - 80px); *}
<div class="index-page">
  <div class="container container--main container--post the_post inventure_list">
    <main class="main large-9">
      {include 'components/invest-list'}
    </main>
    <aside class="sidebar sidebar--index desktop-only">
      {include 'components/promo-links'}
      {include 'components/invest-filter'}
    </aside>
  </div>
  <div class="container">
    <div class="show-more show-more--big">
      <a href="/investments" class="show-more__btn font-medium ">Показать все</a>
    </div>
  </div>

  {include 'components/newsletter-full'}

  <div class="container container--main container--post the_post inventure_list mt-6">
    <main class="main large-9">
      <section>
        {* news *}
        <h2 class="section__title-categories"><a href="/news">Новости</a></h2>
        
        <nav class="section__categories">
            <a class="section__category" href="/news/investments">Прямые инвестиции и M&A</a>
            <a class="section__category" href="/news/startup">Стартапы</a>
            <a class="section__category" href="/news/government">Макроинвестиции</a>
            <a class="section__category" href="/news/banking">Кредитование</a>
            <a class="section__category" href="/news/stock">Фондовый рынок</a>
            <a class="section__category" href="/news/realestate">Недвижимость</a>
        </nav>

        {lent_load '/news' 6 var="news_all" analytics=1}
        <div class="cards">
          {foreach $news_all as $post}
            {include 'components/card-post-without-desc'}
          {/foreach}
        </div>
        <div class="show-more">
          <a href="/news" class="show-more__btn font-medium ">Показать все</a>
        </div>
      </section>
      
      <section>
        <h2 class="section__title-categories"><a href="/analytics">Аналитика</a></h2>
        <nav class="section__categories">
          <a class="section__category" href="/analytics/investments">Исследования</a>
          <a class="section__category" href="/analytics/articles">Статьи</a>
          <a class="section__category" href="/analytics/formula">Интервью</a>
          <a class="section__category" href="/analytics/we-invest-in-ukraine">Инвестируем в Украину</a>
          <a class="section__category" href="/tools/database">Рейтинги</a>
          <a class="section__category" href="/tools/library">Библиотека</a>
          <a class="section__category" href="/tools/investors">Инвесторы</a>
        </nav>
        {$invest=[]}
        {lent_load '/analytics' 6 var='analytics' analytics=1}
          <div class="cards">
            {foreach $analytics as $post}
              {include 'components/card-post-without-desc'}
            {/foreach}
          </div>

        <div class="show-more">
          <a href="/analytics" class="show-more__btn font-medium ">Показать все</a>
        </div>
      </section>
      
      <section>
        <h2 class="section__title-categories"><a href="/tools/events">Мероприятия</a></h2>
        {$event=[]}
        <div class="cards cards--event">
         {* <a href="#" class="cards__item event">
              <div class="event__date">
                <div class="event__day font-semibold">
                  12
                </div>
                <div class="event__month">
                  April
                </div>
              </div>
              <img alt="Ukrainian Gaming Week" class="lazyimg cards__img desktop-only" data-src="/img/thumbup.350.254/upload/10001_.jpg">                     
              <div class="cards__img-wrapper mobile-only">
                <img alt="Ukrainian Gaming Week" class="cards__img" itemprop="image" src="/img/thumbup.350.254/upload/10001_.jpg" width="350" height="254">
              </div>
              <div class="desktop-ml-4 desktop-mr-4">
                <h2 class="cards__title ine-clamp line-clamp--1" itemprop="headline">Ukrainian Gaming Week</h2>
                <div itemprop="description" class="the_shorttext line-clamp line-clamp--2">16-17 июня компания Smile-Expo проведет масштабное событие об игорном бизнесе</div>
              </div>
            </a> *}
          {events 4 var='events' analytics=1}
          {$event[]=$events}
            <a href="{$lent->getPath()}" class="cards__item event">
              <div class="event__date">
                <div class="event__day font-semibold">
                  {$events->getAttr(7)->format('d')}
                </div>
                <div class="event__month">
                  {$events->getAttr(7)->format('m')}
                </div>
              </div>
              <img alt="{$lent->getTitle()}" class="lazyimg cards__img desktop-only" data-src="/img/thumbup.236.170{$lent->getImage()->getUrl()}">                     
              <div class="cards__img-wrapper mobile-only">
                <img alt="{$lent->getTitle()}" class="lazyimg cards__img" itemprop="image" data-src="/img/thumbup.236.170{$lent->getImage()->getUrl()}" width="350" height="254">
              </div>

              <div class="desktop-ml-4 desktop-mr-4">
                {block 'post.title'}<h2 class="cards__title ine-clamp line-clamp--1" itemprop="headline">{$post->getH1()}</h2>{/block}
                {block 'post.description'}
                    <div itemprop="description" class="the_shorttext line-clamp line-clamp--2">{$post->getShortText()|truncate:200:"  ..."}</div>
                {/block}
              </div>
            </a>
          {/events}
        </div>
        {* <div class="cell small-12 medium-6 large-6">
            <div class="event">
              <div class="img">
                <a href="{$events->getPath()}">
                  {if $events->getImage()}
                    <!-- {$events->getImage()->thumbup(120,90)} -->
                    <img class="lazyimg" data-src="{$events->getImage()->thumbup(120,90)->getUrl()}" alt='{$events->getTitle()}'>
                  {else}
                    <img class="the_img" src="/img/thumbup.120.90/images/noThumb.jpg" alt="{$events->getH1()}"/>
                  {/if}
                </a>
              </div>
              <div class="content">
                <h5><a href="{$events->getPath()}" >{$events->getTitle()}</a></h5>
                <div class="date">
                  <span><img src="/i/calendar.png"> {$events->getAttr(7)->format('d.m.Y')}</span>
                  <span><img src="/i/clock.png"> {$events->getAttr(7)->format('H:i')} - {$events->getAttr(8)->format('H:i')}</span>
                </div>
                <div class="category">
                  <img src="/i/pers.png" alt="" />{$events->getAttr(9)}
                </div>
              </div>
            </div>
          </div>

           *}
        <div class="show-more">
          <a href="/tools/events" class="show-more__btn font-medium ">Показать все</a>
        </div>
      </section>

      <section class="news">
        <h2 class="section__title-categories"><a href="/tools/video">Видео</a></h2>

        <div class="cards">
          {$video=[]}
          {lent '/tools/video' 4 var='news'}
          {$video[] = $news}
            <div class="cards__item video">
              <div class="cards__img-wrapper">
                {* <img alt="{$lent->getTitle()}" class="lazyimg cards__img" itemprop="image" data-src="/img/thumbup.236.170{$lent->getImage()->getUrl()}" width="350" height="254"> *}
                <div class="youtube cards__img" data-embed="{$news->printAttr("55")}">
                    <div class="play-button">
                      <svg width="70" height="70" viewBox="0 0 70 70" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <circle cx="35" cy="35" r="35" fill="#5E87B3"/>
                        <path d="M47.7961 32.577L47.7962 32.5771C48.7587 33.2356 49.1662 34.0294 49.166 34.7782V34.7785C49.166 35.525 48.7543 36.3204 47.7893 36.9816L29.6607 49.3816L29.66 49.382C28.921 49.8884 28.287 50.0852 27.8549 50.0852C27.4772 50.0852 27.2307 49.9489 27.0501 49.711C26.8452 49.4409 26.666 48.9532 26.666 48.1828V21.3812C26.666 20.6098 26.8454 20.121 27.051 19.8502C27.2322 19.6115 27.4798 19.4746 27.8592 19.4746C28.2936 19.4746 28.9416 19.6738 29.675 20.1761L29.6753 20.1763L47.7961 32.577Z" stroke="white" stroke-width="2"/>
                      </svg>
                    </div>
                </div>
              </div>
              <a href="{$news->getPath()}"> <h2 class="mt-2">{$news->getTitle()}</h2></a>
            </div>
          {/lent}
        </div>
        <div class="show-more">
          <a href="/tools/video" class="show-more__btn font-medium ">Показать все</a>
        </div>
      </section>
      
    </main>
    <aside class="sidebar without-promo-links desktop-only ">
      {include 'components/sidebar'}
    </aside>
  </div>


  {* <a href="{$lent->getPath()}" class="info">
    <div class="statistic">
      <div class="date">
        {$news->getPublished()->format('d.m.y')}
      </div>
      <div class="views">
        <img src="/i/views.png">
        {$news->getViews()}
      </div>
    </div>
    <h4><a href="{$news->getPath()}">{$news->getTitle()}</a></h4>
  </a> *}


  {$month=[1=>"января","февраля", "марта","апреля", "мая", "июня", "июля", "августа", "сентября", "октября", "ноября", "декабря"]}
  {$date=strtotime('-30 day')}
  <div class="grid-container investment_proposals" id="investment">
        <div class="grid-x grid-margin-x">
          <div class="cell small-12 large-9">
            <section class="investment">
              <div class="title">
                <h2 class="filter__heading">
                  <a href="/investments">Инвестиционные предложения</a>
                  <div class="filter__heading-filter toggle-filter">
                    <i class="fa fa-filter" aria-hidden="true"></i>
                  </div>
                </h2>
              </div>
              <nav>
                <a href="/investments/projects">Инвестиционные проекты и стартапы</a> |
                <a href="/investments/business">Продажа бизнеса</a> |
                <a href="/investments/realestate">Недвижимость</a> |
                <a href="/investments/land">Земля</a> |
                <a href="/investments/franchising">Франчайзинг</a> |
                <a href="/investments/offer">Инвесторы</a>
              </nav>
              <div class="mobile_category">
                <a href="/investments/projects">Инвестиционные проекты и стартапы</a><i class="fa fa-chevron-right"></i><i class="fa fa-chevron-down"></i>
                <ul>
                    <li><a href="/investments/business">Продажа бизнеса</a></li>
                    <li><a href="/investments/realestate">Недвижимость</a></li>
                    <li><a href="/investments/land">Земля</a></li>
                    <li><a href="/investments/franchising">Франчайзинг</a></li>
                    <li><a href="/investments/offer">Предложения инвесторов</a></li>
                </ul>
              </div>
              <article>
                <div class="grid-x grid-margin-x">
                  <div class="cell small-12 medium-5 large-5 ">
                  {lent_load '/investments' 6 var="posts" analytics=1}
                  {$bigpost=array_shift($posts)}
                    <div style="position: relative;">
                      <div class="box-shadow"></div>
                      <div class="title-news">
                        <div class="img">
                          <a href="{$bigpost->getPath()}">
                            {if $bigpost->getImage()}
                              {$bigpost->getImage()->thumbup(350,254)}
                            {else}
                              <img class="the_img" src="/img/resize.375.225/images/noThumb.jpg" alt="{$bigpost->getH1()}"/>
                            {/if}
                          </a>
                        </div>
                        <div class="info">
                          <div class="statistic">
                            <div class="date">
                              {$bigpost->getPublished()->format('d.m.y')}
                            </div>
                            <div class="views">
                              <img src="/i/views.png">
                              {$bigpost->getViews()}
                            </div>
                            <div class="rating">
                              <img src="/i/rating.png">
                              {$bigpost->getAttr(13)|number_format:1}
                            </div>
                          </div>
                          <div class="category">
                            {if $bigpost->getParent()->getId() == 7860}
                                <a href="{$bigpost->getParent()->getPath()}"><img src="/i/projects.png" alt="" />{$bigpost->getParent()->getH1()}</a>
                            {elseif $bigpost->getParent()->getId() == 7861}
                                <a href="{$bigpost->getParent()->getPath()}"><img src="/i/business.png" alt="" />{$bigpost->getParent()->getH1()}</a>
                            {elseif $bigpost->getParent()->getId() == 7862}
                                <a href="{$bigpost->getParent()->getPath()}"><img src="/i/realestate.png" alt="" />{$bigpost->getParent()->getH1()}</a>
                            {elseif $bigpost->getParent()->getId() == 7863}
                                <a href="{$bigpost->getParent()->getPath()}"><img src="/i/land.png" alt="" />{$bigpost->getParent()->getH1()}</a>
                            {elseif $bigpost->getParent()->getId() == 7864}
                                <a href="{$bigpost->getParent()->getPath()}"><img src="/i/offer.png" alt="" />{$bigpost->getParent()->getH1()}</a>
                            {else}
                                <span></span>
                            {/if}
                          </div>
                          <h4><a href="{$bigpost->getPath()}">{$bigpost->getTitle()}</a></h4>
                          <p>{$bigpost->getShortText()|truncate:150:"  ..."}</p>
                          <div class="position">
                            <div class="place">
                              <img src="/i/ukraine.png">{if $bigpost->hasAttr("10")} {$bigpost->printAttr("10")}{/if}
                            </div>
                            <hr>
                            <div class="footer">
                              <div>
                              {if $bigpost->getParent()->getId() == 7861 || $bigpost->getParent()->getId() == 7862 ||$bigpost->getParent()->getId() == 7863}
                                <p><span style="font-weight: 700;">ЦЕНА</span> -
                                {if $bigpost->hasAttr("15")} ${$bigpost->printAttr("15")|number_format:0:'.':' '}{/if}</p>
                              {elseif $bigpost->getParent()->getId() == 7860}
                                <p><span style="font-weight: 700;">ИНВЕСТИЦИИ</span> -
                                {if $bigpost->hasAttr("34")} ${$bigpost->printAttr("34")|number_format:0:'.':' '}{/if}</p>
                              {elseif $bigpost->getParent()->getId() == 7864}
                                <p><span style="font-weight: 700;">ИНВЕСТИЦИИ</span> -
                                {if $bigpost->hasAttr("31")} ${$bigpost->printAttr("31")|number_format:0:'.':' '}{/if}</p>
                                {/if}
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="cell small-12 medium-7 large-7">
                    <div class="tabs">
                      <ul class="tabs__caption">
                        <li class="active">Новые</li>
                        <li>Популярные</li>
                        <li>Лучшие</li>
                        <!--<li>По цене <i class="fa fa-arrow-up"></i></li>
                        <li>По цене <i class="fa fa-arrow-down"></i></li>-->
                      </ul>

                      <div class="tabs__content  active">
                        {foreach $posts as $post}
                        <div class="item">
                          <div class="img">
                            <a href="{$post->getPath()}" >
                            {if $post->getImage()}
                                <!-- {$post->getImage()->thumbup(120,90)} -->
                                <img class="lazyimg" data-src="{$post->getImage()->thumbup(120,90)->getUrl()}" alt='{$post->getTitle()}'>
                                
                              {else}
                                <img class="the_img" src="/img/thumbup.120.90/images/noThumb.jpg" alt="{$post->getH1()}"/>
                              {/if}
                            </a>
                          </div>
                          <div class="content">
                            <h4><a href="{$post->getPath()}">{$post->getTitle()}</a></h4>
                            <div class="statistic">
                              <div class="date">
                                {$post->getPublished()->format('d.m.y')}
                              </div>
                              <div class="views">
                                <img src="/i/views.png">
                                {$post->getViews()}
                              </div>
                              <div class="rating">
                                <img src="/i/rating.png">
                                {$post->getAttr(13)|number_format:1}
                              </div>
                            </div>
                          </div>
                        </div>
                        {/foreach}
                        <a href="/investments" class="more">Показать все</a>
                      </div>

                      <div class="tabs__content">
                        {lent '/investments' 5 order_by="a.views DESC" var='news' analytics=1 where="p.attr NOT LIKE '%\"attr58\":1%' AND p.published < '{$date|date_format:"%Y-%m-%d %H:%I:%S"}'"}
                        <div class="item">
                          <div class="img">
                            <a href="{$news->getPath()}" >
                              {if $news->getImage()}
                                <!-- {$news->getImage()->thumbup(120,90)} -->
                                <img class="lazyimg" data-src="{$news->getImage()->thumbup(120,90)->getUrl()}" alt='{$news->getTitle()}'>

                              {else}
                                <img class="the_img" src="/img/thumbup.120.90/images/noThumb.jpg" alt="{$news->getH1()}"/>
                              {/if}
                            </a>
                          </div>
                          <div class="content">
                              <h4><a href="{$news->getPath()}">{$news->getTitle()}</a></h4>
                            <div class="statistic">
                              <div class="date">
                                {$news->getPublished()->format('d.m.y')}
                              </div>
                              <div class="views">
                                <img src="/i/views.png">
                                {$news->getViews()}
                              </div>
                              <div class="rating">
                                <img src="/i/rating.png">
                                {$news->getAttr(13)|number_format:1}
                              </div>
                            </div>
                          </div>
                        </div>
                        {/lent}
                        <a href="/investments" class="more">Показать все</a>
                      </div>

                      <div class="tabs__content">
                        {lent '/investments' 5 order_by="a.rating DESC" var='news' analytics=1}
                        <div class="item">
                          <div class="img">
                            <a href="{$news->getPath()}" >
                              {if $news->getImage()}
                                <!-- {$news->getImage()->thumbup(120,90)} -->
                                <img class="lazyimg" data-src="{$news->getImage()->thumbup(120,90)->getUrl()}" alt='{$news->getTitle()}'>
                              {else}
                                <img class="the_img" src="/img/thumbup.120.90/images/noThumb.jpg" alt="{$news->getH1()}"/>
                              {/if}
                            </a>
                          </div>
                          <div class="content">
                              <h4><a href="{$news->getPath()}">{$news->getTitle()}</a></h4>
                            <div class="statistic">
                              <div class="date">
                                {$news->getPublished()->format('d.m.y')}
                              </div>
                              <div class="views">
                                <img src="/i/views.png">
                                {$news->getViews()}
                              </div>
                              <div class="rating">
                                <img src="/i/rating.png">
                                {$news->getAttr(13)|number_format:1}
                              </div>
                            </div>
                          </div>
                        </div>
                        {/lent}
                        <a href="/investments" class="more">Показать все</a>
                      </div>
                    </div>
                  </div>
                </div>
              </article>
            </section>
          </div>
          <div class="cell large-3 medium-12">
            <aside class="sidebar">

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
                      <!-- select name="filter[attr_10]" id="regions" multiple="multiple">
                        <option value="Kiev">Киев</option>
                        <option value="Ukraine">Украина</option>
                        <option value="SNG">СНГ</option>
                        <option value="Central and Western Europe">Центральная и Восточная Европа</option>
                        <option value="Eastern Europe">Западная Европа</option>
                        <option value="USA">США</option>
                        <option value="Asia">Азия</option>
                      </select -->
                      <input type="text" name="region" id="region" value="">
                    </label>
                    <input type="hidden" name="filter[attr_10]" id="region_val" value="">
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


              <a href="/investor" class="invest_btn">инвестировать</a>
              <a href="/add-inv-prop" class="invest_btn invest_btn1">Найти инвестора</a>
              {* <div class="board">
                <div class="box-shadow"></div>
                <h3><a href="/board">Доска объявлений</a> <a href="/bulletin/add">+ Добавить объявление</a></h3>
                <div class="board1">
                  {lent '/board' 7 var='post'  analytics=1}
                  <div>
                    <span class="published">{$post->getPublished()->format('d.m.y')}</span>
                    <a href="/board#adv-{$post->getId()}">{$post->getH1()|truncate:100:"  ..."}</a>
                  </div>
                  {/lent}
                </div>
                <div class="buttons">
                  <a href="/board" class="a1">Другие объявления <i class="fa fa-chevron-right"></i></a>
                  <a href="/bulletin/add" class="a2">Добавить объявление</a>
                </div>
              </div> *}
            </aside>
          </div>
        </div>
      </div>

      {* <div class="newsletter">
        <div class="container grid-container">
          <div class="newsletter__title">Хотите получать нашу ежемесячную рассылку?</div>
          <p class="newsletter__text">Инвестиционный дайджест InVenture - все самое важное в сфере инвестиций за месяц, на 10 страницах, всего за 5 минут! <br><a target="_blank" id='last-news-link' href="/" class="newsletter__link">Скачать последний выпуск журнала</a></p>
          <div class="newsletter__buttons">
            <button class="newsletter__button newsletter__button--white open_popup">Подписаться</button>
            <a href="/analytics/digest" class="newsletter__button newsletter__button--darken">Смотреть архив</a>
          </div>
        </div>
        <div id="newsletter__archive" hidden>
          {load_digests}
          
          {assign var=digest value=$digests|@end} 
          <a class="m{$digest->getPubDate()->format('n')} y{$digest->getPubDate()->format('Y')}" href="{$digest->getUrl()}"></a>
        </div>
      </div> *}

      <div class="grid-container all_news" id="all_news">
        <div class="grid-x grid-margin-x">
          <div class="cell medium-12 large-9">
            <section class="news">
              <div class="title">
                <h2><a href="/news">Новости</a></h2>
              </div>
              <nav>
                <a href="/news/investments">Прямые инвестиции и M&A</a> |
                <a href="/news/startup">Стартапы</a> |
                <a href="/news/government">Макроинвестиции</a> |
                <a href="/news/banking">Кредитование</a> |
                <a href="/news/stock">Фондовый рынок</a> |
                <a href="/news/realestate">Недвижимость</a>
              </nav>
              <div class="mobile_category">
                <a href="/news/investments">Прямые инвестиции и M&A</a><i class="fa fa-chevron-right"></i><i class="fa fa-chevron-down"></i>
                <ul>
                    <li><a href="/news/startup">Стартапы</a></li>
                    <li><a href="/news/government">Макроинвестиции</a></li>
                    <li><a href="/news/banking">Кредитование</a></li>
                    <li><a href="/news/stock">Фондовый рынок</a></li>
                    <li><a href="/news/realestate">Недвижимость</a></li>
                </ul>
            </div>
              <article class="grid-container">
                <div class="grid-x grid-margin-x">
                  <div class="cell  bg-white  small-12 madium-5 large-5">
                    {lent_load '/news' 6 var="news_all" analytics=1}
            {$bignews=array_shift($news_all)}
                  <div style="position: relative;">
                    <div class="box-shadow"></div>
                    <div class="title-news">
                      <div class="img">
                        <a href="{$bignews->getPath()}">
                          {if $bignews->getImage()}
                            <!-- {$bignews->getImage()->thumbup(350,254)} -->
                            <img class="lazyimg" data-src="{$bignews->getImage()->thumbup(350,254)->getUrl()}" alt='{$bignews->getTitle()}'>
                          {else}
                            <img class="the_img" src="/img/thumbup.350.254/images/noThumb.jpg" alt="{$bignews->getH1()}"/>
                          {/if}

                              </a>
                      </div>
                      <div class="info">
                        <div class="statistic">
                          <div class="date">
                          {$bignews->getPublished()->format('d.m.y')}
                          </div>
                          <div class="views">
                            <img src="/i/views.png">
                            {$bignews->getViews()}
                          </div>
                        </div>
                        <h4><a href="{$bignews->getPath()}">{$bignews->getTitle()}</a></h4>
                        <p>{$bignews->getShortText()|truncate:300:"  ..."}</p>
                      </div>
                    </div>
                  </div>
                  </div>
                  <div class="cell small-12 medium-12 large-7">
                    <div class="tabs">
                            <ul class="tabs__caption">
                              <li class="active">Все</li>
                              <li>Украина</li>
                              <li>Мир</li>
                            </ul>

                            <div class="tabs__content  active">
                                {foreach $news_all as $news}
                        <div class="item">
                          <div class="img">
                              <a href="{$news->getPath()}" >
                              {if $news->getImage()}
                                <!-- {$news->getImage()->thumbup(120,90)} -->
                                <img class="lazyimg" data-src="{$news->getImage()->thumbup(120,90)->getUrl()}" alt='{$news->getTitle()}'>
                              {else}
                                <img class="the_img" src="/img/thumbup.120.90/images/noThumb.jpg" alt="{$news->getH1()}"/>
                              {/if}
                          </a>
                          </div>
                          <div class="content">
                              <h4><a href="{$news->getPath()}">{$news->getTitle()}</a></h4>
                            <div class="statistic">
                              <div class="date">
                              {$news->getPublished()->format('d.m.y')}
                              </div>
                              <div class="views">
                                <img src="/i/views.png">
                                {$news->getViews()}
                              </div>
                          </div>
                          </div>
                        </div>
                        {/foreach}
                        <a href="/news" class="more">Показать все</a>
                        </div>

                            <div class="tabs__content">
                              {lent '/news' 5 category="24" var='news' alaytics=1}
                        <div class="item">
                          <div class="img">
                              <a href="{$news->getPath()}" >
                              {if $news->getImage()}
                                <!-- {$news->getImage()->thumbup(120,90)} -->
                                <img class="lazyimg" data-src="{$news->getImage()->thumbup(120,90)->getUrl()}" alt='{$news->getTitle()}'>
                              {else}
                                <img class="the_img" src="/img/thumbup.120.90/images/noThumb.jpg" alt="{$news->getH1()}"/>
                              {/if}
                          </a>
                          </div>
                          <div class="content">
                              <h4><a href="{$news->getPath()}">{$news->getTitle()}</a></h4>
                              <div class="statistic">
                              <div class="date">
                              {$news->getPublished()->format('d.m.y')}
                              </div>
                              <div class="views">
                                <img src="/i/views.png">
                                {$news->getViews()}
                              </div>
                          </div>
                          </div>
                        </div>
                        {/lent}
                              <a href="/news/ukraine" class="more">Показать все</a>
                            </div>

                            <div class="tabs__content">
                              {lent '/news' 5 category="21" var='news' alaytics=1}
                        <div class="item">
                          <div class="img">
                              <a href="{$news->getPath()}" >
                              {if $news->getImage()}
                                <!-- {$news->getImage()->thumbup(120,90)} -->
                                <img class="lazyimg" data-src="{$news->getImage()->thumbup(120,90)->getUrl()}" alt='{$news->getTitle()}'>

                              {else}
                                <img class="the_img" src="/img/thumbup.120.90/images/noThumb.jpg" alt="{$news->getH1()}"/>
                              {/if}
                          </a>
                          </div>
                          <div class="content">
                              <h4><a href="{$news->getPath()}">{$news->getTitle()}</a></h4>
                              <div class="statistic">
                              <div class="date">
                              {$news->getPublished()->format('d.m.y')}
                              </div>
                              <div class="views">
                                <img src="/i/views.png">
                                {$news->getViews()}
                              </div>
                          </div>
                          </div>
                        </div>
                        {/lent}
                              <a href="/news/world" class="more">Показать все</a>
                            </div>
                          </div>
                  </div>
                </div>
              </article>
            </section>
          </div>
          <div class="cell medium-12 large-3 advertising-cell">
            <aside>
                <div class="advertising" id="advertising">
                  <div class="box-shadow"></div>
                  {widget_slot 'main (370x450)' size=[370,450]}
                  {widget_slot 'post_2 (370x450)' size=[370,450]}
                  {widget_slot 'post_6 (370x450)' size=[370,450]}
                  {widget_slot 'post_7 (370x450)' size=[370,450]}
                  {widget_slot 'post_8 (370x450)' size=[370,450]}
                </div>
            </aside>
          </div>
        </div>
      </div>
      <div class="grid-container all_read" id="all_read">
        <div class="grid-x grid-margin-x">
          <div class="cell medium-12 large-9">
            <section class="news">
              <div class="title">
                <h2><a href="/analytics">Аналитика</a></h2>
              </div>
              <nav>
                <a href="/analytics/investments">Исследования</a> |
                <a href="/analytics/articles">Статьи</a> |
                <a href="/analytics/formula">Интервью</a> |
                <a href="/analytics/we-invest-in-ukraine">Инвестируем в Украину</a> |
                <a href="/tools/database">Рейтинги</a> |
                <a href="/tools/library">Библиотека</a> |
                <a href="/tools/investors">Инвесторы</a>
              </nav>
              <div class="mobile_category">
                <a href="/analytics/investments">Исследования</a><i class="fa fa-chevron-right"></i><i class="fa fa-chevron-down"></i>
                <ul>
                    <li><a href="/analytics/articles">Статьи</a></li>
                    <li><a href="/analytics/formula">Интервью</a></li>
                    <li><a href="/analytics/we-invest-in-ukraine">Инвестируем в Украину</a></li>
                    <li><a href="/tools/database">Рейтинги</a></li>
                    <li><a href="/tools/library">Библиотека</a></li>
                    <li><a href="/tools/investors">Инвесторы</a></li>
                </ul>
            </div>
              <article class="grid-container">
                <div class="grid-x grid-margin-x">
                  {$invest=[]}
                  {lent '/analytics' 3 var='analytics' analytics=1}
                  {$invest[] = $analytics}
                  <div class="cell  bg-white  small-12 medium-4 large-4">
                    <div class="box-shadow"></div>
                    <div class="read_news">
                      <div class="img">
                        <a href="{$analytics->getPath()}">
                          {if $analytics->getImage()}
                          <!-- ->getUrl() -->
                          
                          <img class="lazyimg" data-src="{$analytics->getImage()->thumbup(270,202)->getUrl()}" alt='{$analytics->getTitle()}'>
                            <!-- {$analytics->getImage()->thumbup(270,202)} -->
                          {else}
                            <img class="the_img" src="/img/thumbup.270.202/images/noThumb.jpg" alt="{$analytics->getH1()}"/>
                          {/if}
                        </a>
                      </div>
                      <div class="info">
                        <div class="statistic">
                          <div class="date">
                            {$analytics->getPublished()->format('d.m.y')}
                          </div>
                          <div class="views">
                          <img src="/i/views.png">
                            {$analytics->getViews()}
                          </div>
                        </div>
                        <div class="category">
                          <img src="/i/pers.png" alt="" />{$analytics->getAttr(1)}
                        </div>
                        <h4><a href="{$analytics->getPath()}">{$analytics->getTitle()}</a></h4>
                        <p>{$analytics->getShortText()|truncate:181:"  ..."}</p>
                    </div>
                  </div>
                  </div>
                  {/lent}
                </div>
              </article>
            </section>
          </div>
          
        </div>
      </div>
      <div class="grid-container events">
        <div class="grid-x grid-margin-x">
          <div class="cell medium-12 large-9">
            <section class="news">
              <div class="title">
                <h2><a href="tools/events">Мероприятия</a></h2>
              </div>
              <article class="grid-container">
                <div class="grid-x grid-margin-x">
                {$event=[]}
                {events 4 var='events' analytics=1}
                {$event[]=$events}
                  <div class="cell small-12 medium-6 large-6">
                    <div class="event">
                      <div class="img">
                        <a href="{$events->getPath()}">
                          {if $events->getImage()}
                            <!-- {$events->getImage()->thumbup(120,90)} -->
                            <img class="lazyimg" data-src="{$events->getImage()->thumbup(120,90)->getUrl()}" alt='{$events->getTitle()}'>
                          {else}
                            <img class="the_img" src="/img/thumbup.120.90/images/noThumb.jpg" alt="{$events->getH1()}"/>
                          {/if}
                        </a>
                      </div>
                      <div class="content">
                        <h5><a href="{$events->getPath()}" >{$events->getTitle()}</a></h5>
                        <div class="date">
                          <span><img src="/i/calendar.png"> {$events->getAttr(7)->format('d.m.Y')}</span>
                          <span><img src="/i/clock.png"> {$events->getAttr(7)->format('H:i')} - {$events->getAttr(8)->format('H:i')}</span>
                        </div>
                        <div class="category">
                          <img src="/i/pers.png" alt="" />{$events->getAttr(9)}
                        </div>
                      </div>
                    </div>
                  </div>
                  {/events}
                </div>
              </article>
            </section>
          </div>
        </div>
      </div>
      <div class="grid-container video_block">
        <div class="grid-x grid-margin-x">
          <div class="cell medium-12 large-9">
            <section class="news">
              <div class="title">
                <h2><a href="/tools/video">Видео</a></h2>
              </div>
              <article class="grid-container">
                <div class="grid-x grid-margin-x">
                  {$video=[]}
                  {lent '/tools/video' 3 var='news'}
                  {$video[] = $news}
                  <div class="cell small-12 medium-4 large-4">
                    <div class="box-shadow"></div>
                    <div class="video">
                      <div class="this_video">
                        <!-- <iframe class="video-iframe-index" src="//www.youtube.com/embed/{$news->printAttr("55")}" allowfullscreen></iframe> -->
                        <div class="youtube" data-embed="{$news->printAttr("55")}">
                            <div class="play-button"></div>
                        </div>
                      </div>
                      <div class="info">
                        <div class="statistic">
                          <div class="date">
                            {$news->getPublished()->format('d.m.y')}
                          </div>
                          <div class="views">
                            <img src="/i/views.png">
                            {$news->getViews()}
                          </div>
                        </div>
                        <h4><a href="{$news->getPath()}">{$news->getTitle()}</a></h4>
                      </div>
                    </div>
                  </div>
                  {/lent}
                </div>
              </article>
            </section>
          </div>
        </div>
      </div>

  <script>
    
  </script>
  <div class="dark_bg"></div>
  <div class="my_popup ">
    {#mod Mail}
        <div class="my_popup__wrapper">
            <h5>Заполните, пожалуйста, ваши контактные данные, чтобы получать ежемесячную рассылку!</h5>
            <i class="fa fa-close"></i>
            {subscribe}
        </div>
    {#/mod}
  </div>

  {* <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script> *}

  {* <script src="/js/filter.js"></script> *}
</div>