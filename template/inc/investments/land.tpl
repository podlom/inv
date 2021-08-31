
{if $lang == 'en'}
	{if $post->hasAttr(24) != 0}<li><b>Land purpose:</b> {$post->printAttr(24)}</li>{/if}
	{if $post->getAttr(25) != 0}<li><b>Land area:</b> {$post->getAttr(25)} ha</li>{/if}
	{if $post->getAttr(15) != 0}<li><b>Price:</b> ${$post->getAttr(15)|number_format:0:'.':' '}</li>{/if}
	{if $post->hasAttr(26)}<li><b>Utility systems:</b> {$post->getAttr(26)}</li>{/if}
	{if $post->getAttr(27)}<li><b>Form of ownership:</b> {$post->printAttr(27)}</li>{/if}
{else}
	{if $post->hasAttr(24) != 0}<li><b>Целевое назначение:</b> {$post->printAttr(24)}</li>{/if}
	{if $post->getAttr(25) != 0}<li><b>Площадь:</b> {$post->getAttr(25)} га</li>{/if}
	{if $post->getAttr(15) != 0}<li><b>Стоимость продажи:</b> ${$post->getAttr(15)|number_format:0:'.':' '}</li>{/if}
	{if $post->hasAttr(26)}<li><b>Коммуникации:</b> {$post->getAttr(26)}</li>{/if}
	{if $post->getAttr(27)}<li><b>Форма собственности:</b> {$post->printAttr(27)}</li>{/if}
{/if}