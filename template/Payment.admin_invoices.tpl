
{if $request->query->has('sort')}
    {if $request->query->get('order',0)}
        {$order = 'ASC'}
    {else}
        {$order = 'DESC'}
    {/if}
    {$invoices->orderBy(concat($request->query->get('sort'),' ',$order))}
{/if}

{$query = $request->query->all()}
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
<div class="breadcrumbs">
    <h3>Оплата обьявлений</h3>
    <div>
        <a href="/admin"><i class="fa fa-home"></i>Главная</a> <span>></span> Оплата обьявлений
    </div>
</div>
<div class="table">
                <table>
                    <thead>
                        <tr>
                            <td>ID <a href="{$invoices->getUrlGenerator()->generate($request->query->get('page',1),array_merge($query, ['sort'=>'id', 'order'=>0]))}" class="sort-button sort-button-up"><i class="fa fa-chevron-up"></i></a><a href="{$invoices->getUrlGenerator()->generate($request->query->get('page',1),array_merge($query, ['sort'=>'id', 'order'=>1]))}" class="sort-button sort-button-down"><i class="fa fa-chevron-down"></i></a></td>
                            <td>Описание</td>
                            <td>Статус <a href="{$invoices->getUrlGenerator()->generate($request->query->get('page',1),array_merge($query, ['sort'=>'status', 'order'=>0]))}" class="sort-button sort-button-up"><i class="fa fa-chevron-up"></i></a><a href="{$invoices->getUrlGenerator()->generate($request->query->get('page',1),array_merge($query, ['sort'=>'status', 'order'=>1]))}" class="sort-button sort-button-down"><i class="fa fa-chevron-down"></i></a></td>
                            <td>Сумма <a href="{$invoices->getUrlGenerator()->generate($request->query->get('page',1),array_merge($query, ['sort'=>'amount', 'order'=>0]))}" class="sort-button sort-button-up"><i class="fa fa-chevron-up"></i></a><a href="{$invoices->getUrlGenerator()->generate($request->query->get('page',1),array_merge($query, ['sort'=>'amount', 'order'=>1]))}" class="sort-button sort-button-down"><i class="fa fa-chevron-down"></i></a></td>
                            <td>Валюта <a href="{$invoices->getUrlGenerator()->generate($request->query->get('page',1),array_merge($query, ['sort'=>'currency', 'order'=>0]))}" class="sort-button sort-button-up"><i class="fa fa-chevron-up"></i></a><a href="{$invoices->getUrlGenerator()->generate($request->query->get('page',1),array_merge($query, ['sort'=>'currency', 'order'=>1]))}" class="sort-button sort-button-down"><i class="fa fa-chevron-down"></i></a></td>
                            <td>Дата создания <a href="{$invoices->getUrlGenerator()->generate($request->query->get('page',1),array_merge($query, ['sort'=>'created', 'order'=>0]))}" class="sort-button sort-button-up"><i class="fa fa-chevron-up"></i></a><a href="{$invoices->getUrlGenerator()->generate($request->query->get('page',1),array_merge($query, ['sort'=>'created', 'order'=>1]))}" class="sort-button sort-button-down"><i class="fa fa-chevron-down"></i></a></td>
                            <td>Дата изменения <a href="{$invoices->getUrlGenerator()->generate($request->query->get('page',1),array_merge($query, ['sort'=>'updated', 'order'=>0]))}" class="sort-button sort-button-up"><i class="fa fa-chevron-up"></i></a><a href="{$invoices->getUrlGenerator()->generate($request->query->get('page',1),array_merge($query, ['sort'=>'updated', 'order'=>1]))}" class="sort-button sort-button-down"><i class="fa fa-chevron-down"></i></a></td>
                        </tr>
                    </thead>
                    <tbody>
                    {foreach $invoices as $invoice}
                        <tr>
                            <td><a href="{$controller->getUrlGenerator()->generate('invoice', ['id'=>$invoice->getId()])}">{$invoice->getId()}</a></td>
                            <td><a href="{$controller->getUrlGenerator()->generate('invoice', ['id'=>$invoice->getId()])}">{$invoice->getDescription()}</a></td>
                            <td class="{if $invoice->getStatus==3}status-success{/if}{if $invoice->getStatus() > 4}status-error{/if}">{$invoice->getStatusName()}</td>
                            <td>{$invoice->getAmount()}</td>
                            <td>{$invoice->getCurrency()}</td>
                            <td>{$invoice->getCreated()}</td>
                            <td>{$invoice->getUpdated()}</td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
    <div class="table-foot">
        <p>Показано с {(($invoices->getCurrent()-1)*$invoices->getCount())+1} по {(($invoices->getCurrent()-1)*$invoices->getCount())+1+count($invoices)-1} из {$invoices->getTotal()} инвойсов</p>
        {$invoices->getPagination()->addClass('pagination')}
    </div>
</div>
</div>
