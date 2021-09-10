{* prefilter=off *}

{if $lang !== 'uk'}
  {$lang = 'uk'}
{/if}

<!-- @ts:$lang: {$lang} -->

{* height: calc(100% - 80px); *}
<div class="index-page index-uk">
  <div class="container container--main container--post the_post inventure_list z-0 relative">
    <main class="main large-9">
      {include 'components/invest-list'}
    </main>
    <aside class="sidebar sidebar--index">
			<div class="desktop-only">
				{include 'components/promo-links'}
			</div>
      {include 'components/invest-filter'}
    </aside>
  </div>
  <div class="container">
    <div class="show-more show-more--big">
      <a href="/uk/investments" class="show-more__btn font-medium ">Показати всі</a>
    </div>
  </div>

  {include 'components/newsletter-full'}

  <div class="container container--main container--post the_post inventure_list mt-6">
    <main class="main large-9">
      <section>
        {* news *}

        <div class="section__title-categories pt-0 mb-2 pb-0 flex flex-row justify-between items-center mt-4">
          <a href="/uk/news"><h2  class="section__title-categories pr-4">Новини</h2></a>
          <ul class="sort desktop-only text-xs">
            <li class="sort__item"><a href="/uk/news">Усі</a></li>
            <li class="sort__item"><a href="/uk/news/ukraine">Україна</a></li>
            <li class="sort__item"><a href="/uk/news/world">Світ</a></li>
          </ul>
        </div>
        <div class="relative z-0">
          <div class="section__categories-overlay"></div>
          <nav class="section__categories">
              <a class="section__category" href="/uk/news/investments">Прямі інвестиції та M&A</a>
              <a class="section__category" href="/uk/news/startup">Стартапи</a>
              <a class="section__category" href="/uk/news/government">Макроінвестиції</a>
              <a class="section__category" href="/uk/news/banking">Кредитування</a>
              <a class="section__category" href="/uk/news/stock">Фондовый ринок</a>
              <a class="section__category" href="/uk/news/realestate">Нерухомість</a>
          </nav>
        </div>

        {lent_load '/news' 6 var="news_all" analytics=1}
        <div class="cards">
          {foreach $news_all as $post}
            {include 'components/card-post-without-desc'}
          {/foreach}
        </div>
        <div class="show-more">
          <a href="/uk/news" class="show-more__btn font-medium ">Показати всі</a>
        </div>
      </section>
      
      <section>
        <h2 class="section__title-categories mt-4"><a href="/uk/analytics">Аналітика</a></h2>
        <div class="relative z-0">
          <div class="section__categories-overlay"></div>
          <nav class="section__categories">
            <a class="section__category" href="/uk/analytics/investments">Дослідження</a>
            <a class="section__category" href="/uk/analytics/articles">Статті</a>
            <a class="section__category" href="/uk/analytics/formula">Інтерв`ю</a>
            <a class="section__category" href="/uk/analytics/we-invest-in-ukraine">Інвестуємо в Україну</a>
            <a class="section__category" href="/uk/tools/database">Рейтинги</a>
            <a class="section__category" href="/uk/tools/library">Бібіиотека</a>
            <a class="section__category" href="/uk/tools/investors">Інвестори</a>
          </nav>
        </div>
        {$invest=[]}
        {lent_load '/analytics' 6 var='analytics' analytics=1}
          <div class="cards">
            {foreach $analytics as $post}
              {include 'components/card-post-without-desc'}
            {/foreach}
          </div>

        <div class="show-more">
          <a href="/uk/analytics" class="show-more__btn font-medium ">Показати всі</a>
        </div>
      </section>
      
      <section id="events">
        <h2 class="section__title-categories mt-4"><a href="/uk/tools/events">Заходи</a></h2>
        {$event=[]}
        <div class="cards cards--event">
          {* {events 4 var='events' analytics=1}
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
          {/events} *}
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
          <a href="/uk/tools/events" class="show-more__btn font-medium ">Показати всі</a>
        </div>
      </section>

      <section class="news">
        <h2 class="section__title-categories mt-4"><a href="/uk/tools/video">Відео</a></h2>

        <div class="cards cards--video">
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
              <a href="{$news->getPath()}"> <h2 class="mt-2 line-clamp line-clamp--2 font-semibold">{$news->getTitle()}</h2></a>
            </div>
          {/lent}
        </div>
        <div class="show-more">
          <a href="/uk/tools/video" class="show-more__btn font-medium ">Показати всі</a>
        </div>
      </section>

      <div class="seo-text">{SeoText::getText('/')}</div>
      
    </main>
    <aside class="sidebar sidebar-uk without-promo-links desktop-only ">
      {* include 'components/sidebar' *}
    </aside>
  </div>

  {include 'components/subscribe-modal'}
{* 
  <div class="dark_bg"></div>
  <div class="my_popup ">
    {#mod Mail}
        <div class="my_popup__wrapper">
            <h5>Заполните, пожалуйста, ваши контактные данные, чтобы получать ежемесячную рассылку!</h5>
            <i class="fa fa-close"></i>
            {subscribe}
        </div>
    {#/mod}
  </div> *}

  {* <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script> *}

  {* <script src="/js/filter.js"></script> *}
</div>