{extends 'Blog.post'}
{block 'main' prepend}
<div style="position: relative;">
    <div class="box-shadow3"></div>
    <div class="event_time">
        <ul>
            <li itemprop="organizer"><b>Organizer</b>: {$post->getAttr(9)}</li>
            <li><b>Start</b>: <span itemprop="startDate" content="{$post->getAttr(7)->format('Y-m-d,H:i')}">{$post->getAttr(7)->format('d.m.Y, H:i')}</span></li>
            <li><b>Ending</b>: <span itemprop="endtDate" content="{$post->getAttr(8)->format('Y-m-d')}">{$post->getAttr(8)->format('d.m.Y, H:i')}</span></li>
            <li itemprop="location" ><b>Location</b>: <span>{$post->getAttr(11)}</span></li>
        {if ($post->getAttr(10))}
            <li><b>Address</b>: <span  itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">{$post->printAttr(10)}</span></li>
        {/if}
        {if ($post->getAttr(6))}
            <li><b>Website</b>: <a href="{$post->getAttr(6)}" itemprop="url" target="_blank">{$post->getAttr(6)}</a></li>
        {/if}
        </ul>
    </div>
</div>
{/block}