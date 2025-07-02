{assign "isNews" value=($request->getPathInfo()|strpos:'/news' === 0)}
{assign "isVideo" value=($request->getPathInfo()|strpos:'/tools/video' === 0)}
{assign "isAnalytics" value=($request->getPathInfo()|strpos:'/analytics' === 0)}
{block 'breadcrumbs'}{/block}
<div class="preview__wrapper  {if $post->getImage()}plain-text__card--with-img{else}plain-text__card--without-img{/if}">
  {if $post->getImage()}
    <div class="preview__wrapper-cover preview__wrapper-cover--none">
      {block 'image'}
        <div class="preview__img-wrapper">
          <div class="preview__img-inner">
            <picture>
              <source data-srcset="{$post->getImage()->thumb(600,400)->getUrl()}" media="--mobile" />
              <img class="preview__img lazyload" src="{$post->getImage()->thumb(990,660)->getUrl()}"
                data-src="{$post->getImage()->thumb(990,660)->getUrl()}" alt='{$post->getTitle()}'>
            </picture>
          </div>
        </div>
      {/block}
    </div>
  {/if}
  <div class="preview__wrapper-main mt-6  mobile-mb-4">
    <h1 class="preview__title mb-2">{$post->getTitle()}</h1>
    {block 'post.description'}
      <div itemprop="description" class="preview__description mb-2">{$post->getShortText()}</div>
    {/block}
    <div class="preview__info-wrapper items-center">
      <div class="flex mobile-mb-4">
        {include 'components/share-btn'}
      </div>
      {if ($post->getAttr(6))}
        <a href="{$post->getAttr(6)}" target="_blank" itemprop="url" rel="nofollow"
          class="btn btn--normal btn--blue pl-6 pr-6">
          {if $lang === 'ru'}
            Забронировать
          {elseif $lang === 'uk'}
            Забронювати
          {else}
            Book
          {/if}
        </a>
      {/if}
    </div>
  </div>
  <div class="preview__wrapper-main" style="position: relative;" itemprop="about" itemscope
    itemtype="http://schema.org/Event">
    <div class="line mb-6 mt-6 desktop-only"></div>
    <meta itemprop="name" content="{$post->getH1()}">
    <meta itemprop="description" content="{$post->getShortText()}">
    {if $post->getImage()}
    <meta itemprop="image" content="{url_fix($post->getImage()->getUrl())}">{/if}
    <div class="box-shadow3"></div>
    <div class="event_time">
      <div class="flex flex-col mb-1 mt-1">
        <h2>{if $lang === 'ru'}Организатор{elseif $lang === 'uk'}Організатор{else}Organizer{/if}</h2><span
          itemprop="organizer">{$post->getAttr(9)}</span>
      </div>
      <div class="flex flex-col mb-1 mt-1">
        <h2>{if $lang === 'ru'}Начало{elseif $lang === 'uk'}Початок{else}Start{/if}</h2> <span itemprop="startDate"
          content="{$post->getAttr(7)->format('Y-m-d,H:i')}">{$post->getAttr(7)->format('d.m.Y, H:i')}</span>
      </div>
      <div class="flex flex-col mb-1 mt-1">
        <h2>{if $lang === 'ru'}Окончание{elseif $lang === 'uk'}Закінчення{else}End{/if}</h2> <span itemprop="endDate"
          content="{$post->getAttr(8)->format('Y-m-d')}">{$post->getAttr(8)->format('d.m.Y, H:i')}</span>
      </div>
      <div class="flex flex-col mb-1 mt-1" itemprop="location" itemscope itemtype="https://schema.org/Place">
        <div class="flex flex-col mb-1 mt-1">
          <h2>{if $lang === 'ru'}Локация{elseif $lang === 'uk'}Локація{else}Location{/if}</h2> <span
            itemprop="name">{$post->getAttr(11)}</span>
        </div>
        {if ($post->getAttr(10))}
          <div class="flex flex-col mb-1 mt-1">
            <h2>{if $lang === 'ru'}Адрес{elseif $lang === 'uk'}Адреса{else}Address{/if}</h2> <span
              itemprop="address">{$post->printAttr(10)}</span>
          </div>
        {/if}
      </div>
      {if ($post->getAttr(6))}
        <div class="flex flex-col mb-1 mt-1">
          <h2>{if $lang === 'ru'}Сайт{elseif $lang === 'uk'}Сайт{else}Website{/if}</h2> <a href="{$post->getAttr(6)}"
            target="_blank" itemprop="url" rel="nofollow">{$post->getAttr(6)}</a>
        </div>
      {/if}
    </div>
  </div>
</div>