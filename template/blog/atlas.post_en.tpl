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
    <section class="grid-container investment_single atlas_single">
      <div class="grid-x grid-margin-x">
        <div class="cell large-9 medium-12">
          {block 'breadcrumbs'}
    <div class="clearfix border-bottom">
        <h2>Investors</h2>
    </div>
            <ul class="breadcrumbs-box">
        {if $blog}
            {if !$post && !$rubric && !$category}
                <li class="current">{$blog->getTitle()}</li>
            {else}
                <li class="current"><a href="{$blog->getPath()}">{$blog->getTitle()}</a></li>
            {/if}
        {/if}
        {if $category}
            {if !$post && !$rubric}
                <li class="current">{$category->getTitle()}</li>
            {else}
                <li class="current"><a href="{$category->getPath()}">{$category->getTitle()}</a></li>
            {/if}
        {/if}
        </ul>
{/block}
    {block 'content'}
    {block 'post.head'}
    <div style="position: relative;">
    <div class="box-shadow"></div>
    <div class="row m_b-20 auto-height">
        <div class="medium-{$post_head_size.0|default:4} columns photo-in">
        {block 'post.image'}
            <div id="newsThumb">
                <a href="#" data-reveal-id="thumbBig">
                    {$post->getImage()->thumbup(350,254)}
                </a>
            </div>
            <div id="thumbBig" class="reveal-modal large medium" data-reveal>
                <img itemprop="image" itemscope itemtype="http://schema.org/ImageObject" src="{$post->getImage()->getUrl()}" alt='{$post->getTitle()}' />
                <p><b>{$post->getTitle()}</b></p>
                <a class="close-reveal-modal">&#215;</a>
            </div>
        {/block}
        </div>
        <div class="medium-{$post_head_size.1|default:8} columns">
            <div class="viewbox-cnt attr-in">
                            <div class="hint m_b-10">
                            {block 'post.meta'}
                                {block 'post.views'}<img src="/i/views.png" /><span class="number">{$post->getViews()+1}</span>{/block}
                            {/block}
                            </div>
                            <div class="author">{block 'post.author'}
                                    {if $post->getAttr(1)}<img src="/i/pers.png" alt="" />
                                        {if $post->getAttr(2)}
                                            <a href="{$post->getAttr(2)}">{$post->getAttr(1)}</a>
                                        {else}
                                            {$post->getAttr(1)}
                                        {/if}
                                    {/if}
                                {/block}</div>
                            <h3>{$post->getH1()}</h3>
                            {block 'description'}
                                <ul class="list_attr">
                                    <li>{$post->getShortText()|truncate:200:"  ..."}</li>
                                </ul>
                            {/block}
                            <div class="row">
                                <div class="columns">
                                    <ul class="inline-list share-btn share-btn_atlas_post">
                                        <li><span class='st_facebook_hcount' displayText='Facebook'></span></li>
                                        <li><span class='st_twitter_hcount' displayText='Tweet'></span></li>
                                        <li><span class='st_linkedin_hcount' displayText='LinkedIn'></span></li>
                                        <li><span class='st_googleplus_hcount' displayText='Google +'></span></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
        </div>
    </div>
</div>
    {/block}
    <div style="position: relative; margin-bottom: 24px;">
        <div class="box-shadow"></div>
        <div class="tabs">
          <ul class="tabs__caption">
            <li class="active">Сharacteristic</li>
            <li>Investment</li>
            <li>Management</li>
            <li>Contacts</li>
          </ul>

          <div class="tabs__content  active" id="panel1">
            {if $post->printAttr(46)}<p><b>Investor profile:</b> {$post->printAttr(46)}</p>{/if}
            {if $post->printAttr(52)}<p><b>Investment amount:</b> {$post->printAttr(52)}</p>{/if}
            {if $post->printAttr(53)}<p><b>Investment stage:</b> {$post->printAttr(53)}</p>{/if}
            {if $post->printAttr(59)}<p><b>Region:</b> {$post->printAttr(59)}</p>{/if}
            {if $post->printAttr(51)}<p><b>Sector:</b> {$post->printAttr(51)}</p>{/if}
          </div>
          <div class="tabs__content" id="panel2">

          </div>
          <div class="tabs__content" id="panel3">
            <div class="contacts contacts1">
                    {if $post->getAttr(5) && $post->getAttr(45)}
                        <div class="avatar"><img src="/i/no-photo.png" alt=""></div>
                        <div class="data_contacts">
                        <p><b>Name:</b> {$post->getAttr(5)}</p>
                        <p><b>Position:</b> {$post->getAttr(45)}</p>
                        </div>
                    {/if}
                </div>
          </div>
          <div class="tabs__content" id="panel4">
            {if $post->printAttr(10)}<p><b>Address:</b> {$post->printAttr(10)}</p>{/if}
            {if $post->printAttr(3)}<p><b>Tel:</b> {$post->printAttr(3)}</p>{/if}
            {if $post->printAttr(4)}<p><b>Email:</b> <a href="mailto:{$post->getAttr(4)}">{$post->printAttr(4)}</a></p>{/if}
            {if $post->printAttr(2)}<p><b>Web:</b> <a href="{$post->printAttr(2)}">{$post->printAttr(2)}</a></p>{/if}
          </div>
        </div>
                   <div class="owl-carousel owl-theme">
        <div class="item characteristic">
            <div class="title">
                Сharacteristic
            </div>
             <div class="content">{if $post->printAttr(46)}<p><b>Investor profile:</b> {$post->printAttr(46)}</p>{/if}
            {if $post->printAttr(52)}<p><b>Investment amount:</b> {$post->printAttr(52)}</p>{/if}
            {if $post->printAttr(53)}<p><b>Investment stage:</b> {$post->printAttr(53)}</p>{/if}
            {if $post->printAttr(59)}<p><b>Region:</b> {$post->printAttr(59)}</p>{/if}
            {if $post->printAttr(51)}<p><b>Sector:</b> {$post->printAttr(51)}</p>{/if}</div>
        </div>
        <div class="item gallery">
            <div class="title">
                Investment
            </div>
        </div>
        <div class="item location">
            <div class="title">
                Management
            </div>
            <div class="content">
                            {if $post->printAttr(10)}<p><b>Address:</b> {$post->printAttr(10)}</p>{/if}
            {if $post->printAttr(3)}<p><b>Tel:</b> {$post->printAttr(3)}</p>{/if}
            {if $post->printAttr(4)}<p><b>Email:</b> <a href="mailto:{$post->getAttr(4)}">{$post->printAttr(4)}</a></p>{/if}
            {if $post->printAttr(2)}<p><b>Web:</b> <a href="{$post->printAttr(2)}">{$post->printAttr(2)}</a></p>{/if}
            </div>


        </div>
        <div class="item contacts">
            <div class="title">
                Contacts
            </div>
            <div class="contacts contacts1">
                    {if $post->getAttr(5) && $post->getAttr(45)}
                        <div class="avatar"><img src="/i/no-photo.png" alt=""></div>
                        <div class="data_contacts">
                        <p><b>Name:</b> {$post->getAttr(5)}</p>
                        <p><b>Poisition:</b> {$post->getAttr(45)}</p>
                        </div>
                    {/if}
                </div>
        </div>
    </div>
    </div>
          <div class="wrapper" id="wrapper2">
        <div class="row" itemscope itemtype="http://schema.org/articleBody">
           <div class="box-shadow"></div>
            <div class="columns">
                <div class="viewbox-cnt-body m_b-20" itemprop="text" id="content_body">
                    {block 'post.content'}
                        {content $post}
                    {/block}
                </div>
            </div>
        </div>
    </div>
    <div class="columns" id="newsComments">
        <h2>Comments</h2>
        {include 'inc/disqus'}
    </div>
{/block}
           </div>
           <div class="cell large-3 medium-12">
          <aside class="sidebar">
            <a href="/en/investor" class="invest_btn">invest</a>
            <a href="/en/add-inv-prop" class="invest_btn invest_btn1">find an investor</a>
                  <div class="box-shadow_form">
                <div class="box-shadow"></div>
                <div class="form">
                    <div class="title">
                         <a href="/en/analytics/digest"> <i class="fa fa-rss"></i>
                        Sign up for Digest</a>
                      </div>
                      <div class="img"><img src="/i/digest_img.jpg"></div>
                    {subscribe}
                </div>
              </div>
              <div class="box-shadow_archive">
                    <div class="box-shadow"></div>
                    <div class="archive">
                        <div class="title">
                            <a href="/en/analytics/digest"> <img src="/i/download_icon.png" alt="Загрузить" title="Загрузить">
                            Archive</a>
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
                                    {foreach ["January","February", "March","April", "May", "June", "July", "August", "September", "October", "November", "December"] as $id => $name}
                                        <option value="{$id+1}"{if $digest->getPubDate()->format('n')==$id+1} selected{/if} label="{$name}">{$name}</option>
                                    {/foreach}
                                </select>
                            </div>
                                <a class="blue_but cell-but"  target="_blank" id="archiveFormButton" href="#" disabled="disabled">Download</a>
                        </form>
                    </div>
                  </div>
          <div class="advertising" id="advertising">
                <div class="box-shadow"></div>
                {widget_slot 'main (370x450)' size=[370,450]}
                {widget_slot 'post_2 (370x450)' size=[370,450]}
                {widget_slot 'post_6 (270x350)' size=[270,350]}
              </div>
                                {block 'seo'}
{if count($post->getContentParts('seo'))}
<div class="row">
    <div class="columns">
        <div class="seo-box">
            <div class="large-3 medium-3 columns">
                {content $post 'seo' tag="h2" new=1}
            </div>
            <div class="large-9 medium-9 columns text">
                {content $post 'seo_text' new=1}
            </div>
        </div>
    </div>
</div>
{/if}
{/block}
              </aside>
        </div>
          </div>
         </section>