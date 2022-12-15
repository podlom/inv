{* prefilter=off *}
{extends 'Page.view'}
{block 'page.class' append} digest{/block}
{block 'aside.digest'}{/block}
{block 'aside.subscribe'}{/block}
{block 'page.title'}{/block}
{block 'breadcrumbs'}{/block}
{block 'content'}
{load_digests}
{* 
{$month = [1=>'Январь','Февраль','Март','Апрель','Май','Июнь','Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь']}
{$first = reset($digests)}
  <div class="grid-x grid-margin-x digest_row wrapper">
      <div class="small-12 cell" style="position: relative;">
          <div class="box-shadow"></div>

          <div class="digest post__wrapper mb-6">
            <div class="digest__header" style="border-top-right-radius: 4px; border-top-left-radius: 4px;">
              <ul class="digest__years">
                {for $y=intval($now->format('Y')) to intval($first->getPubDate()->format('Y')) step -1}
                  <li {if $now->format('Y')==$y} class='active'{/if}>{$y}</li>
                {/for}
              </ul>
              <button class="open_popup newsletter__btn font-semibold" data-remodal-target="subscribe">Подписаться на рассылку</button>
            </div>
            <div class="digest__wrapper">
              <div class="digest__months">
                {foreach array_reverse($digests) as $digest}
                  {if !$prev || $prev->getPubDate()->format('Y') != $digest->getPubDate()->format('Y')}
                    {if $prev}</ul>{/if}
                    <ul class="digest__month{if !$prev} active{/if}" id="digest__month-{$digest->getPubDate()->format('Y')}">
                  {/if}
                  <li><a target="_blank" href='{$digest->getUrl()}'><img src="{if $digest->getImage()}{$digest->getImage()->thumbup(120,170)->getUrl()}{else}/img/thumbup.120.170/images/newsletters/{$digest->getPubDate()->format('Y-n')}.png{/if}" alt="">{$month[intval($digest->getPubDate()->format('n'))]}</a></li>
                  {$prev = $digest}
                {/foreach}
                </ul>
            </div>
          </div>


        </div>
    </div>
</div> *}

<section class="archive mb-12">
    
        <div class="subscription__bottom grid-container container">
            {load_digests}
						{if $lang === 'ru'}
							{$month = [1=>'Январь','Февраль','Март','Апрель','Май','Июнь','Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь']}
						{elseif $lang == 'uk'}
							{$month = [1=>'Січень','Лютий','Березень','Квітень','Травень','Червень','Липень','Серпень','Вересень','Жовтень','Листопад','Грудень']}
						{else}
							{$month = [1=>"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]}
						{/if}
            {$first = reset($digests)}
                    <div class="w-full" style="position: relative;">
                      <h1 class="section__title text-center">
												{if $lang == 'ru'}
													Инвестиционный дайджест InVenture
												{elseif $lang == 'uk'}
													Інвестиційний дайджест InVenture
												{else}
													Investment Digest InVenture
												{/if}
											</h1>
                      <p style="max-width: 640px;text-align: center;margin: 0 auto 20px;">
											{if $lang === 'ru'}
												Все самое важное в сфере инвестиций за месяц,<br /> на 10 страницах, всего за 5 минут!
											{elseif $lang == 'uk'}
												Все найважливіше у сфері інвестицій за місяць,<br /> на 10 сторінках, всього за 5 хвилин!
											{else}
												An electronic professional journal that provides<br /> monthly overview in sphere of direct investment and venture capital.
											{/if}
											</p>
                      <button data-remodal-target="subscribe" class="btn btn--normal btn--blue pl-6 pr-6 mobile-mb-2 ml-auto mr-auto">
												{if $lang == 'ru'}Подписаться{elseif $lang == 'uk'}Підписатися{else}Subscribe{/if}
											</button>
                        <div class="digest__header mt-8 mb-4 ml-auto mr-auto block">
                            <ul class="digest__years">
                                {for $y=intval($now->format('Y')) to intval($first->getPubDate()->format('Y')) step -1}
                                    <li{if $now->format('Y')==$y} class='active'{/if}>{$y}</li>
                                {/for}
                            </ul>
                        </div>
                        <div class="digest">
                            <div class="digest__wrapper">
                                <div class="digest__months">
                                {foreach array_reverse($digests) as $digest}
                                {if !$prev || $prev->getPubDate()->format('Y') != $digest->getPubDate()->format('Y')}
                                {if $prev}</ul>{/if}
                                <ul class="digest__month{if !$prev} active{/if}" id="digest__month-{$digest->getPubDate()->format('Y')}">
                                {/if}
                                <li><a target="_blank" href='{$digest->getUrl()}'><img src="{if $digest->getImage()}{$digest->getImage()->getUrl()}{else}/images/newsletters/{$digest->getPubDate()->format('Y-n')}.png{/if}" alt="">{$month[intval($digest->getPubDate()->format('n'))]}</a></li>
                                {$prev = $digest}
                                {* 180,260 *}
                            {/foreach}
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            {* <div id="hidden-digest" hidden></div> *}
        </div>
    </section>

<div id="hidden-digest" hidden></div>


{if $lang === 'ru'}
	{include 'components/reviews' category='digest-social'  title="Отзывы о дайджесте"}
{elseif $lang == 'uk'}
	{include 'components/reviews' category='digest-social'  title="Відгуки про дайджест"}
{else}
	{* {include 'components/reviews' category='digest-social'  title="Digest Reviews"} *}
{/if}


<div class="mt-4 mb-8 container">
  {block 'content.text'}
    {content $editable attr=['class'=>'the_post_content', 'itemprop'=>'text']}
  {/block}
</div>
{/block}