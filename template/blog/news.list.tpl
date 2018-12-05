{extends 'Blog.blog'}
{block 'breadcrumbs'}{/block}
{block 'config' append}
{$cats = [
    'investments'=>['Прямые Инвестиции и M&amp;A', 'Private Equity & M&A'],
    'startup'=>['Стартапы', 'Venture Capital & Startups'],
    'government'=>['Макроэкономика', 'Macroeconomics'],
    'banking'=>['Кредитование', 'Banking'],
    'stock'=>['Фондовый рынок', 'IPO'],
    'realestate'=>['Недвижимость', 'Commercial Property']
]}
{$links = []}
{$l=0}
{if $lang=='en'}{$l=1}{/if}
{$url_base = $blog->getPath()}
{if $category}{$url_base = concat($url_base,'/',$category->getSubpath())}{/if}
{foreach $cats as $n=>$m }
    {$links[concat($url_base,'/', $n)]=$m[$l]}
{/foreach}
{/block}
{block 'nav' append}
<ul class="tabs">
    <li class="tabs-title {if !$category}is-active{/if}"><a href="{$blog->getPath()}{if $rubric}/{$rubric->getSubpath()}{/if}">{if $lang=='en'}Latest{else}Все{/if}</a><li>
    <li class="tabs-title {if $category && $category->getSubpath() =='ukraine'}is-active{/if}"><a href="{$blog->getPath()}/ukraine{if $rubric}/{$rubric->getSubpath()}{/if}">{if $lang=='en'}Ukraine{else}Украина{/if}</a><li>
    <li class="tabs-title {if $category && $category->getSubpath() =='world'}is-active{/if}"><a href="{$blog->getPath()}/world{if $rubric}/{$rubric->getSubpath()}{/if}">{if $lang=='en'}World{else}Мир{/if}</a><li>
</ul>
{/block}