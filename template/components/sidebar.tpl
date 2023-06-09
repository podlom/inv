{assign "isInvestmentsPost" value=((
	$request->getPathInfo()|strpos:'/investments' || 
	$request->getPathInfo()|strpos:'/investments/' === 0 || 
	$request->getPathInfo()|strpos:'/en/investments' || 
	$request->getPathInfo()|strpos:'/uk/investments' || 
	$request->getPathInfo()|strpos:'/en/investments/' === 0 ||
	$request->getPathInfo()|strpos:'/uk/investments/' === 0) && 
	$request->getPathInfo()|strpos:'analytics/investments/' === false)}
{assign "isInvestments" value=(
	(
	 $request->getPathInfo() === '/investments' ||
	 $request->getPathInfo() === '/en/investments' || 
	 $request->getPathInfo() === '/uk/investments' || 
	 $request->getPathInfo()|strpos:'/investments' ||
	 $request->getPathInfo()|strpos:'/investments/' === 0 || 
	 $request->getPathInfo()|strpos:'/en/investments' || 
	 $request->getPathInfo()|strpos:'/uk/investments' || 
	 $request->getPathInfo()|strpos:'/en/investments/' === 0 ||
	 $request->getPathInfo()|strpos:'/uk/investments/' === 0
	)
	&& $request->getPathInfo()|strpos:'analytics/investments/' === false
	)
}
<aside class="sidebar desktop-only" data-test="{$request->getPathInfo()}" data-result="{$isInvestments}">


	{* {if $isInvestments}
        <div class=" mb-6">
            <h2 class="section__title contact-form__title mb-0">
                Контакты
            </h2>
            <div class="contacts__wrapper">
                <div class="contacts__info">
                {#mod Attribute}
                    {if $post->getAttr(5) && $post->getAttr(4) && $post->getAttr(3)}
                        <img data-src="{if $post->getAttr(63)}img/contact-photo.jpg{else}/i/no-photo.png{/if}" class="lazyimg contacts__img">
                        <div class="contacts__text">
                            <h3 class="contacts__text-name">{$post->getAttr(5)}</h3>
                            <a class="contacts__text-link" href="mailto:{$post->getAttr(4)}">{$post->getAttr(4)}</a>
                            <a class="contacts__text-link" href="tel:{preg_replace('![^\+0-9]!', '',$post->getAttr(3))}">{$post->getAttr(3)}</a>
                        </div>
                {else}{#/mod}
                    <img data-src="/images/alex-photo.jpg" class="lazyimg contacts__img">
                    <div class="contacts__text">
                        <h3 class="contacts__text-name">{if $lang=='en'}Alex{else}Алексей{/if}</h3>
                        <a class="contacts__text-link" href="mailto:info@inventure.ua">info@inventure.ua</a>
                        <a class="contacts__text-link" href="tel:+380977727292">+38 097 772 72 92</a>
                    </div>
                {#mod Attribute}{/if}{#/mod}
                </div>
                <button class="contacts__btn btn w-full btn--blue-text">
                    <div class="contacts__icon ">
                        <svg width="24" height="18" viewBox="0 0 24 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M23.5453 5.94375C23.7281 5.79844 24 5.93437 24 6.16406V15.75C24 16.9922 22.9922 18 21.75 18H2.25C1.00781 18 0 16.9922 0 15.75V6.16875C0 5.93438 0.267187 5.80312 0.454687 5.94844C1.50469 6.76406 2.89688 7.8 7.67813 11.2734C8.66719 11.9953 10.3359 13.5141 12 13.5047C13.6734 13.5188 15.375 11.9672 16.3266 11.2734C21.1078 7.8 22.4953 6.75938 23.5453 5.94375ZM12 12C13.0875 12.0188 14.6531 10.6313 15.4406 10.0594C21.6609 5.54531 22.1344 5.15156 23.5687 4.02656C23.8406 3.81562 24 3.4875 24 3.14062V2.25C24 1.00781 22.9922 0 21.75 0H2.25C1.00781 0 0 1.00781 0 2.25V3.14062C0 3.4875 0.159375 3.81094 0.43125 4.02656C1.86563 5.14687 2.33906 5.54531 8.55938 10.0594C9.34688 10.6313 10.9125 12.0188 12 12Z" fill="#5D87AD"></path>
                        </svg>
                    </div>
                    Написать
                </button>
            </div>
        </div>
    {/if} *}

	{block 'aside.top'}

		<div class="desktop-only">
			{include 'components/promo-links'}
		</div>
		{if $isInvestments}
			{include 'components/invest-filter'}
		{/if}
	{/block}
	{block 'aside.subscribe'}
		{include 'components/sidebar-subscription'}
	{/block}
	{block 'aside.banner'}
		{if $lang !== 'en'}
			<div class="advertising lang-{$lang}" id="advertising">
				{#mod Widget}
				{widget_slot 'main (370x450)' size=[370,450]}
				{widget_slot 'post_2 (370x450)' size=[370,450]}
				{widget_slot 'post_6 (370x450)' size=[370,450]}
				{widget_slot 'post_7 (370x450)' size=[370,450]}
				{widget_slot 'post_8 (370x450)' size=[370,450]}
				{#/mod}
			</div>
		{/if}
	{/block}
</aside>