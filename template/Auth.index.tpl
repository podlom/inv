<div class="admin-pages">
	<div class="buttons">
	    <a href="{$controller->url('add')}" class="green button">Создать</a>
	</div>
	<div class="breadcrumbs">
	    <h3>Страницы</h3>
	    <div>
	        <a href="/admin"><i class="fa fa-home"></i>Главная</a> <span>></span> Страницы
	    </div>
	</div>
	<div class="table">
		<table>
			<tr>
				<th>Id</th>
				<th>Name</th>
				<th>Email</th>
			</tr>
			{foreach $items as $user}
			<tr>
				<td>{$user->getId()}</td>
				<td><a href="{$controller->url('edit', ['id'=>$user->getId()])}">{$user->getName()}</a></td>
				<td>{$user->getEmail()}</td>
			</tr>
			{/foreach}
		</table>
		<div class="table-foot">
	        <p>Показано с {(($items->getCurrent()-1)*$items->getCount())+1} по {(($items->getCurrent()-1)*$items->getCount())+1+count($items)-1} из {$items->getTotal()} страниц</p>
	        {$items->getPagination()->addClass('pagination')}
	    </div>
	</div>
</div>