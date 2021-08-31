<a href="{$post->getPath()}" class="horizontal-cards__block">
    <div class="horizontal-cards__logo">
        {block 'image'}
            {if substr($post->getPath(),0,14) == "/tools/video"}
                <div>{$post->getAttr(55)}</div>
            {elseif $post->getImage()}
                {if $parent != 'post'}
                    {$post->getImage()->thumb(350,254)->addClass('horizontal-cards__logo-icon')->setAttr('itemprop','image')}
                {else}
                    {css "https://cdn.jsdelivr.net/gh/fancyapps/fancybox@3.5.6/dist/jquery.fancybox.min.css"}
                    {script name="fancybox" src="https://cdn.jsdelivr.net/gh/fancyapps/fancybox@3.5.6/dist/jquery.fancybox.min.js" require=['jquery']}
                    <a href="{$post->getImage()->getUrl()}" data-fancybox>
                        {$post->getImage()->thumbup(350,254)->addClass('horizontal-cards__logo-icon')->setAttr('itemprop','image')}
                    </a>
                {/if}
                {else}
                    <img class="horizontal-cards__logo-icon" src="/img/resize.375.225/images/noThumb.jpg" alt="{$post->getH1()}"/>
            {/if}
        {/block}
    </div>
    <div class="horizontal-cards__info">
        {block 'post.title'}<h2 class="horizontal-cards__name" itemprop="headline">{$post->getH1()}</h2>{/block}
        {block 'post.description'}
            <div itemprop="description" class="the_shorttext">{$post->getShortText()|truncate:200:"  ..."}</div>
        {/block}
    </div>
    {block 'post.meta'}

        {if !is_null($post->getParent()) && ( $post->getParent()->getId() == 7862 || $post->getParent()->getId() == 7864 || $post->getParent()->getId() == 19303 || $post->getParent()->getId() == 7861 || $post->getParent()->getId() == 7863 || $post->getParent()->getId() == 7860 || $post->getParent()->getId() == 15089 || $post->getParent()->getId() == 15091 || $post->getParent()->getId() == 15092 || $post->getParent()->getId() == 15090 || $post->getParent()->getId() == 15088 )}
            {block 'post.id-num'}
                <div class="id-number"><strong style="margin: 0 5px 0 0">ID:</strong> {$post->getId()}</div>
            {/block}
        {/if}

        <!-- @ts template/partial/post.tpl +43 -->

        {block 'post.reviews'}{/block}

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
    {block 'post.meta.schema'}
        <div itemprop="publisher" itemscope itemtype="http://schema.org/Organization">
            <meta itemprop="url" content="https://inventure.ua/">
            <meta itemprop="name" content="Inventure">
            <div itemprop="logo" itemscope itemtype="http://schema.org/ImageObject">
                <meta itemprop="url" content="https://inventure.com.ua/i/logo_header.png">
            </div>
        </div>
        <meta itemprop="dateModified" content="{$post->getUpdated()->format('c')}">
    {/block}
</a>