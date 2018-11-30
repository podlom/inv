<form>
	<h1>Подтверждение регистрации</h1>
	{if isset($error)}<h3>{$error}</h3>{/if}
	<label>Email:
		<input type="email" name="email" value="{$email}" />
	</label>
	<label>Код подтверждения:
		<input type="text" name="code" value="{$request->attributes->get('code')}" />
	</label>
	<input type="submit" class="button"/>
	<div><a href="{$controller->url('resend_confirm')}">не пришло письмо?</a></div>
</form>