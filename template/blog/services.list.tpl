<section class="grid-container news_list">
      <div class="grid-x grid-margin-x"> 
        <div class="cell small-9">
          {block 'breadcrumbs'}
    <div class="clearfix border-bottom">
        <h2>Инвестиционные услуги</h2>
    </div>
{/block}
    {block 'posts'}
        {foreach $posts as $post}
            {block 'post'}
            <div class="row">
              <div style="position: relative; background-color: white;">
                <div class="box-shadow"></div>
                <div class="auto-height">
                    <div class="medium-{$post_size.0|default:5} columns photo-in {$image_class}">
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
                    <div class="medium-{$post_size.1|default:7} columns">
                        <div class="viewbox-cnt attr-in">
                            <div class="hint m_b-10">
                            {block 'post.meta'}
                                {block 'post.publish'}<time class="time">{$post->getPublished()->format('d.m.y')}</time>{/block}
                                {block 'post.views'}<img src="/i/views.png"/><span class="number">{$post->getViews()+1}</span>{/block}
                            {/block}
                            </div>
                            <h3><a href="{$post->getPath()}">{$post->getH1()}</a></h3>
                            {block 'description'}
                                <ul class="list_attr">
                                    <li>{$post->getShortText()|truncate:200:"  ..."}</li>
                                </ul>
                            {/block}
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
            <ul class="pagination right">
                {foreach $posts->getPagination()->getLinks() as $a}
                    <li class="{$a->getAttr('class')}">{$a->setAttr('class', '')}</li>
                {/foreach}
            </ul>
        </div>
    </div>
    {/block}
        </div>
        <div class="cell small-3">
                        <aside class="sidebar">
                <a href="/investor" class="invest_btn">инвестировать</a>
                <a href="/add-inv-prop" class="invest_btn invest_btn1">найти инвестора</a>
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
                           <a href="/analytics/digest"> <img src="/i/download_icon.png" alt="Загрузить" title="Загрузить">
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
