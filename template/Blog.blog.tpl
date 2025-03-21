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


{* if $lang == 'ru' *}
{$nextPageUrl = '/news.php?lang=ru&action=news-list&page=2'}
{if $request->getPathInfo()|strpos:'/analytics' === 0}
    {$nextPageUrl = '/analytics.php?lang=ru&action=analytics-list&page=2'}
{/if}
{if $request->getPathInfo()|strpos:'/tools/video' === 0}
    {$nextPageUrl = '/video.php?lang=ru&action=video-list&page=2'}
{/if}


{* if $lang == 'uk' *}
{if $lang == 'uk'}
    {$links = [
        '/uk/investments/projects' => 'Інвестиційні проекти і стартапи',
        '/uk/investments/business' => 'Продаж бізнесу',
        '/uk/investments/realestate' => 'Нерухомість',
        '/uk/investments/land' => 'Земля',
        '/uk/investments/franchising' => 'Франчайзинг',
        '/uk/investments/offer' => 'Інвестори'
    ]}
    {$nextPageUrl = '/news.php?lang=uk&action=news-list&page=2'}
    {if $request->getPathInfo()|strpos:'/uk/analytics' === 0}
        {$nextPageUrl = '/analytics.php?lang=uk&action=analytics-list&page=2'}
    {/if}
    {if $request->getPathInfo()|strpos:'/uk/tools/video' === 0}
        {$nextPageUrl = '/video.php?lang=uk&action=video-list&page=2'}
    {/if}
{/if}


{* if $lang == 'en' *}
{if $lang == 'en'}
    {$links = [
        '/en/investments/projects'=>'Investment Projects and Startups',
        '/en/investments/business'=>'Business for Sale',
        '/en/investments/realestate'=>'Commercial Property',
        '/en/investments/land'=>'Land',
        '/en/investments/en_franchising'=>'Franchising',
        '/en/investments/offer'=>'Investor Offers'
    ]}
    {$nextPageUrl = '/news.php?lang=en&action=news-list&page=2'}
    {if $request->getPathInfo()|strpos:'/en/analytics' === 0}
        {$nextPageUrl = '/analytics.php?lang=en&action=analytics-list&page=2'}
    {/if}
    {if $request->getPathInfo()|strpos:'/en/tools/video' === 0}
        {$nextPageUrl = '/video.php?lang=en&action=video-list&page=2'}
    {/if}
{/if}


{if $category && $category->getSubpath()}
    {assign var="nextPageUrl" value=$nextPageUrl|cat:"&category="|cat:$category->getSubpath()}
{/if}

{if $rubric && $rubric->getSubpath()}
    {assign var="nextPageUrl" value=$nextPageUrl|cat:"&rubric="|cat:$rubric->getSubpath()}
{/if}

{assign "isNewStylesAvaible" value=(true)}
{assign "isInvestments" value=(
	$request->getPathInfo()|strpos:'/investments' >= 0 &&
	$request->getPathInfo()|strpos:'/investments' !== false
)}

{block 'page.title'}

    {if $isNewStylesAvaible}
        {if $isInvestments}
            <div class="section__title-categories pt-0 mb-2 pb-0 flex flex-row justify-between items-center">
                {assign "rubricSubpath" value=("")}
                {if !empty($post)}
                    {assign "blogTitle" value=($post->getTitle())}
                    {assign "line" value="99"}
                {else}
                    {assign "blogTitle" value=($blog->getTitle('content'))}
                    {assign "line" value="102"}
                {/if}
                {if !empty($blog)}
                    {assign "blogTitle" value=($blog->getTitle('content'))}
                    {assign "line" value="106"}
                {/if}
                {if !empty($category)}
                    {assign "blogTitle" value=($category->getTitle())}
                    {assign "line" value="110"}
                {/if}
                {if !empty($page)}
                    {assign "blogTitle" value=($page->getTitle())}
                    {assign "line" value="114"}
                {/if}
                {if !empty($rubric)}
                    {assign "blogTitle" value=($rubric->getTitle())}
                    {assign "line" value="118"}
                    {assign "rubricSubpath" value=($rubric->getSubpath())}
                {/if}
                <h1 class="ts-line-{$line} ts-{$rubricSubpath}-ts pr-4 investments__title">{$blogTitle}</h1>
                <a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/add-inv-prop"
                    class="investments__title-link desktop-only ml-4">
                    {if $lang == 'en'}
                        Place an ad
                    {elseif $lang === 'uk'}
                        Розмістити оголошення
                    {else}
                        Разместить объявление
                    {/if}
                </a>
            </div>
        {elseif $request->getPathInfo()|strpos:'/news' >= 0 && $request->getPathInfo()|strpos:'/news' !== false}
            <div class="section__title-categories pt-0 mb-2 pb-0 flex flex-row justify-between items-center">
                {assign "rubricSubpath" value=("")}
                {if !empty($rubric)}
                    {assign "blogTitle" value=($rubric->getTitle())}
                    {assign "line" value="139"}
                    {assign "rubricSubpath" value=($rubric->getSubpath())}
                {else}
                    {assign "blogTitle" value=($blog->getTitle('content'))}
                    {assign "line" value="143"}
                {/if}
                <a href="/news">
                    <h1 data-link="news" class="ts-line-{$line} ts-{$rubricSubpath}-ts section__title-categories pr-4">{$blogTitle}
                    </h1>
                </a>
                <ul class="sort desktop-only text-xs">
                    <li class="sort__item {if !$category}sort__item--active{/if}"><a
                            href="{$blog->getPath()}{if $rubric}/{$rubric->getSubpath()}{/if}">{if $lang=='en'}Latest{elseif $lang == 'uk'}Усі{else}Все{/if}</a>
                    <li>
                    <li class="sort__item {if $category && $category->getSubpath() =='ukraine'}sort__item--active{/if}"><a
                            href="{$blog->getPath()}/ukraine{if $rubric}/{$rubric->getSubpath()}{/if}">{if $lang=='en'}Ukraine{elseif $lang == 'uk'}Україна{else}Украина{/if}</a>
                    <li>
                    <li class="sort__item {if $category && $category->getSubpath() =='world'}sort__item--active{/if}"><a
                            href="{$blog->getPath()}/world{if $rubric}/{$rubric->getSubpath()}{/if}">{if $lang=='en'}World{elseif $lang == 'uk'}Світ{else}Мир{/if}</a>
                    <li>
                </ul>
            </div>
        {elseif $request->getPathInfo()|strpos:'/events' >= 0 && $request->getPathInfo()|strpos:'/events' !== false}
            <div class="section__title-categories pt-0 mb-2 pb-0 flex flex-row justify-between items-center">
                <a href="/tools/events">
                    <h1 class="section__title-categories pr-4">{$blog->getTitle('content')}</h1>
                </a>
                <ul class="sort desktop-only text-xs">
                    <li class="sort__item {if $request->query->get('past',0) == 0}sort__item--active{/if}"><a
                            href="{if $lang == 'en'}/en{elseif $lang == 'uk'}/uk{/if}/tools/events">{if $lang=='en'}Upcoming{elseif $lang == 'uk'}Майбутні{else}Предстоящие{/if}</a>
                    <li>
                    <li class="sort__item {if $request->query->get('past',0) == 1}sort__item--active{/if}"><a
                            href="{if $lang == 'en'}/en{elseif $lang == 'uk'}/uk{/if}/tools/events?past=1">{if $lang=='en'}Past{elseif $lang == 'uk'}Минулі{else}Прошедшие{/if}</a>
                    <li>
                </ul>
            </div>
        {elseif $request->getPathInfo()|strpos:'/analytics' >= 0 && $request->getPathInfo()|strpos:'/analytics' !== false}
            {if !empty($category)}
                {assign "blogTitle" value=($category->getTitle())}
                {assign "line" value="119"}
            {else}
                {assign "blogTitle" value=($blog->getTitle('content'))}
                {assign "line" value="122"}
            {/if}
            <div class="section__title-categories pt-0 mb-2 pb-0 flex flex-row justify-between items-center">
                <a href="/analytics">
                    <h1 class="ts-line-{$line} section__title-categories pr-4">{$blogTitle}</h1>
                </a>

                <a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/add-inv-prop"
                    class="investments__title-link desktop-only ml-4">
                    {if $lang == 'en'}
                        Place an ad
                    {elseif $lang === 'uk'}
                        Розмістити оголошення
                    {else}
                        Разместить объявление
                    {/if}
                </a>
            </div>
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
                        <i class="fa fa-filter" style="color: #5287b0; font-size:24px" aria-hidden="true"></i>
                    </div>
                </h2>

            {else}
                <h2>{$blog->getTitle('content')}</h2>
            {/if}

        </div>
    {/if}
{/block}


{block 'content'}
    {block 'nav'}
        {if ($request->getPathInfo()|strpos:'/search')}
        {else}
            <div class="relative z-0 flex flex-row justify-between items-center {if $isInvestments}investments__nav{/if}">

                {if $links}
                    <div class="relative w-full">
                        <nav class="section__categories">
                            {foreach $links as $url=>$name}
                                <a class="section__category {if $request->getPathInfo()===$url}section__category--active{/if}"
                                    href="{$url}">{$name}</a>
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
                                <li class="sort__item {if $f.sort==$s.0}sort__item--active{/if}"><a
                                        href="?{if $s.0}filter[sort]={$s.0}{/if}">{$s.1}</a>
                                <li>
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
                {block 'post.preview'}
                    {if $horizontal}
                        <div class="horizontal-cards__list">
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
                                {assign "linkAttributes" value=""}
                                {if $post@last}
                                    {assign "linkAttributes" value="hx-get='`$nextPageUrl`' hx-trigger='revealed' hx-indicator='#spinner' hx-swap='afterend'"}
                                {/if}
                                <div {if !empty($linkAttributes)}{$linkAttributes}{/if} itemprop="itemListElement" itemscope
                                    itemtype="http://schema.org/Article">
                                    <meta itemprop="position" content="{$idx}">
                                    {include 'components/card-post' linkAttributes="$linkAttributes"}
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
            {assign "isNewsPage" value=($request->getPathInfo()|strpos:'/news' === 0 || $request->getPathInfo()|strpos:'/en/news' === 0 || $request->getPathInfo()|strpos:'/uk/news' === 0)}
            {assign "isAnalyticsPage" value=($request->getPathInfo()|strpos:'/analytics' === 0 || $request->getPathInfo()|strpos:'/en/analytics' === 0 || $request->getPathInfo()|strpos:'/uk/analytics' === 0)}
            {assign "isVideoPage" value=($request->getPathInfo()|strpos:'/tools/video' === 0 || $request->getPathInfo()|strpos:'/en/tools/video' === 0 || $request->getPathInfo()|strpos:'/uk/tools/video' === 0)}
            {assign "isEventsPage" value=($request->getPathInfo()|strpos:'/tools/events' === 0 || $request->getPathInfo()|strpos:'/en/tools/events' === 0 || $request->getPathInfo()|strpos:'/uk/tools/events' === 0)}

            {if $isInvestmentsPage || $isNewsPage || $isAnalyticsPage || $isVideoPage || $isEventsPage }
                <style>
                    .lds-ellipsis {
                        display: inline-block;
                        position: relative;
                        width: 80px;
                        height: 80px;
                    }

                    .lds-ellipsis div {
                        position: absolute;
                        top: 33px;
                        width: 13px;
                        height: 13px;
                        border-radius: 50%;
                        background: var(--main-accent-color-darken);
                        animation-timing-function: cubic-bezier(0, 1, 1, 0);
                    }

                    .lds-ellipsis div:nth-child(1) {
                        left: 8px;
                        animation: lds-ellipsis1 0.6s infinite;
                    }

                    .lds-ellipsis div:nth-child(2) {
                        left: 8px;
                        animation: lds-ellipsis2 0.6s infinite;
                    }

                    .lds-ellipsis div:nth-child(3) {
                        left: 32px;
                        animation: lds-ellipsis2 0.6s infinite;
                    }

                    .lds-ellipsis div:nth-child(4) {
                        left: 56px;
                        animation: lds-ellipsis3 0.6s infinite;
                    }

                    @keyframes lds-ellipsis1 {
                        0% {
                            transform: scale(0);
                        }

                        100% {
                            transform: scale(1);
                        }
                    }

                    @keyframes lds-ellipsis3 {
                        0% {
                            transform: scale(1);
                        }

                        100% {
                            transform: scale(0);
                        }
                    }

                    @keyframes lds-ellipsis2 {
                        0% {
                            transform: translate(0, 0);
                        }

                        100% {
                            transform: translate(24px, 0);
                        }
                    }

                    .htmx-indicator {
                        opacity: 0;
                        transition: opacity 500ms ease-in;
                    }

                    .htmx-request .htmx-indicator {
                        opacity: 1
                    }

                    .htmx-request.htmx-indicator {
                        opacity: 1
                    }
                </style>
                <div id="spinner" style="margin: 0 auto; display: block;" class="lds-ellipsis htmx-indicator">
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                </div>
                {script src="https://unpkg.com/htmx.org@1.9.10" name="htmx" }
                <script>
                    const htmxScript = document.querySelector('script[data-name="htmx"]');
                    htmxScript.addEventListener("load", () => {
                        console.log('htmx loaded')
                        const cardList = document.querySelector('.cards');
                        if (cardList) window.htmx.process(cardList);
                    });
                </script>
            {else}
                <ul class="pagination mb-10">
                    {foreach $posts->getPagination()->getLinks() as $a}
                        <li class="{$a->getAttr('class')}">{$a->setAttr('class', '')}</li>
                    {/foreach}
                </ul>
            {/if}
        {/block}
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