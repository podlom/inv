<div class="bwrap">
	<nav class="navbar row mb-2">
		<h1 class="h4">
			{$form->field('name')->getInput()->getValue()}
			<small class="text-muted">{$form->field('email')->getInput()->getValue()}</small>
		</h1>
	</nav>

	<div class="card shadow-sm">
		<div id="mailing" class="card-body">
			<form method="POST">
				<div class="form-group row">
					<label for="staticEmail" class="col-sm-2 col-form-label">Email</label>
					<div class="col-sm-10">
						{$form->field('email')->getInput()->addClass('form-control')->setId('staticEmail')}
					</div>
				</div>
				<div class="form-group row">
					<label for="staticName" class="col-sm-2 col-form-label">Имя</label>
					<div class="col-sm-10">
						{$form->field('name')->getInput()->addClass('form-control')->setId('staticName')}
					</div>
				</div>

				<input type="hidden" name="backUrl" value="{$smarty.get.backUrl}">

				<div class="form-group mb-0 text-right">
					<button class="btn btn-main" type="submit" type="button">Сохранить</button>
				</div>
			</form>
		</div>
		<div class="card-body">
			{if isset($smarty.post.backUrl) && !empty($smarty.post.backUrl)}
				<a href="{$smarty.post.backUrl}">Повернутись</a>
			{elseif isset($smarty.get.backUrl) && !empty($smarty.get.backUrl)}
				<a href="{$smarty.get.backUrl}">Повернутись</a>
			{/if}
		</div>
	</div>
</div>
