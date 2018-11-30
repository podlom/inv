{capture assign='topbar'}
    <a href="{$controller->getUrlGenerator()->generate('add')}" class="button tiny radius success" style="display:inline">Создать</a>
    {* <a href="#" class="button tiny radius alert" style="display:inline">Удалить</a> *}
{/capture}
{if $request->query->has('sort')}
    {if $request->query->get('order',0)}
        {$order = 'ASC'}
    {else}
        {$order = 'DESC'}
    {/if}
    {$items->orderBy(concat($request->query->get('sort'),' ',$order))}
{/if}
{$query = $request->query->all()}
{script 'ui'}

<div class="admin-pages">
    <div class="menu-blocks">   
        <div>
            <div>
                <p>Новости</p>
                <i class="fa fa-newspaper-o"></i>
            </div>
            <div>
                <a href="/admin/blog/11">Больше информации <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div>
            <div>
                <p>Инвестиционные предложения</p>
                <i class="fa fa-wpforms"></i>
            </div>
            <div>
                <a href="/admin/blog/7859">Больше информации <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div>
            <div>
                <p>Мероприятия</p>
                <i class="fa fa-calendar"></i>
            </div>
            <div>
                <a href="/admin/blog/34">Больше информации <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div>
            <div>
                <p>Доска объявлений</p>
                <i class="fa fa-list-alt"></i>
            </div>
            <div>
                <a href="/admin/blog/14976">Больше информации <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
    </div>
    <div class="buttons">
        <a href="{$controller->getUrlGenerator()->generate('add')}" class="green button">Создать</a>
    </div>
    <div class="breadcrumbs">
        <h3>Страницы</h3>
        <div>
            <a href="/admin"><i class="fa fa-home"></i>Главная</a> <span>></span> Страницы
        </div>
    </div>
    <div class="table">
        <table>
            <thead>
                <tr>
                    <td>ID <a href="{$items->getUrlGenerator()->generate($request->query->get('page',1),array_merge($query, ['sort'=>'id', 'order'=>0]))}" class="sort-button sort-button-up"><i class="fa fa-chevron-up"></i></a><a href="{$items->getUrlGenerator()->generate($request->query->get('page',1),array_merge($query, ['sort'=>'id', 'order'=>1]))}" class="sort-button sort-button-down"><i class="fa fa-chevron-down"></i></a></td>
                    <td>Название <a href="{$items->getUrlGenerator()->generate($request->query->get('page',1),array_merge($query, ['sort'=>'h1', 'order'=>0]))}" class="sort-button sort-button-up"><i class="fa fa-chevron-up"></i></a><a href="{$items->getUrlGenerator()->generate($request->query->get('page',1),array_merge($query, ['sort'=>'h1', 'order'=>1]))}" class="sort-button sort-button-down"><i class="fa fa-chevron-down"></i></a></td>
                    <td>URL</td>
                    <td>Дата публикации <a href="{$items->getUrlGenerator()->generate($request->query->get('page',1),array_merge($query, ['sort'=>'published', 'order'=>0]))}" class="sort-button sort-button-up"><i class="fa fa-chevron-up"></i></a><a href="{$items->getUrlGenerator()->generate($request->query->get('page',1),array_merge($query, ['sort'=>'published', 'order'=>1]))}" class="sort-button sort-button-down"><i class="fa fa-chevron-down"></i></a></td>
                    <td>Дата изменения <a href="{$items->getUrlGenerator()->generate($request->query->get('page',1),array_merge($query, ['sort'=>'updated', 'order'=>0]))}" class="sort-button sort-button-up"><i class="fa fa-chevron-up"></i></a><a href="{$items->getUrlGenerator()->generate($request->query->get('page',1),array_merge($query, ['sort'=>'updated', 'order'=>1]))}" class="sort-button sort-button-down"><i class="fa fa-chevron-down"></i></a></td>
                </tr>
            </thead>
            <tbody>
                {foreach $items as $page}
                <tr>
                    <td>{$page->getId()}</td>
                    <td><a href="{$controller->getUrlGenerator()->generate('edit', ['id'=>$page->getId()])}">{$page->getH1()}</a>
                        <a href="{$controller->getUrlGenerator()->generate('remove', ['id'=>$page->getId()])}" class="icon-button del"><i class="fa fa-close"></i></a>
                        <a href="{$page->getPath()}" class="icon-button view"><i class="fa fa-eye"></i></a>
                    </td>
                    <td><a href="{$page->getPath()}">{$page->getPath()}</a></td>
                    <td>{$page->getPublished()}</td>
                    <td>{$page->getUpdated()}</td>
                </tr>
                {/foreach}
            </tbody>
        </table>
        <div class="table-foot">
            <p>Показано с {(($items->getCurrent()-1)*$items->getCount())+1} по {(($items->getCurrent()-1)*$items->getCount())+1+count($items)-1} из {$items->getTotal()} страниц</p>
            {$items->getPagination()->addClass('pagination')}
        </div>
    </div>
</div>