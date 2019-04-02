{* prefilter=off *}
{if $request->query->has('sort')}
    {if $request->query->get('order',0)}
        {$order = 'ASC'}
    {else}
        {$order = 'DESC'}
    {/if}
    {$pages->orderBy(concat($request->query->get('sort'),' ',$order))}
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
        {if $blog}
            <a href="{$controller->getUrlGenerator()->generate('post.index', ['blog_id'=>$blog->getId()])}" {if $type=='post'}disabled{/if} class="button blue" style="display:inline">Посты</a>
            <a href="{$controller->getUrlGenerator()->generate('category.index', ['blog_id'=>$blog->getId()])}" {if $type=='category'}disabled{/if} class="button blue" style="display:inline">Категории</a>
            <a href="{$controller->getUrlGenerator()->generate('rubric.index', ['blog_id'=>$blog->getId()])}" {if $type=='rubric'}disabled{/if} class="button blue" style="display:inline">Рубрики</a>
            <a href="{$controller->getUrlGenerator()->generate('blog.edit', ['id'=>$blog->getId()])}" class="button blue" style="display:inline">Каталог</a>
            <a href="{$controller->getUrlGenerator()->generate(concat($type,'.add'), ['blog_id'=>$blog->getId()])}" class="button green" style="display:inline">Создать</a>
            {* <a href="#" class="button tiny radius alert" style="display:inline">Удалить</a> *}
        {else}
            <a href="{$controller->getUrlGenerator()->generate(concat('blog.add'))}" class="green button">Создать</a>
            {* <a href="#" class="button tiny radius alert" style="display:inline">Удалить</a> *}
        {/if}
        {if $blog && $blog->getId() == 14976}
            <a href="{$controller->getUrlGenerator()->generate('post.index', ['blog_id'=>14976, 'status'=>2])}" class="button blue" style="display:inline">На модерации</a>
            <a href="{$controller->getUrlGenerator()->generate('post.index', ['blog_id'=>14976, 'status'=>1])}" class="button blue" style="display:inline">Опубликовано</a>
            <a href="{$controller->getUrlGenerator()->generate('post.index', ['blog_id'=>14976, 'status'=>0])}" class="button blue" style="display:inline">Нe оплачено</a>
        {/if}
    </div>
    <div class="breadcrumbs">
        <h3>{if $blog}{$blog->getH1()}{else}Каталог{/if}</h3>
        <div>
            <a href="/admin"><i class="fa fa-home"></i>Главная</a> <span>></span> <a href="/admin/blog">Каталог</a> {if $blog}<span>></span> {$blog->getH1()}{/if}
        </div>
    </div>
    <div class="table">
        <div class="search">
            <div>
                Показывать
                <select>
                    <option>10</option>
                    <option>20</option>
                    <option>30</option>
                    <option>40</option>
                </select>
                на странице
            </div>
            <div>
                Поиск: <form method="GET"><input type="search" name="q" value="{$request->query->get('q')}"/> <button class="button"><i class="fa fa-search"></i></button></form>
            </div>
        </div>
        <table>
            <thead>
                <tr>
                    <td>ID <a href="{$pages->getUrlGenerator()->generate(1,array_merge($query, ['sort'=>'id']))}" class="sort-button sort-button-up"><i class="fa fa-chevron-up"></i></a><a href="{$pages->getUrlGenerator()->generate(1,array_merge($query, ['sort'=>'!id']))}" class="sort-button sort-button-down"><i class="fa fa-chevron-down"></i></a></td>
                    <td>Название
                        <a href="{$pages->getUrlGenerator()->generate(1,array_merge($query, ['sort'=>'h1']))}" class="sort-button sort-button-up">
                            <i class="fa fa-chevron-up"></i>
                        </a>
                        <a href="{$pages->getUrlGenerator()->generate(1,array_merge($query, ['sort'=>'!h1']))}" class="sort-button sort-button-down">
                            <i class="fa fa-chevron-down"></i>
                        </a>
                    </td>
                    <td>URL</td>
                    {if $type=='post' && $categories}
                    <td class="category">
                        {* !R create react component for filter {react 'React.EntitySelect' props=['name'=>'category', 'url'=>$controller->url('category.index'), 'multiple'=>true, 'value'=>[]]} *}
                        {$f = $request->query->get('filter')}
                        {$filter = []}
                        {foreach $f as $k=>$v}{if $k=='parent'}{continue}{/if}{$filter[$k]=$v}{/foreach}
                        <select onchange="if(this.value!=location.href)location.href=this.value;">
                            <option value="{$pages->getUrlGenerator()->generate(1,array_merge($query, ['filter'=>$filter]))}" label="Категория">Категория</option>
                            {$filter['parent']='null'}
                            <option {if $f['parent']=='null'}selected {/if}value="{$pages->getUrlGenerator()->generate(1,array_merge($query, ['filter'=>$filter]))}" label="Без категории">Без категории</option>
                            {foreach $categories as $id=>$category}
                                {$filter['parent']=$id}
                                <option {if $f['parent']==$id}selected {/if}value="{$pages->getUrlGenerator()->generate(1,array_merge($query, ['filter'=>$filter]))}" label="{$category}">{$category}</option>
                            {/foreach}
                        </select>
                    </td>
                    {/if}
                    {* if $type=='post' && $types}
                    <td class="type">
                        <select onchange="if(this.value!=location.href)location.href=this.value;">
                            <option value="{$pages->getUrlGenerator()->generate(1,array_merge($query, ['type'=>null]))}" label="Тип">Тип</option>
                            {$i=0}
                            {foreach $types as $class=>$name}
                                <option {if $request->query->get('type')===$i}selected {/if}value="{$pages->getUrlGenerator()->generate($request->query->get('page',1),array_merge($query, ['type'=>$i++]))}" label="{$name}">{$name}</option>
                            {/foreach}
                        </select>
                    </td>
                    {/if *}
                    <td>Дата публикации <a href="{$pages->getUrlGenerator()->generate($request->query->get('page',1),array_merge($query, ['sort'=>'published', 'order'=>0]))}" class="sort-button sort-button-up"><i class="fa fa-chevron-up"></i></a><a href="{$pages->getUrlGenerator()->generate($request->query->get('page',1),array_merge($query, ['sort'=>'published', 'order'=>1]))}" class="sort-button sort-button-down"><i class="fa fa-chevron-down"></i></a></td>
                    <td>Дата изменения <a href="{$pages->getUrlGenerator()->generate($request->query->get('page',1),array_merge($query, ['sort'=>'updated', 'order'=>0]))}" class="sort-button sort-button-up"><i class="fa fa-chevron-up"></i></a><a href="{$pages->getUrlGenerator()->generate($request->query->get('page',1),array_merge($query, ['sort'=>'updated', 'order'=>1]))}" class="sort-button sort-button-down"><i class="fa fa-chevron-down"></i></a></td>
                    <td>Автор</td>
                    {if $blog && $blog->getId() == 14976}
                        <td>
                            Статус
                        </td>
                    {/if}
                </tr>
            </thead>
            <tbody>
                {foreach $pages as $page}
                <tr>
                    <td>{$page->getId()}</td>
                    <td>{*
                   <input type="checkbox" id="page_{$page->getId()}">
                    <label for="page_{$page->getId()}"></label>
                *}
                <a href="
                {if $type && $type!='blog'}
                    {$controller->getUrlGenerator()->generate(concat($type,'.edit'), ['id'=>$page->getId(), 'blog_id'=>$blog->getId()])}
                {else}
                    {$controller->getUrlGenerator()->generate('post.index', ['blog_id'=>$page->getId()])}
                {/if}">{$page->getH1()}</a>{if $blog}<a class="icon-button del" href="{$controller->getUrlGenerator()->generate(concat($type,'.remove'), ['id'=>$page->getId(), 'blog_id'=>$blog->getId()])}"><i class="fa fa-close"></i></a>{/if}<a class="icon-button view" href="{$page->getPath()}"><i class="fa fa-eye"></i></a></td>
                    <td><a href="{$page->getPath()}">{$page->getPath()}</a></td>
                    {if $type=='post' && $categories}
                    <td>
                        {if $page->getParent()}{$categories[$page->getParent()->getId()]}{else}Нет{/if}
                    </td>
                    {/if}
                     {* if $type=='post' && $types}
                    <td>
                        {if $types[get_class($page)]}{$types[get_class($page)]}{else}unknown{/if}
                    </td>
                    {/if *}
                    <td>{$page->getPublished()}</td>
                    <td>{$page->getUpdated()}</td>
                    <td>{if $page->getUser()}{$page->getUser()->getName()}{else}Аноним{/if}</td>
                    {if $blog && $blog->getId() == 14976}
                    <td>
                        {if $page->getStatus() == 1}
                            Опубликовано
                        {elseif $page->getAttr(61) != 1}
                            Не оплачено
                        {elseif $page->getStatus() == 0}
                            На модерации
                        {/if}
                    </td>
                {/if}
                </tr>
                {/foreach}
            </tbody>
        </table>
        <div class="table-foot">
            <p>Показано с {(($pages->getCurrent()-1)*$pages->getCount())+1} по {(($pages->getCurrent()-1)*$pages->getCount())+1+count($pages)-1} из {$pages->getTotal()} {if !$blog}типов записей{else}записей{/if}</p>
            {$pages->getPagination()->addClass('pagination')}
        </div>
    </div>
</div>