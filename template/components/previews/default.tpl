{assign "isNews" value=($request->getPathInfo()|strpos:'/news' >= 0)}
{assign "isVideo" value=($request->getPathInfo()|strpos:'/tools/video' >= 0)}
{assign "isAnalytics" value=($request->getPathInfo()|strpos:'/analytics' >= 0)}
{block 'breadcrumbs'}{/block}
<div class="preview__wrapper  {if $post->getImage()}plain-text__card--with-img{else}plain-text__card--without-img{/if}">
    {if $post->getImage()}
      <div class="preview__wrapper-cover preview__wrapper-cover--none">
          {block 'image'}
            <div class="preview__img-wrapper">
              <div class="preview__img-inner">
                <picture>
                  <source data-srcset="{$post->getImage()->thumb(600,400)->getUrl()}" media="--mobile" />
                  <img class="preview__img lazyload" src="{$post->getImage()->thumb(990,660)->getUrl()}" data-src="{$post->getImage()->thumb(990,660)->getUrl()}" alt='{$post->getTitle()}'>
                </picture>
                {* <img class="preview__img lazyimg" data-src="{$post->getImage()->thumb(600,400)->getUrl()}" alt='{$post->getTitle()}'> *}
                <div class="img-overlay"></div>
                <div class="preview__img-footer flex justify-between mobile-only">
                  <div class="preview__date mr-2 font-semibold text-sm">
                    {$post->getPublished()->format('d.m.y')}
                  </div>
                  <div class="flex items-center">
                    <svg width="16" height="11" viewBox="0 0 16 11" fill="none" xmlns="http://www.w3.org/2000/svg">
                      <path d="M7.98888 0C2.6069 0 0 5.42316 0 5.42316C0 5.42316 2.59008 10.8463 7.98888 10.8463C13.3877 10.8463 15.9778 5.42316 15.9778 5.42316C15.9778 5.42316 13.3709 0 7.98888 0ZM7.98888 9.61685C5.6679 9.61685 3.80102 7.73053 3.80102 5.42316C3.80102 3.09895 5.68472 1.22947 7.98888 1.22947C10.293 1.22947 12.1767 3.11579 12.1767 5.42316C12.1767 7.74737 10.3099 9.61685 7.98888 9.61685Z" fill="white"/>
                      <path d="M9.95609 4.64973C9.30016 4.64973 8.76196 4.11078 8.76196 3.45394C8.76196 3.25183 8.81242 3.04973 8.91333 2.88131C8.62741 2.78026 8.30786 2.71289 7.9883 2.71289C6.49144 2.71289 5.26367 3.92552 5.26367 5.42447C5.26367 6.92342 6.47462 8.15289 7.9883 8.15289C9.48516 8.15289 10.6961 6.94026 10.6961 5.42447C10.6961 5.10447 10.6456 4.78447 10.5279 4.49815C10.3766 4.5992 10.1747 4.64973 9.95609 4.64973Z" fill="white"/>
                    </svg>
                    <span class="ml-2 font-semibold text-sm">
                      {$post->getViews()}
                    </span>
                  </div>
                </div>
              </div>
              <div class="preview__info">
                  <h1 class="preview__title">
                      {$post->getTitle()}
                  </h1>
                  {block 'post.description'}
                    <div itemprop="description" class="preview__description">{$post->getShortText()|truncate:200:"  ..."}</div>
                  {/block}
              </div>
            </div>
          {/block}
      </div>
    {/if}
    <div class="preview__wrapper-main pt-6 mobile-mt-0">
        {if !$post->getImage()}
          <h1 class="preview__title mb-2">{$post->getTitle()}</h1>
          {block 'post.description'}
            <div itemprop="description" class="preview__description">{$post->getShortText()|truncate:200:"  ..."}</div>
          {/block}
        {/if}
        
        {if $isNews || $isAnalytics}
          <div class="preview__info-wrapper is-news-{$isNews} is-analytics-{$isAnalytics} is-attr64-{$post->getAttr(64)} is-attr65-{$post->getAttr(65)}">
            <div class="flex desktop-only">
              <div class="preview__date mr-2 font-semibold text-sm">
                {$post->getPublished()->format('d.m.y')}
              </div>
              {if $post->getAttr(64) == 1}
                  <div data-tippy-content="На правах рекламы" class="preview__post-type preview__post-type--red mr-2">Р</div>
              {/if}
              {if $post->getAttr(65) == 1}
                  <div data-tippy-content="Эксклюзивный материал InVenture" class="preview__post-type mr-2">Э</div>
              {/if}

              
            
              {$rubrics = $post->getRubrics()}
              {$breadcrumbs = array_filter([$blog, $category,$rubrics[0]])}
              <ul class="preview__breadcrumbs breadcrumbs-box" itemprop="breadcrumb" itemscope itemtype="https://schema.org/BreadcrumbList">
                {foreach $breadcrumbs as $item}
                  <li {if $item@last || $item@first}style="display:none;"{elseif $item@index ==count($breadcrumbs)-2}class="current"{/if} itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
                      <meta itemprop="position" content="{$item@index+1}">
                      <a href="{$item->getPath()}" itemprop="item">
                          <span class="truncate block  text-sm"  itemprop="name">{$item->geth1()|truncate:75:" ..."}</span>
                      </a>
                  </li>
                {/foreach}
              </ul>

            </div>
            {include 'components/share-btn'}
          </div>
        {else}
          {include 'components/share-btn'}
        {/if}
    </div>
</div>
