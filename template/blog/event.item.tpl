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
    <section class="grid-container investment_single search_result event_single"  itemscope itemtype="http://schema.org/Event">
      <div class="grid-x grid-margin-x">
        <div class="cell large-9 medium-12">
          {block 'breadcrumbs'}
    <div class="clearfix border-bottom">
        <h2>Мероприятия</h2>
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
        <div class="medium-{$post_head_size.0|default:5} columns photo-in">
        {block 'post.image'}
            <div id="newsThumb">
                <a href="#" itemprop="url" data-reveal-id="thumbBig">
                    {if $post->hasImage()}{$post->getImage()->thumbup(350,254)}{else}<img src="/skynar/img/no_image.svg" />{/if}
                </a>
            </div>
            <div id="thumbBig" class="reveal-modal large medium" data-reveal>
                <img itemprop="image"  src="{$post->getImage()->getUrl()}" itemscope itemtype="http://schema.org/URL" itemtype="http://schema.org/ImageObject" alt='{$post->getTitle()}' />
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
                            <h3 itemprop="name">{$post->getH1()}</h3>
                            {block 'description'}
                                <ul class="list_attr">
                                    <li>{$post->getShortText()|truncate:200:"  ..."}</li>
                                </ul>
                            {/block}
                            <div class="row">
                                <div class="columns">
                                    <ul class="inline-list share-btn">
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
    	<div style="position: relative;">
    		<div class="box-shadow3"></div>
	        <div class="event_time"  itemprop="name">
			    <ul>
			        <li><b>Организатор</b>: <span itemprop="organizer">{$post->getAttr(9)}</span></li>
			        <li><b>Начало</b>: <span itemprop="startDate" content="{$post->getAttr(7)->format('Y-m-d,H:i')}">{$post->getAttr(7)->format('d.m.Y, H:i')}</span></li>
			        <li><b>Окончание</b>: <span itemprop="endtDate" content="{$post->getAttr(8)->format('Y-m-d')}">{$post->getAttr(8)->format('d.m.Y, H:i')}</span></li>
			        <li itemprop="location"><b>Локация</b>: <span>{$post->getAttr(11)}</span></li>
			        {if ($post->getAttr(10))}<li><b>Адрес</b>: <span itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">{$post->printAttr(10)}</span></li>{/if}
			        {if ($post->getAttr(6))}<li><b>Сайт</b>: <a href="{$post->getAttr(6)}" target="_blank" itemprop="url">{$post->getAttr(6)}</a></li>{/if}
			    </ul>
			</div>
		</div>
          <div class="wrapper">
        <div class="row">
            <div class="box-shadow"></div>
            <div class="columns">
                <div class="viewbox-cnt-body m_b-20" itemprop="description">
                    {block 'post.content'}
                        {content $post}
                    {/block}
                    <div class="row">
                    <div class="columns">
                        <ul class="inline-list share-btn">
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
           <div class="columns">
                    <div style="position: relative;">
                    	<div class="box-shadow box-shadow1"></div>
	                    <div class="contacts">
	                        <h2>Контакты</h2>
	                        <div class="contacts1">
                            {if $post->getAttr(5) && $post->getAttr(4) && $post->getAttr(3)}

                                <div class="avatar"><img src="/i/no-photo.png" alt=""></div>
                                <div class="data_contacts">
                                <p><b>Имя:</b> {$post->getAttr(5)}</p>
                                <p><b>E-Mail:</b> <a href="mailto:{$post->getAttr(5)}">{$post->getAttr(4)}</a></p>
                                <p><b>Телефон:</b> <a href="tel:{$post->getAttr(3)}">{$post->getAttr(3)}</a></p>
                                </div>

                            {else}

                                <div class="avatar"><img src="/i/no-photo.png" alt=""></div>
                                <div class="data_contacts">
                                    <p><b>Имя:</b> Алексей Олейников</p>
                                    <p><b>E-Mail:</b> <a href="mailto:info@inventure.ua">info@inventure.ua</a></p>
                                    <p><b>Телефон:</b> <a href="tel:+380677136571">+38(067)713-65-71</a></p>
                                </div>

                            {/if}
                        </div>
	                    </div>
					</div>
                {block 'map'}
                    {$loc = $post->getAttr(10)}
                    {if $loc.lat && $loc.lng}
                    <div style="position: relative;">
                    	<div class="box-shadow box-shadow2"></div>
	                    <div class="map" id="eventMapBlock">
	                        <h2>Карта</h2>
	                        <div><div id="google_map"></div></div>
	                    </div>
					</div>
                    {script_code require="jquery,google_maps_api"}
                    {script 'google_maps_api'}
                    loader.on('google_maps',function(){
                        map = new google.maps.Map($('#google_map')[0], {
                                zoom: 14,
                                center: new google.maps.LatLng({number_format($loc.lat,5,'.','')}, {number_format($loc.lng,5,'.','')}),
                                mapTypeId: google.maps.MapTypeId.ROADMAP,
                                mapTypeControl: false,
                                rotateControl: false,
                                streetViewControl: false,
                        });
                        marker = new google.maps.Marker({
                            map: map,
                            position: new google.maps.LatLng({number_format($loc.lat,5,'.','')}, {number_format($loc.lng,5,'.','')})
                        });
                    });
                    {/script_code}
                {/if}
                {/block}
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
                        {/if}
                      <div class="box-shadow_form">
                    <div class="box-shadow"></div>
                    <div class="form">
                        <div class="title">
                            {if $lang == 'en'}<a href="/en/analytics/digest"> <i class="fa fa-rss"></i>Sign up for Digest</a>


                        {else}
                            <a href="/analytics/digest"> <i class="fa fa-rss"></i>Подписка на дайджест</a>
                        {/if}
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
                        {/if}
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
              </aside>
        </div>
     </div>
</div>

