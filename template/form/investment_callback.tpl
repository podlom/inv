{$form->setId('inv_cb')->open()}
{foreach $form->getErrors() as $e}
<div class="alert callout">
{$e.1}
</div>
{/foreach}
<div class="grid-x grid-margin-x">
	<div class="cell small-6">{$form->getField('firstname')->getInput()}</div>
	<div class="cell small-6">{$form->getField('lastname')->getInput()}</div>
	<div class="cell small-6">{$form->getField('email')->getInput()}</div>
	<div class="cell small-6">{$form->getField('tel')->getInput()->setAttr('id', 'phone')}
	<span id="valid-msg" class="hide">✓ Valid</span>
    <span id="error-msg" class="hide"></span>
    <script>
    var input = document.querySelector("#phone");
    window.intlTelInput(input, {
    dropdownContainer: document.body,
    utilsScript: "/js/utils.js",
    });
    </script>
	</div>
	<div class="cell small-6">{$form->getSubmit()->addClass('button alert expanded')->setAttr('value', 'Отправить')}</div>
</div>
{$form->getField('url')->getInput()->setValue(full_link($request->getPathInfo()))}

<input type="hidden" name="sf_investment_callback[url]" value="">
<input type="hidden" name="sf_investment_callback[ga_utm]" value="">

{$form->protection()}
{$form->close()}