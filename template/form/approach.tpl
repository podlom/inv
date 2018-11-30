{$form->open()}
	{if $lang=='en'}
		<div>{$form->getField('name')->getInput()->setAttr('placeholder', 'Name')}</div>
		<div>{$form->getField('email')->getInput()->setAttr('type','email')}</div>
		<div>{$form->getField('tel')->getInput()->setAttr('placeholder', 'Tel')}</div>
		<div>{$form->getField('text')->getInput()->setAttr('placeholder', 'Short description of the investment offer (up to 200 characters)')}</div>
    	<div><input type="submit" name="" value="Send"></div>
    {else}
	    <div>{$form->getField('name')->getInput()}</div>
	    <div>{$form->getField('email')->getInput()->setAttr('type','email')}</div>
	    <div>{$form->getField('tel')->getInput()}</div>
	    <div>{$form->getField('text')->getInput()}</div>
	    <div><input type="submit" name="" value="Отправить"></div>
    {/if}
    {$form->protection()}
{$form->close()}