{* prefilter=off *}
{extends 'Blog.blog'}
{block 'breadcrumbs'}{/block}
{block 'config' append}
{$cats = [
    'investments'=>['Прямые Инвестиции и M&amp;A', 'Private Equity & M&A', 'Прямі Інвестиції та M&amp;A'],
    'startup'=>['Стартапы', 'Venture Capital & Startups', 'Стартапи'],
    'government'=>['Макроэкономика', 'Macroeconomics', 'Макроекономіка'],
    'banking'=>['Кредитование', 'Banking', 'Кредитування'],
    'stock'=>['Фондовый рынок', 'IPO', 'Фондовий ринок'],
    'realestate'=>['Недвижимость', 'Commercial Property', 'Нерухомість']
]}
{/block}
