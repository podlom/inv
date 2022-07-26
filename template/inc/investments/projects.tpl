

{if $lang == 'en'}
	{if $post->hasAttr(16)}
    {$t = $post->printAttr(16)->getChilds()}
    {if $t.0}<li><b>Sector:</b> {$t.0->getChilds()|array_pop}</li>{/if}
    {if $t.1}<li><b>Business activity:</b> {$t.1->getChilds()|array_pop}</li>{/if}
	{/if}
	{if $post->hasAttr(32) != ''}<li><b>Stage:</b> {$post->printAttr(32)}</li>{/if}
	{if $post->getAttr(15) != 0}<li><b>Project cost:</b> ${$post->getAttr(15)|number_format:0:'.':' '}</li>{/if}
	{if $post->getAttr(34) != 0}<li><b>Required investments:</b> ${$post->getAttr(34)|number_format:0:'.':' '}</li>{/if}
	{if $post->hasAttr(33) != ''}<li><b>Type of investment:</b> {$post->printAttr(33)}</li>{/if}
	{if $post->getAttr(35) != 0}<li><b>Share in capital:</b> {$post->getAttr(35)}%</li>{/if}
	{if $post->getAttr(36) != 0}<li><b>Return on investment, years:</b> {$post->getAttr(36)}</li>{/if}
	{if $post->getAttr(37) != 0}<li><b>IRR:</b> {$post->getAttr(37)}%</span></li>{/if}
	{if $post->getAttr(38) != 0}<li><b>NPV:</b> ${$post->getAttr(38)|number_format:0:'.':' '}</li>{/if}
{elseif $lang == 'uk'}
	{if $post->hasAttr(16)}
    {$t = $post->printAttr(16)->getChilds()}
    {if $t.0}<li><b>Галузь:</b> {$t.0->getChilds()|array_pop}</li>{/if}
    {if $t.1}<li><b>Вид деятельности:</b> {$t.1->getChilds()|array_pop}</li>{/if}
	{/if}
	{if $post->getAttr(32) != ''}<li><b>Стадия проекта:</b> {$post->printAttr(32)}</li>{/if}
	{if $post->getAttr(15) != 0}<li><b>Стоимость проекта:</b> ${$post->getAttr(15)|number_format:0:'.':' '}</li>{/if}
	{if $post->getAttr(34) != 0}<li><b>Требуемые инвестиции:</b> ${$post->getAttr(34)|number_format:0:'.':' '}</li>{/if}
	{if $post->getAttr(33) != ''}<li><b>Тип инвестиций:</b> {$post->printAttr(33)}</li>{/if}
	{if $post->getAttr(35) != 0}<li><b>Предложение инвестору:</b> {$post->getAttr(35)}%</li>{/if}
	{if $post->getAttr(36) != 0}<li><b>Окупаемость инвестиций, лет:</b> {$post->getAttr(36)}</li>{/if}
	{if $post->getAttr(37) != 0}<li><b>IRR:</b> {$post->getAttr(37)}%</span></li>{/if}
	{if $post->getAttr(38) != 0}<li><b>NPV:</b> ${$post->getAttr(38)|number_format:0:'.':' '}</li>{/if}
{else}
	{if $post->hasAttr(16)}
    {$t = $post->printAttr(16)->getChilds()}
    {if $t.0}<li><b>Отрасль:</b> {$t.0->getChilds()|array_pop}</li>{/if}
    {if $t.1}<li><b>Вид деятельности:</b> {$t.1->getChilds()|array_pop}</li>{/if}
	{/if}
	{if $post->getAttr(32) != ''}<li><b>Стадия проекта:</b> {$post->printAttr(32)}</li>{/if}
	{if $post->getAttr(15) != 0}<li><b>Стоимость проекта:</b> ${$post->getAttr(15)|number_format:0:'.':' '}</li>{/if}
	{if $post->getAttr(34) != 0}<li><b>Требуемые инвестиции:</b> ${$post->getAttr(34)|number_format:0:'.':' '}</li>{/if}
	{if $post->getAttr(33) != ''}<li><b>Тип инвестиций:</b> {$post->printAttr(33)}</li>{/if}
	{if $post->getAttr(35) != 0}<li><b>Предложение инвестору:</b> {$post->getAttr(35)}%</li>{/if}
	{if $post->getAttr(36) != 0}<li><b>Окупаемость инвестиций, лет:</b> {$post->getAttr(36)}</li>{/if}
	{if $post->getAttr(37) != 0}<li><b>IRR:</b> {$post->getAttr(37)}%</span></li>{/if}
	{if $post->getAttr(38) != 0}<li><b>NPV:</b> ${$post->getAttr(38)|number_format:0:'.':' '}</li>{/if}
{/if}