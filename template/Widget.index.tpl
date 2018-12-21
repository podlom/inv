<div class="admin-pages">
    <div class="buttons">
            <a href="{$controller->url('add')}" class="button blue" style="display:inline">Создать</a>
    </div>
    <div class="breadcrumbs">
        <h3>{if $blog}{$blog->getH1()}{else}Каталог{/if}</h3>
        <div>
            <a href="/admin"><i class="fa fa-home"></i>Главная</a> <span>&gt;</span> <a href="/admin/widget">Віджети</a>
        </div>
    </div>
    <div class="table">
        <table class="table-page">
            <tr>
                <th>
                    Id
                    <div class="sort">
                        <a class="sortUp" href="?sort_by=id&order=DESC"></a>
                        <a class="sortDown" href="?sort_by=id&order=ASC"></a>
                    </div>
                </th>
                <th>
                    Name
                    <div class="sort">
                        <a class="sortUp" href="?sort_by=name&order=DESC"></a>
                        <a class="sortDown" href="?sort_by=name&order=ASC"></a>
                    </div>
                </th>
                <th>
                    Type
                </th>
                <th>
                    Description
                </th>
            </tr>
        {foreach $items as $item}
            <tr>
                <td><a href="{$controller->getUrlGenerator()->generate('edit', ['id'=>$item->getId()])}">{$item->getId()}</a></td>
                <td><a href="{$controller->getUrlGenerator()->generate('edit', ['id'=>$item->getId()])}">{$item->getName()}</a></td>
                <td><a href="{$controller->getUrlGenerator()->generate('edit', ['id'=>$item->getId()])}">{$item->getDisplayName()}</a></td>
                {* <td>{$item->getDisplayName()} <a href="{$controller->getUrlGenerator()->generate('slot_select', ['id'=>$item->getId()])}">Разместить</a></td> *}
                <td>{$item->getDescription()}</td>
            </tr>
        {/foreach}
        </table>
    </div>
</div>
