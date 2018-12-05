{* prefilter=off *}
{block 'post.preview'}
<div class="row the_preview">
  <div style="position: relative; background-color: white;">
    <div class="box-shadow"></div>
    <div class="auto-height">
        <div class="medium-{$post_size.0|default:5} columns {$image_class}">
            {block 'image'}
            {if substr($post->getPath(),0,14) == "/tools/video"}
                <div>{$post->getAttr(55)}</div>
            {elseif $post->getImage()}
                <a href="{$post->getPath()}">
                    {$post->getImage()->thumbup(350,254)->addClass('the_img')}
                </a>
            {else}
                <a href="{$post->getPath()}">
                    <img class="the_img" src="/img/resize.375.225/images/noThumb.jpg" alt="{$post->getH1()}" itemscope itemtype="http://schema.org/ImageObject"/>
                </a>
            {/if}
            {/block}
        </div>
        <div class="medium-{$post_size.1|default:7} columns">
            <div class="the_description">
                <div class="hint">
                {block 'post.meta'}
                    {block 'post.publish'}<time class="time" itemprop="datePublished">{$post->getPublished()->format('d.m.y')}</time>{/block}
                    {block 'post.views'}<img src="/i/views.png" /><span class="number">{$post->getViews()+1}</span>{/block}
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
                </div>
                {block 'post.title'}<a href="{$post->getPath()}"><h3>{$post->getH1()}</h3></a>{/block}
                {block 'post.author'}
                <div class="author">
                    {if $post->getAttr(1)}<img src="/i/pers.png" alt="" />
                        {if $post->getAttr(2)}
                            <a href="{$post->getAttr(2)}">{$post->getAttr(1)}</a>
                        {else}
                            {$post->getAttr(1)}
                        {/if}
                    {/if}
                </div>
                {/block}
                {block 'post.description'}
                    <ul class="list_attr">
                        <li>{$post->getShortText()|truncate:200:"  ..."}</li>
                    </ul>
                {/block}
                {block 'post.share'}
                <div class="row">
                    <div class="columns">
                        <ul class="inline-list share-btn">
                              <li><span class='st_facebook_hcount' st_url="https://inventure.com.ua{$post->getPath()}" displayText='Facebook'></span></li>
                              <li><span class='st_twitter_hcount' st_url="https://inventure.com.ua{$post->getPath()}" displayText='Tweet'></span></li>
                              <li><span class='st_linkedin_hcount' st_url="https://inventure.com.ua{$post->getPath()}" displayText='LinkedIn'></span></li>
                              <li><span class='st_googleplus_hcount' st_url="https://inventure.com.ua{$post->getPath()}" displayText='Google +'></span></li>
                          </ul>
                    </div>
                </div>
                {/block}
            </div>
        </div>
    </div>
    {block 'post.extras'}{/block}
   </div>
</div>
{/block}