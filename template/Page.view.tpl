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
{if !$page}{$page = $post}{/if}
{if !$page}{$page = $category}{/if}
{if !$page}{$page = $rubric}{/if}
{if !$page}{$page = $blog}{/if}
<div class="grid-container {if $request->getPathInfo() == '/investor'||$request->getPathInfo() == '/en/investor'}investor-form{elseif $request->getPathInfo() == '/tools/experts'} {else}search_result news_single investment_single video_single event_single{/if}">
     <div class="grid-x grid-margin-x">
            {block 'page.title'}{/block}
            <div class="large-9 medium-12 cell">
                {block 'breadcrumbs'}
                <div class="clearfix">
                    <ul class="breadcrumbs-box">
                        <li class="current">{$page->getH1()|truncate:75:" ..."|trim}</li>
                    </ul>
                </div>
                {/block}
                {block 'menu'}{/block}
                {block 'filter'}{/block}
                {block 'content'}
                <div class="row" itemscope itemtype="http://schema.org/articleBody">
                    <div class="columns">
                        <div class="viewbox-cnt-body m_b-20" itemprop="text">
                            {content $editable}
                        </div>
                    </div>
                </div>
                {/block}
        </div>
            <div class="cell large-3 medium-12">
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
                        {/if}
                      <div class="box-shadow_form">
                    <div class="box-shadow"></div>

                    {#mod Mail}
                    <div class="form">
                        <div class="title">
                            {if $lang == 'en'}<a href="/en/analytics/digest"> <i class="fa fa-rss"></i>Sign up for Digest</a>


                        {else}
                            <a href="/analytics/digest"> <i class="fa fa-rss"></i>Подписка на дайджест</a>
                        {/if}
                          </div>
                          <div class="img"><img src="/i/digest_img.jpg"></div>
                        {subscribe}
                    </div>
                    {#/mod}
                  </div>
                   <div class="box-shadow_archive">
                    <div class="box-shadow"></div>
                    <div class="archive">
                        <div class="title">
                           {if $lang == 'en'}<a href="/en/analytics/digest"> <img src="/i/download_icon.png" alt="Загрузить" title="Загрузить">Archive</a>


                        {else}
                           <a href="/analytics/digest"> <img src="/i/download_icon.png" alt="Загрузить" title="Загрузить">Архив выпусков</a>
                        {/if}
                          </div>
                        {#mod Digest}
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
                        {#/mod}
                    </div>
                  </div>
                <div class="advertising" id="advertising">
                <div class="box-shadow"></div>
                {#mod Widget}
                {if $page}
                {widget_slot 'main (370x450)' size=[370,450] target=$page->getId()}
                {widget_slot 'post_2 (370x450)' size=[370,450] target=$page->getId()}
                {widget_slot 'post_6 (270x350)' size=[270,350] target=$page->getId()}
                {/if}
                {#/mod}
              </div>
              </aside>
        </div>
     </div>
</div>

