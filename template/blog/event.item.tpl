{extends 'Blog.post'}

<!-- @ts template/blog/event.item.tpl +3 -->

{block 'main' prepend}{/block}

{block 'post.preview'}

<div class="row post ">
  <div class="post__wrapper">
    
    <div class="post__preview">
      {include 'components/previews/event'}
    </div>
    
    <div class="post__container">
        <div class="line mb-6 mt-6"></div>
        <div class="post__content content pb-6">
            {block 'post.content'}
                {content $post attr=['class'=>'the_post_content','itemprop'=>'articleBody']}
            {/block}
        </div>
    </div>
  </div>
</div>
{/block}
