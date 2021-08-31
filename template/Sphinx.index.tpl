{extends 'Blog.blog'}
{block 'page.title'}
{* <div class="clearfix border-bottom">
    <h2>Результаты поиска</h2>
</div> *}
{/block}
{block 'breadcrumbs'}{/block}
{block 'menu'}
<div class="search-cnt m_b-15">
    {* <div class="box-shadow"></div> *}
    {* <h3>Вы искали</h3> *}
    <form id="search-page" class="search-form mb-2" action="/search" method="get">
        {* <div class="large-5 medium-5 columns">
            <input name="q" type="search" value="{$request->query->get("q")}" placeholder="Инвестиционный поиск" />
        </div> *}
        <div class="section__title-categories pt-0 mb-2 pb-0 flex flex-row justify-between items-center">
            <a href="/investments">
                <h1 class="pr-4">Вы искали:</h1>
            </a>
            <ul id="sort-select" class="sort desktop-only text-xs">
                <li data-value="rel" class="sort__item"><a href="#">По релевантности</a></li>
                <li data-value="date" class="sort__item"><a href="#">Новые</a></li>
                <li data-value="view" class="sort__item"><a href="#">Популярные</a></li>
                <li data-value="category" class="sort__item"><a href="#">По категории</a></li>
            </ul>
        </div>
        <input id="sort" name="sort" value="{$request->query->get("sort")}"  hidden />
        {* <div class="large-5 medium-5 columns">
            <select name="sort">
                <option value="rel">По релевантности</option>
                <option value="date">По дате</option>
                <option value="view">По просмотрам</option>
                <option value="category">По категории</option>
            </select>
        </div> *}
        <div class="flex items-center flex-between">
            <input name="q" type="search" value="{$request->query->get("q")}" placeholder="Инвестиционный поиск" class="subscription__input search-form__input pt-0 pb-0 w-full" />
            <button class="btn btn--normal btn--blue pl-6 pr-6 ml-2">Искать</button>
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
