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
{block 'post.views' append}
<div class="reviews">{widget 6 target=$post->getId()}</div> {$post->getRating()|number_format:1}
{/block}
{block 'contacts.inner'}
<div class="grid-x grid-margin-x">
    <div class="cell small-12 medium-6">
        {$smarty.block.parent}
    </div>
    <div class="cell small-12 medium-6">
            <div class="contacts">
                <div class="box-shadow box-shadow1"></div>
                <h2>Связаться со мной</h2>
                {form 'investment_callback'}
            </div>
    </div>
</div>
{/block}