<section class="grid-container news_single template_view">
      <div class="grid-x grid-margin-x">
        <div class="cell medium-12 large-9">
          {block 'breadcrumbs'}
    <div class="clearfix border-bottom">
        <h2>{$page->getH1()|truncate:75:" ..."|trim}</h2>
    </div>
{/block}
          <div class="wrapper">
        <div class="row" itemscope itemtype="http://schema.org/articleBody">
            <div class="box-shadow"></div>  
            <div class="columns">
                <div class="viewbox-cnt-body m_b-20" itemprop="text" {if $request->getPathInfo() == '/about/contacts' || $request->getPathInfo() == '/en/about/contacts'}itemscope itemtype="http://schema.org/Organization"{/if}>
                    {block 'post.content'} 
                        {content $page}
                    {/block}
                </div>
                </div>
           </div>
       </div>
   </div>
           <div class="cell medium-12 large-3">
<aside class="sidebar">
                {if $lang == 'en'}
                            <a href="/en/investor" class="invest_btn">invest</a>
                        {else}
                            <a href="/investor" class="invest_btn">инвестировать</a>
                        {/if}
                {if $lang == 'en'}
                            <a href="/en/add-inv-prop" class="invest_btn invest_btn1">find an investor</a>
                        {else}
                            <a href="/add-inv-prop" class="invest_btn invest_btn1">найти инвестора</a>
                        {/if}</a>
                      <div class="box-shadow_form">
                    <div class="box-shadow"></div>
                    <div class="form">
                        <div class="title">
                            {if $lang == 'en'}<a href="/en/analytics/digest"> <i class="fa fa-rss"></i>Sign up for Digest</a>
                        
                            
                        {else}
                            <a href="/analytics/digest"> <i class="fa fa-rss"></i>Подписка на дайджест</a>
                        {/if}
                         </a>
                          </div>
                          <div class="img"><img src="/i/digest_img.jpg"></div>
                        {subscribe}
                    </div>
                  </div>
                   <div class="box-shadow_archive">
                    <div class="box-shadow"></div>
                    <div class="archive">
                        <div class="title">
                           {if $lang == 'en'}<a href="/en/analytics/digest"> <img src="/i/download_icon.png" alt="Загрузить" title="Загрузить">Archive</a>
                           
                            
                        {else}
                           <a href="/analytics/digest"> <img src="/i/download_icon.png" alt="Загрузить" title="Загрузить">Архив выпусков</a>
                        {/if}</a>
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
                                  {if $lang == 'en'}
                                     {foreach ["January","February", "March","April", "May", "June", "July", "August", "September", "October", "November", "December"] as $id => $name}
                                        <option value="{$id+1}"{if $digest->getPubDate()->format('n')==$id+1} selected{/if} label="{$name}">{$name}</option>
                                    {/foreach}
                                  {else}
                                      {foreach ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'] as $id => $name}
                                        <option value="{$id+1}"{if $digest->getPubDate()->format('n')==$id+1} selected{/if} label="{$name}">{$name}</option>
                                    {/foreach}
                                  {/if}
                                    
                                </select>
                            </div>
                                <a class="blue_but cell-but"  target="_blank" id="archiveFormButton" href="#" disabled="disabled">{if $lang == 'en'}
                            Download
                        {else}
                            Скачать
                        {/if}</a>
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