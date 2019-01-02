{extends 'Page.view'}
{block 'page.class' append} digest{/block}
{block 'aside.digest'}{/block}
{block 'aside.subscribe'}{/block}
{block 'content' prepend}
    {include 'partial/post' post=$page}
    <div class="grid-x grid-margin-x digest_row wrapper">
        <div class="medium-8 cell" style="position: relative;">
            <div class="inner">
                <div class="box-shadow"></div>
                <h3><i class="fa fa-rss"></i>Бесплатная подписка на дайджест</h3>
                <div class="pad">{subscribe template="Mail.subscribe_digest"}</div>
            </div>
        </div>
        <div  class="medium-4 cell" style="position: relative;">
            <div class="inner">
                <div class="box-shadow"></div>
                <h3><i class="fa fa-rss"></i>Архив выпусков</h3>
                <div class="pad">
                    <div id="digest">
                        {load_digests}
                        {foreach $digests as $digest}
                            <a class="m{$digest->getPubDate()->format('n')} y{$digest->getPubDate()->format('Y')}" href="{$digest->getUrl()}"></a>
                        {/foreach}
                    </div>
                    <div class="select year">
                        <select name="archiveFormYear" id="archiveFormYear">
                            {$now = date_create()}
                            {for $year=2012 to $now->format('Y')}
                                <option value="{$year}" label="{$year}"{if $digest->getPubDate()->format('Y')==$year} selected{/if}>{$year}</option>
                            {/for}
                        </select>
                    </div>
                    <div class="select months">
                        <select name="archiveFormMonths" id="archiveFormMonths">
                            {foreach ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'] as $id => $name}
                                <option value="{$id+1}"{if $digest->getPubDate()->format('n')==$id+1} selected{/if} label="{$name}">{$name}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="text-center">
                        <a class="blue_but" target="_blank" id="archiveFormButton" href="/data/digest/inventure-investment-digest-april-2013.pdf">Скачать</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
{/block}