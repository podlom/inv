{block 'post'}
<div class="row">
  <div style="position: relative; background-color: white;">
    <div class="box-shadow"></div>
    <div class="auto-height">
        <div class="medium-{$post_size.0|default:5} columns photo-in {$image_class}">
            {block 'image'}
            {if substr($post->getPath(),0,14) == "/tools/video"}
                <div>{$post->getAttr(55)}</div>
            {elseif $post->getImage()}
                <a href="{$post->getPath()}">
                    {$post->getImage()->thumbup(350,254)}
                </a>
            {else}
                <a href="{$post->getPath()}">
                    <img src="/img/resize.375.225/images/noThumb.jpg" alt="{$post->getH1()}" itemscope itemtype="http://schema.org/ImageObject"/>
                </a>
            {/if}
            {/block}
        </div>
        <div class="medium-{$post_size.1|default:7} columns">
            <div class="viewbox-cnt attr-in">
                <div class="hint m_b-10">
                {block 'post.meta'}
                    {block 'post.publish'}<time class="time">{$post->getPublished()->format('d.m.y')}</time>{/block}
                    {block 'post.views'}<img src="/i/views.png"/><span class="number">{$post->getViews()+1}</span>{/block}
                    {block 'post.rubric'}
                    {$r=$post->getRubrics()}
                    {if substr($blog->getPath(),0,5) == '/news' && $r.0}
                        <img src="/i/folded-newspaper.png" alt="" />{$r.0->getH1()}
                    {/if}
                    {/block}
                {/block}
                </div>
                <div class="author">{block 'post.author'}
                        {if $post->getAttr(1)}<img src="/i/pers.png" alt="" />
                            {if $post->getAttr(2)}
                                <a href="{$post->getAttr(2)}">{$post->getAttr(1)}</a>
                            {else}
                                {$post->getAttr(1)}
                            {/if}
                        {/if}
                    {/block}</div>
                <h3><a href="{$post->getPath()}">{$post->getH1()}</a></h3>
                {block 'description'}
                    <ul class="list_attr">
                        <li>{$post->getShortText()|truncate:200:"  ..."}</li>
                    </ul>
                {/block}
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
            </div>
        </div>
    </div>
   </div>
</div>
{/block}