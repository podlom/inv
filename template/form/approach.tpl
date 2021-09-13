{$form->open()}
	{if $lang=='en'}
		<div>{$form->getField('firstname')->getInput()->setAttr('placeholder', 'Firstname')}</div>
		<div>{$form->getField('lastname')->getInput()->setAttr('placeholder', 'Lastname')}</div>
		<div>{$form->getField('email')->getInput()->setAttr('type','email')}</div>
		{* <div>{ $form->getField('tel')->getInput()->setAttr('data-plugin-inputmask', 'inputmask_5de8d519')->setAttr('id','tel1id') }</div> *}
		{literal}
		<div class="input-aproach">
        <input type="tel" id="phone" name="sf_approach[tel]" required>
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
        {/literal}
		<div>
			<h3>What is your request related to</h3>
			{$form->getField('querytype')->getInput()}
		</div>
		<div>{$form->getField('price')->getInput()->setAttr('placeholder', 'Required investment / Price')}</div>
		<div>{$form->getField('region')->getInput()->setAttr('placeholder', 'Region')}</div>
		<div>{$form->getField('text')->getInput()->setAttr('placeholder', 'Short description of the investment offer (up to 200 characters)')}</div>
    	<div class='grid-x'><input class="blue_but cell-but small-12" type="submit" name="" value="Send"></div>
	    <div><button type='button' class="blue_but cell-but close__popup">Close</button></div>

    {else}
	    <div>{$form->getField('firstname')->getInput()}</div>
	    <div>{$form->getField('lastname')->getInput()}</div>
	    <div>{$form->getField('email')->getInput()->setAttr('type','email')}</div>
	    {* <div>  $form->getField('tel')->getInput()->setAttr('data-plugin-inputmask', 'inputmask_5de8d519')->setAttr('id','tel1id')  </div> *}
	{literal}
		<div class="input-aproach">
        <input type="tel" id="phone" name="sf_approach[tel]" required>
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
    {/literal}
		<div>
			<h3>{$form->getField('querytype')->getLabel()}</h3>
			{$form->getField('querytype')->getInput()}
		</div>
		<div>{$form->getField('price')->getInput()->setAttr('placeholder', 'Требуемые инвестиции / Цена $')}</div>
		<div>{$form->getField('region')->getInput()->setAttr('placeholder', 'Регион')}</div>
	    <div>{$form->getField('text')->getInput()}</div>
	    <div class='grid-x'><input class="blue_but cell-but small-12" type="submit" name="" value="Отправить"></div>
	    <div class='grid-x'><button data-remodal-action="close" type='button' class="blue_but cell-but  small-12 close__popup">Закрыть</button></div>
    {/if}

	<input type="hidden" name="sf_approach[latel_deal_name]" id="dealName" value="">
	<input type="hidden" name="sf_approach[ga_utm]" value="">

    {$form->protection()}
{$form->close()}