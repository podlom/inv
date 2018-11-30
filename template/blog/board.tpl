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
    <section class="grid-container news_list board_page">
      <div class="grid-x grid-margin-x">
        <div class="cell large-9 medium-12">
          {block 'breadcrumbs'}
    <div class="clearfix border-bottom">
        <h2>Доска объявлений</h2>
        <a href="/bulletin/add">Добавить объявление</a>
    </div>
    <nav>
      <a href="/board/projects">Инвестиционные проекты и стартапы</a> |
      <a href="/board/business">Продажа бизнеса</a> |
      <a href="/board/realestate">Недвижимость</a> |
      <a href="/board/land">Земельные участки</a> |
      <a href="/board/offer">Инвесторы</a>
    </nav>
    <div class="mobile_category">
      <a href="/board/projects">Инвестиционные проекты и стартапы</a><i class="fa fa-chevron-right"></i><i class="fa fa-chevron-down"></i>
      <ul>
          <li><a href="/board/business">Продажа бизнеса</a></li>
          <li><a href="/board/realestate">Недвижимость</a></li>
          <li><a href="/board/land">Земельные участки</a></li>
          <li><a href="/board/offer">Предложения инвесторов</a></li>
      </ul>
  </div>
{/block}
{block 'posts'}
        {foreach $posts as $post}
            {block 'post'}
            <div class="row">
              <div style="position: relative;">
                <div class="auto-height">
                    <div class="medium-{$post_size.0|default:5} columns photo-in {$image_class}">
                        {block 'image'}
                        {if $post->getImage()}
                                <a href="{$post->getPath()}">{$post->getImage()->thumbup(350,254)}</a>
                        {elseif substr($post->getPath(),0,14) == "/tools/video"}
                            <div>{$post->getAttr(55)}</div>
                        {else}
                                <img src="/img/resize.375.225/images/noThumb.jpg" alt="{$post->getH1()}" itemscope itemtype="http://schema.org/ImageObject"/>
                        {/if}
                        {/block}
                    </div>
                    <div class="medium-{$post_size.1|default:7} columns">
                        <div class="viewbox-cnt attr-in">
                            <div class="hint m_b-10">
                            {block 'post.meta'}
                                <span>ID: {$post->getId()}</span>
                                {block 'post.publish'}<time class="time">{$post->getPublished()->format('d.m.y')}</time>{/block}
                            {if $post->getParent()->getId() == 15088}
                                <a href="{$post->getParent()->getPath()}"><img src="/i/projects.png" alt="" class="category"/>{$post->getParent()->getH1()}</a>
                            {elseif $post->getParent()->getId() == 15089}
                                <a href="{$post->getParent()->getPath()}"><img src="/i/business.png" alt="" class="category"/>{$post->getParent()->getH1()}</a>
                            {elseif $post->getParent()->getId() == 15090}
                                <a href="{$post->getParent()->getPath()}"><img src="/i/realestate.png" alt="" class="category"/>{$post->getParent()->getH1()}</a>
                            {elseif $post->getParent()->getId() == 15091}
                                <a href="{$post->getParent()->getPath()}"><img src="/i/land.png" alt="" class="category"/>{$post->getParent()->getH1()}</a>
                            {elseif $post->getParent()->getId() == 15092}
                                <a href="{$post->getParent()->getPath()}"><img src="/i/offer.png" alt="" class="category"/>{$post->getParent()->getH1()}</a>
                            {else}
                                <span></span>
                            {/if}
                            {/block}
                            </div>
                            <h3><a href="{$post->getPath()}">{$post->getH1()}</a></h3>
                            <div class="place">
                                <img src="/i/ukraine.png">{if $post->hasAttr("10")} {$post->printAttr("10")}{/if}
                            </div>
                            <div class="price">
                            {if $post->getParent()->getId() == 15089 || $post->getParent()->getId() == 15090 ||$post->getParent()->getId() == 15091}
                              <p><span style="font-weight: 700;">ЦЕНА</span> - 
                              {if $post->getAttr("15")!=''} ${$post->printAttr("15")|number_format:0:'.':' '}{else}Договорная{/if}</p>
                            {elseif $post->getParent()->getId() == 15088}
                              <p><span style="font-weight: 700;">ИНВЕСТИЦИИ</span> - 
                              {if $post->hasAttr("15")} ${$post->printAttr("15")|number_format:0:'.':' '}{/if}</p>
                            {elseif $post->getParent()->getId() == 15092}
                              <p><span style="font-weight: 700;">ИНВЕСТИЦИИ</span> - 
                              {if $post->hasAttr("15")} ${$post->printAttr("15")|number_format:0:'.':' '}{/if}</p>
                              {/if} 
                            </div>
                        </div>
                    </div>
                    </div>
                    <div class="accordion" id="adv-{$post->getId()}">
                        <p class="toggle_btn"><span>Показать текст обьявления</span><span>Скрыть текст обьявления</span></p>
                        <article class="block">
                            {block 'post.content'} 
                                {content $post}
                            {/block}
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
                        </article>
					</div>
               </div>
            </div>
            {/block}
        {/foreach}
    {/block}
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
        <div class="cell large-3 medium-12">
          <aside class="sidebar">
            <a href="/investor" class="invest_btn">инвестировать</a>
            <a href="/add-inv-prop" class="invest_btn invest_btn1">найти инвестора</a>
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
