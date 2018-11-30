{$form->open()}
<h3>Восстановлеение пароля</h3>
{foreach $form->getFields() as $field}
{$field}
{/foreach}
{$form->getSubmit()->addClass('button')}
{$form->close()}