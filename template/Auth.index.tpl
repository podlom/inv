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
				<td><a href="{$controller->url('edit', ['id'=>$user->getId()])}">{$user->getName()}</a>

					<a data-toggle="tooltip" data-placement="top" title="Удалить пользователя" class="btn btn-link" data-href="/admin/user/remove/{$user->getId()}"
					   onclick="removeUserConfirm(this);" data-original-title="Удалить пользователя"><i class="fa fa-remove" aria-hidden="true"></i></a>
				</td>
				<td>{$user->getEmail()}</td>
			</tr>
			{/foreach}
		</table>

		<script>
			function removeUserConfirm(e) {
				if (confirm('Вы действительно хотите удалить пользователя?')) {
					window.location.href = e.dataset.href;
				}
			}
		</script>

		<div class="table-foot">
	        <p>Показано с {(($items->getCurrent()-1)*$items->getCount())+1} по {(($items->getCurrent()-1)*$items->getCount())+1+count($items)-1} из {$items->getTotal()} страниц</p>
	        {$items->getPagination()->addClass('pagination')}
	    </div>
	</div>
</div>

{script_code require=["jquery"] name="indexauth"}

console.log('+35 Script loaded');

{literal}

	function checkManagerStatus()
	{
		console.log('+41 checkManagerStatus() ');
		$.post(
			'/auth-attr-data.php',
			{'action':'check_if_superadmin'},
			function(r0){
				console.log('+46 got result: ' + r0);
				if (r0 == 0) {
					console.log('+48 not super admin.');
					window.location.href = '/admin';
				} else {
					console.log('+50 you are super admin.');
				}
			}
		);
	}
	$(document).ready(function(){ checkManagerStatus(); });

{/literal}

{/script_code}