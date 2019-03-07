{extends 'Page.view'}
{block 'page.class' append} digest{/block}
{block 'aside.digest'}{/block}
{block 'aside.subscribe'}{/block}
{block 'content' prepend}
      <div class="grid-x grid-margin-x digest_row wrapper">
        <div class="small-12 cell" style="position: relative;">
            <div class="box-shadow"></div>

            <div class="digest">
              <div class="digest__header">
                <ul class="digest__years">
                  <li class='active'>2019</li>
                  <li>2018</li>
                  <li>2017</li>
                </ul>
                <button class="newsletter__button newsletter__button--white open_popup digest__subscription">Подписаться на рассылку</button>
              </div>
              <div class="digest__wrapper">
                <div class="digest__months">
                    <ul class="digest__month active" id="digest__month-2019">
                        <li hidden></li>
                        <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters_en/2019-2.png" alt="">February</a></li>
                    </ul>

                  <ul class="digest__month" id="digest__month-2018">
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters_en/2018-1.png" alt="">January</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters_en/2018-2.png" alt="">February</a></li>
                    <li hidden></li>
                    <li hidden></li>
                    <li hidden></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters_en/2018-6.png" alt="">June</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters_en/2018-7.png" alt="">July</a></li>
                    <li hidden></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters_en/2018-9.png" alt="">September</a></li>
                  </ul>

                  <ul class="digest__month" id="digest__month-2017">
                    <li hidden></li>
                    <li hidden></li>
                    <li hidden></li>
                    <li hidden></li>
                    <li hidden></li>
                    <li hidden></li>
                    <li hidden></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters_en/2017-8.png" alt="">August</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters_en/2017-9.png" alt="">September</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters_en/2017-10.png" alt="">October</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters_en/2017-11.png" alt="">November</a></li>
                  </ul>

              </div>
            </div>


        </div>
    </div>
    </div>

<div id="hidden-digest" hidden>

    {load_digests}
    {foreach $digests as $digest}
        <div data-year="{$digest->getPubDate()->format('Y')}" data-month="{$digest->getPubDate()->format('n')}">{$digest->getUrl()}</div>
    {/foreach}
</div>
{/block}
