{* {extends 'Blog.post'}
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
            <li class="active">Characteristic</li>
            {if count($post->getImages())>1}<a href="#photosContent">Gallery</a>{/if}
            <a href="#eventMapBlock">Location</a>
            <a href="#contactsBlock">Contacts</a>
          </ul>

          <div class="tabs__content  active" id="panel1">
            {include concat('inc/investments-old/',$post->getParent()->getSubpath())}
          </div>
        </div>
    </div>
{/block} *}




{extends 'Blog.post'}
{block 'post.preview' prepend}
{if $post->getAttr(58) == 1}
{$image_class = 'inv-sold'}
{else}
{$image_class = ''}
{/if}
{/block}

{block 'post.preview'}

<div class="row post ">
{* post--card *}
  <div class="post__wrapper post__wrapper--big-shadow mb-4">
    <div class="post__container  mobile-mt-0">
        <div class="post__content content pb-6 pt-6 mobile-pt-0 mobile-pb-0">
            {block 'post.content'}
                {content $post attr=['class'=>'the_post_content','itemprop'=>'articleBody']}
            {/block}
        </div>
    </div>
  </div>
</div>
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
{/block}

{block 'post.reviews' append}
    <div class="rating">
        <img src="/i/rating.png">
        {$post->getAttr(13)|number_format}
    </div> 
{/block}

{block 'contacts.inner'}
<div class="grid-x grid-margin-x">
    <div class="cell small-12 medium-6">
        {$smarty.block.parent}
    </div>
    <div class="cell small-12 medium-6">
            <div class="contacts">
                <div class="box-shadow box-shadow1"></div>
                <h2>Contact with us</h2>
                {form 'investment_callback'}
            </div>
    </div>
</div>

{* <div class="grid-x grid-margin-x">
    <div class="cell small-12 medium-12">
        <div class="post-subscribe">
            <div class="post-subscribe__title">Хотите быть в курсе новых инвестиционных предложений?</div>
            <div class="post-subscribe__subtitle">Подпишитесь на ежемесячный дайджест!</div>
            <a href="/digest-social" class="subscription__button post-subscribe__btn"> Подписаться </a>
        </div>
    </div>
</div> *}
{/block}