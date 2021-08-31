
{if $lang == 'en'}
	{if $post->hasAttr(16)}
    {$t = $post->printAttr(16)->getChilds()}
    {if $t.0}<li><b>Sector:</b> {$t.0->getChilds()|array_pop}</li>{/if}
    {if $t.1}<li><b>Business activity:</b> {$t.1->getChilds()|array_pop}</li>{/if}
	{/if}
	{if $post->getAttr(15)}<li><b>Price:</b> ${$post->getAttr(15)|number_format:0:'.':' '}</li>{/if}
	{if $post->getAttr(17)}<li><b>Share:</b> {$post->getAttr(17)}%</li>{/if}
	{if $post->getAttr(18)}<li><b>Life period of business (years):</b> {$post->getAttr(18)}</li>{/if}
	{if $post->getAttr(19)}<li><b>Number of employees:</b> {$post->getAttr(19)}</li>{/if}
	{if $post->getAttr(20)}<li><b>Payback period (years):</b> {$post->getAttr(20)}</li>{/if}
	{if $post->getAttr(21)}<li><b>Turnover:</b> {$post->getAttr(21)|number_format:0:'.':' '} USD</li>{/if}
	{if $post->getAttr(22)}<li><b>EBITDA:</b> {$post->getAttr(22)|number_format:0:'.':' '} USD</li>{/if}
	{if $post->getAttr(23)}<li><b>Net Profit:</b> {$post->getAttr(23)|number_format:0:'.':' '} USD</li>{/if}
{else}
	{if $post->hasAttr(16)}
    {$t = $post->printAttr(16)->getChilds()}
    {if $t.0}<li><b>Отрасль:</b> {$t.0->getChilds()|array_pop}</li>{/if}
    {if $t.1}<li><b>Вид деятельности:</b> {$t.1->getChilds()|array_pop}</li>{/if}
	{/if}
	{if $post->getAttr(15)}<li><b>Цена:</b> ${$post->getAttr(15)|number_format:0:'.':' '}</li>{/if}
	{if $post->getAttr(17)}<li><b>Продажа доли бизнеса:</b> {$post->getAttr(17)}%</li>{/if}
	{if $post->getAttr(18)}<li><b>Срок существования:</b> {$post->getAttr(18)}</li>{/if}
	{if $post->getAttr(19)}<li><b>Количество сотрудников:</b> {$post->getAttr(19)}</li>{/if}
	{if $post->getAttr(20)}<li><b>Окупаемость бизнеса, лет:</b> {$post->getAttr(20)}</li>{/if}
	{if $post->getAttr(21)}<li><b>Оборот, за последний год:</b> {$post->getAttr(21)|number_format:0:'.':' '} USD</li>{/if}
	{if $post->getAttr(22)}<li><b>EBITDA, за последний год:</b> {$post->getAttr(22)|number_format:0:'.':' '} USD</li>{/if}
	{if $post->getAttr(23)}<li><b>Чистая прибыль, за последний год:</b> {$post->getAttr(23)|number_format:0:'.':' '} USD</li>{/if}
{/if}