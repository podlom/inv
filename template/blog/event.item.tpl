{extends 'Blog.post'}
{block 'main' prepend}
<div style="position: relative;">
    <div class="box-shadow3"></div>
    <div class="event_time">
        <ul>
            <li><b>Организатор</b>: <span itemprop="organizer">{$post->getAttr(9)}</span></li>
            <li><b>Начало</b>: <span itemprop="startDate" content="{$post->getAttr(7)->format('Y-m-d,H:i')}">{$post->getAttr(7)->format('d.m.Y, H:i')}</span></li>
            <li><b>Окончание</b>: <span itemprop="endtDate" content="{$post->getAttr(8)->format('Y-m-d')}">{$post->getAttr(8)->format('d.m.Y, H:i')}</span></li>
            <li itemprop="location"><b>Локация</b>: <span>{$post->getAttr(11)}</span></li>
        {if ($post->getAttr(10))}
            <li><b>Адрес</b>: <span itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">{$post->printAttr(10)}</span></li>
        {/if}
        {if ($post->getAttr(6))}
            <li><b>Сайт</b>: <a href="{$post->getAttr(6)}" target="_blank" itemprop="url">{$post->getAttr(6)}</a></li>
        {/if}
        </ul>
    </div>
</div>
{/block}