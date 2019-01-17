<div class="admin-pages">
    <div class="edit">
    	{$form->open()}
        <div class="flex-form">
        	<div>
        	<div>
        		<h1>Change password</h1>
                <h3>
                    {$user->getName()}
                    <span class="subheader">{$user->getEmail()}</span>
                </h3>
                {if $response->result == 'ok'}
                    <h5 class="success">password changed!</h5>
                {/if}
                {$form->getField('password')}
        	</div>
        	{$form->getSubmit()->addClass('button green')->setAttr('value', "Сохранить")}
        	</div>
        </div>
        {$form->close()}
	</div>
</div>