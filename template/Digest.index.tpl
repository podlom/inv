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
    <a href="{$controller->getUrlGenerator()->generate('add')}" class="green button">Добавить</a>
</div>
<div class="breadcrumbs">
    <h3>Дайджест</h3>
    <div>
        <a href="/admin"><i class="fa fa-home"></i>Главная</a> <span>></span> Дайджест
    </div>
</div>
<div class="table">
                <table>
                    <thead>
                        <tr>
                            <td style="width: auto;">Заголовок <a href="?sort_by=title&order=DESC" class="sort-button sort-button-up"><i class="fa fa-chevron-up"></i></a><a href="?sort_by=title&order=ASC" class="sort-button sort-button-down"><i class="fa fa-chevron-down"></i></a></td>
                            <td>Язык <a href="?sort_by=lang&order=DESC" class="sort-button sort-button-up"><i class="fa fa-chevron-up"></i></a><a href="?sort_by=lang&order=ASC" class="sort-button sort-button-down"><i class="fa fa-chevron-down"></i></a></td>
                            <td>Публикация <a href="?sort_by=pub_date&order=DESC" class="sort-button sort-button-up"><i class="fa fa-chevron-up"></i></a><a href="?sort_by=pub_date&order=ASC" class="sort-button sort-button-down"><i class="fa fa-chevron-down"></i></a></td>
                            <td>Файл <a href="?sort_by=url&order=DESC" class="sort-button sort-button-up"><i class="fa fa-chevron-up"></i></a><a href="?sort_by=url&order=ASC" class="sort-button sort-button-down"><i class="fa fa-chevron-down"></i></a></td>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach $items as $item}
                        <tr>
                            <td style="width: auto;"><a href="{$controller->getUrlGenerator()->generate('edit', ['id'=>$item->getId()])}">{$item->getTitle()|default:'[emtpy]'}</a></td>
                            <td>{$item->getLang()}</td>
                            <td>{$item->getPubDate()->format('d F Y')}</td>
                            <td><a href="{$item->getUrl()}">{$item->getFileName()}</a></td>
                        </tr>
                        {/foreach}
                    </tbody>
                </table>
    <div class="table-foot">
        <p>Показано с {(($items->getCurrent()-1)*$items->getCount())+1} по {(($items->getCurrent()-1)*$items->getCount())+1+count($items)-1} из {$items->getTotal()} файлов</p>
        {$items->getPagination()->addClass('pagination')}
    </div>
</div>
</div>