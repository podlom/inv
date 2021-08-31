{extends 'Blog.blog'}
{block 'breadcrumbs'}{/block}
{block 'content'}
<div class="m_b-20">
    <h2><a href="/tools/investors">Инвесторы</a></h2>   
    <div class="viewbox grid-x grid-margin-x ">
        {$atlas=[]}
        {lent '/tools/investors' 4 var='atlases'}
        {$atlas[]=$atlases}
        <div class="large-3 medium-3 cell">
            <a href="{$atlases->getPath()}">
                <img class="img-center m_b-10" src="/img/thumbup.310.225{if $atlases->getImage()->getUrl()}{$atlases->getImage()->getUrl()}{else}/images/noThumb.jpg{/if}" alt='{$atlases->getTitle()}' />
            </a>
            <h3><a href="{$atlases->getPath()}">{$atlases->getTitle()}</a></h3>
            <div class="hint">
                <div class="m_b-5">{$atlases->printAttr("46")}</div>
                <div class="m_b-5">{$atlases->printAttr("52")}</div>
                <div class="m_b-5">{$atlases->printAttr("53")}</div>
                {if $atlases->printAttr("51")}{$atlases->printAttr("51")}{/if}
            </div>
        </div>
        {/lent}
    </div>
</div>
<div class="grid-x grid-margin-x m_b-20">
    <div class="large-6 medium-6 cell m_b-20">
        <h2><a href="tools/database">База данных</a></h2>
        <div class="viewbox">
            {lent  '/tools' 5 var='db' category="23" analytics=1}
                <div class="media">
                    <span class="media-left"><a href="{$db->getPath()}"><img class="icon16 news" src="/i/-.gif" alt="" /></a></span>
                    <span class="media-body"><a href="{$db->getPath()}">{$db->getTitle()}</a></span>
                </div>
            {/lent}
        </div>
    </div>
    <div class="large-6 medium-6 cell m_b-20">
        <h2><a href="tools/library">Библиотека</a></h2>
        <div class="viewbox">
            {$library=[]}
            {lent '/tools/library' 5 var='libraries'}
            {$library[]=$libraries}
                <div class="media">
                    <span class="media-left"><a href="{$libraries->getPath()}"><img class="icon16 file" src="/i/-.gif" alt="" /></a></span>
                    <span class="media-body"><a href="{$libraries->getPath()}">{$libraries->getTitle()}</a></span>
                </div>
            {/lent}
        </div>
    </div>
</div>
{/block}
