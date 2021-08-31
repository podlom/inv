{* prefilter=off *}
{extends 'Blog.post'}
{block 'page.scope'}itemtype="http://schema.org/NewsArticle"{/block}
{* {block 'post.parent'}
    {$rubrics = $post->getRubrics()}
    {$r = $rubrics[0]}
    {if $r}
        <a href="{$r->getPath()}">
            <img src="/i/folded-newspaper.png" alt="" />
            {$r->getH1()}
        </a>
    {/if}
{/block} *}

{block 'content' append}
    <h2 class="section__title mt-4">{if $lang=='en'}Related posts{else}Читайте также{/if}</h2>
    <article class="cards">
        {similar_posts $post 3}
            <a href="{$lent->getPath()}" class="cards__item">
                <div class="cards__img-wrapper">
                    <img class="lazyimg cards__img" data-src="/img/thumbup.350.254{$lent->getImage()->getUrl()}" alt="{$lent->getTitle()}">                     
                </div>
                {block 'post.title'}<h2 class="cards__title" itemprop="headline">{$lent->getH1()}</h2>{/block}
                <div class="cards__meta flex justify-between mt-auto opacity-75 text-sm">
                    <div class="cards__date  text-sm">{$lent->getPublished()->format('d.m.y')}</div>
                    <div class="cards__meta-wrapper  text-sm">
                        <div class="cards__meta-stat">
                            <svg width="16" height="11" viewBox="0 0 16 11" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M8 0.0910645C2.61053 0.0910645 0 5.51478 0 5.51478C0 5.51478 2.59368 10.9385 8 10.9385C13.4063 10.9385 16 5.51478 16 5.51478C16 5.51478 13.3895 0.0910645 8 0.0910645ZM8 9.70889C5.67579 9.70889 3.80631 7.82238 3.80631 5.51478C3.80631 3.19033 5.69263 1.32066 8 1.32066C10.3074 1.32066 12.1937 3.20717 12.1937 5.51478C12.1937 7.83922 10.3242 9.70889 8 9.70889Z" fill="#808080"></path>
                                <path d="M9.97239 4.74104C9.31555 4.74104 8.77659 4.20209 8.77659 3.54525C8.77659 3.34314 8.82712 3.14104 8.92818 2.97262C8.64186 2.87157 8.32186 2.8042 8.00186 2.8042C6.50291 2.8042 5.27344 4.01683 5.27344 5.51577C5.27344 7.01472 6.48607 8.2442 8.00186 8.2442C9.50081 8.2442 10.7134 7.03156 10.7134 5.51577C10.7134 5.19577 10.6629 4.87577 10.545 4.58946C10.3934 4.69051 10.1913 4.74104 9.97239 4.74104Z" fill="#808080"></path>
                            </svg>
                            <div>{$post->getViews()}</div>
                        </div>
                    </div>
                </div>
            </a>
        {/similar_posts}
    </article>
{/block}
{block 'contacts'}{/block}