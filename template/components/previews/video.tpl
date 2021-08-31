
{assign "isVideo" value=($request->getPathInfo()|strpos:'/tools/video' === 0)}
{if $isVideo}{/if}

<div class="preview__wrapper">

  <div class="preview__wrapper-cover preview__wrapper-cover--none">
      {block 'image'}
        <div class="preview__img-wrapper">
          <iframe class="video-iframe video-content preview__video lazyload" itemscope itemtype="http://schema.org/ImageObject" data-src="//www.youtube.com/embed/{$post->printAttr("55")}" frameborder="0" allowfullscreen></iframe>
        </div>
      {/block}
  </div>
  <div class="preview__wrapper-main pt-6 mobile-mt-0">
    <h1 class="preview__title mb-2">{$post->getTitle()}</h1>
    {block 'post.description'}
      <div itemprop="description" class="preview__description cards__img">{$post->getShortText()|truncate:200:"  ..."}</div>
    {/block}

    <div class="preview__info-wrapper  mt-4">
      <div class="flex desktop-only">
        <div class="preview__date mr-2 font-semibold text-sm">
          {$post->getPublished()->format('d.m.y')}
        </div>
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
  </div>