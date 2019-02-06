{$month=[1=>"January","February", "March","April", "May", "June", "July", "August", "September", "October", "November", "December"]}
    
    <div class="grid-container investment_proposals investment_proposals_en" id="investment">
      <div class="grid-x grid-margin-x">
        <div class="cell medium-12 large-9">
          <section class="investment">
            <div class="title">
              <h2><a href="/en/investments">Investment Proposals</a></h2>
            </div>
            <nav>
                <a href="/en/investments/projects">Investment Projects and Startups</a> |
                <a href="/en/investments/business">Business for Sale</a> |
                <a href="/en/investments/realestate">Commercial Property</a> |
                <a href="/en/investments/land">Land</a> |
                <a href="/en/investments/offer">Investor Offers</a>
            </nav>
            <div class="mobile_category">
              <a href="/en/investments">Investment Proposals</a><i class="fa fa-chevron-right"></i><i class="fa fa-chevron-down"></i>
              <ul>
                  <li><a href="/en/investments/business">Business for sale</a></li>
                  <li><a href="/en/investments/realestate">Commercial property</a></li>
                  <li><a href="/en/investments/land">Lands</a></li>
                  <li><a href="/en/investments/offer">Investor offers</a></li>
              </ul>
          </div>
            <article class="grid-container">
                    <div class="grid-x grid-margin-x">
                      <div class="cell small-12 medium-5 large-5">
                        {lent_load '/en/investments' 6 var="posts" analytics=1}
                        {$bigpost=array_shift($posts)}
                      <div style="position: relative;">
                        <div class="box-shadow"></div>  
                        <div class="title-news">
                          <div class="img">
                            <a href="{$bigpost->getPath()}">
                              {$bigpost->getImage()->thumbup(350,254)}
                            </a>
                          </div>
                          <div class="info">
                            <div class="statistic">
                              <div class="date">
                                {$bigpost->getPublished()->format('d.m.y')}
                              </div>
                              <div class="views">
                                <img src="/i/views.png">
                                {$bigpost->getViews()}
                              </div>
                              <div class="rating">
                                <img src="/i/rating.png">
                                {$bigpost->getRating()|number_format:1}
                              </div>
                            </div>
                            <div class="category">
                            {if $bigpost->getParent()->getId() == 9778}
                                <a href="{$bigpost->getParent()->getPath()}"><img src="/i/projects.png" alt="" />{$bigpost->getParent()->getH1()}</a>
                            {elseif $bigpost->getParent()->getId() == 9779}
                                <a href="{$bigpost->getParent()->getPath()}"><img src="/i/business.png" alt="" />{$bigpost->getParent()->getH1()}</a>
                            {elseif $bigpost->getParent()->getId() == 9780}
                                <a href="{$bigpost->getParent()->getPath()}"><img src="/i/realestate.png" alt="" />{$bigpost->getParent()->getH1()}</a>
                            {elseif $bigpost->getParent()->getId() == 9781}
                                <a href="{$bigpost->getParent()->getPath()}"><img src="/i/land.png" alt="" />{$bigpost->getParent()->getH1()}</a>
                            {elseif $bigpost->getParent()->getId() == 9782}
                                <a href="{$bigpost->getParent()->getPath()}"><img src="/i/offer.png" alt="" />{$bigpost->getParent()->getH1()}</a>
                            {else}
                                <span></span>
                            {/if}
                          </div>
                            <h4><a href="{$bigpost->getPath()}">{$bigpost->getTitle()}</a></h4>
                            <p>{$bigpost->getShortText()|truncate:150:"  ..."}</p>
                            <div class="position">
                          <div class="place">
                            <img src="/i/ukraine.png">{if $bigpost->hasAttr("10")} {$bigpost->printAttr("10")}{/if}
                          </div>
                          <hr>
                            <div class="footer">
                            <div>
                            {if $bigpost->getParent()->getId() == 9779 || $bigpost->getParent()->getId() == 9780 ||$bigpost->getParent()->getId() == 9781}
                              <p><span style="font-weight: 700;">PRICE</span> - 
                              {if $bigpost->getAttr("15")!=''} ${$bigpost->printAttr("15")|number_format:0:'.':' '}{else}Negotiable{/if}</p>
                            {elseif $bigpost->getParent()->getId() == 9778}
                              <p><span style="font-weight: 700;">INVESTMENTS</span> - 
                              {if $bigpost->hasAttr("34")} ${$bigpost->printAttr("34")|number_format:0:'.':' '}{/if}</p>
                            {elseif $bigpost->getParent()->getId() == 9782}
                              <p><span style="font-weight: 700;">INVESTMENTS</span> - 
                              {if $bigpost->hasAttr("31")} ${$bigpost->printAttr("31")|number_format:0:'.':' '}{/if}</p>
                              {/if} 
                            </div>
                          </div>
                        </div>
                          </div>
                        </div>
                      </div>
                      </div>
                      <div class="cell small-12 medium-7 large-7">
                        <div class="tabs">
                          <ul class="tabs__caption">
                            <li class="active">Latest</li>
                            <li>Popular</li>
                            <li>Featured</li>
                          </ul>

                          <div class="tabs__content  active">
                                                   {foreach $posts as $post}
                            <div class="item">
                              <div class="img">
                                <a href="{$post->getPath()}" >
                                  <img src="/img/thumbup.236.170{$post->getImage()->getUrl()}" alt='{$post->getTitle()}' />
                                </a>
                              </div>
                              <div class="content">
                                  <h4><a href="{$post->getPath()}">{$post->getTitle()}</a></h4>
                                  <div class="category">
                            {if $post->getParent()->getId() == 9778}
                                <a href="{$post->getParent()->getPath()}"><img src="/i/projects.png" alt="" />{$post->getParent()->getH1()}</a>
                            {elseif $post->getParent()->getId() == 9779}
                                <a href="{$post->getParent()->getPath()}"><img src="/i/business.png" alt="" />{$post->getParent()->getH1()}</a>
                            {elseif $post->getParent()->getId() == 9780}
                                <a href="{$post->getParent()->getPath()}"><img src="/i/realestate.png" alt="" />{$post->getParent()->getH1()}</a>
                            {elseif $post->getParent()->getId() == 9781}
                                <a href="{$post->getParent()->getPath()}"><img src="/i/land.png" alt="" />{$post->getParent()->getH1()}</a>
                            {elseif $post->getParent()->getId() == 9782}
                                <a href="{$post->getParent()->getPath()}"><img src="/i/offer.png" alt="" />{$post->getParent()->getH1()}</a>
                            {else}
                                <span></span>
                            {/if}
                          </div>
                                <div class="statistic">
                                  <div class="date">
                                    {$post->getPublished()->format('d.m.y')}
                                  </div>
                                  <div class="views">
                                    <img src="/i/views.png">
                                    {$post->getViews()}
                                  </div>
                                  <div class="rating">
                                    <img src="/i/rating.png">
                                    {$post->getRating()|number_format:1}
                                  </div>
                                </div>
                              </div>
                            </div>
                            {/foreach}
                            <a href="/en/investments" class="more">View all</a>
                          </div>

                          <div class="tabs__content">
                            {lent '/en/investments' 5 order_by="a.views DESC" var='news' analytics=1}
                            <div class="item">
                              <div class="img">
                                <a href="{$news->getPath()}" >
                                  <img src="/img/thumbup.236.170{$news->getImage()->getUrl()}" alt='{$news->getTitle()}' />
                                </a>
                              </div>
                              <div class="content">
                                  <h4><a href="{$news->getPath()}">{$news->getTitle()}</a></h4>
                                  <div class="category">
                            {if $post->getParent()->getId() == 9778}
                                <a href="{$post->getParent()->getPath()}"><img src="/i/projects.png" alt="" />{$post->getParent()->getH1()}</a>
                            {elseif $post->getParent()->getId() == 9779}
                                <a href="{$post->getParent()->getPath()}"><img src="/i/business.png" alt="" />{$post->getParent()->getH1()}</a>
                            {elseif $post->getParent()->getId() == 9780}
                                <a href="{$post->getParent()->getPath()}"><img src="/i/realestate.png" alt="" />{$post->getParent()->getH1()}</a>
                            {elseif $post->getParent()->getId() == 9781}
                                <a href="{$post->getParent()->getPath()}"><img src="/i/land.png" alt="" />{$post->getParent()->getH1()}</a>
                            {elseif $post->getParent()->getId() == 9782}
                                <a href="{$post->getParent()->getPath()}"><img src="/i/offer.png" alt="" />{$post->getParent()->getH1()}</a>
                            {else}
                                <span></span>
                            {/if}
                          </div>
                                <div class="statistic">
                                  <div class="date">
                                    {$news->getPublished()->format('d.m.y')}
                                  </div>
                                  <div class="views">
                                    <img src="/i/views.png">
                                    {$news->getViews()}
                                  </div>
                                  <div class="rating">
                                    <img src="/i/rating.png">
                                    {$news->getRating()|number_format:1}
                                  </div>
                                </div>
                              </div>
                            </div>
                            {/lent}
                            <a href="/en/investments" class="more">View all</a>
                          </div>

                          <div class="tabs__content">
                            {lent '/en/investments' 5 order_by="a.rating DESC" var='news' analytics=1}
                            <div class="item">
                              <div class="img">
                                <a href="{$news->getPath()}" >
                                  <img src="/img/thumbup.236.170{$news->getImage()->getUrl()}" alt='{$news->getTitle()}' />
                                </a>
                              </div>
                              <div class="content">
                                  <h4><a href="{$news->getPath()}">{$news->getTitle()}</a></h4>
                                  <div class="category">
                            {if $post->getParent()->getId() == 9778}
                                <a href="{$post->getParent()->getPath()}"><img src="/i/projects.png" alt="" />{$post->getParent()->getH1()}</a>
                            {elseif $post->getParent()->getId() == 9779}
                                <a href="{$post->getParent()->getPath()}"><img src="/i/business.png" alt="" />{$post->getParent()->getH1()}</a>
                            {elseif $post->getParent()->getId() == 9780}
                                <a href="{$post->getParent()->getPath()}"><img src="/i/realestate.png" alt="" />{$post->getParent()->getH1()}</a>
                            {elseif $post->getParent()->getId() == 9781}
                                <a href="{$post->getParent()->getPath()}"><img src="/i/land.png" alt="" />{$post->getParent()->getH1()}</a>
                            {elseif $post->getParent()->getId() == 9782}
                                <a href="{$post->getParent()->getPath()}"><img src="/i/offer.png" alt="" />{$post->getParent()->getH1()}</a>
                            {else}
                                <span></span>
                            {/if}
                          </div>
                                <div class="statistic">
                                  <div class="date">
                                    {$news->getPublished()->format('d.m.y')}
                                  </div>
                                  <div class="views">
                                    <img src="/i/views.png">
                                    {$news->getViews()}
                                  </div>
                                  <div class="rating">
                                    <img src="/i/rating.png">
                                    {$news->getRating()|number_format:1}
                                  </div>
                                </div>
                              </div>
                            </div>
                            {/lent}
                            <a href="/en/investments" class="more">View all</a>
                          </div>
                        </div>
                      </div>
                    </div>
                  </article>
          </section>
        </div>
        <div class="cell medium-12 large-3">
          <aside class="sidebar">
            <a href="/en/investor" class="invest_btn">Invest</a>
            <a href="/en/add-inv-prop" class="invest_btn invest_btn1">Find an investor</a>
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
          </aside>
        </div>
      </div>
    </div>
    <div class="grid-container all_news all_news_en" id="all_news">
      <div class="grid-x grid-margin-x">
        <div class="cell medium-12 large-9">
          <section class="news news_en">
            <div class="title">
              <h2><a href="/en/news">News</a></h2>
            </div>
            <nav>
                <a href="/en/news/investments">Private Equity &amp; M&amp;A</a> |
                <a href="/en/news/startup">Venture Capital &amp; Startups</a> |
                <a href="/en/news/government">Macroeconomics</a> |
                <a href="/en/news/banking">Banking</a> |
                <a href="/en/news/stock">Stock Market &amp; IPO</a> |
                <a href="/en/news/realestate">Commercial Property</a> 
            </nav>
            <div class="mobile_category">
              <a href="/en/news/investments">Private Equity &amp; M&amp;A</a><i class="fa fa-chevron-right"></i><i class="fa fa-chevron-down"></i>
              <ul>
                  <li><a href="/en/news/startup">Venture Capital &amp; startups</a></li>
                  <li><a href="/en/news/government">Macroeconomics</a></li>
                  <li><a href="/en/news/banking">Banking</a></li>
                  <li><a href="/en/news/stock">Stock Market &amp; IPO</a></li>
                  <li><a href="/en/news/realestate">Commercial Property</a> </li>
              </ul>
          </div>
            <article class="grid-container">
              <div class="grid-x grid-margin-x">
                <div class="cell  bg-white  small-12 madium-5 large-5">
                    {lent_load '/en/news' 6 var="news_all" analytics=1}
                    {$bignews=array_shift($news_all)}
                <div style="position: relative;">
                  <div class="box-shadow"></div>
                  <div class="title-news">
                    <div class="img">
                      <a href="{$bignews->getPath()}">
                                {$bignews->getImage()->thumbup(350,254)}
                            </a>
                    </div>
                    <div class="info">
                      <div class="statistic">
                        <div class="date">
                         {$bignews->getPublished()->format('d.m.y')}
                        </div>
                        <div class="views">
                          <img src="/i/views.png">
                          {$bignews->getViews()}
                        </div>
                      </div>
                      {$r=$bignews->getRubrics()}
                        {if $r.0}<div class="hint m_t-5 category"><a href="#"><img src="/i/folded-newspaper.png" alt="" />{$r.0->getH1()}</a></div>{/if}
                      <h4><a href="{$bignews->getPath()}">{$bignews->getTitle()}</a></h4>
                      <p>{$bignews->getShortText()|truncate:300:"  ..."}</p>
                    </div>
                  </div>
                </div>
                </div>
                <div class="cell small-12 medium-12 large-7">
                  <div class="tabs">
                          <ul class="tabs__caption">
                            <li class="active">Latest</li>
                            <li>Ukraine</li>
                            <li>World</li>
                          </ul>

                          <div class="tabs__content  active">
                              {foreach $news_all as $news}
                      <div class="item">
                        <div class="img">
                            <a href="{$news->getPath()}" >
                            <img src="/img/thumbup.236.170{$news->getImage()->getUrl()}" alt='{$news->getTitle()}' />
                        </a>
                        </div>
                        <div class="content">
                            <h4><a href="{$news->getPath()}">{$news->getTitle()}</a></h4>
                            {$r=$news->getRubrics()}
                          {if $r.0}<div class="hint m_t-5 category"><a href="#"><img src="/i/folded-newspaper.png" alt="" />{$r.0->getH1()}</a></div>{/if}
                          <div class="statistic">
                            <div class="date">
                             {$news->getPublished()->format('d.m.y')}
                            </div>
                            <div class="views">
                              <img src="/i/views.png">
                              {$news->getViews()}
                            </div>
                         </div>
                        </div>
                      </div>
                      {/foreach}
                      <a href="/en/news" class="more">View all</a>
                      </div>

                          <div class="tabs__content">
                            {lent '/en/news' 5 category='9752' var='news' alaytics=1}
                      <div class="item">
                        <div class="img">
                            <a href="{$news->getPath()}" >
                            <img src="/img/thumbup.236.170{$news->getImage()->getUrl()}" alt='{$news->getTitle()}' />
                        </a>
                        </div>
                        <div class="content">
                            <h4><a href="{$news->getPath()}">{$news->getTitle()}</a></h4>
                            {$r=$news->getRubrics()}
                          {if $r.0}<div class="hint m_t-5 category"><a href="#"><img src="/i/folded-newspaper.png" alt="" />{$r.0->getH1()}</a></div>{/if}
                            <div class="statistic">
                            <div class="date">
                             {$news->getPublished()->format('d.m.y')}
                            </div>
                            <div class="views">
                              <img src="/i/views.png">
                              {$news->getViews()}
                            </div>
                         </div>
                        </div>
                      </div>
                      {/lent}
                            <a href="/en/news/ukraine" class="more">View all</a>
                          </div>

                          <div class="tabs__content">
                            {lent '/en/news' 5 category="9750" var='news' alaytics=1}
                      <div class="item">
                        <div class="img">
                            <a href="{$news->getPath()}" >
                            <img src="/img/thumbup.236.170{$news->getImage()->getUrl()}" alt='{$news->getTitle()}' />
                        </a>
                        </div>
                        <div class="content">
                            <h4><a href="{$news->getPath()}">{$news->getTitle()}</a></h4>
                            {$r=$news->getRubrics()}
                          {if $r.0}<div class="hint m_t-5 category"><a href="#"><img src="/i/folded-newspaper.png" alt="" />{$r.0->getH1()}</a></div>{/if}
                            <div class="statistic">
                            <div class="date">
                             {$news->getPublished()->format('d.m.y')}
                            </div>
                            <div class="views">
                              <img src="/i/views.png">
                              {$news->getViews()}
                            </div>
                         </div>
                        </div>
                      </div>
                      {/lent}
                            <a href="/en/news/world" class="more">View all</a>
                          </div>
                        </div>
                </div>
              </div>
            </article>
          </section>
        </div>
        <div class="cell medium-12 large-3">
          <aside>
           <div class="advertising" id="advertising">
                <div class="box-shadow"></div>
                {widget_slot 'main (370x450)' size=[370,450]}
                {widget_slot 'post_2 (370x450)' size=[370,450]}
                {widget_slot 'post_6 (270x350)' size=[270,350]}
              </div>
          </aside>
        </div>
      </div>
    </div>
    <div class="grid-container all_read" id="all_read">
      <div class="grid-x grid-margin-x">
        <div class="cell medium-12 large-9">
          <section class="news">
            <div class="title">
              <h2><a href="/en/analytics">Analytics</a></h2>
            </div>
            <nav>
                <a href="/en/analytics/investments">Research</a> |
                <a href="/en/analytics/articles">Articles</a> |
                <a href="/en/analytics/formula">Investment interview</a> |
                <a href="/en/analytics/we-invest-in-ukraine">We invest in Ukraine</a> |
                <a href="/en/tools/database">Ratings</a> |
                <a href="/en/tools/library">Library</a> |
                <a href="/en/tools/investors">Investors</a>
            </nav>
            <div class="mobile_category">
              <a href="/en/analytics/investments">Research</a><i class="fa fa-chevron-right"></i><i class="fa fa-chevron-down"></i>
              <ul>
                  <li><a href="/en/analytics/articles">Articles</a></li>
                <li><a href="/en/analytics/formula">Investment interview</a></li>
                <li><a href="/en/analytics/we-invest-in-ukraine">We invest in Ukraine</a></li>
                <li><a href="/en/tools/database">Ratings</a></li>
                <li><a href="/en/tools/library">Library</a></li>
                <li><a href="/en/tools/investors">Investors</a></li>
              </ul>
          </div>
            <article class="grid-container">
              <div class="grid-x grid-margin-x">
                {$invest=[]}
                {lent '/en/analytics' 3 var='analytics' analytics=1}
                {$invest[] = $analytics}
                <div class="cell  bg-white  small-12 medium-4 large-4">
                  <div class="box-shadow"></div>
                  <div class="read_news">
                    <div class="img">
                      <a href="{$analytics->getPath()}">
                        {$analytics->getImage()->thumbup(320,230)}
                      </a>
                    </div>
                    <div class="info">
                      <div class="statistic">
                        <div class="date">
                          {$analytics->getPublished()->format('d.m.y')}
                        </div>
                        <div class="views">
                         <img src="/i/views.png">
                          {$analytics->getViews()}
                        </div>
                      </div>
                      <div class="category"> 
                        <img src="/i/pers.png" alt="" />{$analytics->getAttr(1)}
                      </div>
                      <h4><a href="{$analytics->getPath()}">{$analytics->getTitle()}</a></h4>
                      <p>{$analytics->getShortText()|truncate:181:"  ..."}</p>
                  </div>
                </div>
                </div>
                {/lent}
                <a href="/en/analytics" class="cell small-12 more">View all</a>
              </div>
            </article>
          </section>
        </div>
        <div class="cell medium-12 large-3">
            <aside>
              
            </aside>
        </div>
      </div>
    </div>
    <div class="grid-container events">
      <div class="grid-x grid-margin-x">
        <div class="cell medium-12 large-9">
          <section class="news">
            <div class="title">
              <h2><a href="/en/tools/events">Events</a></h2>
            </div>
            <article class="grid-container">
              <div class="grid-x grid-margin-x">
                {$event=[]}
                {lent '/en/tools/events' 4 var='events' analytics=1}
                {$event[]=$events}
                <div class="cell small-6">
                  <div class="event">
                    <div class="img">
                      <a href="{$events->getPath()}">{$events->getImage()->thumbup(320,230)}</a>
                    </div>
                    <div class="content">
                      <h5><a href="{$events->getPath()}" >{$events->getTitle()}</h5>
                      <div class="date">
                        <span><img src="/i/calendar.png"> {$events->getAttr(7)->format('d.m.Y')}</span>
                        <span><img src="/i/clock.png"> {$events->getAttr(7)->format('H:i')} - {$events->getAttr(8)->format('H:i')}</span>
                      </div>
                      <div class="category">
                        <img src="/i/pers.png" alt="" />{$events->getAttr(9)}
                      </div>
                    </div>
                  </div>
                </div>
                {/lent}
              </div>
            </article>
          </section>
        </div>
      </div>
    </div>
    <div class="grid-container video_block">
      <div class="grid-x grid-margin-x">
        <div class="cell medium-12 large-9">
          <section class="news">
            <div class="title">
              <h2><a href="/en/tools/video">Video</a></h2>
            </div>
            <article class="grid-container">
              <div class="grid-x grid-margin-x">
                {$video=[]}
                {lent '/en/tools/video' 3 var='news'}
                {$video[] = $news}
                <div class="cell small-12 medium-4 large-4">
                  <div class="box-shadow"></div>
                  <div class="video">
                    <div class="this_video">
                      <iframe class="video-iframe-index" src="//www.youtube.com/embed/{$news->printAttr("55")}" allowfullscreen></iframe>
                    </div>
                    <div class="info">
                      <div class="statistic">
                        <div class="date">
                          {$news->getPublished()->format('d.m.y')}
                        </div>
                        <div class="views">
                          <img src="/i/views.png">
                          {$news->getViews()}
                        </div>
                      </div>
                      <h4><a href="{$news->getPath()}">{$news->getTitle()}</a></h4>
                    </div>
                  </div>
                </div>
                {/lent}
              </div>
            </article>
          </section>
        </div>
      </div>
    </div>