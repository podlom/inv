{* prefilter=off *}
{extends 'Blog.post'}
{block 'content' append}
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.css">

    {* {block 'similar'} *}
    {* <div class="title_read_also">
        <h2><a href="tools/events">{if $lang=='en'}Related posts{else}Читайте также{/if}</a></h2>
    </div>
    <article class="grid-container read_also">
        <div class="grid-margin-x grid-x">
        {similar_posts $post 4}
            <div class="cell small-12 medium-6">
                <a href="{$lent->getPath()}" class="news_inv">
                    <div class="img">
                            <img src="/img/thumbup.236.170{$lent->getImage()->getUrl()}" alt='{$lent->getTitle()}' />
                    </div>
                    <div class="content">
                        <h5>
                            {$lent->getH1()}
                        </h5>
                    </div>
                </a>
            </div>
        {/similar_posts}
        </div>
    </article> *}
    <h2 class="section__title mt-4">{if $lang=='en'}Related posts{elseif $lang == 'uk'}Читайте також{else}Читайте также{/if}</h2>
        <article class="cards mb-12">
            {similar_posts $post 3}
                <a href="{$lent->getPath()}" class="cards__item">
                    <div class="cards__labels flex">
                        {if $lent->getAttr(64) == 1}
                            <div data-tippy-content="{if $lang=='en'}{elseif $lang == 'uk'}На правах реклами{else}На правах рекламы{/if}" class="preview__post-type preview__post-type--red mr-2">Р</div>
                        {/if}
                        {if $lent->getAttr(65)}
                            <div data-tippy-content="{if $lang=='en'}{elseif $lang == 'uk'}Ексклюзивний матеріал InVenture{else}Эксклюзивный материал InVenture{/if}" class="preview__post-type mr-2">Э</div>
                        {/if}
                    </div>
                    <div class="cards__img-wrapper">
                        <img class="lazyimg cards__img" data-src="/img/thumbup.350.254{$lent->getImage()->getUrl()}" alt="{$lent->getTitle()}">                     
                    </div>
                    {block 'post.title'}<h2 class="cards__title" itemprop="headline">{$lent->getH1()}</h2>{/block}
                    <div class="cards__meta flex justify-between mt-auto opacity-75 text-sm">
                        <div class="cards__date text-sm">{$lent->getPublished()->format('d.m.y')}</div>
                        <div class="cards__meta-wrapper  text-sm">
                            <div class="cards__meta-stat">
                                <svg width="16" height="11" viewBox="0 0 16 11" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M8 0.0910645C2.61053 0.0910645 0 5.51478 0 5.51478C0 5.51478 2.59368 10.9385 8 10.9385C13.4063 10.9385 16 5.51478 16 5.51478C16 5.51478 13.3895 0.0910645 8 0.0910645ZM8 9.70889C5.67579 9.70889 3.80631 7.82238 3.80631 5.51478C3.80631 3.19033 5.69263 1.32066 8 1.32066C10.3074 1.32066 12.1937 3.20717 12.1937 5.51478C12.1937 7.83922 10.3242 9.70889 8 9.70889Z" fill="#808080"></path>
                                    <path d="M9.97239 4.74104C9.31555 4.74104 8.77659 4.20209 8.77659 3.54525C8.77659 3.34314 8.82712 3.14104 8.92818 2.97262C8.64186 2.87157 8.32186 2.8042 8.00186 2.8042C6.50291 2.8042 5.27344 4.01683 5.27344 5.51577C5.27344 7.01472 6.48607 8.2442 8.00186 8.2442C9.50081 8.2442 10.7134 7.03156 10.7134 5.51577C10.7134 5.19577 10.6629 4.87577 10.545 4.58946C10.3934 4.69051 10.1913 4.74104 9.97239 4.74104Z" fill="#808080"></path>
                                </svg>
                                <div>{$lent->getViews()}</div>
                            </div>
                        </div>
                    </div>
                </a>
            {/similar_posts}
        </article>
    {* {/block} *}
{/block}

{block 'contacts'}{/block}

