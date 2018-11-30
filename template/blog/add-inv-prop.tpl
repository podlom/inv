<section class="grid-container news_single template_view">
      <div class="grid-x grid-margin-x">
        <div class="cell large-9 medium-12">
          {block 'breadcrumbs'}
    <div class="clearfix border-bottom">
        <h2>{$page->getH1()|truncate:75:" ..."|trim}</h2>
    </div>
{/block}
          <div class="wrapper">
        <div class="row" itemscope itemtype="http://schema.org/articleBody">
            <div class="box-shadow"></div>  
            <div class="columns">
                    {block 'content'}
    <div class="viewbox-cnt-body add-inv-prop-body">
        <div class="box-shadow"></div>
        <img src="i/add-inv-prop-img.png" itemscope itemtype="http://schema.org/ImageObject">
        <table class="add-inv-prop-table">
            <thead>
                <tr>
                    <td></td>
                    <td>Разместить обьявления</td>
                    <td>Комплексный подход</td>
                    <td>Индивидуальный подход</td>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Масштаб</td>
                    <td>Малый бизнес</td>
                    <td>Малый бизнес<br>Средний бизнес</td>
                    <td>Средний бизнес<br>Крупный бизнес</td>
                </tr>
                <tr>
                    <td>Интернет продажи</td>
                    <td><img src="i/check.png"></td>
                    <td><img src="i/check.png"></td>
                    <td><img src="i/check.png"></td>
                </tr>
                <tr>
                    <td>Прямые продажи</td>
                    <td></td>
                    <td></td>
                    <td><img src="i/check.png"></td>
                </tr>
                <tr>
                    <td>Комиссия</td>
                    <td></td>
                    <td><img src="i/check.png"></td>
                    <td><img src="i/check.png"></td>
                </tr>
                <tr>
                    <td>Сопровождение сделки</td>
                    <td></td>
                    <td><img src="i/check.png"></td>
                    <td><img src="i/check.png"></td>
                </tr>
                <tr>
                    <td>Консультационная поддержка</td>
                    <td></td>
                    <td><img src="i/check.png"></td>
                    <td><img src="i/check.png"></td>
                </tr>
                <tr>
                    <td>Индивидуальнальний менеджер</td>
                    <td></td>
                    <td></td>
                    <td><img src="i/check.png"></td>
                </tr>
                <tr>
                    <td>Бюджет</td>
                    <td><img src="i/gold_1.png"></td>
                    <td><img src="i/gold_3.png"></td>
                    <td><img src="i/gold_5.png"></td>
                </tr>
                <tfoot>
                    <td></td>
                    <td><a href="/bulletin/add">Подробнее</a></td>
                    <td><a href="/complex-approach">Подробнее</a></td>
                    <td><a href="http://inventure.ua">Подробнее</a></td>
                </tfoot>
            </tbody>
        </table>
        {content $page}
    </div>
{/block}
                </div>
           </div>
       </div>
   </div>
           <div class="cell large-3 medium-12">
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
                      <div class="img"><img src="/i/form_img.png"></div>
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