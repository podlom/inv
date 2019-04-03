<div class="loginPage">
    <div class="user_login">
    <div class="social_login">
        <div><i class="fa fa-facebook-f"></i> Войти через Facebook</div>
        <div><i class="fa fa-twitter"></i> Войти через Twitter</div>
        <div><i class="fa fa-google-plus"></i> Войти через Google+</div>
    </div>
    <div class="or">
        <div></div>
        <div>ИЛИ</div>
        <div></div>
    </div>
    <div>
        <h1>Регистрация пользователя</h1>
        {foreach $form->getErrors() as $e}
            <div class="panel callout radius alert">{$e.1}</div>
        {/foreach}
	{$s = $form->getSubmit()->setAttr('value', 'Регистрация')}
	{$form->open()}
		{$form->getField('name_name')->getInput()->setAttr('placeholder','Имя')}
		{$form->getField('email')->getInput()->setAttr('placeholder','E-mail')}
		{$form->getField('password')->getInput()->setAttr('placeholder','Пароль')}
		{$form->getField('confirm')->getInput()->setAttr('placeholder','Подтвердите пароль')}
		<div>
			{$form->getSubmit()->setAttr('value', 'Регистрация')->addClass('blue_but')}
			<a href="/user/login">Войти</a>
		</div>
	{$form->close()}
    </div>
</div>
</div>
