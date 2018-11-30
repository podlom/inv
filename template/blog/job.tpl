<section class="grid-container news_single">
      <div class="grid-x grid-margin-x">
        <div class="cell large-9 medium-12">
          {block 'breadcrumbs'}
    <div class="clearfix border-bottom">
        <h2>
            {if $lang == 'en'}
                Vacancies InVenture Media Group
            {else}
                Вакансии InVenture Media Group
            {/if}
        </h2>
    </div>
{/block}
            {block 'content'}
    {block 'post.head'}
    <div style="position: relative;">
    <div class="box-shadow"></div>
    <div class="row m_b-20 auto-height">
        <div class="medium-{$post_head_size.0|default:5} columns photo-in">
        {block 'post.image'}
            <div id="newsThumb">
                <a href="#" data-reveal-id="thumbBig">
                    {$post->getImage()->thumbup(350,254)}
                </a>
            </div>
            <div id="thumbBig" class="reveal-modal large medium" data-reveal>
                <img itemprop="image" src="{$post->getImage()->getUrl()}" alt='{$post->getTitle()}' itemscope itemtype="http://schema.org/ImageObject"/>
                <p><b>{$post->getTitle()}</b></p>
                <a class="close-reveal-modal">&#215;</a>
            </div>
        {/block}
        </div>
        <div class="medium-{$post_head_size.1|default:7} columns">
            <div class="viewbox-cnt attr-in">
                            <div class="hint m_b-10">
                            {block 'post.meta'}
                                {block 'post.publish'}<time class="time">{$post->getPublished()->format('d.m.y')}</time>{/block}
                                {block 'post.views'}<img src="/i/views.png" /><span class="number">{$post->getViews()+1}</span>{/block}
                            {/block}
                            </div>
                            <h3>{$post->getH1()}</h3>
                            {block 'description'}
                                <ul class="list_attr">
                                    <li>{$post->getShortText()|truncate:200:"  ..."}</li>
                                </ul>
                            {/block}
                        </div>
        </div>
    </div>
</div>
    {/block}
          <div class="wrapper">
        <div class="row" itemscope itemtype="http://schema.org/articleBody">
          	<div class="box-shadow"></div>  
            <div class="columns">
                <div class="viewbox-cnt-body m_b-20" itemprop="text">
                    {block 'post.content'} 
                        {content $post}
                    {/block}
                </div>
                {block 'post.images'}
                    {if count($post->getImages())>1}
                        <div  class="viewbox-cnt-body m_b-20" id="photosContent">
                            <h2>Галерея</h2>
                            <section id="newsThumb">
                                {foreach $post->getImages() as $idx=>$image}
                                    {if $image != $post->getImage()}
                                        <a href="#" data-reveal-id="{concat('thumbSmall_',$image->getId())}">
                                            {$image->thumbup(310,225)->setAttr('itemprop','image')}
                                        </a>
                                        <div id="{concat('thumbSmall_',$image->getId())}" class="reveal-modal large medium" data-reveal>
                                            {$image->setAttr('itemprop','image')}
                                            <p><b>{$post->getTitle()}</b></p><a class="close-reveal-modal">&#215;</a>
                                        </div>
                                    {/if}
                                {/foreach}
                            </section>
                            <div class="owl-carousel js-gallery news_slider">
                                {foreach $post->getImages() as $idx=>$image}
                                    {if $image != $post->getImage()}
                                        <div class="item">
                                            <div class="photo">
                                                <a href="#" data-reveal-id="{concat('thumbSmall_',$image->getId())}">
                                                    {$image->thumbup(310,225)->setAttr('itemprop','image')}
                                                </a>
                                            </div>
                                            <div id="{concat('thumbSmall_',$image->getId())}" class="reveal-modal large medium" data-reveal>
                                                {$image->setAttr('itemprop','image')}
                                                <p><b>{$post->getTitle()}</b></p><a class="close-reveal-modal">&#215;</a>
                                            </div>
                                        </div>
                                    {/if}
                                {/foreach}
                            </div>
                        </div>
                    {/if}
                {/block}
                {block 'post.contacts'}{/block}
             </div>  
           </div> 	
    </div>
    <div class="columns" id="newsComments">
        <h2>Комментарии</h2>
        {include 'inc/disqus'}
    </div>
{/block}
           </div>
           <div class="cell large-3 medium-12">
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
                        {/if}</a>
                      <div class="box-shadow_form">
                    <div class="box-shadow"></div>
                    <div class="form">
                        <div class="title">
                            {if $lang == 'en'}<a href="/en/analytics/digest"> <i class="fa fa-rss"></i>Sign up for Digest</a>
                        
                            
                        {else}
                            <a href="/analytics/digest"> <i class="fa fa-rss"></i>Подписка на дайджест</a>
                        {/if}
                         </a>
                          </div>
                          <div class="img"><img src="/i/digest_img.jpg"></div>
                        {subscribe}
                    </div>
                  </div>
                   <div class="box-shadow_archive">
                    <div class="box-shadow"></div>
                    <div class="archive">
                        <div class="title">
                           {if $lang == 'en'}<a href="/en/analytics/digest"> <img src="/i/download_icon.png" alt="Загрузить" title="Загрузить">Archive</a>
                           
                            
                        {else}
                           <a href="/analytics/digest"> <img src="/i/download_icon.png" alt="Загрузить" title="Загрузить">Архив выпусков</a>
                        {/if}</a>
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