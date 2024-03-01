<header class="header header--mobile mobile-only">
	<div class="header__wrapper">
		<button aria-label="Menu" id="open-mobile-menu" class="header__btn header__btn--burger"></button>

		<a class="header__logo items-center flex ml-2"
			href="{if $lang == 'en'}/en{elseif $lang == 'uk'}/uk{else}/?lang=ru{/if}">
			<img src="/images/logo.svg" width="175px" height="26px" alt="Inventure logo" />
		</a>


		<div class="flex ml-auto">
			<div class="header__socials flex">
				<a class="header__social-icon" itemprop="sameAs" href="https://www.facebook.com/inventure.com.ua"
					target="_blank">
					<svg xmlns="http://www.w3.org/2000/svg" fill="#fff" enable-background="new 0 0 512 512" height="35"
						viewBox="0 0 512 512" width="34">
						<path
							d="m512 256c0-141.4-114.6-256-256-256s-256 114.6-256 256 114.6 256 256 256c1.5 0 3 0 4.5-.1v-199.2h-55v-64.1h55v-47.2c0-54.7 33.4-84.5 82.2-84.5 23.4 0 43.5 1.7 49.3 2.5v57.2h-33.6c-26.5 0-31.7 12.6-31.7 31.1v40.8h63.5l-8.3 64.1h-55.2v189.5c107-30.7 185.3-129.2 185.3-246.1z" />
					</svg>
				</a>
				<a class="header__social-icon" itemprop="sameAs" href="https://t.me/inventure" target="_blank">
					<svg xmlns="http://www.w3.org/2000/svg" fill="#fff" enable-background="new 0 0 24 24" height="35"
						viewBox="0 0 24 24" width="34">
						<path
							d="m12 24c6.629 0 12-5.371 12-12s-5.371-12-12-12-12 5.371-12 12 5.371 12 12 12zm-6.509-12.26 11.57-4.461c.537-.194 1.006.131.832.943l.001-.001-1.97 9.281c-.146.658-.537.818-1.084.508l-3-2.211-1.447 1.394c-.16.16-.295.295-.605.295l.213-3.053 5.56-5.023c.242-.213-.054-.333-.373-.121l-6.871 4.326-2.962-.924c-.643-.204-.657-.643.136-.953z" />
					</svg>
				</a>

			</div>
			<a href="{if $lang === 'en'}/en/{elseif $lang == 'uk'}/uk/{else}/{/if}about/contacts" aria-label="Callback"
				class="header__btn header__btn--blue">
				<svg width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg">
					<path
						d="M16.5557 11.8149C15.4537 11.8149 14.3716 11.6426 13.3462 11.3037C12.8438 11.1323 12.2261 11.2896 11.9194 11.6045L9.8955 13.1324C7.54833 11.8794 6.10252 10.4341 4.8667 8.10455L6.34959 6.13336C6.73486 5.74861 6.87305 5.18658 6.70748 4.65923C6.36717 3.62845 6.1943 2.54691 6.1943 1.44441C6.19434 0.647953 5.54639 0 4.74998 0H1.44436C0.647953 0 0 0.647953 0 1.44436C0 10.5733 7.42678 18 16.5557 18C17.3521 18 18 17.352 18 16.5556V13.2593C18 12.4629 17.352 11.8149 16.5557 11.8149Z"
						fill="white" />
				</svg>
			</a>
		</div>






	</div>
</header>

<nav id="mobile-nav" class="mobile-nav">

	<form action="/search" method="get" class="search_frm flex relative mobile-nav__search search">
		<input name="q" class="w-full search__input" type="search" value="{$query}"
			placeholder="{if $lang === 'ru'}Поиск среди 30 000 материалов в области инвестиций{elseif $lang == 'uk'}Пошук серед 30 000 метеріалів в галузі інвестицій{else}Search among 30,000 materials about investments{/if}" />
		<button aria-label="Search" class="search__button"><i class="fa fa-search" aria-hidden="true"></i></button>
	</form>

	<ul class="cd-navigation mb-0">
		<li class="item-has-children">
			<a class="mobile-nav__header font-semibold " href="#0"><span>{if $lang == 'ru'}Инвестиционные
					предложения{elseif $lang == 'uk'}Інвестиційні пропозиції
					{else}Investment proposals
					{/if}</span> <svg width="13" height="7" viewBox="0 0 13 7" fill="none" xmlns="http://www.w3.org/2000/svg">
					<path opacity="0.3" d="M12 1L6.5 6.5L1 1" stroke="black" stroke-linecap="round" stroke-linejoin="round" />
				</svg>
			</a>{if $lang === 'en'}{else}{/if}
			<ul class="sub-menu" style="display:none;">
				<li><a href="{if $lang === 'en'}/en{elseif $lang == 'uk'}/uk{/if}/investments">
						{if $lang === 'ru'}Посмотреть все{elseif $lang == 'uk'}Показати всі{else}Show all{/if}
					</a></li>
				<li><a href="{if $lang === 'en'}/en{elseif $lang == 'uk'}/uk{/if}/investments/projects">
						{if $lang === 'ru'}Инвестиционные проекты и стартапы
						{elseif $lang == 'uk'}Інвестиційні проекти та
						стартапи{else}Investment Projects and Startups
						{/if}
					</a></li>
				<li><a href="{if $lang === 'en'}/en{elseif $lang == 'uk'}/uk{/if}/investments/business">
						{if $lang === 'ru'}Продажа бизнеса{elseif $lang == 'uk'}Продаж бізнесу{else}Business for Sale{/if}
					</a></li>
				<li><a href="{if $lang === 'en'}/en{elseif $lang == 'uk'}/uk{/if}/investments/realestate">
						{if $lang === 'ru'}Недвижимость{elseif $lang == 'uk'}Нерухомість{else}Commercial Property{/if}
					</a></li>
				<li><a href="{if $lang === 'en'}/en{elseif $lang == 'uk'}/uk{/if}/investments/land">
						{if $lang === 'ru'}Земля{elseif $lang == 'uk'}Земля{else}Land{/if}
					</a></li>
				<li><a
						href="{if $lang == 'en'}/en{elseif $lang == 'uk'}/uk{/if}/investments/{if $lang == 'en'}/en_{/if}franchising">
						{if $lang === 'ru'}Франчайзинг{elseif $lang == 'uk'}Франчайзинг{else}Franchising{/if}
					</a></li>
				<li><a href="{if $lang === 'en'}/en{elseif $lang == 'uk'}/uk{/if}/investments/offer">
						{if $lang === 'ru'}Предложения инвесторов
						{elseif $lang == 'uk'}Інвестиційні пропозиції
						{else}Investor
						Offers{/if}
					</a></li>
				<li><a href="{if $lang === 'en'}/en{elseif $lang == 'uk'}/uk{/if}/add-inv-prop">
						{if $lang === 'ru'}Привлечение инвестиций / продажа бизнеса
						{elseif $lang == 'uk'}Залучення інвестицій /
						продаж бізнесу{else}Services for Raising Capital & Sell a Business
						{/if}
					</a></li>
				<li><a href="{if $lang === 'en'}/en{elseif $lang == 'uk'}/uk{/if}/project">
						{if $lang === 'ru'}Сервисы для инвестора
						{elseif $lang == 'uk'}Сервіси для інвесторів
						{else}Services for
						Investors{/if}
					</a></li>
			</ul>
		</li> <!-- item-has-children -->



		<li class="item-has-children">
			<a class="mobile-nav__header font-semibold"
				href="#0"><span>{if $lang === 'ru'}Новости{elseif $lang == 'uk'}Новини{else}News{/if}</span> <svg width="13"
					height="7" viewBox="0 0 13 7" fill="none" xmlns="http://www.w3.org/2000/svg">
					<path opacity="0.3" d="M12 1L6.5 6.5L1 1" stroke="black" stroke-linecap="round" stroke-linejoin="round" />
				</svg>
			</a>
			<ul class="sub-menu" style="display:none;">
				<li><a href="{if $lang === 'en'}/en{elseif $lang == 'uk'}/uk{/if}/news">
						{if $lang === 'ru'}Посмотреть все{elseif $lang == 'uk'}Подивитись всі{else}Show all{/if}
					</a></li>
				<li><a href="{if $lang === 'en'}/en{elseif $lang == 'uk'}/uk{/if}/news/investments">
						{if $lang === 'ru'}Прямые инвестиции и M&A
						{elseif $lang == 'uk'}Прямі інвестиції та M&A
						{else}Private Equity
						& M&A{/if}
					</a></li>
				<li><a href="{if $lang === 'en'}/en{elseif $lang == 'uk'}/uk{/if}/news/startup">
						{if $lang === 'ru'}Стартапы{elseif $lang == 'uk'}Стартапи{else}Venture Capital &amp; Startups{/if}
					</a></li>
				<li><a href="{if $lang === 'en'}/en{elseif $lang == 'uk'}/uk{/if}/news/government">
						{if $lang === 'ru'}Макроинвестиции{elseif $lang == 'uk'}Макроінвестиції{else}Macroeconomics{/if}
					</a></li>
				<li><a href="{if $lang === 'en'}/en{elseif $lang == 'uk'}/uk{/if}/news/banking">
						{if $lang === 'ru'}Кредитование{elseif $lang == 'uk'}Кредитування{else}Banking{/if}
					</a></li>
				<li><a href="{if $lang === 'en'}/en{elseif $lang == 'uk'}/uk{/if}/news/stock">
						{if $lang === 'ru'}Фондовый рынок{elseif $lang == 'uk'}Фондовий ринок{else}Stock Market &amp; IPO{/if}
					</a></li>
				<li><a href="{if $lang === 'en'}/en{elseif $lang == 'uk'}/uk{/if}/news/realestate">
						{if $lang === 'ru'}Недвижимость{elseif $lang == 'uk'}Нерухомість{else}Commercial Property{/if}
					</a></li>
				<li><a href="{if $lang === 'en'}/en{elseif $lang == 'uk'}/uk{/if}/news/ukraine">
						{if $lang === 'ru'}Украина{elseif $lang == 'uk'}Україна{else}Ukraine{/if}
					</a></li>
				<li><a href="{if $lang === 'en'}/en{elseif $lang == 'uk'}/uk{/if}/news/world">
						{if $lang === 'ru'}Мир{elseif $lang == 'uk'}Світ{else}World{/if}
					</a></li>
			</ul>
		</li> <!-- item-has-children -->

		<li class="item-has-children">
			<a class="mobile-nav__header font-semibold"
				href="#0"><span>{if $lang === 'ru'}Аналитика{elseif $lang == 'uk'}Аналітика{else}Analytics{/if}</span>
				<svg width="13" height="7" viewBox="0 0 13 7" fill="none" xmlns="http://www.w3.org/2000/svg">
					<path opacity="0.3" d="M12 1L6.5 6.5L1 1" stroke="black" stroke-linecap="round" stroke-linejoin="round" />
				</svg></a>
			<ul class="sub-menu" style="display:none;">
				<li><a href="{if $lang === 'en'}/en{elseif $lang == 'uk'}/uk{/if}/analytics">
						{if $lang === 'ru'}Посмотреть все{elseif $lang == 'uk'}Переглянути всі{else}Show all{/if}
					</a></li>
				<li><a href="{if $lang === 'en'}/en{elseif $lang == 'uk'}/uk{/if}/analytics/investments">
						{if $lang === 'ru'}Исследования{elseif $lang == 'uk'}Дослідження{else}Research{/if}
					</a></li>
				<li><a href="{if $lang === 'en'}/en{elseif $lang == 'uk'}/uk{/if}/analytics/articles">
						{if $lang === 'ru'}Статьи{elseif $lang == 'uk'}Статті{else}Articles{/if}
					</a></li>
				<li><a href="{if $lang === 'en'}/en{elseif $lang == 'uk'}/uk{/if}/analytics/formula">
						{if $lang === 'ru'}Интервью{elseif $lang == 'uk'}Інтервʼю{else}Investment interview{/if}
					</a></li>
				<li><a href="{if $lang === 'en'}/en{elseif $lang == 'uk'}/uk{/if}/analytics/we-invest-in-ukraine">
						{if $lang === 'ru'}Инвестируем в Украину
						{elseif $lang == 'uk'}Інвестуймо в Україну
						{else}We invest in
						Ukraine{/if}
					</a></li>
				<li><a href="{if $lang === 'en'}/en{elseif $lang == 'uk'}/uk{/if}/tools/database">
						{if $lang === 'ru'}Рейтинги{elseif $lang == 'uk'}Рейтинги{else}Ratings{/if}
					</a></li>
				<li><a href="{if $lang === 'en'}/en{elseif $lang == 'uk'}/uk{/if}/tools/library">
						{if $lang === 'ru'}Библиотека{elseif $lang == 'uk'}Бібліотека{else}Library{/if}
					</a></li>
				<li><a href="{if $lang === 'en'}/en{elseif $lang == 'uk'}/uk{/if}/tools/investors">
						{if $lang === 'ru'}Инвесторы{elseif $lang == 'uk'}Інвестори{else}Investors{/if}
					</a></li>
				<li><a href="{if $lang === 'en'}/en{elseif $lang == 'uk'}/uk{/if}/tools/events">
						{if $lang === 'ru'}Мероприятия{elseif $lang == 'uk'}Події{else}Events{/if}
					</a></li>
			</ul>
		</li> <!-- item-has-children -->
	</ul> <!-- cd-navigation -->

	<div class="mobile-nav__divider mb-4"></div>

	{assign var=emptyDataCounter value=0}
	{#mod 'Locale'}
	{locale_data}
	{foreach $locale_data as $langArr=>$data}
		{if !$data}
			{assign var=emptyDataCounter value=$emptyDataCounter+1}
			{continue}
		{/if}
		{if ($lang == 'ru' && $langArr != 'ru') || ($lang == 'uk' && $langArr != 'uk') || ($lang == 'en' &&  $langArr != 'en')}
			<div class="header__right-item header__right-item--lang">
				<a href="{if $langArr=='ru' and $data.url|count_characters == 0 }/?lang=ru{else}{$data.url|default:'#'}{/if}"
					{if $data} title="{$data['title']}" {/if} class="flex items-center">
					<svg width="24" height="24" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" style="margin-right: 5px;">
						<path style="fill: var(--main-accent-color);"
							d="M21.7811 5.07298C21.7807 5.06525 21.7799 5.05751 21.7786 5.04983C21.7486 5.00697 21.7117 4.9701 21.6808 4.9281C21.4567 4.62286 21.2195 4.32907 20.9692 4.04668C20.9006 3.96952 20.832 3.89321 20.7617 3.81775C20.5039 3.54169 20.2336 3.27845 19.9506 3.02811C19.8983 2.9818 19.8494 2.93382 19.7971 2.88835C19.0998 2.29098 18.3363 1.77544 17.5216 1.35194C17.489 1.33481 17.4548 1.32024 17.4213 1.30306C17.0585 1.11868 16.6865 0.952951 16.3067 0.806609C16.2209 0.775763 16.1429 0.746575 16.0615 0.720853C15.7237 0.599128 15.3807 0.492524 15.0326 0.401041C14.9297 0.373611 14.8268 0.345328 14.7222 0.321314C14.3793 0.241587 14.0364 0.180699 13.6856 0.130964C13.5793 0.115541 13.4747 0.0949435 13.3675 0.0820827C12.4643 -0.0276864 11.5512 -0.0276864 10.6479 0.0820827C10.5407 0.0949435 10.4361 0.115541 10.3298 0.130964C9.97912 0.180699 9.63273 0.241587 9.29317 0.321314C9.18858 0.345328 9.08569 0.373611 8.98281 0.401041C8.6324 0.492473 8.28948 0.599078 7.95394 0.720853C7.86819 0.749991 7.79017 0.779179 7.70873 0.806609C7.32899 0.952951 6.95693 1.11863 6.59411 1.30306C6.56065 1.32019 6.52639 1.33476 6.49379 1.35194C5.67637 1.77499 4.9103 2.29048 4.21054 2.88835C4.15824 2.93377 4.10936 2.9818 4.05706 3.02811C3.77126 3.2796 3.50088 3.54285 3.24598 3.81775C3.17569 3.89321 3.10707 3.96952 3.03849 4.04668C2.78756 4.32846 2.55034 4.62225 2.32688 4.92805C2.29603 4.97005 2.25916 5.00692 2.22912 5.04978C2.2252 5.05726 2.22173 5.065 2.21882 5.07293C-0.738467 9.21738 -0.738467 14.7822 2.21882 18.9266C2.22173 18.9345 2.22515 18.9423 2.22912 18.9498C2.25911 18.9926 2.29598 19.0295 2.32688 19.0715C2.55039 19.3767 2.78756 19.6705 3.03849 19.9529C3.10707 20.0301 3.17569 20.1064 3.24598 20.1818C3.50435 20.4579 3.77468 20.7211 4.05706 20.9715C4.10936 21.0178 4.15824 21.0658 4.21054 21.1112C4.90783 21.7086 5.67135 22.2241 6.48605 22.6476C6.51865 22.6648 6.55292 22.6793 6.58637 22.6965C6.94919 22.8809 7.3212 23.0466 7.70099 23.193C7.78675 23.2238 7.86477 23.253 7.9462 23.2787C8.284 23.4005 8.62697 23.5071 8.97507 23.5985C9.07796 23.626 9.18084 23.6543 9.28544 23.6783C9.62841 23.758 9.97133 23.8189 10.322 23.8686C10.4283 23.884 10.5329 23.9046 10.6401 23.9175C11.5434 24.0273 12.4565 24.0273 13.3598 23.9175C13.467 23.9046 13.5716 23.884 13.6779 23.8686C14.0286 23.8189 14.375 23.758 14.7145 23.6783C14.8191 23.6543 14.922 23.626 15.0249 23.5985C15.3758 23.5071 15.7188 23.4005 16.0537 23.2787C16.1395 23.2496 16.2175 23.2204 16.299 23.193C16.6787 23.0466 17.0508 22.8809 17.4136 22.6965C17.447 22.6794 17.4813 22.6648 17.5139 22.6476C18.3286 22.2241 19.0921 21.7086 19.7894 21.1112C19.8417 21.0658 19.8906 21.0178 19.9429 20.9715C20.2287 20.7205 20.4991 20.4573 20.754 20.1818C20.8243 20.1064 20.8929 20.0301 20.9615 19.9529C21.2124 19.6705 21.4496 19.3767 21.6731 19.0715C21.7039 19.0295 21.7408 18.9926 21.7708 18.9498C21.7747 18.9423 21.7782 18.9345 21.7811 18.9266C24.7384 14.7823 24.7384 9.21743 21.7811 5.07298ZM20.8029 6.69521C21.6228 8.04564 22.118 9.56804 22.2492 11.1425H17.1135C17.0506 10.1209 16.8898 9.10767 16.6334 8.11678C18.0841 7.84509 19.4883 7.36633 20.8029 6.69521ZM14.1855 1.94781C14.2335 1.95896 14.2798 1.97438 14.3278 1.98553C14.6348 2.05758 14.9392 2.13986 15.2367 2.24275C15.2821 2.25817 15.3267 2.27621 15.3713 2.29249C15.6663 2.39537 15.9569 2.50941 16.2416 2.63546C16.2913 2.65862 16.3402 2.68434 16.3899 2.7075C16.6626 2.83726 16.9289 2.97758 17.189 3.12849L17.3605 3.23223C17.6074 3.38314 17.8475 3.54461 18.0807 3.71667C18.1407 3.76038 18.2007 3.80243 18.2599 3.8504C18.4885 4.02186 18.7074 4.20563 18.9166 4.40171C18.9715 4.45145 19.0281 4.50033 19.0821 4.55177C19.3016 4.76011 19.5108 4.98045 19.7132 5.20853C19.7389 5.23852 19.7663 5.26595 19.792 5.29428C18.6311 5.84755 17.4012 6.24262 16.1353 6.46889C15.5488 4.85666 14.7741 3.31929 13.8272 1.88873C13.9463 1.91013 14.0681 1.92213 14.1855 1.94781ZM8.60562 11.1424C8.67324 10.2148 8.83119 9.29586 9.0772 8.39881C10.0486 8.51421 11.0261 8.57143 12.0043 8.57027C12.9835 8.56997 13.9619 8.5113 14.934 8.39449C15.1796 9.29299 15.3367 10.2133 15.403 11.1424H8.60562ZM15.403 12.8572C15.3354 13.7849 15.1775 14.7038 14.9314 15.6009C13.96 15.4855 12.9826 15.4283 12.0043 15.4294C11.0252 15.4283 10.0469 15.4855 9.07459 15.6009C8.82928 14.7038 8.67224 13.7849 8.60557 12.8572H15.403V12.8572ZM12.0043 2.27023C12.98 3.65312 13.7825 5.15045 14.3938 6.72867C13.6001 6.81296 12.8025 6.85531 12.0043 6.85557C11.207 6.85461 10.4102 6.81201 9.61731 6.72781C10.2294 5.15065 11.0309 3.65382 12.0043 2.27023ZM4.29639 5.20762C4.4979 4.97954 4.70794 4.7592 4.92743 4.55087C4.98143 4.49942 5.03805 4.45054 5.09291 4.40081C5.30441 4.2082 5.52335 4.02443 5.74967 3.8495C5.80885 3.80403 5.86883 3.76374 5.92886 3.71577C6.16207 3.54431 6.40215 3.38279 6.64907 3.23133L6.82053 3.12759C7.08061 2.97557 7.34697 2.8352 7.61961 2.70659C7.66934 2.68343 7.71823 2.65771 7.76796 2.63455C8.05261 2.50595 8.34328 2.39191 8.63823 2.29158C8.68279 2.2753 8.72398 2.25727 8.77281 2.24185C9.07032 2.14238 9.373 2.06009 9.68166 1.98463C9.72969 1.97348 9.77596 1.95805 9.82484 1.94776C9.94229 1.92203 10.0641 1.91003 10.1832 1.88858C9.23595 3.31939 8.46099 4.85706 7.87426 6.46959C6.60833 6.24332 5.37841 5.84825 4.21752 5.29498C4.24324 5.26504 4.27067 5.23761 4.29639 5.20762ZM3.20579 6.69521C4.52005 7.36628 5.92394 7.84504 7.3744 8.11678C7.11824 9.10772 6.95773 10.1209 6.89513 11.1425H1.7594C1.89072 9.56804 2.38586 8.04564 3.20579 6.69521ZM3.20579 17.3045C2.38581 15.9541 1.89067 14.4317 1.7594 12.8572H6.89513C6.95803 13.8789 7.11879 14.8921 7.37525 15.883C5.92454 16.1546 4.52035 16.6334 3.20579 17.3045ZM9.82313 22.0519C9.7751 22.0407 9.72883 22.0253 9.68081 22.0142C9.37386 21.9421 9.06947 21.8598 8.77196 21.7569C8.72649 21.7415 8.68193 21.7235 8.63732 21.7072C8.34238 21.6043 8.05175 21.4903 7.76706 21.3642C7.71732 21.3411 7.66844 21.3153 7.61871 21.2922C7.34607 21.1624 7.07971 21.0221 6.81963 20.8712L6.64817 20.7675C6.40125 20.6165 6.16116 20.4551 5.92796 20.283C5.86793 20.2393 5.80794 20.1973 5.74876 20.1493C5.52013 19.9778 5.3012 19.7941 5.09201 19.598C5.03715 19.5482 4.98053 19.4994 4.92652 19.4479C4.70704 19.2396 4.49785 19.0192 4.29549 18.7912C4.26977 18.7612 4.24234 18.7337 4.21662 18.7054C5.37756 18.1521 6.60742 17.7571 7.87336 17.5308C8.45983 19.143 9.23455 20.6804 10.1814 22.111C10.0623 22.0896 9.94059 22.0776 9.82313 22.0519ZM12.0043 21.7295C11.0286 20.3466 10.2261 18.8493 9.61474 17.2711C11.2026 17.1002 12.8042 17.1002 14.3921 17.2711L14.3912 17.2719C13.7792 18.849 12.9777 20.3459 12.0043 21.7295ZM19.7122 18.7921C19.5107 19.0201 19.3007 19.2405 19.0812 19.4488C19.0272 19.5003 18.9706 19.5491 18.9157 19.5989C18.7042 19.7921 18.4853 19.9759 18.259 20.1502C18.1998 20.1956 18.1398 20.2402 18.0798 20.2839C17.8466 20.4554 17.6065 20.6169 17.3596 20.7684L17.1881 20.8721C16.9286 21.0236 16.6622 21.1639 16.389 21.2931C16.3393 21.3163 16.2904 21.342 16.2407 21.3651C15.956 21.4937 15.6654 21.6078 15.3704 21.7081C15.3259 21.7244 15.2847 21.7424 15.2358 21.7578C14.9383 21.8573 14.6356 21.9396 14.327 22.0151C14.279 22.0262 14.2327 22.0416 14.1838 22.0519C14.0663 22.0777 13.9446 22.0897 13.8254 22.1111C14.7723 20.6805 15.547 19.1432 16.1335 17.5309C17.3994 17.7572 18.6293 18.1523 19.7902 18.7056C19.7654 18.7346 19.738 18.7621 19.7122 18.7921ZM20.8029 17.3045C19.4886 16.6335 18.0847 16.1547 16.6342 15.883C16.8904 14.892 17.0509 13.8788 17.1135 12.8572H22.2492C22.1179 14.4316 21.6228 15.954 20.8029 17.3045Z" />
					</svg>
					<span>
						{if $langArr == 'ru'}
							Рус
						{elseif $langArr == 'uk'}
							Укр
						{elseif $langArr == 'en'}
							En
						{/if}
					</span>
				</a>
			</div>
			{* <div class="mr-2"></div> *}
		{/if}
	{/foreach}
	{#/mod}

	<div class="mobile-nav__divider mt-4 mb-4"></div>

	<ul class="cd-single-item-wrapper ">
		{if !$user || !$user->getId()}
			<li>
				<a href="{if $lang === 'en'}/en{elseif $lang == 'uk'}/uk{/if}/user/login">
					{if $lang === 'ru'}Вход{elseif $lang == 'uk'}Вхід{else}Login{/if}
				</a>
			</li>
		{else}
			<li>
				<a href="{if $lang === 'en'}/en{elseif $lang == 'uk'}/uk{/if}/user/logout">
					{if $lang === 'ru'}Выход{elseif $lang == 'uk'}Вихід{else}Logout{/if}
				</a>
			</li>
		{/if}
		<li>
			<a href="https://inventure.ua{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{else}/{/if}"
				target="_blank">{if $lang === 'ru'}О компании{elseif $lang === 'uk'}Про компанію{else}About us{/if}</a>
		</li>
		<li><a href="{if $lang === 'en'}/en{elseif $lang == 'uk'}/uk{/if}/analytics/digest">
			{if $lang == 'ru'}
				Инвестиционный дайджест
			{elseif $lang == 'uk'}
				Інвестиційний дайджест
			{else}
				Investment Digest
			{/if}
			</a></li>
		<li><a href="{if $lang === 'en'}/en{elseif $lang == 'uk'}/uk{/if}/about/contacts">
				{if $lang === 'ru'}Контакты{elseif $lang == 'uk'}Контакти{else}Contacts{/if}
			</a></li>


	</ul>

	<div class="mobile-nav__socials mb-12">
		<a target="_blank" rel="nofollow" href="https://t.me/inventure">
			<svg width="20" height="20" xmlns="http://www.w3.org/2000/svg" aria-label="Telegram" viewBox="0 0 512 512">
				<rect width="512" height="512" rx="15%" fill="#37aee2" />
				<path fill="#c8daea" d="M199 404c-11 0-10-4-13-14l-32-105 245-144" />
				<path fill="#a9c9dd" d="M199 404c7 0 11-4 16-8l45-43-56-34" />
				<path fill="#f6fbfe"
					d="m204 319 135 99c14 9 26 4 30-14l55-258c5-22-9-32-24-25L79 245c-21 8-21 21-4 26l83 26 190-121c9-5 17-3 11 4" />
			</svg>
		</a>
		<a target="_blank" rel="nofollow" href="https://www.facebook.com/inventure.com.ua">
			<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
				<path
					d="M16.7482 0H2.87441C1.28959 0 0 1.31439 0 2.92969V17.0703C0 18.6856 1.28959 20 2.87441 20H8.66156V12.9297H6.36203V9.41406H8.66156V7.03125C8.66156 5.09262 10.2088 3.51562 12.1108 3.51562H15.5985V7.03125H12.1108V9.41406H15.5985L15.0236 12.9297H12.1108V20H16.7482C18.333 20 19.6226 18.6856 19.6226 17.0703V2.92969C19.6226 1.31439 18.333 0 16.7482 0Z"
					fill="#3B8FEE"></path>
			</svg>
		</a>
		<a target="_blank" rel="nofollow" href="https://www.linkedin.com/groups/4386794/">
			<svg width="20"  height="20" viewBox="0 0 20 20" fill="none"
				xmlns="http://www.w3.org/2000/svg">
				<path
					d="M17.0703 0H2.92969C1.31439 0 0 1.31439 0 2.92969V17.0703C0 18.6856 1.31439 20 2.92969 20H17.0703C18.6856 20 20 18.6856 20 17.0703V2.92969C20 1.31439 18.6856 0 17.0703 0ZM7.07031 15.8594H4.72656V7.65625H7.07031V15.8594ZM7.07031 6.48438H4.72656V4.14062H7.07031V6.48438ZM15.2734 15.8594H12.9297V11.1719C12.9297 10.5258 12.4039 10 11.7578 10C11.1118 10 10.5859 10.5258 10.5859 11.1719V15.8594H8.24219V7.65625H10.5859V8.09799C11.2 7.9071 11.5988 7.65625 12.3438 7.65625C13.9333 7.65793 15.2734 9.08386 15.2734 10.769V15.8594Z"
					fill="#3D76B1"></path>
			</svg>
		</a>
		<a target="_blank" rel="nofollow" href="https://twitter.com/inventure_ua">
			<svg width="20"  height="20" viewBox="0 0 20 20" fill="none"
				xmlns="http://www.w3.org/2000/svg">
				<rect width="19.6226" height="20" rx="3" fill="#4EB1EF"></rect>
				<path
					d="M8.22294 16C7.61753 16 6.9944 15.9487 6.36753 15.8457C5.26343 15.6643 4.14576 15.0595 3.82949 14.8784L3 14.4034L3.89806 14.0941C4.87976 13.756 5.47694 13.5463 6.21618 13.2179C5.47598 12.8425 4.9055 12.1672 4.63089 11.2942L4.42197 10.6299L4.5933 10.6574C4.43084 10.4859 4.30256 10.3118 4.20312 10.1535C3.84947 9.59097 3.66223 8.90357 3.70207 8.31451L3.74137 7.73473L4.07281 7.86918C3.93299 7.59266 3.83195 7.29735 3.77256 6.98782C3.62783 6.23298 3.74896 5.43104 4.11372 4.72977L4.40242 4.17471L4.78855 4.66042C6.00971 6.19673 7.55644 7.10807 9.39219 7.37487C9.31721 6.83356 9.37339 6.31117 9.55935 5.84291C9.77586 5.2977 10.161 4.83537 10.6729 4.50582C11.2413 4.13992 11.9307 3.96262 12.6139 4.00658C13.3388 4.05323 13.997 4.3377 14.5197 4.82978C14.775 4.76031 14.9631 4.68615 15.2173 4.58592C15.3703 4.52562 15.5437 4.45716 15.7608 4.37886L16.5606 4.09026L16.039 5.65029C16.0734 5.64727 16.1089 5.64469 16.1459 5.64302L17 5.60252L16.4952 6.32504C16.4663 6.36643 16.4589 6.37817 16.4486 6.39439C16.4079 6.4586 16.3573 6.53847 15.6644 7.50742C15.491 7.75005 15.4044 8.06606 15.4205 8.3974C15.4819 9.65652 15.3344 10.7957 14.9818 11.7832C14.6483 12.7175 14.1316 13.5191 13.4461 14.1658C12.5978 14.9658 11.5161 15.5136 10.231 15.7937C9.60058 15.9311 8.92361 16 8.22294 16Z"
					fill="white"></path>
			</svg>
		</a>

	</div>
</nav>