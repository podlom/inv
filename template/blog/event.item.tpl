{extends 'Blog.post'}
{block 'main' prepend}
<div style="position: relative;" itemprop="about" itemscope itemtype="http://schema.org/Event">
    <meta itemprop="name" content="{$post->getH1()}">
    <meta itemprop="description" content="{$post->getShortText()}">
    {if $post->getImage()}<meta itemprop="image" content="{url_fix($post->getImage()->getUrl())}">{/if}
    <div class="box-shadow3"></div>
    <div class="event_time">
        <div><b>Организатор</b>: <span itemprop="organizer">{$post->getAttr(9)}</span></div>
        <div><b>Начало</b>: <span itemprop="startDate" content="{$post->getAttr(7)->format('Y-m-d,H:i')}">{$post->getAttr(7)->format('d.m.Y, H:i')}</span></div>
        <div><b>Окончание</b>: <span itemprop="endDate" content="{$post->getAttr(8)->format('Y-m-d')}">{$post->getAttr(8)->format('d.m.Y, H:i')}</span></div>
        <div itemprop="location" itemscope itemtype="https://schema.org/Place">
        <div><b>Локация</b>: <span itemprop="name">{$post->getAttr(11)}</span></div>
        {if ($post->getAttr(10))}
            <div><b>Адрес</b>: <span itemprop="address">{$post->printAttr(10)}</span></div>
        {/if}
        </div>
        {if ($post->getAttr(6))}
            <div><b>Сайт</b>: <a href="{$post->getAttr(6)}" target="_blank" itemprop="url" rel="nofollow">{$post->getAttr(6)}</a></div>
        {/if}
    </div>
</div>
{/block}