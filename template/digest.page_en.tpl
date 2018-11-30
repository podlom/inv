<section class="grid-container news_single digest">
  <div class="grid-x grid-margin-x">
    <div class="cell large-9 medium-12">
    <div class="clearfix border-bottom">
        <h2>Investment Digest</h2>
    </div>
{block 'content'}
    <div class="row  m_b-20" style="position: relative;">
        <div class="box-shadow"></div>
        <div  class=" medium-5 columns photo-in">
            <div id="newsThumb">
                {$page->getImage()->thumbup(350,254)}
            </div>
        </div>
        <div class="medium-7 columns">
            <div class="viewbox-cnt">
                <h3 class="h3" itemprop="name">{$page->getTitle()}</h3>
                <div itemscope="" itemtype="http://schema.org/CreativeWork">
                    <div itemprop="description">
                        <ul class="list_attr">
                            <li class="m_b-15">{$page->getShortText()}</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="large-8 medium-8 columns m_b-20" style="position: relative;">
            <div class="box-shadow1"></div>
            <h3><i class="fa fa-rss"></i>Free Digest Subscription</h3>
            <form class="row" id="subscribe" action="/!Mail" method="POST" name="subscribe">
  				<div>
	                <input type="text" name="subscribe[name]" id="subscribeName" placeholder="First Name and Surname" />
	                <input type="text" name="subscribe[company]" id="subscribeCompany" placeholder="Company" />
            	</div>
            	<div>
	                <input type="text" name="subscribe[job]" id="subscribeJob" placeholder="Position" />
	                <input type="email" name="subscribe[email]" id="subscribeMail" placeholder="E-mail" />
            	</div>
            	<div>
	                <input type="tel" name="subscribe[phone]" id="subscribeTel" placeholder="Phone" />
	                <button class="blue_but cell-but" id="subscribeButton" name="subscribeButton" type="submit" value="subscribe">Subscribe</button>
   				</div>
            </form>
        </div>
        <div  class="large-4 medium-4 columns m_b-20" style="position: relative;">
            <div class="box-shadow2"></div>
            <h3><i class="fa fa-rss"></i>Archive</h3>
            <div id="digest">
                {load_digests}
                {foreach $digests as $digest}
                    <a class="m{$digest->getPubDate()->format('n')} y{$digest->getPubDate()->format('Y')}" href="{$digest->getUrl()}"></a>
                {/foreach}
            </div>
            <div class="select year">
                <select name="archiveFormYear" id="archiveFormYear">
                    {$now = date_create()}
                    {for $year=2012 to $now->format('Y')}
                        <option value="{$year}" label="{$year}"{if $digest->getPubDate()->format('Y')==$year} selected{/if}>{$year}</option>
                    {/for}
                </select>
            </div>
            <div class="select months">
                <select name="archiveFormMonths" id="archiveFormMonths">
                    {foreach ["January","February", "March","April", "May", "June", "July", "August", "September", "October", "November", "December"] as $id => $name}
                        <option value="{$id+1}"{if $digest->getPubDate()->format('n')==$id+1} selected{/if} label="{$name}">{$name}</option>
                    {/foreach}
                </select>
            </div>
            <div class="text-center">
                <a class="blue_but" target="_blank" id="archiveFormButton" href="/data/digest/inventure-investment-digest-april-2013.pdf">Download</a>
            </div>
        </div>
    </div>
    <div class="row" itemscope itemtype="http://schema.org/articleBody">
        <div class="columns">
            <div class="viewbox-cnt-body m_b-20" itemprop="text">
                {content $page}
            </div>
            <div id="digestComments">
                <h2>Comments</h2>
                {include 'inc/disqus'}
            </div>
        </div>
    </div>
{/block}

</div>
           <div class="cell small-3">
                        <aside class="sidebar">
                <a href="/investor" class="invest_btn">invest</a>
                <a href="/add-inv-prop" class="invest_btn invest_btn1">find an investor</a>
                      <div class="box-shadow_form">
                    <div class="box-shadow"></div>
                    <div class="form">
                        <div class="title">
                            <a href="/analytics/digest"> <i class="fa fa-rss"></i>
                        Sign up for Digest </a>
                          </div>
                          <div class="img"><img src="/i/digest_img.jpg"></div>
                        {subscribe}
                    </div>
                  </div>
                   <div class="box-shadow_archive">
                    <div class="box-shadow"></div>
                    <div class="archive">
                        <div class="title">
                           <a href="/analytics/digest"> <i class="fa fa-rss"></i>
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