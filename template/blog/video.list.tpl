{extends 'blog/analytics.list'}
{block 'config' append}
    {$posts->setCount(10)}
{/block}
{block 'image'}
<img src="//img.youtube.com/vi/{$post->printAttr('55')}/mqdefault.jpg" class="cards__img" itemscope itemtype="http://schema.org/ImageObject">
{/block}