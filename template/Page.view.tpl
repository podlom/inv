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

{assign "isFullView" value=($request->getPathInfo() == '/add-inv-prop' || $request->getPathInfo() == '/investor')}

<div itemscope itemtype="http://schema.org/WebPage" class="{block 'page.class'}grid-container {if $request->getPathInfo() == '/investor'||$request->getPathInfo() == '/en/investor'}investor-form{else}the_post{/if}{/block}">

    <div class="grid-x grid-margin-x">
        <div class="{if $isFullView}large-12{else}large-9{/if} medium-12 cell">
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
        {if !$isFullView}
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
                    <div class="newsletter-side">
                      <div class="box-shadow"></div>
                      <img src="/images/newsletter-icon.svg" alt="" class="newsletter-side__img">
                      <div class="newsletter-side__heading">Хотите получать нашу ежемесячную рассылку?</div>
                      <button class="newsletter-side__button open_popup">Подписаться</button>
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


{if !$isFullView}
    <div class="dark_bg"></div>
    <div class="my_popup ">
      {#mod Mail}
          <div class="my_popup__wrapper">
              <h5>Заполните, пожалуйста, ваши контактные данные, чтобы получать ежемесячную рассылку!</h5>
              <i class="fa fa-close"></i>
              {subscribe}
          </div>
      {#/mod}
    </div>
{/if}
