{if $lang === 'en'}
	{lent_load '/en/investments' 6 var="posts" analytics=1}
{elseif $lang === 'uk'}
	{lent_load '/uk/investments' 6 var="posts" analytics=1}
{else}
	{lent_load '/investments' 6 var="posts" analytics=1}
{/if}

{$bigpost=array_shift($posts)}
{if !is_null($bigpost)}

	<div class="invest-projects">
		<div class="section__title-categories pt-0 mb-2 pb-0 flex flex-row justify-between items-center">
			<a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/investments">
				<h2 class="ts-19 home-page-title pr-4">{if $lang === 'ru'}Инвестиционные предложения
					{elseif $lang === 'uk'}Інвестиційні
					пропозиції{else}Investment proposals
					{/if}</h2>
			</a>
			<div class="flex items-center">
				<ul class="sort desktop-only text-xs">
					<li class="sort__item sort__item--active"><a
							href="">{if $lang === 'ru'}Новые{elseif $lang === 'uk'}Нові{else}Latest{/if}</a></li>
					<li class="sort__item"><a
							href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/investments?filter[sort]=views">{if $lang === 'ru'}Популярные{elseif $lang === 'uk'}Популярні{else}Popular{/if}</a>
					</li>
					<li class="sort__item"><a
							href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/investments?filter[sort]=rating">{if $lang === 'ru'}Лучшие{elseif $lang === 'uk'}Кращі{else}Featured{/if}</a>
					</li>
				</ul>
				<a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/add-inv-prop"
					class="investments__title-link desktop-only ml-4">
					{if $lang == 'en'}
						Place an ad
					  {elseif $lang === 'uk'}
						Розмістити обʼяву
					  {else}
						Разместить объявление
					  {/if}
					</a>
			</div>
		</div>

		<div class="relative z-0">
			<nav class="section__categories">
				<a class="section__category" href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/investments/projects">
					{if $lang === 'ru'}Инвестиционные проекты и стартапы
					{elseif $lang === 'uk'}Інвестиційні проекти та
					стартапи{else}Investment Projects and Startups
					{/if}</a>
				<a class="section__category" href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/investments/business">
					{if $lang === 'ru'}Продажа бизнеса{elseif $lang === 'uk'}Продаж бізнесу{else}Business for Sale{/if}</a>
				<a class="section__category" href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/investments/realestate">
					{if $lang === 'ru'}Недвижимость{elseif $lang === 'uk'}Нерухомість{else}Commercial Property{/if}</a>
				<a class="section__category" href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/investments/land">
					{if $lang === 'ru'}Земля{elseif $lang === 'uk'}Земля{else}Land{/if}</a>
				<a class="section__category"
					href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/investments/{if $lang === 'en'}/en_{/if}franchising">
					{if $lang === 'ru'}Франчайзинг{elseif $lang === 'uk'}Франчайзинг{else}Franchising{/if}</a>
				<a class="section__category" href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/investments/offer">
					{if $lang === 'ru'}Инвесторы{elseif $lang === 'uk'}Інвестори{else}Investor Offers{/if}</a>
			</nav>
			<div class="section__categories-overlay"></div>
		</div>

		<div class="section__controls flex flex-row mobile-only " data-source="invest-list">
			<select id="invest-sort" class="mobile-sort mr-2">
				<option value="">{if $lang === 'ru'}Новые{elseif $lang === 'uk'}Нові{else}Latest{/if}</option>
				<option value="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/investments?filter[sort]=views">
					{if $lang === 'ru'}Популярные{elseif $lang === 'uk'}Популярні{else}Popular{/if}</option>
				<option value="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/investments?filter[sort]=rating">
					{if $lang === 'ru'}Лучшие{elseif $lang === 'uk'}Кращі{else}Featured{/if}</option>
			</select>
			<button aria-label="Filter" id="open-mobile-filter"
				class="section__controls-btn flex items-center justify-center toggle-filter">
				<svg style="max-width:1em; pl-2 pr-2" width="16" height="17" viewBox="0 0 16 17" fill="none"
					xmlns="http://www.w3.org/2000/svg">
					<path
						d="M15.3109 0.0300305H0.689296C0.431248 0.0295546 0.194826 0.170116 0.0769405 0.393966C-0.0425712 0.620831 -0.0215957 0.89402 0.131087 1.10121L5.48781 8.46385C5.4896 8.46638 5.49155 8.46877 5.49334 8.4713C5.68798 8.72768 5.79334 9.03831 5.79383 9.35734V15.3601C5.79269 15.5377 5.86424 15.7086 5.99253 15.8347C6.12098 15.9607 6.29562 16.0318 6.47773 16.0318C6.57025 16.0316 6.66196 16.0137 6.74748 15.9789L9.75755 14.8592C10.0271 14.7788 10.2062 14.5305 10.2062 14.2316V9.35734C10.2067 9.03831 10.312 8.72768 10.5065 8.4713C10.5083 8.46877 10.5102 8.46638 10.512 8.46385L15.8689 1.10105C16.0216 0.89402 16.0426 0.620989 15.9231 0.394125C15.8053 0.170116 15.5688 0.0295546 15.3109 0.0300305Z"
						fill="#5D87AD" />
				</svg>
			</button>
		</div>
		{if $bigpost->getImage()}
		<link rel="preload" as="image" href="{$bigpost->getImage()->thumbup(600,400)->getUrl()}">{/if}
		<div class="invest-projects__grid cards">
			<a href="{$bigpost->getPath()}" class="cards__item card cards__item--big">
				<div class="cards__img-wrapper mb-4">
					{if $bigpost->getImage()}
						<img src="data:image/gif;base64,R0lGODlhAQABAAD/ACwAAAAAAQABAAACADs="
							data-src="{$bigpost->getImage()->thumbup(600,400)->getUrl()}" alt="{$bigpost->getH1()}"
							class="lazyimg cards__img">
					{else}
						<img class="lazyimg cards__img" data-src="/img/resize.375.225/images/noThumb.jpg" alt="{$bigpost->getH1()}" />
					{/if}
				</div>
				<div class="opacity-75 text-sm w-full cards__meta pt-0 mt-0">{$bigpost->getPublished()->format('d.m.y')}</div>
				<h2 class="cards__title mt-0">{$bigpost->getTitle()}</h2>
				<p class="cards__description">{$bigpost->getShortText()|truncate:150:"  ..."}</p>
				{if $bigpost->hasAttr("10")}
					<div class="mt-2">
						<p class="font-bold inline">
							{if $lang === 'ru'}Расположение:{elseif $lang === 'uk'}Розташування:{else}Location:{/if}</p>
						<p class="inline"> {$bigpost->printAttr("10")}</p>
					</div>
				{/if}
				<div
					class="cards__meta flex justify-between mt-auto opacity-75 text-sm big-itm parent-category-id-{$bigpost->getParent()->getId()} ">
						{if $bigpost->hasAttr("15")}
							<p class="price-tag font-semibold text-sm attr15-len-{$bigpost->hasAttr("15")|strlen}">
							{if $bigpost->hasAttr("15")}
								{if $bigpost->getAttr("15")|strlen}${$bigpost->printAttr("15")|number_format:0:'.':' '}{else}Договорная{/if}{/if}
							</p>
						{elseif $bigpost->getParent()->getId() == 7860 || $bigpost->getParent()->getId() == 9778 || $bigpost->getParent()->getId() == 19303 || $bigpost->getParent()->getId() == 19304}
							<p class="price-tag font-semibold text-sm attr34-len-{$bigpost->hasAttr("34")|strlen}">
								{if $bigpost->hasAttr("34")}
									{if $bigpost->getAttr("34")|strlen}${$bigpost->printAttr("34")|number_format:0:'.':' '}{else}Договорная{/if}{/if}
								</p>
							{elseif $bigpost->getParent()->getId() == 7864 || $bigpost->getParent()->getId() == 9782}
								<p class="price-tag font-semibold text-sm attr31-len-{$bigpost->hasAttr("31")|strlen}">
									{if $bigpost->hasAttr("31")}
										{if $bigpost->getAttr("31")|strlen}${$bigpost->printAttr("31")|number_format:0:'.':' '}{else}Договорная{/if}{/if}
									</p>
								{/if}
								<div class="flex items-center ml-auto">
									{if $bigpost->getAttr(13)}
										<div class="flex items-center mr-4">
											<img data-src="/images/icons/star.svg" width="16px" height="16px" alt="Rating icon" class="lazyimg">
											<p class="ml-2 font-semibold text-sm">{$bigpost->getAttr(13)|number_format}</p>
										</div>
									{/if}
									<div class="flex items-center">
										<img data-src="/images/icons/eye.svg" width="16px" height="16px" alt="Views icon" class="lazyimg">
										<p class="ml-2 font-semibold text-sm">{$bigpost->getViews()}</p>
									</div>
								</div>
							</div>
						</a>
						<div class="flex flex-col invest-projects__list">
							{foreach $posts as $post}

								<a href="{$post->getPath()}" class="cards__item cards__item--horizontal-sm card">
									<div class="cards__img-wrapper bd-radius--default">
										{if $post->getImage()}
											<img src="data:image/gif;base64,R0lGODlhAQABAAD/ACwAAAAAAQABAAACADs="
												data-src="{$post->getImage()->thumbup(350,254)->getUrl()}" alt="{$post->getH1()}"
												class="lazyimg cards__img mt-3 desktop-mt-0 border-4">
										{else}
											<img class="cards__img mt-3 desktop-mt-0 border-4 lazyimg"
												src="data:image/gif;base64,R0lGODlhAQABAAD/ACwAAAAAAQABAAACADs="
												data-src="/img/resize.375.225/images/noThumb.jpg" alt="{$post->getH1()}" />
										{/if}
									</div>
									<div class="flex flex-col w-full">
										<div class="opacity-75 text-sm w-full cards__meta pt-0 mt-0 mobile-mt-2">
											{$post->getPublished()->format('d.m.y')}</div>
										<div class="line-clamp line-clamp--2 desktop-line-clamp-3 mt-4 desktop-mt-0 desktop-mb-0  mobile-mt-0">
											<h2 class="cards__title mt-0 mb-0">{$post->getTitle()}</h2>
										</div>
										<div class="cards__meta flex justify-between mt-auto opacity-75 text-sm ts-post-parent-id-{$post->getParent()->getId()}">
											{if $post->hasAttr("15")}
												<p class="price-tag font-semibold text-sm attr15-len-{$post->hasAttr("15")}">
													{if $post->hasAttr("15")|mb_strlen}{if $post->getAttr("15")|strlen}${$post->printAttr("15")|number_format:0:'.':' '}{else}Договорная{/if}{/if}
												</p>
											{elseif $post->getParent()->getId() == 7860 || $post->getParent()->getId() == 9778 || $post->getParent()->getId() == 19303 || $post->getParent()->getId() == 19304}
												<p class="price-tag font-semibold text-sm attr34-len-{$post->hasAttr("34")}">
													{if $post->hasAttr("34")|mb_strlen}{if $post->getAttr("34")|strlen}${$post->printAttr("34")|number_format:0:'.':' '}{else}Договорная{/if}{/if}
												</p>
											{elseif $post->getParent()->getId() == 7864 || $post->getParent()->getId() == 9782}
												<p class="price-tag font-semibold text-sm attr31-len-{$post->hasAttr("31")}">
													{if $post->hasAttr("31")|mb_strlen}{if $post->getAttr("31")|strlen}${$post->printAttr("31")|number_format:0:'.':' '}{else}Договорная{/if}{/if}
												</p>
											{/if}
											<div class="flex items-center ml-auto">
												{if $post->getAttr(13)}
													<div class="flex items-center mr-4">
														<img data-src="/images/icons/star.svg" width="16px" height="16px" alt="Rating icon" class="lazyimg">
														<p class="ml-2 font-semibold text-sm">{$post->getAttr(13)|number_format}</p>
													</div>
												{/if}
												<div class="flex items-center ">
													<img data-src="/images/icons/eye.svg" width="16px" height="16px" alt="Views icon" class="lazyimg">
													<p class="ml-2 font-semibold text-sm">{$post->getViews()}</p>
												</div>
											</div>
										</div>
									</div>
								</a>
							{/foreach}
						</div>
					</div>
				</div>

			{/if}