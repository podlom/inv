{extends 'Blog.blog'}
{block 'page.title'}
<div class="clearfix border-bottom">
    <h2>Результаты поиска</h2>
</div>
{/block}
{block 'breadcrumbs'}{/block}
{block 'menu'}
<div class="search-cnt m_b-15">
    <div class="box-shadow"></div>
    <h3>Изменить поисковый запрос</h3>
    <form action="/search" method="get">
        <div class="large-5 medium-5 columns">
            <input name="q" type="search" value="{$request->query->get("q")}" placeholder="Инвестиционный поиск" />


        </div>
        <div class="large-5 medium-5 columns">
            <select name="sort">
                <option value="rel">По релевантности</option>
                <option value="date">По дате</option>
                <option value="view">По просмотрам</option>
                <option value="category">По категории</option>
            </select>
        </div>
        <div class="large-2 medium-2 columns">
            <button class="blue_but">Поиск</button>
        </div>
    </form>
</div>
{$posts = $pages}
{/block}
{block 'post.author'}{/block}
{block 'post.rubric'}{/block}
{block 'content' append}
    {if !$posts}
    <div class="no_results">
            Введите поисковый запрос.
    </div>
    {/if}
{/block}
