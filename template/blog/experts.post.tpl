{extends 'Blog.post'}
{block 'post.head' prepend}
{$post_head_size = [2,10]}
{/block}

{block 'post.image' append}
<div class="text-center m_t-10">
    <a class="blue_but" data-reveal-id="questionForm" data-expert-id="{$post->getId()}" href="#">Задать вопрос</a>
</div>
{/block}

{block 'content' append}
<div id="questionForm" class="reveal-modal questionFormCenter" data-reveal>
    <h2>Задать вопрос</h2>
    {form callback}
    <a class="close-reveal-modal">&#215;</a>
</div>
{/block}
