<div class="login_page clearfix">
    <div class="user_login login-form flex items-center flex-col justify-center">
        <!-- <div class="social_login">
            <div><a href="/user/login/facebook"><i class="fa fa-facebook-f"></i> Войти через Facebook</a></div>
            <div><a href="#" disabled><i class="fa fa-twitter"></i> Войти через Twitter</a></div>
            <div><a href="/user/login/google"><i class="fa fa-google-plus"></i> Войти через GMail</a></div>
        </div> -->
        <!-- <div class="or">
            <div></div>
            <div>ИЛИ</div>
            <div></div>
        </div> -->
        <div  class="user_login__wrapper login-form__wrapper">
            <h1 class="text-xl mb-4">Войдите в свой аккаунт</h1>
            {foreach $form->getErrors() as $e}
                <div class="panel callout radius alert">{$e.1}</div>
            {/foreach}
            {$s = $form->getSubmit()->setAttr('value', 'Войти')->addClass('blue_but')}
            {$form->open()}
            <div class="large-12 w-full mb-2">
                <label class="flex flex-col font-semibold text-sm">Логин
                    {$form->getField('login')->getInput()->setAttr('placeholder','email@gmaill.com')->addClass('subscription__input mt-1')}
                </label>
            </div>
            <div class="large-12 w-full mb-2">
                <label class="flex flex-col font-semibold text-sm">Пароль
                    {$form->getField('password')->getInput()->setAttr('placeholder','*********')->addClass('subscription__input mt-1')}
                </label>
            </div>
            <div class="mb-4 mt-4">
                <!-- <label><input type="checkbox" name=""> Запомнить меня</label> -->
                {$form->getSubmit()->setAttr('value', 'Войти')->addClass('w-full btn btn--blue btn--normal')}
            </div>
            {* <div class="user_login__facebook">
                <a class="login-form__link" href="/user/login/facebook"><i class="fa fa-facebook-f"></i> Войти через Facebook</a>
            </div> *}
            <footer class="user_login__secondary login-form__footer mt-2 pt-2">
                <a class="login-form__link " href="/user/register">Зарегистрироваться</a> 
                <a class="login-form__link " href="/user/restore">Забыли пароль?</a>
            </footer>
            {$form->close()}
        </div>
    </div>
</div>
