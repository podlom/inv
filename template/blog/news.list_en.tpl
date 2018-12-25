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
    <section class="grid-container news_list">
      <div class="grid-x grid-margin-x">
        <div class="cell large-9 medium-12">
          {block 'breadcrumbs'}
    <div class="clearfix border-bottom">
        <h2>News</h2>
    </div>
{/block}
          <nav>
              <span {if $rubric && $rubric->getSubpath()=='investments'}class="active"{/if}><a href="{$blog->getPath()}{if $category}/{$category->getSubpath()}{/if}/investments">Private Equity & M&A</a></span> |
            <span {if $rubric && $rubric->getSubpath()=='startup'}class="active"{/if}><a href="{$blog->getPath()}{if $category}/{$category->getSubpath()}{/if}/startup">Venture Capital & Startups</a></span> |
            <span {if $rubric && $rubric->getSubpath()=='government'}class="active"{/if}><a href="{$blog->getPath()}{if $category}/{$category->getSubpath()}{/if}/government">Macroeconomics</a></span> |
            <span {if $rubric && $rubric->getSubpath()=='banking'}class="active"{/if}><a href="{$blog->getPath()}{if $category}/{$category->getSubpath()}{/if}/banking">Banking</a></span> |
            <span {if $rubric && $rubric->getSubpath()=='stock'}class="active"{/if}><a href="{$blog->getPath()}{if $category}/{$category->getSubpath()}{/if}/stock">IPO</a></span> |
            <span {if $rubric && $rubric->getSubpath()=='realestate'}class="active"{/if}><a href="{$blog->getPath()}{if $category}/{$category->getSubpath()}{/if}/realestate">Commercial Property</a></span>
          </nav>
          <div class="mobile_category">
              <a href="/en/news/investments">Private equity and M&amp;A</a><i class="fa fa-chevron-right"></i><i class="fa fa-chevron-down"></i>
              <ul>
                  <li><a href="/en/news/startup">Venture capital&amp; startups</a></li>
                  <li><a href="/en/news/government">Goverment finance</a></li>
                  <li><a href="/en/news/banking">Banking</a></li>
                  <li><a href="/en/news/stock">Stock market &amp; IPO</a></li>
                  <li><a href="/en/news/realestate">Commercial property</a> </li>
              </ul>
          </div>
          <div class="content_nav1 nav-top clearfix">
            <ul>
                <li class="{if $category && $category->getSubpath() =='ukraine'}not_active{elseif $category && $category->getSubpath() =='world'}not_active{else}active{/if}"><a href="/en/news">Latest</a><li>
                <li class="{if $category && $category->getSubpath() =='ukraine'}active{/if}"><a href="/en/news/ukraine{if $rubric}/{$rubric->getSubpath()}{/if}">Ukraine</a><li>
                <li class="{if $category && $category->getSubpath() =='world'}active{/if}"><a href="/en/news/world{if $rubric}/{$rubric->getSubpath()}{/if}">World</a><li>
            </ul>
            </div>
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
                                {block 'post.rubric'}
                                {$r=$post->getRubrics()}
                                {if $r.0}
                                    <img src="/i/folded-newspaper.png" alt="" />{$r.0->getH1()}
                                {/if}
                                {/block}
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
                            <h3><a href="{$post->getPath()}">{$post->getH1()}</a></h3>
                            {block 'description'}
                                <ul class="list_attr">
                                    <li>{$post->getShortText()|truncate:200:"  ..."}</li>
                                </ul>
                            {/block}
                            <div class="row">
                                <div class="columns">
                                    <ul class="inline-list share-btn">
                                        <li><span class='st_facebook_hcount' st_url="https://inventure.com.ua{$post->getPath()}" displayText='Facebook'></span></li>
                                        <li><span class='st_twitter_hcount' st_url="https://inventure.com.ua{$post->getPath()}" displayText='Tweet'></span></li>
                                        <li><span class='st_linkedin_hcount' st_url="https://inventure.com.ua{$post->getPath()}" displayText='LinkedIn'></span></li>
                                        <li><span class='st_googleplus_hcount' st_url="https://inventure.com.ua{$post->getPath()}" displayText='Google +'></span></li>
                                    </ul>
                                </div>
                            </div>
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
        <div class="cell large-3 medium-12">
          <aside class="sidebar">
            <a href="/en/investor" class="invest_btn">invest</a>
            <a href="/en/add-inv-prop" class="invest_btn invest_btn1">FIND AN INVESTOR</a>
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
          </aside>
        </div>
      </div>
    </section>
