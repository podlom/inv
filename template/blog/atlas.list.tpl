    {script src="https://ws.sharethis.com/button/buttons.js" name="share_button"}
{script_code require="share_button"}
    stLight.options({
        publisher: "4251639a-288c-4b8a-a294-b65b62a0c7e1",
        doNotHash: false,
        doNotCopy: false,
        hashAddressBar: false,
        popup:true,
        servicePopup: true
    });
{/script_code}
    <section class="grid-container news_list atlas_list">
      <div class="grid-x grid-margin-x"> 
        <div class="cell large-9 medium-12">
          {block 'breadcrumbs'}
    <div class="clearfix border-bottom">
        <h2>Инвесторы</h2>
    </div>
    <nav>
              <a href="/analytics/investments">Исследования</a> |
              <a href="/analytics/articles">Статьи</a> |
              <a href="/analytics/formula">Интервью</a> |
              <a href="">Инвестируем в Украину</a> |
              <a href="/tools/database">Рейтинги</a> |
              <a href="/tools/library">Библиотека</a> |
              <a href="/tools/investors">Инвесторы</a>
          </nav>
            <div class="mobile_category">
              <a href="/analytics/investments">Исследования</a><i class="fa fa-chevron-right"></i><i class="fa fa-chevron-down"></i>
              <ul>
                  <li><a href="/analytics/articles">Статьи</a></li>
                  <li><a href="/analytics/formula">Интервью</a></li>
                  <li><a href="/analytics/we-invest-in-ukraine">Инвестируем в Украину</a></li>
                  <li><a href="/tools/database">Рейтинги</a></li>
                  <li><a href="/tools/library">Библиотека</a></li>
                  <li><a href="/tools/investors">Инвесторы</a></li>
              </ul>
          </div>
    <div style="position: relative;" class="tablet_atlas_filter">
    <div class="box-shadow1"></div>
<div class="filter m_b-15" >
    {filter fields=[60,16,53,46]} {*investments,kved,stage,type *}
    <form name="atlas-form" method="get" action="">
        <h3><i class="fa fa-search"></i>Поиск инвестора</h3>
        <div class="row">
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
            <div class="columns">
                <center><button class="blue_but" type="submit" aria-label="submit form">Искать</button></center>
            </div>
        </div>
    </form>
</div>

</div>
{/block}
    {block 'posts'}
        {foreach $posts as $post}
            {block 'post'}
            <div class="row">
              <div style="position: relative; background-color: white;">
                <div class="box-shadow"></div>
                <div class="auto-height">
                    <div class="medium-{$post_size.0|default:4} columns photo-in {$image_class}">
                        {block 'image'}
                        {if $post->getImage()}
                            <a href="{$post->getPath()}">
                                {$post->getImage()->thumbup(350,254)}
                            </a>
                        {elseif substr($post->getPath(),0,14) == "/tools/video"}
                            <div>{$post->getAttr(55)}</div>
                        {else}
                            <a href="{$post->getPath()}">
                                <img src="/img/resize.375.225/images/noThumb.jpg" alt="{$post->getH1()}" itemscope itemtype="http://schema.org/ImageObject"/>
                            </a>
                        {/if}
                        {/block}
                    </div>
                    <div class="medium-{$post_size.1|default:8} columns">
                        <div class="viewbox-cnt attr-in">
                            <div class="hint m_b-10">
                            {block 'post.meta'}
                                {block 'post.publish'}<time class="time">{$post->getPublished()->format('d.m.y')}</time>{/block}
                                {block 'post.views'}<img src="/i/views.png"/><span class="number">{$post->getViews()+1}</span>{/block}
                            {/block}
                            </div>
                            <h3><a href="{$post->getPath()}">{$post->getH1()}</a></h3>
                            <ul class="list_attr">
                                {if $post->printAttr(46)}<li><b>Тип инвестора:</b> {$post->printAttr(46)}</li>{/if}
                                {if $post->printAttr(52)}<li><b>Размер инвестицй:</b> {$post->printAttr(52)}</li>{/if}
                                {if $post->printAttr(53)}<li><b>Стадии инвестирования:</b> {$post->printAttr(53)}</li>{/if}
                            </ul>
                        </div>
                    </div>
                </div>
               </div>
            </div>
            {/block}
        {/foreach}
    {/block}
    {block 'pagination'}
    <div class="row">
        <div class="columns">
            <ul class="pagination">
                {foreach $posts->getPagination()->getLinks() as $a}
                    <li class="{$a->getAttr('class')}">{$a->setAttr('class', '')}</li>
                {/foreach}
            </ul>
        </div>
    </div>
    {/block}
        </div>
        <div class="cell large-3 medium-12">
          <aside class="sidebar">
            <a href="/investor" class="invest_btn">инвестировать</a>
            <a href="/add-inv-prop" class="invest_btn invest_btn1">найти инвестора</a>
{block 'filter'}
<div style="position: relative;" class="atlas_filter">
    <div class="box-shadow1"></div>
<div class="filter m_b-15" >
    {filter fields=[10,60,16,53,46]} {* address,investments,kved,stage,type *}
    <form name="atlas-form" method="get" action="">
        <h3><i class="fa fa-search"></i>Поиск инвестора</h3>
        <div class="row">
            <div>
                {$filter->getField('search')->getInput()->setAttr('placeholder', "Поиск по названию")}
            </div>
            <!--<div>
                {$filter->getField(10)->getInput()->setAttr('placeholder', "Регион")}
            </div>-->
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
            <div class="columns">
                <center><button class="blue_but" type="submit" aria-label="submit form">Искать</button></center>
            </div>
        </div>
    </form>
</div>

</div>
{/block}
                  <div class="box-shadow_form">
                <div class="box-shadow"></div>
                <div class="form">
                    <div class="title">
                        <a href="/analytics/digest"> <i class="fa fa-rss"></i>
                        Подписка на дайджест </a>
                      </div>
                      <div class="img"><img src="/i/digest_img.jpg"></div>
                    {subscribe}
                </div>
              </div>
                  <div class="box-shadow_archive">
                    <div class="box-shadow"></div>
                    <div class="archive">
                        <div class="title">
                            <a href="/analytics/digest"><img src="/i/download_icon.png" alt="Загрузить" title="Загрузить">
                            Архив выпусков</a>
                          </div>
                        <form name="archiveForm" method="post" action="#">
                            <div class="d_n" id="digest">
                                {load_digests}
                                {foreach $digests as $digest}
                                    <a class="m{$digest->getPubDate()->format('n')} y{$digest->getPubDate()->format('Y')}" href="{$digest->getUrl()}"></a>
                                {/foreach}
                            </div>
                            <div class="option">
                                <select name="archiveFormYear" id="archiveFormYear" class="select1">
                                    {$now = date_create()}
                                    {for $year=2012 to $now->format('Y')}
                                        <option value="{$year}" label="{$year}"{if $digest->getPubDate()->format('Y')==$year} selected{/if}>{$year}</option>
                                    {/for}
                                </select>
                                <select name="archiveFormMonths" id="archiveFormMonths" class="select2">
                                    {foreach ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'] as $id => $name}
                                        <option value="{$id+1}"{if $digest->getPubDate()->format('n')==$id+1} selected{/if} label="{$name}">{$name}</option>
                                    {/foreach}
                                </select>
                            </div>
                                <a class="blue_but cell-but"  target="_blank" id="archiveFormButton" href="#" disabled="disabled">Скачать</a>
                        </form>
                    </div>
                  </div>
           <div class="advertising" id="advertising">
                  <div class="box-shadow"></div>
                  {widget_slot 'main (370x450)' size=[370,450]}
                {widget_slot 'post_2 (370x450)' size=[370,450]}
                {widget_slot 'post_6 (270x350)' size=[270,350]}
                </div>
          </aside>
        </div>
      </div>
    </section>
