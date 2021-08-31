<div class="bwrap">
<nav class="navbar row mb-2">
    <h1 class="h4"><a href="/admin/mail/mailing">Рассылки</a> 
    	<small class="text-muted">/ список серверов</small>
    </h1>

    <a href="/admin/mail/mailing/server/add" class="btn btn-main" style="display:inline"><i class="fa fa-plus" aria-hidden="true"></i> Добавить</a>
</nav>

<div class="card shadow-sm">
	<div class="table-responsive table-responsive-lg">
        <table style="min-width: 800px" class="table table-borderless table-list konkurs-list">
            <thead>
                 <tr class="">
                    <th scope="col" ><b>Название</b></th>
                    <th scope="col" class="list-date"><b>Email</b></th>
                    <th scope="col" class="list-date"><b>Хост</b></th>
                    <th scope="col" class="list-controls text-right"><b>Управление</b></th>
                </tr>
            </thead>
            <tbody>
                {foreach $items as $item}
                <tr>
                    <td scope="row">
                    	<a class="btn-link" href="{$controller->url('mailserver.edit', ['id'=>$item->getId()])}">{$item->getName()}</a>
                    </td>
                    <td>{$item->getEmail()}</td>
                    <td>{$item->getHost()}</td>
                    <td class="list-controls text-right">
                        <div class="btn-group btn-group-sm ">
                            <a data-toggle="tooltip" data-placement="top" title="Редактировать"
                            class="btn btn-link" href="{$controller->url('mailserver.edit', ['id'=>$item->getId()])}"><i class="fa fa-pencil" aria-hidden="true"></i></a>
                        </div>
                        <div class="btn-group dropleft">
                            <div class="dropdown dropleft">
                                <a class="btn" href="#" role="button" id="ddcMenu{$key}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-ellipsis-v" aria-hidden="true"></i></a>
                                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="ddcMenu{$key}">
                                    <a class="dropdown-item" href="{$controller->url('mailserver.edit', ['id'=>$item->getId()])}"><i class="fa fa-pencil" aria-hidden="true"></i> Редактировать</a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item color-red" href="{$controller->url('mailserver.remove', ['id'=>$item->getId()])}"><i class="fa fa-trash" aria-hidden="true"></i> Удалить</a>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                {/foreach}
            </tbody>
        </table>
    </div>
</div>

{block name="pagination"}
<div class="container my-2">
    <div class="row justify-content-center">
        <div class="pagination d-inline-flex py-2">
            {$items->getPagination()}
        </div>
    </div>
</div>
{/block}
</div>