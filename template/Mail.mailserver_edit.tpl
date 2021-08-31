<div class="bwrap">
<nav class="navbar row mb-2">
    <h1 class="h4">
    	<a href="/admin/mail/mailing">Рассылки</a>
    	<small class="text-muted"> / <a href="/admin/mail/mailing/server">список серверов</a></small>
        {if ($entity->getName())}<small class="text-muted"> / {$entity->getName()}{/if}
        </small>
    </h1>
</nav>

<div class="card shadow-sm">
	<div class="card-body">
		{$form->open()}
			<div class="form-group row">
				<label for="staticName" class="col-sm-2 col-form-label">Имя</label>
				<div class="col-sm-10">
					{$form->getInput('name')->addClass('form-control')->setId('staticName')->setAttr('required', true)}
				</div>
			</div>
			<div class="form-group row">
				<label for="staticEmail" class="col-sm-2 col-form-label">Email</label>
				<div class="col-sm-10">
					{$form->getInput('email')->addClass('form-control')->setId('staticEmail')->setAttr('required', true)}
				</div>
			</div>
			<div class="form-group row">
				<label for="staticHost" class="col-sm-2 col-form-label">Хост</label>
				<div class="col-sm-10">
					{$form->getInput('host')->addClass('form-control')->setId('staticHost')->setAttr('required', true)}
				</div>
			</div>
			<div class="form-group row">
				<label for="inputPassword" class="col-sm-2 col-form-label">Пароль</label>
				<div class="col-sm-10">
					{$form->getInput('password')->addClass('form-control')->setId('inputPassword')}
				</div>
			</div>
			<div class="form-group row">
				<label for="staticPort" class="col-sm-2 col-form-label">Порт</label>
				<div class="col-sm-10">
					{$form->getInput('port')->addClass('form-control')->setId('staticPort')}
				</div>
			</div>
			<div class="form-group row">
				<label for="staticEncription" class="col-sm-2 col-form-label">Шифрование</label>
				<div class="col-sm-10">
					{$form->getInput('encription')->addClass('form-control')->setId('staticEncription')}
				</div>
			</div>
			<div class="form-group mb-0 text-right">
				<button type="submit" class="btn btn-main"><i class="fa fa-floppy-o" aria-hidden="true"></i> Сохранить</button>
			</div>
		{$form->close()}
	</div>
</div>
</div>