{extends 'Blog.post'}
{block 'post.preview' prepend}
{if $post->getAttr(58) == 1}
{$image_class = 'inv-sold'}
{else}
{$image_class = ''}
{/if}
{/block}
{block 'post.image'}
    <div id="newsThumb">
        <a href="#" data-reveal-id="thumbBig">
            {$post->getImage()->thumbup(350,254)}
        </a>
    </div>
    <div id="thumbBig" class="reveal-modal large medium" data-reveal>
        <img itemprop="image" src="{$post->getImage()->getUrl()}" alt='{$post->getTitle()}' itemscope itemtype="http://schema.org/ImageObject"/>
        <p><b>{$post->getTitle()}</b></p>
        <a class="close-reveal-modal">&#215;</a>
    </div>
{/block}
{block 'main' prepend}
<div style="position: relative; margin-bottom: 24px;">
    <div class="box-shadow"></div>
    <div class="tabs">
      <ul class="tabs__caption">
        <li class="active">Характеристика</li>
        {if count($post->getImages())>1}<a href="#photosContent">Галерея</a>{/if}
        <a href="#eventMapBlock">Расположение</a>
        <a href="#contacts">Контакты</a>
      </ul>

      <div class="tabs__content  active" id="panel1">
        {include concat('inc/investments/',$post->getParent()->getSubpath())}
      </div>
    </div>
</div>
{/block}