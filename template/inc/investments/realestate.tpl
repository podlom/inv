{if $lang == 'en'}
	{if $post->getAttr(39) != 0}<li><b>Type of property:</b> <span>{$post->printAttr(39)}</span></li>{/if}
	{if $post->getAttr(41) != 0}<li><b>Total area:</b> {$post->getAttr(41)} sq.m.</li>{/if}
	{if $post->getAttr(15) != 0}<li><b>Price:</b> ${$post->getAttr(15)|number_format:0:'.':' '}</li>{/if}
	{if $post->getAttr(42) != 0}<li><b>Total land area:</b> {$post->getAttr(42)} ha</li>{/if}
	{if $post->getAttr(43) != 0}<li><b>Turnover:</b> ${$post->getAttr(43)|number_format:0:'.':' '}</li>{/if}
	{if $post->getAttr(40) != 0}<li><b>Form of ownership:</b> {$post->getAttr(40)}</li>{/if}
{elseif $lang == 'uk'}
	{if $post->getAttr(39) != 0}<li><b>Тип недвижимости:</b> <span>{$post->printAttr(39)}</span></li>{/if}
	{if $post->getAttr(41) != 0}<li><b>Общая площадь недвижимости:</b> {$post->getAttr(41)} кв.м.</li>{/if}
	{if $post->getAttr(15) != 0}<li><b>Цена:</b> ${$post->getAttr(15)|number_format:0:'.':' '}</li>{/if}
	{if $post->getAttr(42) != 0}<li><b>Площадь земельного участка:</b> {$post->getAttr(42)} га</li>{/if}
	{if $post->getAttr(43) != 0}<li><b>Валовый доход недвижимости за последний год:</b> ${$post->getAttr(43)|number_format:0:'.':' '}</li>{/if}
	{if $post->getAttr(40) != 0}<li><b>Форма собственности земельного участка:</b> {$post->getAttr(40)}</li>{/if}
{else}
	{if $post->getAttr(39) != 0}<li><b>Тип недвижимости:</b> <span>{$post->printAttr(39)}</span></li>{/if}
	{if $post->getAttr(41) != 0}<li><b>Общая площадь недвижимости:</b> {$post->getAttr(41)} кв.м.</li>{/if}
	{if $post->getAttr(15) != 0}<li><b>Цена:</b> ${$post->getAttr(15)|number_format:0:'.':' '}</li>{/if}
	{if $post->getAttr(42) != 0}<li><b>Площадь земельного участка:</b> {$post->getAttr(42)} га</li>{/if}
	{if $post->getAttr(43) != 0}<li><b>Валовый доход недвижимости за последний год:</b> ${$post->getAttr(43)|number_format:0:'.':' '}</li>{/if}
	{if $post->getAttr(40) != 0}<li><b>Форма собственности земельного участка:</b> {$post->getAttr(40)}</li>{/if}
{/if}