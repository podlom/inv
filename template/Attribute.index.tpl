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
		<a href="{$controller->getUrlGenerator()->generate('add')}" class="button green">Создать</a>
	</div>
	<div class="breadcrumbs">
		<h3>Атрибуты</h3>
		<div>
			<a href="/admin">Главная</a> <span>></span> Атрибуты
		</div>
	</div>
	<div class="table">
		<table>
			<thead>
				<tr>
					<td>ID</td>
					<td>Название</td>
					<td>Тип</td>
					<td>Комментарий</td>
				</tr>
			</thead>
			<tbody>
				{foreach $attributes as $attr}
				<tr>
					<td>{$attr->getId()}</td>
					<td><a href="{$controller->getUrlGenerator()->generate('edit', ['id'=>$attr->getId()])}">{$attr->getName()|default:'[ empty ]'}</a></td>
					<td>{$attr->getDisplayName()}</td>
					<td>{$attr->getComment()}</td>
				</tr>
				{/foreach}
			</tbody>
		</table>
		<div class="table-foot">
			<p>Показано с {(($attributes->getCurrent()-1)*$attributes->getCount())+1} по {(($attributes->getCurrent()-1)*$attributes->getCount())+1+count($attributes)-1} из {$attributes->getTotal()} атрибутов</p>
			{$attributes->getPagination()->addClass('pagination')}
		</div>
	</div>
</div>