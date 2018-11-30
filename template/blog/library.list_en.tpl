<section class="grid-container news_single library library_en">
  <div class="grid-x grid-margin-x">
    <div class="cell large-9 medium-12">
    <div class="clearfix border-bottom">
        <h2>Library</h2>
    </div>
{block 'breadcrumbs'}
<div class="clearfix">
     <nav>
              <a href="/en/analytics/investments">Research</a> |
              <a href="/en/analytics/articles">Articles</a> |
              <a href="/en/analytics/formula">Interview</a> |
              <a href="/en/analytics/we-invest-in-ukraine">We Invest in Ukraine</a> |
              <a href="/en/tools/database">Ratings</a> |
              <a href="/en/tools/library">Library</a> |
              <a href="/en/tools/atlsa">Investors</a>
          </nav>
          <div class="mobile_category">
              <a href="/en/analytics/investments">Research</a><i class="fa fa-chevron-right"></i><i class="fa fa-chevron-down"></i>
              <ul>
                  <li><a href="/en/analytics/articles">Articles</a></li>
                  <li><a href="/en/analytics/formula">Interview</a></li>
                  <li><a href="/en/analytics/we-invest-in-ukraine">We Invest in Ukraine</a></li>
                  <li><a href="/en/tools/database">Ratings</a></li>
                  <li><a href="/en/tools/library">Library</a></li>
                  <li><a href="/en/tools/investors">Investors</a></li>             
              </ul>
          </div>
</div>
{/block}
{block 'filter'}
<div style="position: relative;">
<div class="box-shadow"></div>
<div class="search-cnt m_b-15 clearfix">
    {filter fields=[48,49,62]}
    <form class="columns m_b-20" name="library-form" method="get">
        <div class="row">
                {$filter->getField('search')->getInput()->setAttr('placeholder', "Search by name")}
                <button class="blue_but m_t-5" type="submit" aria-label="submit form">Search</button>
        </div>
        <div class="row">
            <div class="large-4 medium-4 columns">
                <h3>Type:</h3>
                {$filter->getField(48)->getInput()->setId('lib2')->addClass('')}
            </div>
            <div class="large-4 medium-4 columns">
                <h3>Language:</h3>
                {$filter->getField(49)->getInput()->setId('lib3')->addClass('')}
            </div>
            <div class="large-4 medium-4 columns">
                <h3>Year:</h3>
                <select>
                    <option>2018</option>
                    <option>2017</option>
                    <option>2016</option>
                    <option>2015</option>
                    <option>2014</option>
                </select>
            </div>
        </div>
    </form>
</div>
{/block}
{block 'posts'}
<ul class="info_table">
    <li class="thead">
        <div>Title</div>
        <div>Year</div>
        <div>Type</div>
        <div>Language</div>
        <div>Source</div>
    </li>
    {foreach $posts as $post}
        <li class="tbody">
            <div class="text-left" data-header="Название"><span><a href="{if $post->getImage()}{$post->getImage()->getUrl()}{else}#{/if}" class="LibraryLinkDownload">{$post->getH1()}</a></span></div>
            <div data-header="Год">{$post->getAttr('62')}</div>
            <div data-header="Тематика"><span>{$post->printAttr(48)}</span></div>
            <div data-header="Язык"><span>
                {if ($post->getAttr("49") == 1)}
                    <img alt="Ru" src="http://pbwm.ru/images/flags/png/ru.png?1291794745"  />
                {elseif ($post->getAttr("49") == 2)}
                    <img alt="Gb" src="http://pbwm.ru/images/flags/png/gb.png?1291794745"  />
                {elseif ($post->getAttr("49") != 2) && ($post->getAttr("49") != 1)}
                    <img alt="Ua" src="http://pbwm.ru/images/flags/png/ua.png?1291794745" />
                {/if}
            </span></div>
            <div class="text-left" data-header="Источник"><span>{$post->getAttr("1")}</span></div>
        </li>
    {/foreach}
</ul>
{foreach $posts as $post}
<article class="library_mob">
  <p class="p1">Title</p>
  <h6>{$post->getH1()}</h6>
  <p class="p1">Year</p>
  <p>{$post->getAttr('62')}</p>
  <p class="p1">Type</p>
  <p>{$post->printAttr(48)}</p>
  <p class="p1">Language</p>
  <p>{if ($post->getAttr("49") == 1)}
                    <img alt="Ru" src="http://pbwm.ru/images/flags/png/ru.png?1291794745"  />Russian
                {elseif ($post->getAttr("49") == 2)}
                    <img alt="Gb" src="http://pbwm.ru/images/flags/png/gb.png?1291794745"  /> English
                {elseif ($post->getAttr("49") != 2) && ($post->getAttr("49") != 1)}
                    <img alt="Ua" src="http://pbwm.ru/images/flags/png/ua.png?1291794745" /> Ukranian
                {/if}</p>
  <p class="p1">Source</p>
  <p>{$post->getAttr("1")}</p>
</article>
{/foreach}
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
          </aside>
        </div>
  </div>
 </section>