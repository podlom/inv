<div class="admin-pages">
    <div class="buttons">
        <a href="{$controller->url('password', ['user_id'=>$entity->getId()])}" class="button green">Смена пароля</a>
    </div>
    <div class="edit">
    	{$form->toHtml()->addClass('row')->open()}
        <div class="flex-form">
        	<div>
        	<div>
        		{foreach $form->toHtml()->getChilds() as $ch}
        			{if $ch@last}{else}{$ch}{/if}
        		{/foreach}
        	</div>
        	{$form->getSubmit()->addClass('button green')->setAttr('value', "Сохранить")}
        	</div>
        </div>
        {$form->close()}
	</div>
</div>