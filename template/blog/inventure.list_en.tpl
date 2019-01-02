{* prefilter=off *}
{* prefilter=off *}
{extends 'Blog.blog'}
{block 'page.class' append} inventure_list{/block}
{block 'config'}
{$links = [
    '/en/investments/projects'=>'Investment Projects and Startups',
    '/en/investments/business'=>'Business for Sale',
    '/en/investments/realestate'=>'Commercial Property',
    '/en/investments/land'=>'Land',
    '/en/investments/offer'=>'Investor Offers'
]}
{$sorts = [
    ['', 'Latest'],
    ['views', 'Popular'],
    ['rating', 'Featured']
]}
{/block}
{block 'breadcrumbs'}{/block}
{block 'nav' append}
{$f = $request->query->get('filter')}
<ul class="tabs">
    {foreach $sorts as $s}
    <li class="tabs-title {if $f.sort==$s.0}is-active{/if}"><a href="?{if $s.0}filter[sort]={$s.0}{/if}">{$s.1}</a><li>
    {/foreach}
</ul>
{/block}
{block 'posts'}
<div class="auto-height">
    <article>
        {$posts->setCount(24)}
        {foreach $posts as $post}
        {if $post->getAttr(58) == 1}
            {$image_class = 'inv-sold'}
        {else}
            {$image_class = ''}
        {/if}
    {block 'post!NO'}
        <div class="">
            <div class="box-shadow"></div>
            <div class="item ">
        {block 'image'}
                {if $post->getImage()}
                <div class="img">
                    <a href="{$post->getPath()}" class="{$image_class}">
                        {$post->getImage()->thumbup(350,254)}
                    </a>
                </div>
                {else}
                    <a href="{$post->getPath()}">
                        <img src="/img/resize.375.225/images/noThumb.jpg" alt="{$post->getH1()}" itemscope itemtype="http://schema.org/ImageObject"/>
                    </a>
                {/if}
        {/block}
                <div class="padding">
                    <div class="statistic">
                        <div class="date">
                          {$post->getPublished()->format('d.m.y')}
                        </div>
                        <div class="views">
                          <img src="/i/views.png">
                          {$post->getViews()+1}
                        </div>
                        <div class="rating">
                          <img src="/i/rating.png">
                          {$post->getRating()|number_format:1}
                        </div>
                    </div>
                    <div class="category">
                        {if $post->getParent()->getId() == 7860}
                            <a href="{$post->getParent()->getPath()}"><img src="/i/projects.png" alt="" />{$post->getParent()->getH1()}</a>
                        {elseif $post->getParent()->getId() == 7861}
                            <a href="{$post->getParent()->getPath()}"><img src="/i/business.png" alt="" />{$post->getParent()->getH1()}</a>
                        {elseif $post->getParent()->getId() == 7862}
                            <a href="{$post->getParent()->getPath()}"><img src="/i/realestate.png" alt="" />{$post->getParent()->getH1()}</a>
                        {elseif $post->getParent()->getId() == 7863}
                            <a href="{$post->getParent()->getPath()}"><img src="/i/land.png" alt="" />{$post->getParent()->getH1()}</a>
                        {elseif $post->getParent()->getId() == 7864}
                            <a href="{$post->getParent()->getPath()}"><img src="/i/offer.png" alt="" />{$post->getParent()->getH1()}</a>
                        {else}
                            <span></span>
                        {/if}
                    </div>
                    <h4><a href="{$post->getPath()}">{$post->getH1()}</a></h4>
                    <div class="position">
                        <div class="place">
                            <img src="/i/ukraine.png">{if $post->hasAttr("10")} {$post->printAttr("10")}{/if}
                        </div>
                        <hr>
                        <div class="footer">
                            <div>
                            {if $post->getParent()->getId() == 7861 || $post->getParent()->getId() == 7862 ||$post->getParent()->getId() == 7863}
                                <p>
                                    <span style="font-weight: 700;">PRICE</span> -
                                    {if trim($post->getAttr("15"))} ${$post->printAttr("15")|number_format:0:'.':' '}{else}Договорная{/if}
                                </p>
                            {elseif $post->getParent()->getId() == 7860}
                                <p>
                                    <span style="font-weight: 700;">INVESTMENTS</span> -
                                    {if trim($post->getAttr("34"))} ${$post->printAttr("34")|number_format:0:'.':' '}{else}Договорная{/if}
                                </p>
                            {elseif $post->getParent()->getId() == 7864}
                                <p>
                                    <span style="font-weight: 700;">INVESTMENTS</span> -
                                    {if trim($post->getAttr("31"))} ${$post->printAttr("31")|number_format:0:'.':' '}{else}Договорная{/if}
                                </p>
                            {/if}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    {/block}
        {/foreach}
    </article>
</div>
{/block}
