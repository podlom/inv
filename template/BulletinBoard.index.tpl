{extends 'Blog.blog'}
{block 'config'}
{$posts = $items}
{/block}
{block 'post.meta'}

    {block 'post.publish'}<time class="time">{$post->getPublished()->format('d.m.y')}</time>{/block}

    {block 'post.id-num'}
        <span class="id-number"><strong style="margin: 0 5px 0 0">ID:</strong> {$post->getId()}</span>
    {/block}

    <!-- @ts bulletin board wtf ?!! -->

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
{block 'page.class' append} board_page my_board{/block}
{block 'page.title'}
<div class="clearfix border-bottom">
    <h2>Мои обьявления ({$items->getTotal()})</h2>
    <a class="add_board" href="/bulletin/add">Добавить объявление</a>
</div>
{/block}
{block 'breadcrumbs'}
<div class="del_adv">Вы подали запрос на удаление объявления. Оно больше не отображается на сайте и не участвует в поиске. После проверки нашим модератором, объявление будет удалено полностью.</div>
{/block}
{block 'post.share'}{/block}
{block 'post.author'}{/block}
{block 'post.description'}
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
<div class="del_edit_buttons">
    <a href="{$controller->getUrlGenerator()->generate('edit', ['id'=>$post->getId()])}"><img src="/i/edit.png"> Редактировать обьявление</a>
    {if $post->getStatus() == '1'}<a href="{$controller->getUrlGenerator()->generate('hide', ['id'=>$post->getId()])}" id="del_adv"><img src="/i/trash.png"> Удалить</a>{/if}

    {if $post->getAttr(61) != '1'}
    <a href="/bulletin/pay/{$post->getId()}" class="pay_btn">Оплатить</a>
    {elseif $post->getStatus() == '0'}
    <p class="status">На модерации</p>
    {elseif $post->getStatus() == '1'}
    <p class="status">Опубликовано</p>
    {/if}
</div>
{/block}
{*
        {block 'posts'}
        {foreach $items as $post}
            {include 'partial/post'}
            {block 'post'}
            <div class="grid-x grid-margin-x">
              <div style="position: relative;">
                <div class="box-shadow"></div>
                <div class="auto-height">
                    <div class="medium-{$post_size.0|default:5} cell photo-in {$image_class}">
                        {block 'image'}
                        {if $post->getImage()}
                                {$post->getImage()->thumbup(350,254)}
                        {elseif substr($post->getPath(),0,14) == "/tools/video"}
                            <div>{$post->getAttr(55)}</div>
                        {else}
                                <img src="/img/resize.375.225/images/noThumb.jpg" alt="{$post->getH1()}" />
                        {/if}
                        {/block}
                    </div>
                    <div class="medium-{$post_size.1|default:7} cell">
                        <div class="viewbox-cnt attr-in">
                            <div class="hint m_b-10">

                            </div>
                            <h3><a href="{$post->getPath()}">{$post->getH1()}</h3>
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
                            <div class="del_edit_buttons">
                            	<a href="{$controller->getUrlGenerator()->generate('edit', ['id'=>$post->getId()])}"><img src="/i/edit.png"> Редактировать обьявление</a>
								{if $post->getStatus() == '1'}<a href="{$controller->getUrlGenerator()->generate('hide', ['id'=>$post->getId()])}" id="del_adv"><img src="/i/trash.png"> Удалить</a>{/if}

                                {if $post->getAttr(61) != '1'}
                                <a href="/bulletin/pay/{$post->getId()}" class="pay_btn">Оплатить</a>
                                {elseif $post->getStatus() == '0'}
                                <p class="status">На модерации</p>
                                {elseif $post->getStatus() == '1'}
                                <p class="status">Опубликовано</p>
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
        </div>
        <div class="cell large-3 medium-12">
          <aside class="sidebar">
            <a href="/investor" class="invest_btn">инвестировать</a>
            <a href="/add-inv-prop" class="invest_btn invest_btn1">найти инвестора</a>
                  <div class="box-shadow_form">
                <div class="box-shadow"></div>
                <div class="form">
                    <div class="title">
                        <a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/analytics/digest"> <i class="fa fa-rss"></i>
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
                           <a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/analytics/digest"><img src="/i/download_icon.png" alt="Загрузить" title="Загрузить">
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
*}