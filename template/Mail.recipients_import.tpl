<h1>Import</h1>
<h3>to {$mailing->getName()}</h3>
{if $success}
<div class="success">Imported {$done} recipients, {$invalid} invalid emails, {$skip} skiped.</div>
{else}
<div class="error">{$error}</div>
{/if}
{$error}
<form method="POST" enctype="multipart/form-data">
	<label><input type="checkbox" checked name="clear" /> Delete existing recipients</label>
	<br>
	<input type="hidden" name="MAX_FILE_SIZE" value="2000000" />
	<input type="file" name="file" />
	<input type="submit" />
</form>