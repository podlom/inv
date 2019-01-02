{extends 'blog/analytics.list'}{* ANALYTICS TEMPLATE! *}
{block 'page.class' append} news_single library{/block}
{block 'content.text'}
<div class="wrapper">
    <div class="box-shadow"></div>
    <div class="search-cnt clearfix">
        {filter fields=[48,49,62]}
        <form name="library-form" method="get">
            <div>
                    {$filter->getField('search')->getInput()->setAttr('placeholder', "Search by name")}
                    <button class="blue_but m_t-5" type="submit" aria-label="submit form">Search</button>
            </div>
            <div class="grid-x">
                <div class="large-4 medium-4 cell">
                    <h3>Type:</h3>
                    {$filter->getField(48)->getInput()->setId('lib2')->addClass('')}
                </div>
                <div class="large-4 medium-4 cell">
                    <h3>Language:</h3>
                    {$filter->getField(49)->getInput()->setId('lib3')->addClass('')}
                </div>
                <div class="large-4 medium-4 cell">
                    <h3>Year:</h3>
                    <select name="{$filter->getField(62)->getInput()->getName()}">
                        <option></option>
                        <option>2018</option>
                        <option>2017</option>
                        <option>2016</option>
                        <option>2015</option>
                        <option>2014</option>
                    </select>
                </div>
            </div>
        </form>
    </div>
    <ul class="info_table">
        <li class="thead">
          <div>Title</div>
          <div>Year</div>
          <div>Type</div>
          <div>Language</div>
          <div>Source</div>
        </li>
        {$posts->setCount(50)}
        {foreach $posts as $post}
            <li class="tbody">
                <div class="text-left" data-header="Название"><span><a href="{if $post->getImage()}{$post->getImage()->getUrl()}{else}#{/if}" class="LibraryLinkDownload">{$post->getH1()}</a></span></div>
                <div data-header="Год">{$post->getAttr('62')}</div>
                <div data-header="Тематика"><span>{$post->printAttr(48)}</span></div>
                <div data-header="Язык"><span>
                    {if ($post->getAttr("49") == 1)}
                        <img alt="Ru" src="http://pbwm.ru/images/flags/png/ru.png?1291794745"/>
                    {elseif ($post->getAttr("49") == 2)}
                        <img alt="Gb" src="http://pbwm.ru/images/flags/png/gb.png?1291794745"/>
                    {elseif ($post->getAttr("49") != 2) && ($post->getAttr("49") != 1)}
                        <img alt="Ua" src="http://pbwm.ru/images/flags/png/ua.png?1291794745" />
                    {/if}
                </span></div>
                <div class="text-left" data-header="Источник"><span>{$post->getAttr("1")}</span></div>
            </li>
        {/foreach}
    </ul>

    {foreach $posts as $post}
    <article class="library_mob">
        <p class="p1">Title</p>
        <h6>{$post->getH1()}</h6>
        <p class="p1">Language</p>
        <p>{$post->getAttr('62')}</p>
        <p class="p1">Type</p>
        <p>{$post->printAttr(48)}</p>
        <p class="p1">Language</p>
        <p>
        {if ($post->getAttr("49") == 1)}
            <img alt="Ru" src="http://pbwm.ru/images/flags/png/ru.png?1291794745"/> Russian
        {elseif ($post->getAttr("49") == 2)}
            <img alt="Gb" src="http://pbwm.ru/images/flags/png/gb.png?1291794745"/> English
        {elseif ($post->getAttr("49") != 2) && ($post->getAttr("49") != 1)}
            <img alt="Ua" src="http://pbwm.ru/images/flags/png/ua.png?1291794745" /> Ukrainian
        {/if}
        </p>
        <p class="p1">Source</p>
        <p>{$post->getAttr("1")}</p>
    </article>
    {/foreach}
    <ul class="pagination">
        {foreach $posts->getPagination()->getLinks() as $a}
            <li class="{$a->getAttr('class')}">{$a->setAttr('class', '')}</li>
        {/foreach}
    </ul>
</div>
{/block}