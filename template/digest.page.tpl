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
                  <li>2016</li>
                  <li>2015</li>
                  <li>2014</li>
                  <li>2013</li>
                </ul>
                <button class="newsletter__button newsletter__button--white open_popup digest__subscription">Подписаться на рассылку</button>
              </div>
              <div class="digest__wrapper">
                <div class="digest__months">
                    <ul class="digest__month active" id="digest__month-2019">
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2019-1.png" alt="">Январь</a></li>
                  </ul>
                  <ul class="digest__month" id="digest__month-2018">
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2018-1.png" alt="">Январь</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2018-2.png" alt="">Февраль</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2018-3.png" alt="">Март</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2018-4.png" alt="">Апрель</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2018-5.png" alt="">Май</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2018-6.png" alt="">Июнь</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2018-7.png" alt="">Июль</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2018-8.png" alt="">Август</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2018-9.png" alt="">Сентябрь</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2018-10.png" alt="">Октябрь</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2018-11.png" alt="">Ноябрь</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2018-12.png" alt="">Декабрь</a></li>
                  </ul>

                  <ul class="digest__month" id="digest__month-2017">
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2017-1.png" alt="">Январь</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2017-2.png" alt="">Февраль</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2017-3.png" alt="">Март</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2017-4.png" alt="">Апрель</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2017-5.png" alt="">Май</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2017-6.png" alt="">Июнь</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2017-7.png" alt="">Июль</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2017-8.png" alt="">Август</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2017-9.png" alt="">Сентябрь</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2017-10.png" alt="">Октябрь</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2017-11.png" alt="">Ноябрь</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2017-12.png" alt="">Декабрь</a></li>
                  </ul>

                  <ul class="digest__month" id="digest__month-2016">
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2016-1.png" alt="">Январь</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2016-2.png" alt="">Февраль</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2016-3.png" alt="">Март</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2016-4.png" alt="">Апрель</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2016-5.png" alt="">Май</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2016-6.png" alt="">Июнь</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2016-7.png" alt="">Июль</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2016-8.png" alt="">Август</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2016-9.png" alt="">Сентябрь</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2016-10.png" alt="">Октябрь</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2016-11.png" alt="">Ноябрь</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2016-12.png" alt="">Декабрь</a></li>
                  </ul>

                  <ul class="digest__month" id="digest__month-2015">
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2015-1.png" alt="">Январь</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2015-2.png" alt="">Февраль</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2015-3.png" alt="">Март</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2015-4.png" alt="">Апрель</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2015-5.png" alt="">Май</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2015-6.png" alt="">Июнь</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2015-7.png" alt="">Июль</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2015-8.png" alt="">Август</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2015-9.png" alt="">Сентябрь</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2015-10.png" alt="">Октябрь</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2015-11.png" alt="">Ноябрь</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2015-12.png" alt="">Декабрь</a></li>
                  </ul>

                  <ul class="digest__month" id="digest__month-2014">
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2014-1.png" alt="">Январь</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2014-2.png" alt="">Февраль</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2014-3.png" alt="">Март</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2014-4.png" alt="">Апрель</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2014-5.png" alt="">Май</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2014-6.png" alt="">Июнь</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2014-7.png" alt="">Июль</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2014-8.png" alt="">Август</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2014-9.png" alt="">Сентябрь</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2014-10.png" alt="">Октябрь</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2014-11.png" alt="">Ноябрь</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2014-12.png" alt="">Декабрь</a></li>
                  </ul>

                  <ul class="digest__month" id="digest__month-2013">
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2013-1.png" alt="">Январь</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2013-2.png" alt="">Февраль</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2013-3.png" alt="">Март</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2013-4.png" alt="">Апрель</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2013-5.png" alt="">Май</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2013-6.png" alt="">Июнь</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2013-7.png" alt="">Июль</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2013-8.png" alt="">Август</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2013-9.png" alt="">Сентябрь</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2013-10.png" alt="">Октябрь</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2013-11.png" alt="">Ноябрь</a></li>
                    <li><a target="_blank" href=''><img src="http://f.inventure.com.ua/images/newsletters/2013-12.png" alt="">Декабрь</a></li>
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


