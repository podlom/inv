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
                <p>Доска обьявлений</p>
                <i class="fa fa-list-alt"></i>
            </div>
            <div>
                <a href="/admin/blog/14976">Больше информации <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
    </div>
<div class="breadcrumbs">
    <h3>Почта</h3>
    <div>
        <a href="/admin"><i class="fa fa-home"></i>Главная</a> <span>></span> Почта
    </div>
</div>
<div class="table">
                <table>
                    <thead>
                        <tr>
                            <td style="width: auto;">Email</td>
                            <td style="display: none;">Статус</td>
                            {foreach $fields as $name=>$label}
                                <td>
                                   {$label}
                                </td>
                            {/foreach}
                            <td>Дата</td>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach $items as $subsriber}
                            <tr>
                                <td>
                                    <a href="#" disabled>{$subsriber->getEmail()|escape}</a>
                                    {try}
                                    <a href="{$controller->purl('remove', ['id'=>rawurlencode($subsriber->getEmail())])}"><i class="fa fa-close"></i></a>
                                    {catch type="DOMException"}
                                    DOM Exception!
                                    {catch}
                                    <a href="#"><i class="fa fa-close"></i></a>
                                    {/try}
                                </td>
                                <td style="display: none;">{if $subsriber->getStatus()}<b>Подписан</b>{else}<b>Отписался</b>{/if}</td>
                                {foreach $fields as $name=>$label}
                                    {$value = $subsriber->getData($name)}
                                    <td>
                                    {if is_array($value)}
                                        {implode(', ', $value)}
                                    {else}
                                        {$value}
                                    {/if}
                                    </td>
                                {/foreach}
                                <td>{$subsriber->getCreated()->format('Y.m.d H:i')}</td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
    <div class="table-foot">
        <p>Показано с {(($items->getCurrent()-1)*$items->getCount())+1} по {(($items->getCurrent()-1)*$items->getCount())+1+count($items)-1} из {$items->getTotal()} подписчиков</p>
        {$items->getPagination()->addClass('pagination')}
    </div>
</div>
</div>
