{$form->setId('inv_cb')->open()}
{foreach $form->getErrors() as $e}
<div class="alert callout">
{$e.1}
</div>
{/foreach}
<div class="grid-x grid-margin-x">
	<div class="cell small-6">{$form->getField('name')->getInput()}</div>
	<div class="cell small-6">{$form->getField('email')->getInput()}</div>
	<div class="cell small-6">{$form->getField('tel')->getInput()}</div>
	<div class="cell small-6">{$form->getSubmit()->addClass('button alert expanded')}</div>
</div>
{$form->getField('url')->getInput()->setValue(full_link($request->getPathInfo()))}
{$form->protection()}
{$form->close()}