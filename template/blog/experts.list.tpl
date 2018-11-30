{extends 'Blog.blog'}
{block 'breadcrumbs'} 
<div class="clearfix">
    <ul class="breadcrumbs-box">
        <li><a href="/tools">Инвестициионный инструментарий</a></li>
        {if $blog}
            {if !$post && !$rubric && !$category}
                <li class="current">{$blog->getTitle()}</li>
            {else}
                <li><a href="{$blog->getPath()}">{$blog->getTitle()}</a></li>
             {/if}
         {/if}
        {if $category}
            {if !$post && !$rubric}
                <li class="current">{$category->getTitle()}</li>
            {else}
                <li><a href="{$category->getPath()}">{$category->getTitle()}</a></li>
            {/if}
        {/if}
        {if $rubric}
            {if !$post}
                <li class="current">{$rubric->getTitle()}</li>
            {else}
                <li><a href="{$rubric->getPath()}">{$rubric->getTitle()}</a></li>
            {/if}
        {/if}
        {if $post}<li class="current">{$post->getH1()|truncate:75:" ..."}</li>{/if}
    </ul>
</div>
{/block}
{block 'filter'}
<div class="search-cnt m_b-15 clearfix">
    {filter fields=[16]}
    <form name="expert-form" method="GET" action="#">
        <div class="large-5 medium-5 columns">
            {$filter->getField('search')->getInput()->setAttr('placeholder', 'Поиск по имени / компании')}
        </div>
        <div class="large-5 medium-5 columns">
            {* дістаем з фільтра поле вводу, змінюємо поведінку з чекбоксів, на селект, додаемо класс *}
            {$s = $filter->getField(16)->getInput()->setAttr('multiple', false)->addClass('field')}
            {* змінюемо вивод, щоб запхати в нього стандартний надпис *}
            {* добавил подтримку атребуту placeholder, после апдейта можно буде це робити так: ->setAttr('placeholder', 'Выберите отрасль') *}
            {$s->open()} {* відкрили select *}
            {foreach $s->getChilds() as $opt} {* прогнали усі опції *}
            {if $opt->getAttr('value')==false}
                {$opt->addChild('Выберите отрасль')} {* дописали в перший option текст *}
            {else}
                {$opt} {* вивели інші опції *}
            {/if}
            {/foreach}
            {$s->close()} {* закрили тег *}
        </div>
        <div class="large-2 medium-2 columns">
            <button class="blue_but m_t-5" type="submit" aria-label="submit form">Искать</button>
        </div>
    </form>
</div>
{/block}
{block 'posts' prepend}
    {$post_size = [2,10]}
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

