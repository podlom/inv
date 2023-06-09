{extends 'blog/analytics.list'}
{block 'page.class' append} atlas_list{/block}
{block 'config' append}
{capture assign='filters'}
    <div class="filter m_b-15" >
        {filter fields=[60,16,53,46]} {*investments,kved,stage,type *}
        <form name="atlas-form" method="get" action="">
            <h3><i class="fa fa-search"></i>Поиск инвестора</h3>
            <div class="p8">
                <div>
                    {$filter->getField('search')->getInput()->setAttr('placeholder', "Поиск по названию")}
                </div>
                <div>
                    <label class="label-click1 label-input">Отрасли инвестирования<span class="open icon"></span><span class="close icon">&#215;</span></label>
                    <div class="tged1 hide otr-inv">
                        {$filter->getField(16)->getInput()}
                    </div>
                </div>
                <div>
                    <label class="otr-invtitle label-click2 label-input">Стадии инвестирования<span class="open icon"></span><span class="close icon">&#215;</span></label>
                    <div class="otr-inv tged2 hide">
                        {$filter->getField(53)->getInput()}
                    </div>
                </div>
                <div>
                <label class="otr-invtitle label-click3 label-input">Тип инвестора <span class="open icon"></span><span class="close icon">&#215;</span></label>
                    <div class="otr-inv tged3 hide">
                        {$filter->getField(46)->getInput()}
                    </div>
                </div>
               <div>
                    <label class="label-click6 label-input">Размер инвестиций<span class="open icon"></span><span class="close icon">&#215;</span></label>
                    <div class="tged6 otr-inv">{$filter->getField(60)->getInput()->setAttr('placeholder', "Размер инвестиций")}</div>
                </div>
                <div>
                    <center><button class="blue_but" type="submit" aria-label="submit form">Искать</button></center>
                </div>
            </div>
        </form>
    </div>
{/capture}
{/block}
{block 'breadcrumbs'}
<div style="position: relative;" class="tablet_atlas_filter">
    <div class="box-shadow1"></div>
    {$filters}
</div>
{/block}
{block 'aside.top' append}
    {if $request->getPathInfo() == '/' }
        <div style="position: relative;" class="atlas_filter">
            <div class="box-shadow1"></div>
            {$filters}
        </div>
    {/if}
{/block}
{block 'post.description'}
<ul class="list_attr">
    {if $post->printAttr(46)}<li><b>Тип инвестора:</b> {$post->printAttr(46)}</li>{/if}
    {if $post->printAttr(52)}<li><b>Размер инвестицй:</b> {$post->printAttr(52)}</li>{/if}
    {if $post->printAttr(53)}<li><b>Стадии инвестирования:</b> {$post->printAttr(53)}</li>{/if}
</ul>
{/block}