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
        <h3>Перенаправления</h3>
        <div>
            <a href="/admin"><i class="fa fa-home"></i>Главная</a> <span>></span> Перенаправления
        </div>
    </div>
    <div class="table">
        <table>
            <thead>
                <tr>
                    <td style="width: auto;"> <input type="checkbox" name="item[selectAll]" id="chboxTh" value="false" />
                        <label for="chboxTh"></label>
                    </td>
                    <td style="width: 50px;">ID <a href="" class="sort-button sort-button-up"><i class="fa fa-chevron-up"></i></a><a href="" class="sort-button sort-button-down"><i class="fa fa-chevron-down"></i></a></td>
                    <td>URL-Источник <a href="" class="sort-button sort-button-up"><i class="fa fa-chevron-up"></i></a><a href="" class="sort-button sort-button-down"><i class="fa fa-chevron-down"></i></a></td>
                    <td>URL-Цель <a href="" class="sort-button sort-button-up"><i class="fa fa-chevron-up"></i></a><a href="" class="sort-button sort-button-down"><i class="fa fa-chevron-down"></i></a></td>
                    <td style="width: 50px;">Код <a href="" class="sort-button sort-button-up"><i class="fa fa-chevron-up"></i></a><a href="" class="sort-button sort-button-down"><i class="fa fa-chevron-down"></i></a></td>
                </tr>
            </thead>
            <tbody>
                {$items->setCount(20)}
                {foreach $items as $redirect}
                <tr>
                    <td style="width: auto;">
                        <input type="checkbox" name="id[{$redirect->getRoute()->getId()}]" id="page{$redirect->getRoute()->getId()}" /><label for="page{$redirect->getRoute()->getId()}"></label>
                    </td>
                    <td style="width: 50px;">{$redirect->getRoute()->getId()}</td>
                    <td><a href="/admin/redirect/edit/{$redirect->getRoute()->getId()}">{$redirect->getRoute()->getPath()}</a>  </td>
                    <td>{$redirect->getTarget()}</td>
                    <td style="width: 50px;">{$redirect->getStatus()}</td>
                </tr>
                {/foreach}
            </tbody>
        </table>
        <div class="table-foot">
            <p>Показано с {(($items->getCurrent()-1)*$items->getCount())+1} по {(($items->getCurrent()-1)*$items->getCount())+1+count($items)-1} из {$items->getTotal()} перенаправлений</p>
             {$items->getPagination()->addClass('pagination')}
        </div>
    </div>
</div>