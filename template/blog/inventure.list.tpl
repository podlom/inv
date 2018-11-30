{* prefilter=off *}
<section class="grid-container inventure_list">
  <div class="grid-x grid-margin-x">
    <div class="cell large-9 medium-12">
        <div class="clearfix border-bottom">
            <h2>Инвестиционные предложения</h2>
        </div>
                        <div class="box-shadow_filter tablet_inv_filter">
                    <div class="box-shadow"></div>
                   <div class="filter m_b-15 clearfix" >
        {filter fields=[10,16,15,34]} {* адрес, квед, цена, инвестиции *}
            <form method="get">
                <h3><i class="fa fa-search"></i>Поиск предложений</h3>
                <div class="row">
                        {$filter->getField('search')->getInput()->setAttr('placeholder', 'Поиск по названию')}
                    

                    {if !$category}
                            <select onchange="this.form.action=this.value">
                                <option value="/investments">Тип предложения</option>
                                {foreach $blog->getCategories() as $cat}
                                    <option value="{$cat->getPath()}">{$cat->getH1()}</option>
                                {/foreach}
                            </select>
                    {/if}
                            {$filter->getField(10)->getInput()->setAttr('placeholder','Локация')}
                    {if !$category || in_array($category->getSubpath(), ['projects', 'business', 'offer'])}
                        <div>
                            <label class="otr-invtitle label-click4 field-int">Отрасль<span class="open icon"></span><span class="close icon">&#215;</span></label>
                            <div class="otr-inv tged4 hide check-row">
                                {$filter->getField(16)->getInput()}
                            </div>
                        </div>
                    {/if}
                    <div class="columns my_button">
                        <button class="blue_but" type="submit" aria-label="submit form">Искать</button>
                    </div>
                    
                    {$filter = $request->query->get('filter')}
                    {if $filter.sort}
                        <input type="hidden" name="filter[sort]" value="{$filter.sort}" >
                    {/if}
                </div>
            </form>
        </div>
    </div>
        {block 'menu'}
            <nav>
                <span {if $request->getPathInfo() == '/investments/projects'}class="active"{/if}><a href="/investments/projects">Инвестиционные проекты и стартапы</a></span> |
                <span {if $request->getPathInfo() == '/investments/business'}class="active"{/if}><a href="/investments/business">Продажа бизнеса</a></span> |
                <span {if $request->getPathInfo() == '/investments/realestate'}class="active"{/if}><a href="/investments/realestate">Недвижимость</a></span> |
                <span {if $request->getPathInfo() == '/investments/land'}class="active"{/if}><a href="/investments/land">Земельные участки</a></span> |
                <span {if $request->getPathInfo() == '/investments/offer'}class="active"{/if}><a href="/investments/offer">Инвесторы</a></span>
            </nav>
          <div class="mobile_category">
              <a href="/investments/projects">Инвестиционные проекты и стартапы</a><i class="fa fa-chevron-right"></i><i class="fa fa-chevron-down"></i>
              <ul>
                  <li><a href="/investments/business">Продажа бизнеса</a></li>
                  <li><a href="/investments/realestate">Недвижимость</a></li>
                  <li><a href="/investments/land">Земельные участки</a></li>
                  <li><a href="/investments/offer">Предложения инвесторов</a></li>
              </ul>
          </div>
        {/block}
        {block 'filter'}
        {$sort = $request->query->get('sort', 'published')}
{$sorts = [
    [['filter'=>['sort'=>'published']], 'Новые'],
    [['filter'=>['sort'=>'views']], 'Популяные'],
    [['filter'=>['sort'=>'rating']], 'Лучшие']
]}
         <div class="filter-cnt clearfix">  
        {foreach $sorts as $item}
                {$order = $item.0}
                {$name = $item.1}
                {$current=true}
                {foreach $order as $k=>$v}
                    {$val = $request->query->get($k)}
                    {if $val == $v}{continue}{/if}
                    {if is_array($v) && is_array($val)}
                        {foreach $v as $kk=>$vv}
                            {if $val[$kk] != $vv}{$current = false}{break}{/if}
                        {/foreach}
                        {continue}
                    {/if}
                    {$current = false}{break}
                {/foreach}
                {$filter = $request->query->get('filter')}
                {if $filter}
                    {if $order.filter}
                        {$filter.sort = $order.filter.sort}
                    {else}
                        {$filter.sort=''}
                    {/if}
                    {$order.filter = $filter}
                {/if}
                {if $current}
                    <a href="#" class="active">{$name}</a>
                {else}
                    <a href="?{http_build_query($order)}">{$name}</a>
                {/if}
        {/foreach}
        </div>
        {/block}
            <div class="row">
                <div class="auto-height">
                    <article>
                                {block 'posts'}
                                {$posts->setCount(24)}
                    {foreach $posts as $post}
                        {if $post->getAttr(58) == 1}
                        {$image_class = 'inv-sold'}
                        {else}
                        {$image_class = ''}
                        {/if}
                        {block 'post'}
                    <div style="position: relative; height: 500px; margin-bottom: 24px;">
                        <div class="box-shadow"></div>
                    <div class="item ">
                        {block 'image'}
                        {if $post->getImage()}
                        <div class="img">
                            <a href="{$post->getPath()}" class="{$image_class}">
                                {$post->getImage()->thumbup(350,254)}
                            </a>
                        </div>
                        {elseif substr($post->getPath(),0,14) == "/tools/video"}
                            <div>{$post->getAttr(55)}</div>
                        {else}
                            <a href="{$post->getPath()}">
                                <img src="/img/resize.375.225/images/noThumb.jpg" alt="{$post->getH1()}" itemscope itemtype="http://schema.org/ImageObject"/>
                            </a>
                        {/if}
                        {/block}
                      <div class="padding">  
                        <div class="statistic">
                        <div class="date">
                          {$post->getPublished()->format('d.m.y')}
                        </div>
                        <div class="views">
                          <img src="/i/views.png">
                          {$post->getViews()+1}
                        </div>
                        <div class="rating">
                          <img src="/i/rating.png">
                          {$post->getRating()|number_format:1}
                        </div>
                      </div>
                      <div class="category">
                            {if $post->getParent()->getId() == 7860}
                                <a href="{$post->getParent()->getPath()}"><img src="/i/projects.png" alt="" />{$post->getParent()->getH1()}</a>
                            {elseif $post->getParent()->getId() == 7861}
                                <a href="{$post->getParent()->getPath()}"><img src="/i/business.png" alt="" />{$post->getParent()->getH1()}</a>
                            {elseif $post->getParent()->getId() == 7862}
                                <a href="{$post->getParent()->getPath()}"><img src="/i/realestate.png" alt="" />{$post->getParent()->getH1()}</a>
                            {elseif $post->getParent()->getId() == 7863}
                                <a href="{$post->getParent()->getPath()}"><img src="/i/land.png" alt="" />{$post->getParent()->getH1()}</a>
                            {elseif $post->getParent()->getId() == 7864}
                                <a href="{$post->getParent()->getPath()}"><img src="/i/offer.png" alt="" />{$post->getParent()->getH1()}</a>
                            {else}
                                <span></span>
                            {/if}
                          </div>
                      <h4><a href="{$post->getPath()}">{$post->getH1()}</a></h4>
                      <div class="position">
                          <div class="place">
                            <img src="/i/ukraine.png">{if $post->hasAttr("10")} {$post->printAttr("10")}{/if}
                          </div>
                          <hr>
                          <div class="footer">
                            <div>
                            {if $post->getParent()->getId() == 7861 || $post->getParent()->getId() == 7862 ||$post->getParent()->getId() == 7863}
                              <p><span style="font-weight: 700;">ЦЕНА</span> - 
                              {if $post->getAttr("15")!=''} ${$post->printAttr("15")|number_format:0:'.':' '}{else}Договорная{/if}</p>
                            {elseif $post->getParent()->getId() == 7860}
                              <p><span style="font-weight: 700;">ИНВЕСТИЦИИ</span> - 
                              {if $post->hasAttr("34")} ${$post->printAttr("34")|number_format:0:'.':' '}{/if}</p>
                            {elseif $post->getParent()->getId() == 7864}
                              <p><span style="font-weight: 700;">ИНВЕСТИЦИИ</span> - 
                              {if $post->hasAttr("31")} ${$post->printAttr("31")|number_format:0:'.':' '}{/if}</p>
                              {/if} 
                            </div>
                          </div>
                        </div>

                  </div>
                    </div>
                </div>
                    {/block}
        
        {/foreach}
    {/block}
                </article>
                
    {block 'pagination'}
    <div class="row">
        <div class="columns">
            <ul class="pagination">
                {foreach $posts->getPagination()->getLinks() as $a}
                    <li class="{$a->getAttr('class')}">{$a->setAttr('class', '')}</li>
                {/foreach}
            </ul>
        </div>
    </div>
    {/block}
                </div>
            </div>
    </div>
    <div class="cell small-3">
        <aside class="sidebar">
            <a href="/investor" class="invest_btn">инвестировать</a>
            <a href="/add-inv-prop" class="invest_btn invest_btn1">найти инвестора</a>
                <div class="box-shadow_filter">
                    <div class="box-shadow"></div>
                   <div class="filter m_b-15 clearfix" >
        {filter fields=[10,16,15,34]} {* адрес, квед, цена, инвестиции *}
            <form method="get">
                <h3><i class="fa fa-search"></i>Поиск предложений</h3>
                <div class="row">
                        {$filter->getField('search')->getInput()->setAttr('placeholder', 'Поиск по названию')}
                    
                    {if !$category}
                            <select onchange="this.form.action=this.value">
                                <option value="/investments">Тип предложения</option>
                                {foreach $blog->getCategories() as $cat}
                                    <option value="{$cat->getPath()}">{$cat->getH1()}</option>
                                {/foreach}
                            </select>
                    {/if}
                            {$filter->getField(10)->getInput()->setAttr('placeholder','Локация')}
                    {if !$category || in_array($category->getSubpath(), ['projects', 'business', 'offer'])}
                        <div>
                            <label class="otr-invtitle label-click4 field-int">Отрасль<span class="open icon"><img src="/i/arr.png"></span><span class="close icon">&#215;</span></label>
                            <div class="otr-inv tged4 hide check-row">
                                {$filter->getField(16)->getInput()}
                            </div>
                        </div>
                    {/if}
                    <div class="columns my_button">
                        <button class="blue_but" type="submit" aria-label="submit form">Искать</button>
                    </div>
                    
                    {$filter = $request->query->get('filter')}
                    {if $filter.sort}
                        <input type="hidden" name="filter[sort]" value="{$filter.sort}" >
                    {/if}
                </div>
            </form>
        </div>
    </div>
<div class="box-shadow_form">
                <div class="box-shadow"></div>
                <div class="form">
                    <div class="title">
                       <a href="/analytics/digest"> <i class="fa fa-rss"></i>
                        Подписка на дайджест </a>
                      </div>
                      <div class="img"><img src="/i/digest_img.jpg"></div>
                    {subscribe}
                </div>
              </div>
                  <div class="box-shadow_archive">
                    <div class="box-shadow"></div>
                    <div class="archive">
                        <div class="title">
                           <a href="/analytics/digest"><img src="/i/download_icon.png" alt="Загрузить" title="Загрузить">
                            Архив выпусков</a>
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
                                    {foreach ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'] as $id => $name}
                                        <option value="{$id+1}"{if $digest->getPubDate()->format('n')==$id+1} selected{/if} label="{$name}">{$name}</option>
                                    {/foreach}
                                </select>
                            </div>
                                <a class="blue_but cell-but"  target="_blank" id="archiveFormButton" href="#" disabled="disabled">Скачать</a>
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