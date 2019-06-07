<div class="admin-pages">
	<div class="buttons" style="margin-bottom: 30px;">
		<a class="blue button" href="{$controller->url('slot_select', ['id'=>$entity->getId()])}">Разместить</a>
	</div>
    <div class="edit">
    	{$form->open()}
        <div class="flex-form">
        	<div>
        	<div>
        		{foreach $form->toHtml()->getChilds() as $ch}
        			{if $ch@last}{else}{$ch->toHtml()}{/if}
        		{/foreach}
        	</div>
        	{$form->getSubmit()->addClass('button green')->setAttr('value', "Сохранить")}
        	</div>
        </div>
        {$form->close()}
	</div>
</div>