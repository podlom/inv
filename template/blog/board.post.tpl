{extends 'Blog.post'}
{block 'page.class' append} board_page{/block}
{block 'post.description'}
<ul class="list_attr m_b-10">
    <li>{$post->getShortText()|truncate:200:"  ..."}</li>
</ul>
<div class="place">
    <img src="/i/ukraine.png">{if $post->hasAttr("10")} {$post->printAttr("10")}{/if}
</div>
<div class="price">
{if $post->getParent()->getId() == 15089 || $post->getParent()->getId() == 15090 || $post->getParent()->getId() == 15091}
  <p><span style="font-weight: 700;">ЦЕНА</span> -
  {if $post->getAttr("15")!=''} ${$post->printAttr("15")|number_format:0:'.':' '}{else}Договорная{/if}</p>
{elseif $post->getParent()->getId() == 15088}
  <p><span style="font-weight: 700;">ИНВЕСТИЦИИ</span> -
  {if $post->hasAttr("15")} ${$post->printAttr("15")|number_format:0:'.':' '}{/if}</p>
{elseif $post->getParent()->getId() == 15092}
  <p><span style="font-weight: 700;">ИНВЕСТИЦИИ</span> -
  {if $post->hasAttr("15")} ${$post->printAttr("15")|number_format:0:'.':' '}{/if}</p>
  {/if}
</div>
{/block}