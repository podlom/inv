{extends 'Blog.blog'}
{block 'page.class' append} event_list{/block}
{block 'post.description' prepend}
<div class="author">
    <img src="/i/pers.png" alt="" />{$post->getAttr(9)}
</div>
 <div class="date">
    <span><img src="/i/calendar.png"> {$post->getAttr(7)->format('d.m.Y')}</span>
    <span><img src="/i/clock.png"> {$post->getAttr(7)->format('H:i')} - {$post->getAttr(8)->format('H:i')}</span>
</div>
{/block}
{block 'breadcrumbs'}
<ul class="tabs" data-tabs id="example-tabs">
    <li class="tabs-title{if $request->attributes->get('_route')!='archive'} is-active{/if}">
        <a href="{$controller->url('blog')}">
            {if $lang=='en'}Upcoming{else}Предстоящие{/if}
        </a>
    </li>
    <li class="tabs-title{if $request->attributes->get('_route')=='archive'} is-active{/if}">
        <a href="{$controller->url('archive')}">
            {if $lang=='en'}Past{else}Прошедшие{/if}
        </a>
    </li>
</ul>
{/block}