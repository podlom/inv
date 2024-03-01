{* prefilter=off *}
{* height: calc(100% - 80px); *}

{if $lang !== 'en'}
	{$lang = 'en'}
{/if}

<div class="index-page">
	{if !empty($page)}
		{assign "blogTitle" value=($page->getTitle('content'))}
		{assign "line" value="11"}
	{/if}
	{if !empty($blogTitle)}
		<h1 class="ts-line-{$line} ts-lang-{$lang} pr-4 home-page__title" style="height: 0px;visibility: hidden !important;">{$blogTitle}</h1>
	{/if}

	<div class="container container--main container--post the_post inventure_list z-0 relative">
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
			<a href="/en/investments" class="show-more__btn font-medium ">Show all</a>
		</div>
	</div>

	{include 'components/newsletter-full'}

	<div class="container container--main container--post the_post inventure_list mt-6 z-0 relative">
		<main class="main large-9">
			<section>
				{* news *}

				<div class="section__title-categories pt-0 mb-2 pb-0 flex flex-row justify-between items-center mt-4">
					<a href="/en/news">
						<h2 class="section__title-categories pr-4">News</h2>
					</a>
					<ul class="sort desktop-only text-xs">
						<li class="sort__item"><a href="/en/news">All</a></li>
						<li class="sort__item"><a href="/en/news/ukraine">Ukraine</a></li>
						<li class="sort__item"><a href="/en/news/world">World</a></li>
					</ul>
				</div>
				<div class="relative z-0">
					<div class="section__categories-overlay"></div>
					<nav class="section__categories">
						<a class="section__category" href="/en/news/investments">{if $lang === 'ru'}Прямые инвестиции и
							M&A{else}Private Equity & M&A
							{/if}</a>
						<a class="section__category" href="/en/news/startup">{if $lang === 'ru'}Стартапы
						{else}Venture Capital &amp;
							Startups{/if}</a>
						<a class="section__category"
							href="/en/news/government">{if $lang === 'ru'}Макроинвестиции{else}Macroeconomics{/if}</a>
						<a class="section__category" href="/en/news/banking">{if $lang === 'ru'}Кредитование{else}Banking{/if}</a>
						<a class="section__category" href="/en/news/stock">{if $lang === 'ru'}Фондовый рынок
						{else}Stock Market &amp;
							IPO{/if}</a>
						<a class="section__category" href="/en/news/realestate">{if $lang === 'ru'}Недвижимость
						{else}Commercial
							Property{/if}</a>
					</nav>
				</div>

				{lent_load '/en/news' 6 var="news_all" analytics=1}
				<div class="cards">
					{foreach $news_all as $post}
						{include 'components/card-post-without-desc'}
					{/foreach}
				</div>
				<div class="show-more">
					<a href="/en/news" class="show-more__btn font-medium ">Show all</a>
				</div>
			</section>

			<section>
				<h2 class="section__title-categories mt-4"><a href="/en/analytics">Analytics</a></h2>
				<div class="relative z-0">
					<div class="section__categories-overlay"></div>
					<nav class="section__categories">
						<a class="section__category"
							href="/en/analytics/investments">{if $lang === 'ru'}Исследования{else}Research{/if}</a>
						<a class="section__category" href="/en/analytics/articles">{if $lang === 'ru'}Статьи{else}Articles{/if}</a>
						<a class="section__category" href="/en/analytics/formula">{if $lang === 'ru'}Интервью
						{else}Investment
							interview{/if}</a>
						<a class="section__category" href="/en/analytics/we-invest-in-ukraine">{if $lang === 'ru'}Инвестируем в
							Украину{else}We invest in Ukraine
							{/if}</a>
						<a class="section__category" href="/en/tools/database">{if $lang === 'ru'}Рейтинги{else}Ratings{/if}</a>
						<a class="section__category" href="/en/tools/library">{if $lang === 'ru'}Библиотека{else}Library{/if}</a>
						<a class="section__category" href="/en/tools/investors">{if $lang === 'ru'}Инвесторы{else}Investors{/if}</a>
					</nav>
				</div>
				{$invest=[]}
				{lent_load '/en/analytics' 6 var='analytics' analytics=1}
				<div class="cards">
					{foreach $analytics as $post}
						{include 'components/card-post-without-desc'}
					{/foreach}
				</div>

				<div class="show-more">
					<a href="/en/analytics" class="show-more__btn font-medium ">Show all</a>
				</div>
			</section>

			{* <section id="events">
        <h2 class="section__title-categories mt-4"><a href="/en/tools/events">Events</a></h2>
        {$event=[]}
        <div class="cards cards--event">
        </div>
        <div class="show-more">
          <a href="/en/tools/events" class="show-more__btn font-medium ">Show all</a>
        </div>
      </section> *}

			{* <section class="news">
        <h2 class="section__title-categories mt-4"><a href="/en/tools/video">Video</a></h2>

        <div class="cards cards--video">
          {$video=[]}
          {lent '/en/tools/video' 4 var='news'}
          {$video[] = $news}
            <div class="cards__item video">
              <div class="cards__img-wrapper">
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
          <a href="/en/tools/video" class="show-more__btn font-medium ">Show all</a>
        </div>
      </section>
       *}
		</main>
		<aside class="sidebar without-promo-links desktop-only ">
			{include 'components/sidebar'}
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