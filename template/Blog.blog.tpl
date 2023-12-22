{* prefilter=off *}
{extends 'Page.view'}

{$links = [
    '/investments/projects'=>'Инвестиционные проекты и стартапы',
    '/investments/business'=>'Продажа бизнеса',
    '/investments/realestate'=>'Недвижимость',
    '/investments/land'=>'Земля',
    '/investments/franchising'=>'Франчайзинг',
    '/investments/offer'=>'Инвесторы'
]}

{if $lang == 'uk'}
{$links = [
    '/uk/investments/projects' => 'Інвестиційні проекти і стартапи',
    '/uk/investments/business' => 'Продаж бізнесу',
    '/uk/investments/realestate' => 'Нерухомість',
    '/uk/investments/land' => 'Земля',
    '/uk/investments/franchising' => 'Франчайзинг',
    '/uk/investments/offer' => 'Інвестори'
]}
{/if}

{if $lang == 'en'}
{$links = [
    '/en/investments/projects'=>'Investment Projects and Startups',
    '/en/investments/business'=>'Business for Sale',
    '/en/investments/realestate'=>'Commercial Property',
    '/en/investments/land'=>'Land',
    '/en/investments/en_franchising'=>'Franchising',
    '/en/investments/offer'=>'Investor Offers'
]}
{/if}

{assign "isNewStylesAvaible" value=(true)}
{assign "isInvestments" value=(
	$request->getPathInfo()|strpos:'/investments' >= 0 &&
	$request->getPathInfo()|strpos:'/investments' !== false
)}
    {* $request->getPathInfo() == '/add-inv-prop' 
    || $request->getPathInfo() == '/' 
    || $request->getPathInfo() == '/investor' 
    || $request->getPathInfo() == '/tools/investors'
    || $request->getPathInfo() == '/tools/database' 
    || $request->getPathInfo() =='/tools/library'
    || $request->getPathInfo() =='/politika-konfidencialnosti' 
    || $request->getPathInfo() =='/usloviya-ispolzovaniya' 
    || $request->getPathInfo() =='/about' 
    || $request->getPathInfo()|strpos:'/about' === 0
    || $request->getPathInfo()|strpos:'/analytics' === 0
    || $request->getPathInfo()|strpos:'/tools/video' === 0
    || $request->getPathInfo()|strpos:'/news' === 0
    || $request->getPathInfo()|strpos:'/investments' === 0
    || $request->getPathInfo()|strpos:'/tools' === 0
    || $request->getPathInfo()|strpos:'/board' === 0
    || $request->getPathInfo()|strpos:'/search' === 0 *}

{block 'page.title'}

{if $isNewStylesAvaible}
	{if $isInvestments}
        <div class="section__title-categories pt-0 mb-2 pb-0 flex flex-row justify-between items-center">
            {if !empty($post)}
                {assign "blogTitle" value=($post->getTitle())}
            {else}
                {assign "blogTitle" value=($blog->getTitle('content'))}
            {/if}

            {if !empty($blog)}
                {assign "blogTitle" value=($blog->getPath())}
            {/if}

            {if !empty($category)}
                {assign "blogTitle" value=($category->getSubpath())}
            {/if}
            <h1 class="ts-19 pr-4 investments__title">{$blogTitle}</h1>
            <a href="{if $lang == 'en'}/en{elseif $lang == 'uk'}/uk{/if}/add-inv-prop" class="investments__title-link desktop-only" >{if $lang == 'en'}How to advertise?{elseif $lang == 'uk'}Як сюди потрапити?{else}Как сюда попасть?{/if}</a>
        </div>
    {elseif $request->getPathInfo()|strpos:'/news' >= 0 && $request->getPathInfo()|strpos:'/news' !== false}
        <div class="section__title-categories pt-0 mb-2 pb-0 flex flex-row justify-between items-center">
            <a href="/news"><h1 data-link="news" class="section__title-categories pr-4">{$blog->getTitle('content')}</h1></a>
            <ul class="sort desktop-only text-xs">
                <li class="sort__item {if !$category}sort__item--active{/if}"><a href="{$blog->getPath()}{if $rubric}/{$rubric->getSubpath()}{/if}">{if $lang=='en'}Latest{elseif $lang == 'uk'}Усі{else}Все{/if}</a><li>
                <li class="sort__item {if $category && $category->getSubpath() =='ukraine'}sort__item--active{/if}"><a href="{$blog->getPath()}/ukraine{if $rubric}/{$rubric->getSubpath()}{/if}">{if $lang=='en'}Ukraine{elseif $lang == 'uk'}Україна{else}Украина{/if}</a><li>
                <li class="sort__item {if $category && $category->getSubpath() =='world'}sort__item--active{/if}"><a href="{$blog->getPath()}/world{if $rubric}/{$rubric->getSubpath()}{/if}">{if $lang=='en'}World{elseif $lang == 'uk'}Світ{else}Мир{/if}</a><li>
            </ul>
        </div>
    {elseif $request->getPathInfo()|strpos:'/events' >= 0 && $request->getPathInfo()|strpos:'/events' !== false}
        <div class="section__title-categories pt-0 mb-2 pb-0 flex flex-row justify-between items-center">
            <a href="/tools/events">
                <h1 class="section__title-categories pr-4">{$blog->getTitle('content')}</h1>
            </a>
            <ul class="sort desktop-only text-xs">
                <li class="sort__item {if $request->query->get('past',0) == 0}sort__item--active{/if}"><a href="/tools/events">{if $lang=='en'}Upcoming{elseif $lang == 'uk'}Майбутні{else}Предстоящие{/if}</a><li>
                <li class="sort__item {if $request->query->get('past',0) == 1}sort__item--active{/if}"><a href="/tools/events?past=1">{if $lang=='en'}Past{elseif $lang == 'uk'}Минулі{else}Прошедшие{/if}</a><li>
{* {if}sort__item--active{/if} *}
            </ul>
        </div>
    {* {elseif $request->getPathInfo()|strpos:'/analytics' >= 0 && $request->getPathInfo()|strpos:'/analytics' !== false}
        <div class="section__title-categories pt-0 mb-2 pb-0 flex flex-row justify-between items-center">
            <a href="/news"><h1  class="section__title-categories pr-4">{$blog->getTitle('content')}</h1></a>
            <ul class="sort desktop-only text-xs">
                <li class="sort__item {if !$category}sort__item--active{/if}"><a href="{$blog->getPath()}{if $rubric}/{$rubric->getSubpath()}{/if}">{if $lang=='en'}Latest{else}Все{/if}</a><li>
                <li class="sort__item {if $category && $category->getSubpath() =='ukraine'}sort__item--active{/if}"><a href="{$blog->getPath()}/ukraine{if $rubric}/{$rubric->getSubpath()}{/if}">{if $lang=='en'}Ukraine{else}Украина{/if}</a><li>
                <li class="sort__item {if $category && $category->getSubpath() =='world'}sort__item--active{/if}"><a href="{$blog->getPath()}/world{if $rubric}/{$rubric->getSubpath()}{/if}">{if $lang=='en'}World{else}Мир{/if}</a><li>
            </ul>
        </div> *}
    {else}
        <h1 class="section__title">
            {$blog->getTitle('content')}
        </h1>
    {/if}
{else}
    <div class="clearfix border-bottom">
        {if $isInvestmentsPage}
            <h2 class="filter__heading">
                <span>{$blog->getTitle('content')}</span>
                
                    <div class="filter__heading-filter toggle-filter">
                        <i class="fa fa-filter"  style="color: #5287b0; font-size:24px" aria-hidden="true"></i>
                    </div>
            </h2>
            
        {else}
            <h2>{$blog->getTitle('content')}</h2>
        {/if}
        
    </div>
{/if}
{/block}
{* {block 'breadcrumbs'}
    <div class="clearfix">
        <ul class="breadcrumbs-box" itemprop="breadcrumb" itemscope>
        {$bc = array_filter([$blog, $category, $rubric, $post])}
        {foreach $bc as $bi}
            {if $bi@last}
                <li class="current">{$bi->getTitle()|truncate:75:" ..."}</li>
            {else}
                <li><a href="{$bi->getPath()}">{$bi->getTitle()|truncate:75:" ..."}</a></li>
            {/if}
        {/foreach}
        </ul>
    </div>
{/block} *}

{block 'content'}
    {block 'nav'}
    {if ($request->getPathInfo()|strpos:'/search')}
    {else}
        <div class="relative z-0 flex flex-row justify-between items-center {if $isInvestments}investments__nav{/if}">
            
            {if $links}
                <div class="relative w-full">
                    <nav class="section__categories">
                        {foreach $links as $url=>$name}
                            <a class="section__category {if $request->getPathInfo()===$url}section__category--active{/if}" href="{$url}">{$name}</a>
                        {/foreach}	
                    </nav>
                    <div class="section__categories-overlay"></div>
                </div>
            {/if}

						{if $isInvestments}
							<ul class="sort desktop-only text-xs">
									{$f = $request->query->get('filter')}
									{foreach $sorts as $s}
											{if $s}
													<li class="sort__item {if $f.sort==$s.0}sort__item--active{/if}"><a href="?{if $s.0}filter[sort]={$s.0}{/if}">{$s.1}</a><li>
											{/if}
									{/foreach}
							</ul>
						{/if}
        </div>
    {/if}
		
    {/block}
    {block 'content.text'}
        {block 'posts'}
        {if $isNewStylesAvaible}
            {assign "horizontal" value=($request->getPathInfo() == '/tools/investors')}
            
            {block 'post.preview'}
                {if $horizontal}
                    <div  class="horizontal-cards__list">
                        {foreach $posts as $idx=>$post}
                            <div itemprop="itemListElement" itemscope itemtype="http://schema.org/Article">
                                <meta itemprop="position" content="{$idx}">
                                {include 'components/horizontal-post'}
                            </div>
                        {/foreach}
                    </div>
                {else}
                    <div class="cards">
                        {foreach $posts as $idx=>$post}
                            <div   itemprop="itemListElement" itemscope itemtype="http://schema.org/Article">
                                <meta itemprop="position" content="{$idx}">
                                {include 'components/card-post'}
                            </div>
                        {/foreach}
                    </div>
                {/if}
            {/block}
            {* <div class="horizontal-cards__list"  itemprop="mainEntity" itemscope itemtype="https://schema.org/ItemList">
                {foreach $posts as $idx=>$post}
                    <div  itemprop="itemListElement" itemscope itemtype="http://schema.org/Article">
                        <meta itemprop="position" content="{$idx}">
                        {include 'partial/post'}
                    </div>
                {/foreach}
            </div> *}
        {else}
            <div class="the_list" itemprop="mainEntity" itemscope itemtype="https://schema.org/ItemList">
                {foreach $posts as $idx=>$post}
                <div itemprop="itemListElement" itemscope itemtype="http://schema.org/Article">
                    <meta itemprop="position" content="{$idx}">
                    {include 'partial/post-old'}
                </div>
                {/foreach}
            </div>
        {/if}
        {/block}
        {block 'pagination'}
            <ul class="pagination mb-10">
                {foreach $posts->getPagination()->getLinks() as $a}
                    <li class="{$a->getAttr('class')}">{$a->setAttr('class', '')}</li>
                {/foreach}
            </ul>
        {/block}

				{if $isInvestments}
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
				{/if}
    {/block}
{/block}
{block 'main' append}

{block seo}
	{if (SeoText::getText($request->getPathInfo()))}
		<div class="content mb-8 opacity-75 seo-text">
				{SeoText::getText($request->getPathInfo())}
		</div>
	{/if}
{/block} 

{/block}


