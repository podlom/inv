<div class="loginPage">
    <div class="user_login login-form flex items-center flex-col justify-center">
    <!-- <div class="social_login">
        <div><a href="/user/login/facebook"><i class="fa fa-facebook-f"></i> Войти через Facebook</a></div>
        <div><i class="fa fa-twitter"></i> Войти через Twitter</div>
        <div><a href="/user/login/google"><i class="fa fa-google-plus"></i> Войти через GMail</a></div>
    </div>
    <div class="or">
        <div></div>
        <div>ИЛИ</div>
        <div></div>
    </div> -->
    <div class="user_login__wrapper login-form__wrapper">
        <h1 class="text-xl mb-4">Регистрация пользователя</h1>
        {foreach $form->getErrors() as $e}
            <div class="panel callout radius alert">{$e.1}</div>
        {/foreach}
	{$s = $form->getSubmit()->setAttr('value', 'Регистрация')}
	{$form->open()}
    <div class="large-12 w-full mb-2">
        <label class="flex flex-col font-semibold text-sm">Имя
		  {$form->getField('name_name')->getInput()->setAttr('placeholder','')->addClass('subscription__input mt-1')}
        </label>
    </div>

	
    <div class="large-12 w-full mb-2">
        <label class="flex flex-col font-semibold text-sm">E-mail
    	   {$form->getField('email')->getInput()->setAttr('placeholder','email@gmail.comm')->addClass('subscription__input mt-1')}
        </label>
    </div>
	
    <div class="large-12 w-full mb-2">
        <label class="flex flex-col font-semibold text-sm">Пароль
    	   {$form->getField('password')->getInput()->setAttr('placeholder','*******')->addClass('subscription__input mt-1')}
        </label>
    </div>
	
    <div class="large-12 w-full mb-2">
        <label class="flex flex-col font-semibold text-sm">Подтвердите пароль
    	   {$form->getField('confirm')->getInput()->setAttr('placeholder','*******')->addClass('subscription__input mt-1')}
        </label>
    </div>
		<div class="mt-4">
			{$form->getSubmit()->setAttr('value', 'Регистрация')->addClass('w-full btn btn--blue btn--normal')}
		</div>
        {* <div class="user_login__facebook">
            <a href="/user/login/facebook"><i class="fa fa-facebook-f"></i> Войти через Facebook</a>
        </div> *}
        <div class="user_login__secondary text-center">
            <a class="login-form__link pt-2 pb-2 pl-2 pr-2 block mt-2" href="/user/login">Войти</a>
        </div>
	{$form->close()}
    </div>
</div>
</div>
