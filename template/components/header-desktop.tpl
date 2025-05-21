<header data-lang="{$lang}" class="header header--desktop desktop-only">
	<div class="header__wrapper">
		<div class="container header__container">
			<a class="header__logo" href="{if $lang == 'en'}/en{elseif $lang == 'uk'}/uk{else}/?lang=ru{/if}">
				<img src="/images/logo.svg" width="200px" height="26px" alt="Inventure logo" />
			</a>
			<div class="menu">
				{block 'menu'}
					<nav class="header__nav" id="nav">
						<li class="header__nav-item">
							<span><a rel="nofollow"
									href="https://inventure.ua{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{else}/{/if}"
									target="_blank">{if $lang === 'ru'}О компании
									{elseif $lang === 'uk'}Про компанію
									{else}About
									us{/if}</a></span>
						</li>
						<li class="menu-item1 header__nav-item">
							<span>
								<a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/investments">{if $lang === 'ru'}Инвестиционные
								предложения{elseif $lang === 'uk'}Інвестиційні пропозиції
								{else}Investment proposals
								{/if}</a></span>
						<div class="menu-item">
							<div class="grid-container container">
								<div class="menu-item__left">
									<ul class="menu-item__left-top">
										<a
											href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/investments/projects">
											<li>
												<svg width="23" height="23" fill="none">
													<use xlink:href="/images/header-icons-sprite.svg#projects" />
												</svg>
												{if $lang === 'ru'}Инвестиционные проекты и стартапы
												{elseif $lang === 'uk'}Інвестиційні проекти
												та стартапи{else}Investment Projects and Startups
												{/if}
											</li>
										</a>
										<a
											href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/investments/land">
											<li>
												<svg class="investments-land" width="22" height="22" fill="none">
													<use
														xlink:href="/images/header-icons-sprite.svg#investments-land" />
												</svg>
												{if $lang === 'ru'}Земля{elseif $lang === 'uk'}Земля{else}Land{/if}
											</li>
										</a>
										<a
											href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/investments/business">
											<li>
												<svg width="23" height="20" viewBox="0 0 23 20" fill="none">
													<use
														xlink:href="/images/header-icons-sprite.svg#investments-business" />
												</svg>
												{if $lang === 'ru'}Продажа бизнеса
												{elseif $lang === 'uk'}Продаж бізнесу
												{else}Business for Sale
												{/if}
											</li>
										</a>
										<a
											href="{if $lang == 'en'}/en{elseif $lang == 'uk'}/uk{/if}/investments/{if $lang == 'en'}/en_{/if}franchising">
											<li>
												<svg class="franchising-svg" width="22" height="22" viewBox="0 0 22 22"
													fill="none">
													<use
														xlink:href="/images/header-icons-sprite.svg#investments-franchising" />
												</svg>
												{if $lang === 'ru'}Франчайзинг{elseif $lang === 'uk'}Франчайзинг{else}Franchising{/if}
											</li>
										</a>
										<a
											href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/investments/offer">
											<li>
												<svg width="23" height="26" viewBox="0 0 23 26" fill="none">
													<use
														xlink:href="/images/header-icons-sprite.svg#investments-offer" />
												</svg>
												{if $lang === 'ru'}Инвесторы
												{elseif $lang === 'uk'}Інвестори
												{else}Investor
												Offers{/if}
											</li>
										</a>
										<a
											href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/investments/realestate">
											<li>
												<svg class="fill-svg" width="24" height="24" viewBox="0 0 24 24"
													fill="none">
													<use
														xlink:href="/images/header-icons-sprite.svg#investments-realestate" />

												</svg>
												{if $lang === 'ru'}Недвижимость
												{elseif $lang === 'uk'}Нерухомість
												{else}Commercial
												Property{/if}
											</li>
										</a>
									</ul>
									<ul class="menu-item__left-bottom">
										<a class="font-weight-bold"
											href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/add-inv-prop">
											<li>
												<svg width="23" height="20" viewBox="0 0 23 20" fill="none"
													xmlns="http://www.w3.org/2000/svg">
													<use xlink:href="/images/header-icons-sprite.svg#add-inv-prop" />
												</svg>
												{if $lang === 'ru'}Найти инвестора или продать бизнес
												{elseif $lang === 'uk'}Знайти інвестора або
												продати бізнес{else}Services for Raising Capital & Sell a Business<
													{/if} </li>
										</a>
										<a class="font-weight-bold"
											href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/investor">
											<li>
												<svg class="fill-svg" width="23" height="23" viewBox="0 0 23 23"
													fill="none">
													<use xlink:href="/images/header-icons-sprite.svg#investor" />
												</svg>
												{if $lang === 'ru'}Сервисы для инвестора
												{elseif $lang === 'uk'}Сервіси для
												інвестора{else}Services for Investors
												{/if}
											</li>
										</a>
									</ul>
								</div>
								<a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/add-inv-prop"
									class="menu-item__right menu--add-inv-prop" style="padding: 20px 40px !important;">
									<div class="menu-item__info">
										<p class="menu-item__info-text">
											{* {if $lang === 'ru'}Узнай вероятность привлечения инвестиций в свой бизнес прямо сейчас{else}Find out the probability of raising investment for your business right now.{/if} *}
											{if $lang === 'ru'}
												Привлечение инвестиций, продажа бизнеса и коммерческой недвижимости в
												Украине
											{elseif $lang === 'uk'}
												Залучення інвестицій, продаж бізнесу та комерційної нерухомості в Україні
											{else}
												Services for Raising Capital & Sell a Business
											{/if}
										</p>
										<span class="menu-item__info-btn">
											{if $lang === 'ru'}Узнать подробности
											{elseif $lang === 'uk'}Дізнатися більше
											{else}Get more
											information{/if}
										</span>
									</div>
									{* <a
                    href="https://setup.inventure.com.ua"
                    target="_blank"
                    class="menu-item__advert"
                  >
                    <img class="lazyload" data-src="/images/header-advert.jpg" alt="{if $lang === 'ru'}Узнай вероятность привлечения инвестиций в свой бизнес прямо сейчас{else}Find out the probability of raising investment for your business right now.{/if}"/>
                  </a> *}
								</a>
							</div>
						</div>
					</li>
					<li class="menu-item2  header__nav-item">
						<span><a
								href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/news">{if $lang === 'ru'}Новости{elseif $lang === 'uk'}Новини{else}News{/if}</a></span>
						<div class="menu-item">
							<div class="grid-container container">
								<div class="menu-item__list-wrapper">
									<ul class="menu-item__list {if $lang === 'en'}mr-24{/if}">
										<a
											href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/news/investments">
											<li>
												<svg width="23" height="20" viewBox="0 0 23 20" fill="none">
													<use
														xlink:href="/images/header-icons-sprite.svg#news-investments" />
												</svg>
												{if $lang === 'ru'}
													Прямые инвестиции и M&A
												{elseif $lang === 'uk'}
													Прямі інвестиції та M&A
												{else}
													Private Equity & M&A
												{/if}
											</li>
										</a>
										<a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/news/startup">
											<li>
												<svg width="23" height="23" viewBox="0 0 23 23" fill="none">
													<use xlink:href="/images/header-icons-sprite.svg#news-startup" />

												</svg>
												{if $lang === 'ru'}Стартапы
												{elseif $lang === 'uk'}Стартапи
												{else}Venture Capital &amp;
												Startups{/if}
											</li>
										</a>
										<a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/news/government">
											<li>
												<svg width="23" height="26" viewBox="0 0 23 26" fill="none">
													<use xlink:href="/images/header-icons-sprite.svg#news-government" />

												</svg>
												{if $lang === 'ru'}Макроинвестиции{elseif $lang === 'uk'}Макроінветиції{else}Macroeconomics{/if}
											</li>
										</a>
										<a href="{if $lang == 'en'}/en{elseif $lang == 'uk'}/uk{/if}/news/banking">
											<li>
												<svg class="fill-svg franchising-svg" width="22" height="16"
													viewBox="0 0 22 16" fill="none">
													<use xlink:href="/images/header-icons-sprite.svg#news-banking" />
												</svg>
												{if $lang == 'ru'}Кредитование{elseif $lang == 'uk'}Кредитування{else}Banking{/if}
											</li>
										</a>
										<a href="{if $lang == 'en'}/en{elseif $lang == 'uk'}/uk{/if}/news/stock">
											<li>
												<svg class="fill-svg" width="24" height="24" viewBox="0 0 24 24"
													fill="none">
													<use xlink:href="/images/header-icons-sprite.svg#news-stock" />

												</svg>
												{if $lang === 'ru'}Фондовый рынок
												{elseif $lang === 'uk'}Фондовий ринок
												{else}Stock Market &amp;
												IPO{/if}
											</li>
										</a>
										<a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/news/realestate">
											<li>
												<svg class="fill-svg" width="24" height="24" viewBox="0 0 24 24"
													fill="none">
													<use xlink:href="/images/header-icons-sprite.svg#news-realestate" />
												</svg>
												{if $lang === 'ru'}Недвижимость
												{elseif $lang === 'uk'}Нерухомість
												{else}Commercial
												Property{/if}
											</li>
										</a>
									</ul>
									<ul class="menu-item__list menu-item__list--world">
										<a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/news/ukraine">
											<li>
												<svg class="nochange" width="22" height="22" viewBox="0 0 22 22"
													fill="none" xmlns="http://www.w3.org/2000/svg">
													<use xlink:href="/images/header-icons-sprite.svg#news-ukraine"
														style="stroke: none;" />
												</svg>
												{if $lang === 'ru'}Украина{elseif $lang === 'uk'}Україна{else}Ukraine{/if}
											</li>
										</a>
										<a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/news/world">
											<li>
												<svg width="22" class="nochange" height="22" viewBox="0 0 22 22"
													fill="none">
													<use xlink:href="/images/header-icons-sprite.svg#news-world"
														style="stroke: none;" />
												</svg>
												{if $lang === 'ru'}Мир{elseif $lang === 'uk'}Світ{else}World{/if}
											</li>
										</a>
									</ul>
								</div>
							</div>
						</div>
					</li>
					<li class="menu-item3  header__nav-item">
						<span><a
								href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/analytics">{if $lang === 'ru'}Аналитика{elseif $lang === 'uk'}Аналітика{else}Analytics{/if}</a></span>
						<div class="menu-item">
							<div class="grid-container container">
								<div class="menu-item__left">
									<ul class="menu-item__left-top">
										<a
											href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/analytics/investments">
											<li>
												<svg class="fill-svg" width="24" height="23" viewBox="0 0 24 23"
													fill="none" xmlns="http://www.w3.org/2000/svg">
													<use
														xlink:href="/images/header-icons-sprite.svg#analytics-investments" />
												</svg>
												{if $lang === 'ru'}Исследования{elseif $lang === 'uk'}Дослідження{else}Research{/if}
											</li>
										</a>
										<a
											href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/analytics/we-invest-in-ukraine">
											<li>
												<svg class="invest-ukraine" width="22" height="25" viewBox="0 0 22 25"
													fill="none">
													<use
														xlink:href="/images/header-icons-sprite.svg#analytics-ukraine" />
												</svg>
												{if $lang === 'ru'}Инвестируем в Украину
												{elseif $lang === 'uk'}Інвестуємо в Україну
												{else}We
												invest in Ukraine{/if}
											</li>
										</a>
										<a
											href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/analytics/articles">
											<li>
												<svg width="24" height="24" viewBox="0 0 24 24" fill="none">
													<use
														xlink:href="/images/header-icons-sprite.svg#analytics-articles" />
												</svg>
												{if $lang === 'ru'}Статьи{elseif $lang === 'uk'}Статті{else}Articles{/if}
											</li>
										</a>
										<a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/tools/database">
											<li>
												<svg class="fill-svg" width="24" height="22" viewBox="0 0 24 22"
													fill="none">
													<use xlink:href="/images/header-icons-sprite.svg#tools-database" />
												</svg>
												{if $lang === 'ru'}Рейтинги{elseif $lang === 'uk'}Рейтинги{else}Ratings{/if}
											</li>
										</a>
										<a
											href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/analytics/formula">
											<li>
												<svg class="fill-svg" width="24" height="19" viewBox="0 0 24 19"
													fill="none">
													<use
														xlink:href="/images/header-icons-sprite.svg#analytics-formula" />
												</svg>
												{if $lang === 'ru'}Интервью
												{elseif $lang === 'uk'}Інтерв`ю
												{else}Investment
												interview{/if}
											</li>
										</a>
										<a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/tools/library">
											<li>
												<svg class="fill-svg" width="24" height="24" viewBox="0 0 24 24"
													fill="none" xmlns="http://www.w3.org/2000/svg">
													<use xlink:href="/images/header-icons-sprite.svg#tools-library" />
												</svg>
												{if $lang === 'ru'}Библиотека{elseif $lang === 'uk'}Бібліотека{else}Library{/if}
											</li>
										</a>
										<a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/tools/investors">
											<li>
												<svg width="22" height="26" viewBox="0 0 22 26" fill="none"
													xmlns="http://www.w3.org/2000/svg">
													<use xlink:href="/images/header-icons-sprite.svg#tools-investors" />
												</svg>
												{if $lang === 'ru'}Инвесторы{elseif $lang === 'uk'}Інвестори{else}Investors{/if}
											</li>
										</a>
									</ul>
								</div>
								<div class="menu-item__right">
									<div class="menu-item__info">
										<p class="menu-item__info-text">
											{if $lang == 'ru'}
												Получайте ежемесячный инвестиционный журнал в сфере прямых
												инвестиций и венчурного капитала.
											{else if $lang == 'en'}
												Get a monthly investment magazine in private equity and venture capital.
											{else}
												Отримайте щомісячний інвестиційний журнал у галузі прямих інвестицій та
												венчурного капіталу.
											{/if}
										</p>
										<a href="#" data-remodal-target="subscribe" class="menu-item__info-link">
											{if $lang == 'ru'}Подписаться{elseif $lang == 'uk'}Підписатися{else}Subscribe{/if}
										</a>
									</div>
									<a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/analytics/digest"
										class="menu-item__advert">
										<img class="lazyload" data-src="/images/newsletter-advert.jpg"
											alt="{if $lang == 'ru'}Дайджест{elseif $lang == 'uk'}Дайджест{else}Digest{/if}" />
									</a>
								</div>
							</div>
						</div>
					</li>
					<li class="header__nav-item"><span><a
								href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/analytics/digest">{if $lang == 'ru'}Дайджест{elseif $lang == 'uk'}Дайджест{else}Digest{/if}</a></span>
					</li>
				</nav>
				{/block}
			</div>
			<div class="header__right">
				<div class="search font-weight-bold header__right-item">
					<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
						<path
							d="M23.8535 22.4395L16.8817 15.4677C18.204 13.8351 19 11.7597 19 9.50004C19 4.26175 14.7383 0 9.49999 0C4.2617 0 0 4.26175 0 9.50004C0 14.7383 4.26175 19.0001 9.50004 19.0001C11.7597 19.0001 13.8351 18.204 15.4677 16.8817L22.4395 23.8536C22.6348 24.0488 22.9513 24.0488 23.1467 23.8536L23.8536 23.1466C24.0488 22.9513 24.0488 22.6347 23.8535 22.4395ZM9.50004 17.0001C5.3643 17.0001 2.00002 13.6358 2.00002 9.50004C2.00002 5.36429 5.3643 2.00002 9.50004 2.00002C13.6358 2.00002 17.0001 5.36429 17.0001 9.50004C17.0001 13.6358 13.6358 17.0001 9.50004 17.0001Z"
							fill="black" />
					</svg>
				</div>
				<div>
					{if !$user || !$user->getId()}
						<a class="header__right-item header__right-item--social"
							href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/user/login" style="height:24px;">
							<svg width="24" height="24" viewBox="0 0 26 26" fill="none" xmlns="http://www.w3.org/2000/svg">
								<path
									d="M25 13C25 6.38342 19.6166 1 13 1C6.38342 1 1 6.38342 1 13C1 16.4948 2.50284 19.6449 4.89498 21.8399L4.88364 21.8499L5.27287 22.178C5.29818 22.1994 5.32567 22.2169 5.35098 22.2378C5.55782 22.4093 5.77207 22.5721 5.99025 22.7296C6.06095 22.7807 6.13164 22.8317 6.20364 22.8815C6.43665 23.042 6.67578 23.1943 6.92015 23.3388C6.97338 23.3702 7.02705 23.4007 7.08073 23.4313C7.34822 23.5836 7.62138 23.7271 7.90109 23.8589C7.9216 23.8685 7.94255 23.8772 7.96305 23.8868C8.87462 24.3105 9.84771 24.6217 10.8653 24.8054C10.8919 24.8102 10.9185 24.815 10.9456 24.8198C11.2615 24.8743 11.5809 24.918 11.9043 24.9472C11.9436 24.9507 11.9828 24.9529 12.0225 24.9564C12.3446 24.983 12.6701 25 13 25C13.3268 25 13.6493 24.983 13.9696 24.9572C14.0102 24.9537 14.0508 24.9516 14.0913 24.9481C14.4121 24.9188 14.7289 24.8765 15.0417 24.8228C15.0688 24.818 15.0963 24.8132 15.1233 24.808C16.1257 24.6282 17.0848 24.3241 17.9846 23.9113C18.0177 23.896 18.0513 23.8816 18.0845 23.8659C18.3537 23.7393 18.6169 23.6028 18.8748 23.4575C18.9389 23.4212 19.0026 23.3846 19.0663 23.3471C19.3011 23.2087 19.5319 23.0643 19.7562 22.9107C19.8369 22.8557 19.9159 22.7977 19.9958 22.7401C20.1873 22.6022 20.3754 22.4599 20.5583 22.3111C20.5988 22.2784 20.6425 22.25 20.6822 22.2164L21.0815 21.8831L21.0697 21.873C23.4828 19.6772 25 16.5127 25 13ZM1.87273 13C1.87273 6.86429 6.86429 1.87273 13 1.87273C19.1357 1.87273 24.1273 6.86429 24.1273 13C24.1273 16.3063 22.6764 19.2788 20.3793 21.3184C20.2511 21.2298 20.1219 21.1504 19.9897 21.0841L16.295 19.2369C15.9633 19.0711 15.7574 18.7377 15.7574 18.3673V17.0769C15.8429 16.9713 15.9332 16.8518 16.0266 16.7204C16.5049 16.0449 16.8884 15.2935 17.1681 14.4849C17.721 14.2223 18.078 13.6716 18.078 13.0497V11.5028C18.078 11.1245 17.9392 10.7575 17.6909 10.4691V8.43258C17.7136 8.20611 17.7939 6.928 16.8692 5.87375C16.065 4.95564 14.7633 4.49091 13 4.49091C11.2367 4.49091 9.93498 4.95564 9.13076 5.87331C8.20611 6.92756 8.2864 8.20567 8.30909 8.43215V10.4687C8.06124 10.7571 7.92204 11.1241 7.92204 11.5024V13.0493C7.92204 13.5297 8.1376 13.9779 8.50676 14.2803C8.86022 15.6649 9.58764 16.713 9.85644 17.0682V18.3311C9.85644 18.6871 9.66226 19.0144 9.34938 19.1855L5.89905 21.0675C5.78909 21.1273 5.68 21.1971 5.57091 21.2752C3.30225 19.2365 1.87273 16.2823 1.87273 13ZM19.5276 22.0031C19.3748 22.1139 19.2195 22.2212 19.062 22.3238C18.9895 22.3709 18.9175 22.418 18.8438 22.4639C18.6378 22.5913 18.4284 22.7126 18.2145 22.826C18.1674 22.8509 18.1199 22.8745 18.0723 22.8989C17.5809 23.1507 17.0726 23.3671 16.5503 23.543C16.5319 23.5491 16.5136 23.5556 16.4948 23.5617C16.2212 23.6525 15.9441 23.7332 15.664 23.8026C15.6631 23.8026 15.6623 23.8031 15.6614 23.8031C15.3786 23.8729 15.0924 23.9309 14.8044 23.9785C14.7965 23.9798 14.7887 23.9815 14.7808 23.9828C14.5098 24.0269 14.2367 24.0588 13.9626 24.0828C13.9142 24.0871 13.8657 24.0902 13.8169 24.0937C13.5459 24.1142 13.2736 24.1273 13 24.1273C12.7233 24.1273 12.4476 24.1137 12.1731 24.0932C12.1255 24.0897 12.078 24.0867 12.0308 24.0823C11.7542 24.0579 11.4788 24.0252 11.2061 23.9807C11.1939 23.9785 11.1817 23.9763 11.1695 23.9741C10.5926 23.8777 10.0249 23.7359 9.472 23.5504C9.45498 23.5447 9.43753 23.5386 9.42051 23.5329C9.14604 23.4396 8.87462 23.3361 8.608 23.2218C8.60625 23.2209 8.60407 23.2201 8.60233 23.2192C8.35011 23.1105 8.10269 22.9901 7.85833 22.8631C7.82647 22.8465 7.79418 22.8308 7.76276 22.8138C7.53978 22.6947 7.3216 22.566 7.10647 22.4316C7.04276 22.3914 6.97949 22.3508 6.91665 22.3098C6.71855 22.1802 6.52305 22.0454 6.3328 21.9027C6.31316 21.8879 6.2944 21.8721 6.27476 21.8573C6.28873 21.8495 6.30269 21.8416 6.31665 21.8337L9.76698 19.9517C10.3604 19.6279 10.7292 19.007 10.7292 18.3311L10.7287 16.7593L10.6284 16.638C10.6188 16.6271 9.67535 15.4794 9.31884 13.9255L9.27913 13.7527L9.13033 13.6563C8.92044 13.5206 8.79476 13.2937 8.79476 13.0489V11.502C8.79476 11.2991 8.88073 11.1101 9.03782 10.9683L9.18182 10.8383V8.40771L9.17789 8.35055C9.17658 8.34007 9.04785 7.29062 9.78705 6.448C10.418 5.72887 11.4993 5.36364 13 5.36364C14.495 5.36364 15.5728 5.72582 16.2055 6.43971C16.9439 7.2736 16.823 8.34269 16.8221 8.35142L16.8182 10.8391L16.9622 10.9692C17.1188 11.1105 17.2052 11.2999 17.2052 11.5028V13.0497C17.2052 13.3609 16.9936 13.6432 16.6899 13.737L16.473 13.8038L16.4032 14.0198C16.1457 14.8196 15.7792 15.5584 15.314 16.2156C15.1997 16.377 15.0884 16.5201 14.9929 16.6297L14.8847 16.7532V18.3673C14.8847 19.0707 15.2756 19.7034 15.9049 20.0176L19.5996 21.8647C19.6231 21.8765 19.6463 21.8887 19.6694 21.9009C19.6227 21.9363 19.5747 21.969 19.5276 22.0031Z"
									fill="black" stroke="black" stroke-width="0.9" />
							</svg>
						</a>
					{else}
						<a class="header__right-item header__right-item--fill"
							href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/user/logout" style="height:24px;">
							<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
								<use xlink:href="/images/header-icons-sprite.svg#user-logout" />
							</svg>
						</a>
					{/if}
				</div>

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
							<a href="{if $langArr=='ru' and $data.url|count_characters == 1 }/?lang=ru{else}{$data.url|default:'#'}{/if}"
								{if $data} title="{$data['title']}" {/if}
								class="flex items-center ts-du-{{$data.url|count_characters}}-cc">
								<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"
									style="margin-right: 5px">
									<path
										d="M21.7811 5.07298C21.7807 5.06525 21.7799 5.05751 21.7786 5.04983C21.7486 5.00697 21.7117 4.9701 21.6808 4.9281C21.4567 4.62286 21.2195 4.32907 20.9692 4.04668C20.9006 3.96952 20.832 3.89321 20.7617 3.81775C20.5039 3.54169 20.2336 3.27845 19.9506 3.02811C19.8983 2.9818 19.8494 2.93382 19.7971 2.88835C19.0998 2.29098 18.3363 1.77544 17.5216 1.35194C17.489 1.33481 17.4548 1.32024 17.4213 1.30306C17.0585 1.11868 16.6865 0.952951 16.3067 0.806609C16.2209 0.775763 16.1429 0.746575 16.0615 0.720853C15.7237 0.599128 15.3807 0.492524 15.0326 0.401041C14.9297 0.373611 14.8268 0.345328 14.7222 0.321314C14.3793 0.241587 14.0364 0.180699 13.6856 0.130964C13.5793 0.115541 13.4747 0.0949435 13.3675 0.0820827C12.4643 -0.0276864 11.5512 -0.0276864 10.6479 0.0820827C10.5407 0.0949435 10.4361 0.115541 10.3298 0.130964C9.97912 0.180699 9.63273 0.241587 9.29317 0.321314C9.18858 0.345328 9.08569 0.373611 8.98281 0.401041C8.6324 0.492473 8.28948 0.599078 7.95394 0.720853C7.86819 0.749991 7.79017 0.779179 7.70873 0.806609C7.32899 0.952951 6.95693 1.11863 6.59411 1.30306C6.56065 1.32019 6.52639 1.33476 6.49379 1.35194C5.67637 1.77499 4.9103 2.29048 4.21054 2.88835C4.15824 2.93377 4.10936 2.9818 4.05706 3.02811C3.77126 3.2796 3.50088 3.54285 3.24598 3.81775C3.17569 3.89321 3.10707 3.96952 3.03849 4.04668C2.78756 4.32846 2.55034 4.62225 2.32688 4.92805C2.29603 4.97005 2.25916 5.00692 2.22912 5.04978C2.2252 5.05726 2.22173 5.065 2.21882 5.07293C-0.738467 9.21738 -0.738467 14.7822 2.21882 18.9266C2.22173 18.9345 2.22515 18.9423 2.22912 18.9498C2.25911 18.9926 2.29598 19.0295 2.32688 19.0715C2.55039 19.3767 2.78756 19.6705 3.03849 19.9529C3.10707 20.0301 3.17569 20.1064 3.24598 20.1818C3.50435 20.4579 3.77468 20.7211 4.05706 20.9715C4.10936 21.0178 4.15824 21.0658 4.21054 21.1112C4.90783 21.7086 5.67135 22.2241 6.48605 22.6476C6.51865 22.6648 6.55292 22.6793 6.58637 22.6965C6.94919 22.8809 7.3212 23.0466 7.70099 23.193C7.78675 23.2238 7.86477 23.253 7.9462 23.2787C8.284 23.4005 8.62697 23.5071 8.97507 23.5985C9.07796 23.626 9.18084 23.6543 9.28544 23.6783C9.62841 23.758 9.97133 23.8189 10.322 23.8686C10.4283 23.884 10.5329 23.9046 10.6401 23.9175C11.5434 24.0273 12.4565 24.0273 13.3598 23.9175C13.467 23.9046 13.5716 23.884 13.6779 23.8686C14.0286 23.8189 14.375 23.758 14.7145 23.6783C14.8191 23.6543 14.922 23.626 15.0249 23.5985C15.3758 23.5071 15.7188 23.4005 16.0537 23.2787C16.1395 23.2496 16.2175 23.2204 16.299 23.193C16.6787 23.0466 17.0508 22.8809 17.4136 22.6965C17.447 22.6794 17.4813 22.6648 17.5139 22.6476C18.3286 22.2241 19.0921 21.7086 19.7894 21.1112C19.8417 21.0658 19.8906 21.0178 19.9429 20.9715C20.2287 20.7205 20.4991 20.4573 20.754 20.1818C20.8243 20.1064 20.8929 20.0301 20.9615 19.9529C21.2124 19.6705 21.4496 19.3767 21.6731 19.0715C21.7039 19.0295 21.7408 18.9926 21.7708 18.9498C21.7747 18.9423 21.7782 18.9345 21.7811 18.9266C24.7384 14.7823 24.7384 9.21743 21.7811 5.07298ZM20.8029 6.69521C21.6228 8.04564 22.118 9.56804 22.2492 11.1425H17.1135C17.0506 10.1209 16.8898 9.10767 16.6334 8.11678C18.0841 7.84509 19.4883 7.36633 20.8029 6.69521ZM14.1855 1.94781C14.2335 1.95896 14.2798 1.97438 14.3278 1.98553C14.6348 2.05758 14.9392 2.13986 15.2367 2.24275C15.2821 2.25817 15.3267 2.27621 15.3713 2.29249C15.6663 2.39537 15.9569 2.50941 16.2416 2.63546C16.2913 2.65862 16.3402 2.68434 16.3899 2.7075C16.6626 2.83726 16.9289 2.97758 17.189 3.12849L17.3605 3.23223C17.6074 3.38314 17.8475 3.54461 18.0807 3.71667C18.1407 3.76038 18.2007 3.80243 18.2599 3.8504C18.4885 4.02186 18.7074 4.20563 18.9166 4.40171C18.9715 4.45145 19.0281 4.50033 19.0821 4.55177C19.3016 4.76011 19.5108 4.98045 19.7132 5.20853C19.7389 5.23852 19.7663 5.26595 19.792 5.29428C18.6311 5.84755 17.4012 6.24262 16.1353 6.46889C15.5488 4.85666 14.7741 3.31929 13.8272 1.88873C13.9463 1.91013 14.0681 1.92213 14.1855 1.94781ZM8.60562 11.1424C8.67324 10.2148 8.83119 9.29586 9.0772 8.39881C10.0486 8.51421 11.0261 8.57143 12.0043 8.57027C12.9835 8.56997 13.9619 8.5113 14.934 8.39449C15.1796 9.29299 15.3367 10.2133 15.403 11.1424H8.60562ZM15.403 12.8572C15.3354 13.7849 15.1775 14.7038 14.9314 15.6009C13.96 15.4855 12.9826 15.4283 12.0043 15.4294C11.0252 15.4283 10.0469 15.4855 9.07459 15.6009C8.82928 14.7038 8.67224 13.7849 8.60557 12.8572H15.403V12.8572ZM12.0043 2.27023C12.98 3.65312 13.7825 5.15045 14.3938 6.72867C13.6001 6.81296 12.8025 6.85531 12.0043 6.85557C11.207 6.85461 10.4102 6.81201 9.61731 6.72781C10.2294 5.15065 11.0309 3.65382 12.0043 2.27023ZM4.29639 5.20762C4.4979 4.97954 4.70794 4.7592 4.92743 4.55087C4.98143 4.49942 5.03805 4.45054 5.09291 4.40081C5.30441 4.2082 5.52335 4.02443 5.74967 3.8495C5.80885 3.80403 5.86883 3.76374 5.92886 3.71577C6.16207 3.54431 6.40215 3.38279 6.64907 3.23133L6.82053 3.12759C7.08061 2.97557 7.34697 2.8352 7.61961 2.70659C7.66934 2.68343 7.71823 2.65771 7.76796 2.63455C8.05261 2.50595 8.34328 2.39191 8.63823 2.29158C8.68279 2.2753 8.72398 2.25727 8.77281 2.24185C9.07032 2.14238 9.373 2.06009 9.68166 1.98463C9.72969 1.97348 9.77596 1.95805 9.82484 1.94776C9.94229 1.92203 10.0641 1.91003 10.1832 1.88858C9.23595 3.31939 8.46099 4.85706 7.87426 6.46959C6.60833 6.24332 5.37841 5.84825 4.21752 5.29498C4.24324 5.26504 4.27067 5.23761 4.29639 5.20762ZM3.20579 6.69521C4.52005 7.36628 5.92394 7.84504 7.3744 8.11678C7.11824 9.10772 6.95773 10.1209 6.89513 11.1425H1.7594C1.89072 9.56804 2.38586 8.04564 3.20579 6.69521ZM3.20579 17.3045C2.38581 15.9541 1.89067 14.4317 1.7594 12.8572H6.89513C6.95803 13.8789 7.11879 14.8921 7.37525 15.883C5.92454 16.1546 4.52035 16.6334 3.20579 17.3045ZM9.82313 22.0519C9.7751 22.0407 9.72883 22.0253 9.68081 22.0142C9.37386 21.9421 9.06947 21.8598 8.77196 21.7569C8.72649 21.7415 8.68193 21.7235 8.63732 21.7072C8.34238 21.6043 8.05175 21.4903 7.76706 21.3642C7.71732 21.3411 7.66844 21.3153 7.61871 21.2922C7.34607 21.1624 7.07971 21.0221 6.81963 20.8712L6.64817 20.7675C6.40125 20.6165 6.16116 20.4551 5.92796 20.283C5.86793 20.2393 5.80794 20.1973 5.74876 20.1493C5.52013 19.9778 5.3012 19.7941 5.09201 19.598C5.03715 19.5482 4.98053 19.4994 4.92652 19.4479C4.70704 19.2396 4.49785 19.0192 4.29549 18.7912C4.26977 18.7612 4.24234 18.7337 4.21662 18.7054C5.37756 18.1521 6.60742 17.7571 7.87336 17.5308C8.45983 19.143 9.23455 20.6804 10.1814 22.111C10.0623 22.0896 9.94059 22.0776 9.82313 22.0519ZM12.0043 21.7295C11.0286 20.3466 10.2261 18.8493 9.61474 17.2711C11.2026 17.1002 12.8042 17.1002 14.3921 17.2711L14.3912 17.2719C13.7792 18.849 12.9777 20.3459 12.0043 21.7295ZM19.7122 18.7921C19.5107 19.0201 19.3007 19.2405 19.0812 19.4488C19.0272 19.5003 18.9706 19.5491 18.9157 19.5989C18.7042 19.7921 18.4853 19.9759 18.259 20.1502C18.1998 20.1956 18.1398 20.2402 18.0798 20.2839C17.8466 20.4554 17.6065 20.6169 17.3596 20.7684L17.1881 20.8721C16.9286 21.0236 16.6622 21.1639 16.389 21.2931C16.3393 21.3163 16.2904 21.342 16.2407 21.3651C15.956 21.4937 15.6654 21.6078 15.3704 21.7081C15.3259 21.7244 15.2847 21.7424 15.2358 21.7578C14.9383 21.8573 14.6356 21.9396 14.327 22.0151C14.279 22.0262 14.2327 22.0416 14.1838 22.0519C14.0663 22.0777 13.9446 22.0897 13.8254 22.1111C14.7723 20.6805 15.547 19.1432 16.1335 17.5309C17.3994 17.7572 18.6293 18.1523 19.7902 18.7056C19.7654 18.7346 19.738 18.7621 19.7122 18.7921ZM20.8029 17.3045C19.4886 16.6335 18.0847 16.1547 16.6342 15.883C16.8904 14.892 17.0509 13.8788 17.1135 12.8572H22.2492C22.1179 14.4316 21.6228 15.954 20.8029 17.3045Z"
										fill="black" />
								</svg>
								<span>
									{if $langArr=='ru'}
										Рус
									{elseif $langArr=='uk'}
										Укр
									{elseif $langArr=='en'}
										En
									{/if}
								</span>
							</a>
						</div>
						{* <div class="mr-2"></div> *}
					{/if}
				{/foreach}
				{#/mod}

				{if $emptyDataCounter > 0 || !$locale_data}
					<div class="mr-2"></div>
				{/if}

				<a class="header__btn header__btn--blue" href="{if $lang === 'en'}/en/{else}/{/if}about/contacts">
					<svg width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg">
						<path
							d="M16.5557 11.8149C15.4537 11.8149 14.3716 11.6426 13.3462 11.3037C12.8438 11.1323 12.2261 11.2896 11.9194 11.6045L9.8955 13.1324C7.54833 11.8794 6.10252 10.4341 4.8667 8.10455L6.34959 6.13336C6.73486 5.74861 6.87305 5.18658 6.70748 4.65923C6.36717 3.62845 6.1943 2.54691 6.1943 1.44441C6.19434 0.647953 5.54639 0 4.74998 0H1.44436C0.647953 0 0 0.647953 0 1.44436C0 10.5733 7.42678 18 16.5557 18C17.3521 18 18 17.352 18 16.5556V13.2593C18 12.4629 17.352 11.8149 16.5557 11.8149Z"
							fill="white" />
					</svg>
				</a>
			</div>
		</div>
	</div>
</header>
<div class="header_search">
	<div class="container">
		<div class="flex w-full items-center">
			<div class="cell small-3 mr-6" style="border:none;">
				<div class="logo">
					<img class="lazyimg" data-src="/images/logo-footer.svg" width="200px">
				</div>
			</div>
			<div class="cell small-9" style="flex:7;">
				<div class="search_input pt-0">
					<form action="/search" method="get" class="search_frm">
						<button style="border:none"><i class="fa fa-search" aria-hidden="true"></i></button>
						<input name="q" class="w-full" type="search" value="{$query}"
							placeholder="{if $lang === 'ru'}Поиск среди 30 000 материалов в области инвестиций{else}Search among 30,000 materials about investments{/if}"
							style="height: 60px;" />
						<i class="fa fa-close mt-0" aria-hidden="true" id="close"
							style="height: 60px;line-height: 60px;width: 60px;text-align: center;"></i>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>