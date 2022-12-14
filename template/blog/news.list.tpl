{* prefilter=off *}
{extends 'Blog.blog'}
{block 'breadcrumbs'}{/block}
{block 'config' append}
	{$cats = [
	    'investments'=>['Прямые Инвестиции и M&A', 'Private Equity & M&A', 'Прямі інвестиції та M&A'],
	    'startup'=>['Стартапы', 'Venture Capital & Startups', 'Стартапи'],
	    'government'=>['Макроэкономика', 'Macroeconomics', 'Макроекономіка'],
	    'banking'=>['Кредитование', 'Banking', 'Кредитування'],
	    'stock'=>['Фондовый рынок', 'IPO', 'Фондовий ринок'],
	    'realestate'=>['Недвижимость', 'Commercial Property', 'Нерухомість']
	]}

	{$links = []}
	{$l=0}
	{if $lang=='en'}{$l=1}{/if}
	{if $lang=='uk'}{$l=2}{/if}
	{$url_base = $blog->getPath()}
	{if $category}{$url_base = concat($url_base,'/',$category->getSubpath())}{/if}
	{foreach $cats as $n=>$m }
		{$links[concat($url_base,'/', $n)]=$m[$l]}
	{/foreach}
{/block}
{block 'nav' append}
	<ul class="tabs">
		<li class="tabs-title {if !$category}is-active{/if}"><a
				href="{$blog->getPath()}{if $rubric}/{$rubric->getSubpath()}{/if}">{if $lang=='en'}Latest{elseif $lang=='uk'}Усі{else}Все{/if}</a>
		<li>
		<li class="tabs-title {if $category && $category->getSubpath() =='ukraine'}is-active{/if}"><a
				href="{$blog->getPath()}/ukraine{if $rubric}/{$rubric->getSubpath()}{/if}">{if $lang=='en'}Ukraine{elseif $lang=='uk'}Україна{else}Украина{/if}</a>
		<li>
		<li class="tabs-title {if $category && $category->getSubpath() =='world'}is-active{/if}"><a
				href="{$blog->getPath()}/world{if $rubric}/{$rubric->getSubpath()}{/if}">{if $lang=='en'}World{elseif $lang=='uk'}Світ{else}Мир{/if}</a>
		<li>
	</ul>
{/block}
{block 'post.parent'}
	{$rubrics = $post->getRubrics()}
	{$r = $rubrics.0}
	{if $r}
		<a href="{$r->getPath()}">
			{if file_exists(concat($module->getApp()->getWebRoot(),'/i/',$r->getSubpath(),'.png'))}
				<img src="{concat('/i/',$r->getSubpath(),'.png')}" alt="" class="category" />
			{else}
				<img src="/i/folded-newspaper.png" alt="" />
			{/if}
			{$r->getH1()}
		</a>
	{/if}
{/block}