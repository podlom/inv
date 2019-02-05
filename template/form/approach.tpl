{$form->open()}
	{if $lang=='en'}
		<div>{$form->getField('name')->getInput()->setAttr('placeholder', 'Name')}</div>
		<div>{$form->getField('email')->getInput()->setAttr('type','email')}</div>
		<div>{$form->getField('tel')->getInput()->setAttr('placeholder', 'Tel')}</div>
		<div>{$form->getField('text')->getInput()->setAttr('placeholder', 'Short description of the investment offer (up to 200 characters)')}</div>
    	<div class='grid-x'><input class="blue_but cell-but small-12" type="submit" name="" value="Send"></div>
	    <div><button type='button' class="blue_but cell-but close__popup">Close</button></div>

    {else}
	    <div>{$form->getField('name')->getInput()}</div>
	    <div>{$form->getField('email')->getInput()->setAttr('type','email')}</div>
	    <div>{$form->getField('tel')->getInput()}</div>
	    <div>{$form->getField('text')->getInput()}</div>
	    <div class='grid-x'><input class="blue_but cell-but small-12" type="submit" name="" value="Отправить"></div>
	    <div class='grid-x'><button type='button' class="blue_but cell-but  small-12 close__popup">Закрыть</button></div>
    {/if}
    {$form->protection()}
{$form->close()}