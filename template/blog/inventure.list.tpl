{* prefilter=off *}
{extends 'Blog.blog'}
{block 'page.class' append} inventure_list{/block}
{block 'config'}
{if $lang === 'ru'}
{$links = [
    '/investments/projects'=>'Инвестиционные проекты и стартапы',
    '/investments/business'=>'Продажа бизнеса',
    '/investments/realestate'=>'Недвижимость',
    '/investments/land'=>'Земля',
    '/investments/franchising'=>'Франчайзинг',
    '/investments/offer'=>'Инвесторы'
]}

{$sorts = [
    ['', 'Новые'],
    ['views', 'Популярные'],
    ['rating', 'Лучшие']
]}
{else}
{$links = [
    '/en/investments/projects'=>'Investment Projects and Startups',
    '/en/investments/business'=>'Business for Sale',
    '/en/investments/realestate'=>'Commercial Property',
    '/en/investments/land'=>'Land',
    '/en/investments/en_franchising'=>'Franchising',
    '/en/investments/offer'=>'Investor Offers'
]}

{$sorts = [
    ['', 'Latest'],
    ['views', 'Popular'],
    ['rating', 'Featured']
]}
{/if}



{/block}


<div data-append="sort" class="section__title-categories pt-0 mb-2 pb-0 flex flex-row justify-between items-center">
    {* <h1 class="pr-4">Инвестиционные предложения</h1> *}
    <ul class="sort desktop-only text-xs">
        {$f = $request->query->get('filter')}
        {foreach $sorts as $s}
            {if $s}
                <li class="sort__item {if $f.sort==$s.0}sort__item--active{/if}"><a href="?{if $s.0}filter[sort]={$s.0}{/if}">{$s.1}</a><li>
            {/if}
        {/foreach}
    </ul>
</div>



{block 'breadcrumbs'}{/block}
{block 'nav' append}
{* {$f = $request->query->get('filter')}
<ul class="tabs">
    {foreach $sorts as $s}
        {if $s}
            <li class="tabs-title {if $f.sort==$s.0}is-active{/if}"><a href="?{if $s.0}filter[sort]={$s.0}{/if}">{$s.1}</a><li>
        {/if}
    {/foreach}
</ul> *}
{/block}
{block 'posts'}
		{include 'components/mobile-sort'}
    <article id="cards__list" class="cards"></article>
    <style>
    .pagination{
        display: none!important;
    }
.lds-ellipsis {
  display: inline-block;
  position: relative;
  width: 80px;
  height: 80px;
}
.lds-ellipsis div {
  position: absolute;
  top: 33px;
  width: 13px;
  height: 13px;
  border-radius: 50%;
  background: var(--main-accent-color-darken);
  animation-timing-function: cubic-bezier(0, 1, 1, 0);
}
.lds-ellipsis div:nth-child(1) {
  left: 8px;
  animation: lds-ellipsis1 0.6s infinite;
}
.lds-ellipsis div:nth-child(2) {
  left: 8px;
  animation: lds-ellipsis2 0.6s infinite;
}
.lds-ellipsis div:nth-child(3) {
  left: 32px;
  animation: lds-ellipsis2 0.6s infinite;
}
.lds-ellipsis div:nth-child(4) {
  left: 56px;
  animation: lds-ellipsis3 0.6s infinite;
}
@keyframes lds-ellipsis1 {
  0% {
    transform: scale(0);
  }
  100% {
    transform: scale(1);
  }
}
@keyframes lds-ellipsis3 {
  0% {
    transform: scale(1);
  }
  100% {
    transform: scale(0);
  }
}
@keyframes lds-ellipsis2 {
  0% {
    transform: translate(0, 0);
  }
  100% {
    transform: translate(24px, 0);
  }
}
.htmx-indicator{
    opacity:0;
    transition: opacity 500ms ease-in;
}
.htmx-request .htmx-indicator{
    opacity:1
}
.htmx-request.htmx-indicator{
    opacity:1
}
    </style>
    <div id="spinner" style="margin: 0 auto; display: block;" class="lds-ellipsis htmx-indicator"><div></div><div></div><div></div><div></div></div>
    <script src="https://unpkg.com/htmx.org@1.9.10" integrity="sha384-D1Kt99CQMDuVetoL1lrYwg5t+9QdHe7NLX/SoJYkXDFfX37iInKRy5xLSi8nO7UC" crossorigin="anonymous"></script>
{/block}

{script_code require="jquery"}

    $( document ).ready(function() {
        console.log( "+179 ready!" );
        
    });
    
    

    {* https://dev.inventure.com.ua/invest.php?action=get&filter%5Bcategory%5D%5Bparent%5D=projects&price1=10000&price2=5000000 *}

{/script_code}



{* {$posts->setCount(24)}
    {foreach $posts as $post}
        {if $post->getAttr(58) == 1}
            {$image_class = 'inv-sold'}
        {else}
            {$image_class = ''}
        {/if}
    {block 'post!NO'}
        <a href="{$post->getPath()}" class="cards__item">
                <div class="cards__img-wrapper">
                    {block 'image'}
                        {if $post->getImage()}
                            <img class="cards__img lazyimg" data-src="{$post->getImage()->thumbup(350,254)->getUrl()}" alt='{$post->getTitle()}'>
                        {else}
                            <img  class="cards__img lazyimg" data-src="/img/resize.375.225/images/noThumb.jpg" alt="{$post->getH1()}" itemscope itemtype="http://schema.org/ImageObject"/>
                        {/if}
                    {/block}
                </div>

                {block 'post.title'}<h2 class="cards__title" itemprop="headline">{$post->getH1()}</h2>{/block}
                <div class="cards__meta flex justify-between mt-auto opacity-75 text-sm">
                    <div class="cards__date">
                        {if trim($post->getAttr("15"))} ${$post->printAttr("15")|number_format:0:'.':' '}{else}Договорная{/if}
                    </div>
                    <div class="cards__meta-wrapper">
                        {if $post->getAttr(13)}
                            <div class="cards__meta-stat">
                                <svg width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M13.9631 5.36967C13.871 5.08618 13.6195 4.88548 13.3232 4.85867L9.28184 4.49177L7.68466 0.752449C7.56674 0.477725 7.29842 0.300415 6.99977 0.300415C6.70112 0.300415 6.4327 0.477725 6.31553 0.752449L4.71835 4.49177L0.67632 4.85867C0.38002 4.88602 0.129115 5.08672 0.0364013 5.36967C-0.0557786 5.65315 0.0293516 5.96408 0.253446 6.16062L3.30841 8.83939L2.40766 12.8067C2.34175 13.0984 2.45498 13.4 2.69701 13.575C2.82711 13.6695 2.97996 13.7167 3.13335 13.7167C3.26515 13.7167 3.39707 13.6817 3.51488 13.6112L6.99977 11.5275L10.484 13.6112C10.7396 13.7639 11.061 13.7499 11.3025 13.575C11.5446 13.4 11.6578 13.0984 11.5919 12.8067L10.6911 8.83939L13.7461 6.16062C13.9701 5.96408 14.0553 5.65379 13.9631 5.36967Z" fill="#808080"/>
                                </svg>
                                <div>{$post->getAttr(13)|number_format}</div>
                            </div>
                        {/if}
                        <div class="cards__meta-stat">
                            <svg width="16" height="11" viewBox="0 0 16 11" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M8 0.0910645C2.61053 0.0910645 0 5.51478 0 5.51478C0 5.51478 2.59368 10.9385 8 10.9385C13.4063 10.9385 16 5.51478 16 5.51478C16 5.51478 13.3895 0.0910645 8 0.0910645ZM8 9.70889C5.67579 9.70889 3.80631 7.82238 3.80631 5.51478C3.80631 3.19033 5.69263 1.32066 8 1.32066C10.3074 1.32066 12.1937 3.20717 12.1937 5.51478C12.1937 7.83922 10.3242 9.70889 8 9.70889Z" fill="#808080"/>
                                <path d="M9.97239 4.74104C9.31555 4.74104 8.77659 4.20209 8.77659 3.54525C8.77659 3.34314 8.82712 3.14104 8.92818 2.97262C8.64186 2.87157 8.32186 2.8042 8.00186 2.8042C6.50291 2.8042 5.27344 4.01683 5.27344 5.51577C5.27344 7.01472 6.48607 8.2442 8.00186 8.2442C9.50081 8.2442 10.7134 7.03156 10.7134 5.51577C10.7134 5.19577 10.6629 4.87577 10.545 4.58946C10.3934 4.69051 10.1913 4.74104 9.97239 4.74104Z" fill="#808080"/>
                            </svg>
                            <div>{$post->getViews()+1}</div>
                        </div>
                    </div>
                </div>
                
        </a>
    {/block}
        {/foreach} *}