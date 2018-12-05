{extends 'blog/analytics.list'}{* ANALYTICS TEMPLATE! *}
{block 'page.class' append} experts{/block}
{block 'config'}
{$post_size = [2,10]}
{/block}
{block 'breadcrumbs!NO' append}
<div style="position: relative;">
    <div class="box-shadow1"></div>
    <div class="the_filter m_b-15 clearfix">
        {filter fields=[16]}
        <form name="expert-form" method="GET" action="#">
            <div class="large-5 medium-5 columns">
                {$filter->getField('search')->getInput()->setAttr('placeholder', 'Поиск по имени / компании')}
            </div>
            <div class="large-5 medium-5 columns">
                {$filter->getField(16)->getInput()->setAttr('multiple', false)->addClass('field')->setAttr('placeholder', 'Выберите отрасль')}
            </div>
            <div class="large-2 medium-2 columns">
                <button class="blue_but m_t-5" type="submit" aria-label="submit form">Искать</button>
            </div>
        </form>
    </div>
</div>
{/block}
{block 'image'}
    {$post->getImage()->thumbup(180,200)}
    <div class="text-center m_t-10">
        <a class="blue_but" data-reveal-id="questionForm" data-expert-id="{$post->getId()}" href="#">Задать вопрос</a>
    </div>
{/block}
{block 'post.meta'}{/block}
{block 'post.rubric'}{/block}
{block 'description'}
<ul class="list_attr">
    {if $post->hasAttr("44")}<li><b>Компания:</b> {$post->getAttr("44")}</li>{/if}
    {if $post->hasAttr("45")}<li><b>Должность:</b> {$post->getAttr("45")}</li>{/if}
    {if $post->hasAttr("16")}<li><b>Сфера деятельности:</b> {$post->printAttr("16")}</li>{/if}
    {if $post->getAttr("47")}<li><b>Работа в других компаниях:</b> {$post->getAttr("47")}</li>{/if}
</ul>
{/block}

