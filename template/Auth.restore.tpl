<div class="user_login login-form flex items-center flex-col justify-center">
{$form->open()}
<div class="user_login__wrapper login-form__wrapper">
  <h1 class="text-xl mb-4">Восстановление пароля</h1>
  {foreach $form->getFields() as $field}
    <div class="large-12 w-full mb-2">
        <label class="flex flex-col font-semibold text-sm">E-mail
    	   {$field->getInput()->addClass('subscription__input ')}
        </label>
      </div>
  {/foreach}
  <div class="mt-4">
  {$form->getSubmit()->addClass('w-full btn btn--blue btn--normal')}
  </div>
</div>
{$form->close()}

</div>