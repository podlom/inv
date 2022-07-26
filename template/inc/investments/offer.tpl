
{if $lang == 'en'}
	{if $post->hasAttr(16)}
    {$t = $post->printAttr(16)->getChilds()}
    {if $t.0}<li><b>Sector:</b> {$t.0->getChilds()|array_pop}</li>{/if}
    {if $t.1}<li><b>Business activity:</b> {$t.1->getChilds()|array_pop}</li>{/if}
	{/if}
	{if $post->hasAttr(28) != 0}<li><b>Investment scheme:</b> {$post->printAttr(28)}</li>{/if}
	{if $post->hasAttr(29) != 0}<li><b>Investor profile:</b> {$post->printAttr(29)}</li>{/if}
	{if $post->getAttr(30) != 0}<li><b>Minimum amount:</b> ${$post->getAttr(30)|number_format:0:'.':' '}</li>{/if}
	{if $post->getAttr(31) != 0}<li><b>Maximum amount:</b> ${$post->getAttr(31)|number_format:0:'.':' '}</li>{/if}
{elseif $lang == 'uk'}
	{if $post->hasAttr(16)}
    {$t = $post->printAttr(16)->getChilds()}
    {if $t.0}<li><b>Галузь:</b> {$t.0->getChilds()|array_pop}</li>{/if}
    {if $t.1}<li><b>Вид деятельности:</b> {$t.1->getChilds()|array_pop}</li>{/if}
	{/if}
	{if $post->hasAttr(28) != 0}<li><b>Форма инвестирования:</b> {$post->printAttr(28)}</li>{/if}
	{if $post->hasAttr(29) != 0}<li><b>Тип инвестора:</b> {$post->printAttr(29)}</li>{/if}
	{if $post->getAttr(30) != 0}<li><b>Минимальная сумма инвестиций:</b> ${$post->getAttr(30)|number_format:0:'.':' '}</li>{/if}
	{if $post->getAttr(31) != 0}<li><b>Максимальная сумма инвестиций:</b> ${$post->getAttr(31)|number_format:0:'.':' '}</li>{/if}
{else}
	{if $post->hasAttr(16)}
    {$t = $post->printAttr(16)->getChilds()}
    {if $t.0}<li><b>Отрасль:</b> {$t.0->getChilds()|array_pop}</li>{/if}
    {if $t.1}<li><b>Вид деятельности:</b> {$t.1->getChilds()|array_pop}</li>{/if}
	{/if}
	{if $post->hasAttr(28) != 0}<li><b>Форма инвестирования:</b> {$post->printAttr(28)}</li>{/if}
	{if $post->hasAttr(29) != 0}<li><b>Тип инвестора:</b> {$post->printAttr(29)}</li>{/if}
	{if $post->getAttr(30) != 0}<li><b>Минимальная сумма инвестиций:</b> ${$post->getAttr(30)|number_format:0:'.':' '}</li>{/if}
	{if $post->getAttr(31) != 0}<li><b>Максимальная сумма инвестиций:</b> ${$post->getAttr(31)|number_format:0:'.':' '}</li>{/if}
{/if}