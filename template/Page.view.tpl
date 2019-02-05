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
{block 'config'}{/block}
<div itemscope itemtype="http://schema.org/WebPage" class="{block 'page.class'}grid-container {if $request->getPathInfo() == '/investor'||$request->getPathInfo() == '/en/investor'}investor-form{else}the_post{/if}{/block}">

    <div class="grid-x grid-margin-x">
        <div class="{if $request->getPathInfo() == '/add-inv-prop'}large-12{else}large-9{/if} medium-12 cell">
            {block 'page.title'}
            <div class="clearfix border-bottom">
                {content $editable part="title" tag="h2" attrs=['itemprop'=>'headline']}
            </div>
            {/block}
            {block 'breadcrumbs'}
            <div class="clearfix">
                <ul class="breadcrumbs-box">
                    <li><a href="/">{site_name()}</a></li>
                    <li class="current">{$page->getH1()|truncate:75:" ..."|trim}</li>
                </ul>
            </div>
            {/block}
            {block 'menu'}{/block}
            {block 'filter'}{/block}
            {block 'content'}
            <div class="wrapper" itemprop="mainEntity" {block 'page.scope'}itemtype="http://schema.org/CreativeWork"{/block} itemscope>
                <div class="box-shadow"></div>
                <div class="viewbox-cnt-body m_b-20">
                    {block 'content.text'}
                    {content $editable attr=['class'=>'the_post_content', 'itemprop'=>'text']}
                    {/block}
                </div>
            </div>
            {/block}
        </div>
        {if $request->getPathInfo() != '/add-inv-prop'}
            <div class="cell large-3 medium-12">
                {block 'aside.top'}
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
                {/block}
                {block 'aside.subscribe'}
                    <div class="box-shadow_form">
                        <div class="box-shadow"></div>
                        {#mod Mail}
                        <div class="form">
                            <div class="title">
                                {if $lang == 'en'}<a href="/en/analytics/digest"> <i class="fa fa-rss"></i>Sign up for Digest</a>
                            {else}
                                <a href="/analytics/digest"> <i class="fa fa-rss"></i>Инвестиционный дайджест</a>
                            {/if}
                              </div>
                              <div class="img"><img src="/i/digest_img.jpg"></div>
                            {subscribe}
                        </div>
                        {#/mod}
                    </div>
                {/block}
                {block 'aside.digest'}
                    <div class="box-shadow_archive">
                        <div class="box-shadow"></div>
                        <div class="archive">
                            <div class="title">
                            {if $lang == 'en'}
                                <a href="/en/analytics/digest"> <img src="/i/download_icon.png" alt="Загрузить" title="Загрузить">Archive</a>
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
                {/block}
                {block 'aside.banner'}
                    <div class="advertising" id="advertising">
                        <div class="box-shadow"></div>
                        {#mod Widget}
                        {widget_slot 'main (370x450)' size=[370,450]}
                        {widget_slot 'post_2 (370x450)' size=[370,450]}
                        {widget_slot 'post_6 (270x350)' size=[370,450]}
                        {#/mod}
                    </div>
                {/block}
                </aside>
            </div>
        {/if}
    </div>
</div>

