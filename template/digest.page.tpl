{* prefilter=off *}
{extends 'Page.view'}
{block 'page.class' append} digest{/block}
{block 'aside.digest'}{/block}
{block 'aside.subscribe'}{/block}
{block 'content' prepend}
{load_digests}
{$month = [1=>'Январь','Февраль','Март','Апрель','Май','Июнь','Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь']}
{$first = reset($digests)}
    <div class="grid-x grid-margin-x digest_row wrapper">
        <div class="small-12 cell" style="position: relative;">
            <div class="box-shadow"></div>

            <div class="digest">
              <div class="digest__header">
                <ul class="digest__years">
                  {for $y=intval($now->format('Y')) to intval($first->getPubDate()->format('Y')) step -1}
                    <li{if $now->format('Y')==$y} class='active'{/if}>{$y}</li>
                  {/for}
                </ul>
                <button class="newsletter__button newsletter__button--white open_popup digest__subscription">Подписаться на рассылку</button>
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
    </div>

<div id="hidden-digest" hidden>

</div>

{/block}


