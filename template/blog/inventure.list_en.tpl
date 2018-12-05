{* prefilter=off *}
{extends 'Blog.blog'}
{block 'page.class' append} inventure_list inventure_list_en{/block}
{block 'breadcrumbs'}
{$links = [
    '/en/investments/projects'=>'Investment Projects and Startups',
    '/en/investments/business'=>'Business for Sale',
    '/en/investments/realestate'=>'Commercial Property',
    '/en/investments/land'=>'Land',
    '/en/investments/offer'=>'Investor Offers'
]} 
<nav>
  {foreach $links as $url=>$name}
    <a href="{$url}"{if $category && $category->getPath()===$url} class="active"{/if}>{$name}</a>{if !$name@last} | {/if}
  {/foreach}
</nav>
<div class="mobile_category">
  {if $category}
  <a href="#">{$category->getH1()}</a><i class="fa fa-chevron-right"></i><i class="fa fa-chevron-down"></i>
  {else}
  <a href="#">Category</a><i class="fa fa-chevron-right"></i><i class="fa fa-chevron-down"></i>
  {/if}
  <ul>
  {foreach $links as $url=>$name}
    {if $category && $category->getPath() != $url}
    <li><a href="{$url}">{$name}</a></li>
    {/if}
  {/foreach}
  </ul>
</div>

{$sorts = [
    ['!published', 'Latest'],
    ['views', 'Popular'],
    ['rating', 'Featured']
]}
<div class="filter-cnt clearfix">  
{foreach $sorts as $s}
    <a href="?sort={$s.0}">{$s.1}</a>
{/foreach}
</div>
{/block}
{block 'posts'}
<div class="auto-height">
    <article>
        {$posts->setCount(24)}
        {foreach $posts as $post}
        {if $post->getAttr(58) == 1}
            {$image_class = 'inv-sold'}
        {else}
            {$image_class = ''}
        {/if}
    {block 'post!NO'}
        <div class="">
            <div class="box-shadow"></div>
            <div class="item ">
        {block 'image'}
                {if $post->getImage()}
                <div class="img">
                    <a href="{$post->getPath()}" class="{$image_class}">
                        {$post->getImage()->thumbup(350,254)}
                    </a>
                </div>
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
                        {if $post->getParent()}
                            <a href="{$post->getParent()->getPath()}"><img src="/i/{$post->getParent()->getSubpath()}.png" alt="" />{$post->getParent()->getH1()}</a>
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
                            {if $post->getParent()->getId() == 9779 || $post->getParent()->getId() == 9780 ||$post->getParent()->getId() == 9781}
                                <p><span style="font-weight: 700;">PRICE</span> - 
                                    {if $post->getAttr("15")!=''} ${$post->printAttr("15")|number_format:0:'.':' '}{else}Negotiable{/if}
                                </p>
                            {elseif $post->getParent()->getId() == 9778}
                                <p>
                                    <span style="font-weight: 700;">INVESTMENTS</span> - 
                                    {if $post->hasAttr("34")} ${$post->printAttr("34")|number_format:0:'.':' '}{/if}
                                </p>
                            {elseif $post->getParent()->getId() == 9782}
                                <p>
                                    <span style="font-weight: 700;">INVESTMENTS</span> - 
                                    {if $post->hasAttr("31")} ${$post->printAttr("31")|number_format:0:'.':' '}{/if}
                                </p>
                            {/if} 
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    {/block}
        {/foreach}
    </article>
</div>
{/block}
                
{* {filter fields=[10,16,15,34]}
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
            </form> *}
