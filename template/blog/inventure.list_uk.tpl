{* prefilter=off *}
{extends 'Blog.blog'}
{block 'page.class' append} inventure_list{/block}
{block 'config'}
	{$links = [
	    '/investments/projects'=>'Інвестиційні проекти та стартапи',
	    '/investments/business'=>'Продаж бізнесу',
	    '/investments/realestate'=>'Нерухомість',
	    '/investments/land'=>'Земля',
	    '/investments/franchising'=>'Франчайзинг',
	    '/investments/offer'=>'Інвестори'
	]}

	{$sorts = [
	    ['', 'Нові'],
	    ['views', 'Популярні'],
	    ['rating', 'Найкращі']
	]}



{/block}


<div data-append="sort" class="section__title-categories pt-0 mb-2 pb-0 flex flex-row justify-between items-center">
	{* <h1 class="pr-4">Инвестиционные предложения</h1> *}
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
</div>



{block 'breadcrumbs'}{/block}
{block 'nav' append}
{/block}
	{block 'posts'}
		{include 'components/mobile-sort'}
		<article id="cards__list" class="cards"></article>
	{/block}

	{script_code require="jquery"}

	$( document ).ready(function() {
	console.log( "+179 ready!" );

	});



	{* https://dev.inventure.com.ua/invest.php?action=get&filter%5Bcategory%5D%5Bparent%5D=projects&price1=10000&price2=5000000 *}

	{/script_code}
