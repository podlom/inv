<header>
	<div class="breadcrumbs"> <span>Tinyurl</span> </div>
	<div class="actions">
		<a class="button" href="{$controller->purl('add')}">Add</a>
	</div>
</header>
<article class="content-wrapp">
	<table class="list"><tbody>
		<tr>
			<th>target URL</th>
			<th>action</th>
			<th>clicks</th>
			<th>short url</th>
		</tr>
		{foreach $items as $item}
			{$url = $module->id_to_url($item->getId())}
			<tr class="item">
				<td><a href="{$controller->purl('edit', ['id'=>$item->getId()])}">{$item->getUrl()}</a></td>
				<td><span>{$item->getAction()}</span></td>
				<td>{$item->getClicks()}</td>
				<td><a href="{$url}">{$url}</a></td>
			</div>
		{/foreach}
	</tbody></table>
</article>