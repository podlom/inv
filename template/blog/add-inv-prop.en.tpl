<section class="grid-container news_single template_view add-inv-prop_en">
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
        <div class="img"></div>
        <table class="add-inv-prop-table">
            <thead>
                <tr>
                    <td></td>
                    <td>Complex Approach </td>
                    <td>Individual Approach</td>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Scale</td>
                    <td>Small Business<br> and Medium Business</td>
                    <td>Medium Business<br> and Big Business</td>
                </tr>
                <tr>
                    <td>Online sales</td>
                    <td><span class="check"></span></td>
                    <td><span class="check"></span></td>
                </tr>
                <tr>
                    <td>Direct sales</td>
                    <td></td>
                    <td><span class="check"></span></td>
                </tr>
                <tr>
                    <td>Success Fee</td>
                    <td><span class="check"></span></td>
                    <td><span class="check"></span></td>
                </tr>
                <tr>
                    <td>Deal support</td>
                    <td><span class="check"></span></td>
                    <td><span class="check"></span></td>
                </tr>
                <tr>
                    <td>Consulting support</td>
                    <td><span class="check"></span></td>
                    <td><span class="check"></span></td>
                </tr>
                <tr>
                    <td>Individual manager</td>
                    <td></td>
                    <td><span class="check"></span></td>
                </tr>
                <tr>
                    <td>Budget</td>
                    <td><span class="gold2"></span></td>
                    <td><span class="gold3"></span></td>
                </tr>
                <tfoot>
                    <td></td>
                    <td><a href="/en/complex-approach">Read more</a></td>
                    <td><a href="">Read more</a></td>
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
            <a href="/en/investor" class="invest_btn">invest</a>
            <a href="/en/add-inv-prop" class="invest_btn invest_btn1">find an investor</a>
                  <div class="box-shadow_form">
                <div class="box-shadow"></div>
                <div class="form">
                    <div class="title">
                         <a href="/en/analytics/digest"> <i class="fa fa-rss"></i>
                        Sign up for Digest</a>
                      </div>
                      <div class="img"><img src="/i/form_img.png"></div>
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