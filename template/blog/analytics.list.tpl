{extends 'Blog.blog'}{* used by: board,experts,lirary,tools*}
{block 'config' append}
{if $lang == 'en'}
{$links = [
    '/en/analytics/investments'=>'Research',
    '/en/analytics/articles'=>'Articles',
    '/en/analytics/formula'=>'Interview',
    '/en/analytics/we-invest-in-ukraine'=>'We Invest in Ukraine',
    '/en/tools/database'=>'Ratings',
    '/en/tools/library'=>'Library',
    '/en/tools/investors'=>'Investors'
]}
{else}
{$links = [
  '/analytics/articles'=>'Статьи',
    '/analytics/formula'=>'Интервью',
    '/analytics/we-invest-in-ukraine'=>'Инвестируем в Украину',
    '/tools/database'=>'Рейтинги',
    '/tools/library'=>'Библиотека',
    '/tools/investors'=>'Инвесторы'
]}
{/if}
{/block}
{block 'breadcrumbs'}{/block}