<a href="{$post->getPath()}" class="cards__item">
    <div class="cards__labels flex">
        {if $post->getAttr(64) == 1}
            <div data-tippy-content="{if $lang=='en'}{elseif $lang == 'uk'}На правах реклами{else}На правах рекламы{/if}" class="preview__post-type preview__post-type--red mr-2">Р</div>
        {/if}
        {if $post->getAttr(65)}
            <div data-tippy-content="{if $lang=='en'}{elseif $lang == 'uk'}Ексклюзивний матеріал InVenture{else}Эксклюзивный материал InVenture{/if}" class="preview__post-type mr-2">Э</div>
        {/if}
    </div>
		
    <div class="cards__img-wrapper">
        {block 'image'}
            {if substr($post->getPath(),0,14) == "/tools/video"}
                <div>{$post->getAttr(55)}</div>
            {elseif $post->getImage()}
                {if $parent != 'post'}
                    {$post->getImage()->addClass('cards__img')->setAttr('itemprop','image')}
                {else}
                    {css "https://cdn.jsdelivr.net/gh/fancyapps/fancybox@3.5.6/dist/jquery.fancybox.min.css"}
                    {script name="fancybox" src="https://cdn.jsdelivr.net/gh/fancyapps/fancybox@3.5.6/dist/jquery.fancybox.min.js" require=['jquery']}
                    <a href="{$post->getImage()->getUrl()}" data-fancybox>
                        {$post->getImage()->addClass('cards__img')->setAttr('itemprop','image')}
                    </a>
                {/if}
                {else}
                <img class="lazyimg cards__img" src="/img/resize.375.225/images/noThumb.jpg" alt="{$post->getH1()}"/>
            {/if}
        {/block}
    </div>

    {block 'post.title'}<h2 class="cards__title" itemprop="headline">{$post->getH1()}</h2>{/block}
    {block 'post.description'}
        <div itemprop="description" class="the_shorttext">{$post->getShortText()|truncate:200:"  ..."}</div>
    {/block}
    <div class="cards__meta flex justify-between mt-auto opacity-75 text-sm">
      <div class="cards__date text-sm">
        {$post->getPublished()->format('d.m.y')}
      </div>
      <div class="cards__meta-wrapper text-sm">
       {if $post->getAttr(13)}
            <div class="cards__meta-stat">
                <img data-src="/images/icons/star.svg" alt="Rating icon" class="lazyload mr-2">
                <div>{$post->getAttr(13)|number_format}</div>
            </div>
        {/if}
        <div class="cards__meta-stat">
            <img data-src="/images/icons/eye.svg" alt="Views icon" class="lazyload mr-2">
            <div>{$post->getViews()+1}</div>
        </div>
      </div>
    </div>
</a>

{* 
    <div class="horizontal-cards__info">
        {block 'post.title'}<h2 class="horizontal-cards__name" itemprop="headline">{$post->getH1()}</h2>{/block}
        {block 'post.description'}
            <div itemprop="description" class="the_shorttext">{$post->getShortText()|truncate:200:"  ..."}</div>
        {/block}
    </div>
    {block 'post.meta'}

        {block 'post.parent'}
        {if $post->getParent()}
            <a href="{$post->getParent()->getPath()}">
                {if file_exists(concat($module->getApp()->getWebRoot(),'/i/',$post->getParent()->getSubpath(),'.png'))}
                    <img src="{concat('/i/',$post->getParent()->getSubpath(),'.png')}" alt="" class="category"/>
                {else}
                    <img src="/i/folded-newspaper.png" alt="" />
                {/if}
                {$post->getParent()->getH1()}
            </a>
        {/if}
        {/block}
        
    {/block}
    {block 'post.meta.schema'}
        <div itemprop="publisher" itemscope itemtype="http://schema.org/Organization">
            <meta itemprop="url" content="https://inventure.ua/">
            <meta itemprop="name" content="Inventure">
            <div itemprop="logo" itemscope itemtype="http://schema.org/ImageObject">
                <meta itemprop="url" content="https://inventure.com.ua/i/logo_header.png">
            </div>
        </div>
        <meta itemprop="dateModified" content="{$post->getUpdated()->format('c')}">
    {/block}
</a> *}