<div class="login_page clearfix">
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
                <h1>Войдите в свой аккаунт</h1>
                {foreach $form->getErrors() as $e}
                    <div class="panel callout radius alert">{$e.1}</div>
                {/foreach}
                {$s = $form->getSubmit()->setAttr('value', 'Войти')->addClass('blue_but')}
                {$form->open()}
                {$form->getField('login')->getInput()->setAttr('placeholder','Логин')}
                {$form->getField('password')->getInput()->setAttr('placeholder','Пароль')}
                <div>
                    <label><input type="checkbox" name=""> Запомнить меня</label>
                	{$form->getSubmit()->setAttr('value', 'Войти')->addClass('blue_but')}
                </div>
                <div>
                    <a href="/user/register">Зарегистрироваться</a> | <a href="">Забыли пароль?</a>
                </div>
                {$form->close()}
            </div>
    </div>
</div>
