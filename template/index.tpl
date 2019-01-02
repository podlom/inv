{* prefilter=off *}
{$month=[1=>"января","февраля", "марта","апреля", "мая", "июня", "июля", "августа", "сентября", "октября", "ноября", "декабря"]}
<div class="grid-container investment_proposals" id="investment">
      <div class="grid-x grid-margin-x">
        <div class="cell medium-12 large-9">
          <section class="investment">
            <div class="title">
              <h2><a href="/investments">Инвестиционные предложения</a></h2>
            </div>
            <nav>
              <a href="/investments/projects">Инвестиционные проекты и стартапы</a> |
              <a href="/investments/business">Продажа бизнеса</a> |
              <a href="/investments/realestate">Недвижимость</a> |
              <a href="/investments/land">Земельные участки</a> |
              <a href="/investments/offer">Инвесторы</a>
            </nav>
            <div class="mobile_category">
              <a href="/investments/projects">Инвестиционные проекты и стартапы</a><i class="fa fa-chevron-right"></i><i class="fa fa-chevron-down"></i>
              <ul>
                  <li><a href="/investments/business">Продажа бизнеса</a></li>
                  <li><a href="/investments/realestate">Недвижимость</a></li>
                  <li><a href="/investments/land">Земельные участки</a></li>
                  <li><a href="/investments/offer">Предложения инвесторов</a></li>
              </ul>
          </div>
            <article class="grid-container">
                    <div class="grid-x grid-margin-x">
                      <div class="cell small-5">
                      	{lent_load '/investments' 6 var="posts" analytics=1}
						            {$bigpost=array_shift($posts)}
                      <div style="position: relative;">
                        <div class="box-shadow"></div>
                        <div class="title-news">
                          <div class="img">
                            <a href="{$bigpost->getPath()}">
                              {$bigpost->getImage()->thumbup(350,254)}
                            </a>
                          </div>
                          <div class="info">
                            <div class="statistic">
                              <div class="date">
                                {$bigpost->getPublished()->format('d.m.y')}
                              </div>
                              <div class="views">
                                <img src="/i/views.png">
                                {$bigpost->getViews()}
                              </div>
                              <div class="rating">
                                <img src="/i/rating.png">
                                {$bigpost->getRating()|number_format:1}
                              </div>
                            </div>
                            <div class="category">
                              {if $bigpost->getParent()->getId() == 7860}
                                  <a href="{$bigpost->getParent()->getPath()}"><img src="/i/projects.png" alt="" />{$bigpost->getParent()->getH1()}</a>
                              {elseif $bigpost->getParent()->getId() == 7861}
                                  <a href="{$bigpost->getParent()->getPath()}"><img src="/i/business.png" alt="" />{$bigpost->getParent()->getH1()}</a>
                              {elseif $bigpost->getParent()->getId() == 7862}
                                  <a href="{$bigpost->getParent()->getPath()}"><img src="/i/realestate.png" alt="" />{$bigpost->getParent()->getH1()}</a>
                              {elseif $bigpost->getParent()->getId() == 7863}
                                  <a href="{$bigpost->getParent()->getPath()}"><img src="/i/land.png" alt="" />{$bigpost->getParent()->getH1()}</a>
                              {elseif $bigpost->getParent()->getId() == 7864}
                                  <a href="{$bigpost->getParent()->getPath()}"><img src="/i/offer.png" alt="" />{$bigpost->getParent()->getH1()}</a>
                              {else}
                                  <span></span>
                              {/if}
                            </div>
                            <h4><a href="{$bigpost->getPath()}">{$bigpost->getTitle()}</a></h4>
                            <p>{$bigpost->getShortText()|truncate:150:"  ..."}</p>
                            <div class="position">
                          <div class="place">
                            <img src="/i/ukraine.png">{if $bigpost->hasAttr("10")} {$bigpost->printAttr("10")}{/if}
                          </div>
                          <hr>
                          <div class="footer">
                            <div>
                            {if $bigpost->getParent()->getId() == 7861 || $bigpost->getParent()->getId() == 7862 ||$bigpost->getParent()->getId() == 7863}
                              <p><span style="font-weight: 700;">ЦЕНА</span> -
                              {if $bigpost->hasAttr("15")} ${$bigpost->printAttr("15")|number_format:0:'.':' '}{/if}</p>
                            {elseif $bigpost->getParent()->getId() == 7860}
                              <p><span style="font-weight: 700;">ИНВЕСТИЦИИ</span> -
                              {if $bigpost->hasAttr("34")} ${$bigpost->printAttr("34")|number_format:0:'.':' '}{/if}</p>
                            {elseif $bigpost->getParent()->getId() == 7864}
                              <p><span style="font-weight: 700;">ИНВЕСТИЦИИ</span> -
                              {if $bigpost->hasAttr("31")} ${$bigpost->printAttr("31")|number_format:0:'.':' '}{/if}</p>
                              {/if}
                            </div>
                          </div>
                        </div>
                          </div>
                        </div>
                      </div>
                      </div>
                      <div class="cell small-7">
                        <div class="tabs">
                          <ul class="tabs__caption">
                            <li class="active">Новые</li>
                            <li>Популярные</li>
                            <li>Лучшие</li>
                            <!--<li>По цене <i class="fa fa-arrow-up"></i></li>
                            <li>По цене <i class="fa fa-arrow-down"></i></li>-->
                          </ul>

                          <div class="tabs__content  active">
                                                   {foreach $posts as $post}
                            <div class="item">
                              <div class="img">
                                <a href="{$post->getPath()}" >
                                  {$post->getImage()->thumbup(120,90)}
                                </a>
                              </div>
                              <div class="content">
                                  <h4><a href="{$post->getPath()}">{$post->getTitle()}</a></h4>
                                  <div class="category">
                                  {if $post->getParent()->getId() == 7860}
                                      <a href="{$post->getParent()->getPath()}"><img src="/i/projects.png" alt="" />{$post->getParent()->getH1()}</a>
                                  {elseif $post->getParent()->getId() == 7861}
                                      <a href="{$post->getParent()->getPath()}"><img src="/i/business.png" alt="" />{$post->getParent()->getH1()}</a>
                                  {elseif $post->getParent()->getId() == 7862}
                                      <a href="{$post->getParent()->getPath()}"><img src="/i/realestate.png" alt="" />{$post->getParent()->getH1()}</a>
                                  {elseif $post->getParent()->getId() == 7863}
                                      <a href="{$post->getParent()->getPath()}"><img src="/i/land.png" alt="" />{$post->getParent()->getH1()}</a>
                                  {elseif $post->getParent()->getId() == 7864}
                                      <a href="{$post->getParent()->getPath()}"><img src="/i/offer.png" alt="" />{$post->getParent()->getH1()}</a>
                                  {else}
                                      <span></span>
                                  {/if}
                                </div>
                                <div class="statistic">
                                  <div class="date">
                                    {$post->getPublished()->format('d.m.y')}
                                  </div>
                                  <div class="views">
                                    <img src="/i/views.png">
                                    {$post->getViews()}
                                  </div>
                                  <div class="rating">
                                    <img src="/i/rating.png">
                                    {$post->getRating()|number_format:1}
                                  </div>
                                </div>
                              </div>
                            </div>
                            {/foreach}
                            <a href="/investments" class="more">Показать все</a>
                          </div>

                          <div class="tabs__content">
                            {lent '/investments' 5 order_by="a.views DESC" var='news' analytics=1}
                            <div class="item">
                              <div class="img">
                                <a href="{$news->getPath()}" >
                                  {$news->getImage()->thumbup(120,90)}
                                </a>
                              </div>
                              <div class="content">
                                  <h4><a href="{$news->getPath()}">{$news->getTitle()}</a></h4>
                                  <div class="category">
                                  {if $news->getParent()->getId() == 7860}
                                      <a href="{$news->getParent()->getPath()}"><img src="/i/projects.png" alt="" />{$news->getParent()->getH1()}</a>
                                  {elseif $news->getParent()->getId() == 7861}
                                      <a href="{$news->getParent()->getPath()}"><img src="/i/business.png" alt="" />{$news->getParent()->getH1()}</a>
                                  {elseif $news->getParent()->getId() == 7862}
                                      <a href="{$news->getParent()->getPath()}"><img src="/i/realestate.png" alt="" />{$news->getParent()->getH1()}</a>
                                  {elseif $news->getParent()->getId() == 7863}
                                      <a href="{$news->getParent()->getPath()}"><img src="/i/land.png" alt="" />{$news->getParent()->getH1()}</a>
                                  {elseif $news->getParent()->getId() == 7864}
                                      <a href="{$news->getParent()->getPath()}"><img src="/i/offer.png" alt="" />{$news->getParent()->getH1()}</a>
                                  {else}
                                      <span></span>
                                  {/if}
                                </div>
                                <div class="statistic">
                                  <div class="date">
                                    {$news->getPublished()->format('d.m.y')}
                                  </div>
                                  <div class="views">
                                    <img src="/i/views.png">
                                    {$news->getViews()}
                                  </div>
                                  <div class="rating">
                                    <img src="/i/rating.png">
                                    {$news->getRating()|number_format:1}
                                  </div>
                                </div>
                              </div>
                            </div>
                            {/lent}
                            <a href="/investments" class="more">Показать все</a>
                          </div>

                          <div class="tabs__content">
                            {lent '/investments' 5 order_by="a.rating DESC" var='news' analytics=1}
                            <div class="item">
                              <div class="img">
                                <a href="{$news->getPath()}" >
                                  {$news->getImage()->thumbup(120,90)}
                                </a>
                              </div>
                              <div class="content">
                                  <h4><a href="{$news->getPath()}">{$news->getTitle()}</a></h4>
                                  <div class="category">
                                  {if $news->getParent()->getId() == 7860}
                                      <a href="{$news->getParent()->getPath()}"><img src="/i/projects.png" alt="" />{$news->getParent()->getH1()}</a>
                                  {elseif $news->getParent()->getId() == 7861}
                                      <a href="{$news->getParent()->getPath()}"><img src="/i/business.png" alt="" />{$news->getParent()->getH1()}</a>
                                  {elseif $news->getParent()->getId() == 7862}
                                      <a href="{$news->getParent()->getPath()}"><img src="/i/realestate.png" alt="" />{$news->getParent()->getH1()}</a>
                                  {elseif $news->getParent()->getId() == 7863}
                                      <a href="{$news->getParent()->getPath()}"><img src="/i/land.png" alt="" />{$news->getParent()->getH1()}</a>
                                  {elseif $news->getParent()->getId() == 7864}
                                      <a href="{$news->getParent()->getPath()}"><img src="/i/offer.png" alt="" />{$news->getParent()->getH1()}</a>
                                  {else}
                                      <span></span>
                                  {/if}
                                </div>
                                <div class="statistic">
                                  <div class="date">
                                    {$news->getPublished()->format('d.m.y')}
                                  </div>
                                  <div class="views">
                                    <img src="/i/views.png">
                                    {$news->getViews()}
                                  </div>
                                  <div class="rating">
                                    <img src="/i/rating.png">
                                    {$news->getRating()|number_format:1}
                                  </div>
                                </div>
                              </div>
                            </div>
                            {/lent}
                            <a href="/investments" class="more">Показать все</a>
                          </div>
                          <div class="tabs__content">
                            qwerty
                          </div>
                          <div class="tabs__content">
                            qwerty 2
                          </div>
                        </div>
                      </div>
                    </div>
                  </article>
          </section>
        </div>
        <div class="cell large-3 medium-12">
          <aside class="sidebar">
            <a href="/investor" class="invest_btn">инвестировать</a>
            <a href="/add-inv-prop" class="invest_btn invest_btn1">Найти инвестора</a>
            <div class="board">
              <div class="box-shadow"></div>
            	<h3><a href="/board"><img src="i/board_ico.png">Доска объявлений</a> <a href="/bulletin/add">+ Добавить объявление</a></h3>
            	<div class="board1">
	            	{lent '/board' 7 var='post'  analytics=1}
	            	<div>
	            		<span class="published">{$post->getPublished()->format('d.m.y')}</span>
	            		<a href="/board#adv-{$post->getId()}">{$post->getH1()|truncate:100:"  ..."}</a>
	            	</div>
	            	{/lent}
	            </div>
	            <div class="buttons">
	            	<a href="/board" class="a1">Показать все</a>
	            	<a href="/bulletin/add" class="a2">Добавить объявление</a>
	            </div>
	        </div>
          </aside>
        </div>
      </div>
    </div>
    <div class="grid-container all_news" id="all_news">
      <div class="grid-x grid-margin-x">
        <div class="cell medium-12 large-9">
          <section class="news">
            <div class="title">
              <h2><a href="/news">Новости</a></h2>
            </div>
            <nav>
              <a href="/news/investments">Прямые инвестиции и M&A</a> |
              <a href="/news/startup">Стартапы</a> |
              <a href="/news/government">Макроинвестиции</a> |
              <a href="/news/banking">Кредитование</a> |
              <a href="/news/stock">Фондовый рынок</a> |
              <a href="/news/realestate">Недвижимость</a>
            </nav>
            <div class="mobile_category">
              <a href="/news/investments">Прямые инвестиции и M&A</a><i class="fa fa-chevron-right"></i><i class="fa fa-chevron-down"></i>
              <ul>
                  <li><a href="/news/startup">Стартапы</a></li>
                  <li><a href="/news/government">Макроинвестиции</a></li>
                  <li><a href="/news/banking">Кредитование</a></li>
                  <li><a href="/news/stock">Фондовый рынок</a></li>
                  <li><a href="/news/realestate">Недвижимость</a></li>
              </ul>
          </div>
            <article class="grid-container">
              <div class="grid-x grid-margin-x">
                <div class="cell small-5">
                	{lent_load '/news' 6 var="news_all" analytics=1}
					{$bignews=array_shift($news_all)}
                <div style="position: relative;">
                  <div class="box-shadow"></div>
                  <div class="title-news">
                    <div class="img">
                      <a href="{$bignews->getPath()}">
                                {$bignews->getImage()->thumbup(350,254)}
                            </a>
                    </div>
                    <div class="info">
                      <div class="statistic">
                        <div class="date">
                         {$bignews->getPublished()->format('d.m.y')}
                        </div>
                        <div class="views">
                          <img src="/i/views.png">
                          {$bignews->getViews()}
                        </div>
                      </div>
                      {$r=$bignews->getRubrics()}
                        {if $r.0}<div class="hint m_t-5 category"><a href="#"><img src="/i/folded-newspaper.png" alt="" />{$r.0->getH1()}</a></div>{/if}
                      <h4><a href="{$bignews->getPath()}">{$bignews->getTitle()}</a></h4>
                      <p>{$bignews->getShortText()|truncate:300:"  ..."}</p>
                    </div>
                  </div>
                </div>
                </div>
                <div class="cell small-7">
                  <div class="tabs">
                          <ul class="tabs__caption">
                            <li class="active">Все</li>
                            <li>Украина</li>
                            <li>Мир</li>
                          </ul>

                          <div class="tabs__content  active">
                              {foreach $news_all as $news}
                      <div class="item">
                        <div class="img">
                            <a href="{$news->getPath()}" >
                            {$news->getImage()->thumbup(120,90)}
                        </a>
                        </div>
                        <div class="content">
                            <h4><a href="{$news->getPath()}">{$news->getTitle()}</a></h4>
                            {$r=$news->getRubrics()}
                          {if $r.0}<div class="hint m_t-5 category"><a href="#"><img src="/i/folded-newspaper.png" alt="" />{$r.0->getH1()}</a></div>{/if}
                          <div class="statistic">
                            <div class="date">
                             {$news->getPublished()->format('d.m.y')}
                            </div>
                            <div class="views">
                              <img src="/i/views.png">
                              {$news->getViews()}
                            </div>
                         </div>
                        </div>
                      </div>
                      {/foreach}
                      <a href="/news" class="more">Показать все</a>
                      </div>

                          <div class="tabs__content">
                            {lent '/news' 5 category="24" var='news' alaytics=1}
                      <div class="item">
                        <div class="img">
                            <a href="{$news->getPath()}" >
                            {$news->getImage()->thumbup(120,90)}
                        </a>
                        </div>
                        <div class="content">
                            <h4><a href="{$news->getPath()}">{$news->getTitle()}</a></h4>
                            {$r=$news->getRubrics()}
                          {if $r.0}<div class="hint m_t-5 category"><a href="#"><img src="/i/folded-newspaper.png" alt="" />{$r.0->getH1()}</a></div>{/if}
                            <div class="statistic">
                            <div class="date">
                             {$news->getPublished()->format('d.m.y')}
                            </div>
                            <div class="views">
                              <img src="/i/views.png">
                              {$news->getViews()}
                            </div>
                         </div>
                        </div>
                      </div>
                      {/lent}
                            <a href="/news/ukraine" class="more">Показать все</a>
                          </div>

                          <div class="tabs__content">
                            {lent '/news' 5 category="21" var='news' alaytics=1}
                      <div class="item">
                        <div class="img">
                            <a href="{$news->getPath()}" >
                            {$news->getImage()->thumbup(120,90)}
                        </a>
                        </div>
                        <div class="content">
                            <h4><a href="{$news->getPath()}">{$news->getTitle()}</a></h4>
                            {$r=$news->getRubrics()}
                          {if $r.0}<div class="hint m_t-5 category"><a href="#"><img src="/i/folded-newspaper.png" alt="" />{$r.0->getH1()}</a></div>{/if}
                            <div class="statistic">
                            <div class="date">
                             {$news->getPublished()->format('d.m.y')}
                            </div>
                            <div class="views">
                              <img src="/i/views.png">
                              {$news->getViews()}
                            </div>
                         </div>
                        </div>
                      </div>
                      {/lent}
                            <a href="/news/world" class="more">Показать все</a>
                          </div>
                        </div>
                </div>
              </div>
            </article>
          </section>
        </div>
        <div class="cell large-3 medium-12">
          <aside>
              {#mod Mail}
              <div class="box-shadow_form">
                <div class="box-shadow"></div>
                <div class="form">
                	<div class="title">
		               <a href="/analytics/digest"> <i class="fa fa-rss"></i>
		                Инвестиционный дайджест </a>
		              </div>
		              <div class="img"><img src="/i/digest_img.jpg"></div>
                    {subscribe}
                </div>
                {#/mod}
              </div>
              {#mod Digest}
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
                  {#/mod}
          </aside>
        </div>
      </div>
    </div>
    <div class="grid-container all_read" id="all_read">
      <div class="grid-x grid-margin-x">
        <div class="cell medium-12 large-9">
          <section class="news">
            <div class="title">
              <h2><a href="/analytics">Аналитика</a></h2>
            </div>
            <nav>
              <a href="/analytics/investments">Исследования</a> |
              <a href="/analytics/articles">Статьи</a> |
              <a href="/analytics/formula">Интервью</a> |
              <a href="/analytics/we-invest-in-ukraine">Инвестируем в Украину</a> |
              <a href="/tools/database">Рейтинги</a> |
              <a href="/tools/library">Библиотека</a> |
              <a href="/tools/investors">Инвесторы</a>
            </nav>
            <div class="mobile_category">
              <a href="/analytics/investments">Исследования</a><i class="fa fa-chevron-right"></i><i class="fa fa-chevron-down"></i>
              <ul>
                  <li><a href="/analytics/articles">Статьи</a></li>
                  <li><a href="/analytics/formula">Интервью</a></li>
                  <li><a href="/analytics/we-invest-in-ukraine">Инвестируем в Украину</a></li>
                  <li><a href="/tools/database">Рейтинги</a></li>
                  <li><a href="/tools/library">Библиотека</a></li>
                  <li><a href="/tools/investors">Инвесторы</a></li>
              </ul>
          </div>
            <article class="grid-container">
              <div class="grid-x grid-margin-x">
              	{$invest=[]}
                {lent '/analytics' 3 var='analytics' analytics=1}
                {$invest[] = $analytics}
                <div class="cell small-4">
                  <div class="box-shadow"></div>
                  <div class="read_news">
                    <div class="img">
                      <a href="{$analytics->getPath()}">
                        {$analytics->getImage()->thumbup(270,202)}
                      </a>
                    </div>
                    <div class="info">
                      <div class="statistic">
                        <div class="date">
                          {$analytics->getPublished()->format('d.m.y')}
                        </div>
                        <div class="views">
                         <img src="/i/views.png">
                          {$analytics->getViews()}
                        </div>
                      </div>
                      <div class="category">
                        <img src="/i/pers.png" alt="" />{$analytics->getAttr(1)}
                      </div>
                      <h4><a href="{$analytics->getPath()}">{$analytics->getTitle()}</a></h4>
                      <p>{$analytics->getShortText()|truncate:181:"  ..."}</p>
                  </div>
                </div>
                </div>
                {/lent}
              </div>
            </article>
          </section>
        </div>
        <div class="cell medium-12 large-3">
        	<aside>
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
    <div class="grid-container events">
      <div class="grid-x grid-margin-x">
        <div class="cell medium-12 large-9">
          <section class="news">
            <div class="title">
              <h2><a href="tools/events">Мероприятия</a></h2>
            </div>
            <article class="grid-container">
              <div class="grid-x grid-margin-x">
              	{$event=[]}
	            {events 4 var='events' analytics=1}
	            {$event[]=$events}
                <div class="cell small-6">
                  <div class="event">
                    <div class="img">
                      <a href="{$events->getPath()}">{$events->getImage()->thumbup(120,90)}</a>
                    </div>
                    <div class="content">
                      <h5><a href="{$events->getPath()}" >{$events->getTitle()}</a></h5>
                      <div class="date">
                        <span><img src="/i/calendar.png"> {$events->getAttr(7)->format('d.m.Y')}</span>
                        <span><img src="/i/clock.png"> {$events->getAttr(7)->format('H:i')} - {$events->getAttr(8)->format('H:i')}</span>
                      </div>
                      <div class="category">
                        <img src="/i/pers.png" alt="" />{$events->getAttr(9)}
                      </div>
                    </div>
                  </div>
                </div>
                {/events}
              </div>
            </article>
          </section>
        </div>
      </div>
    </div>
    <div class="grid-container video_block">
      <div class="grid-x grid-margin-x">
        <div class="cell medium-12 large-9">
          <section class="news">
            <div class="title">
              <h2><a href="/tools/video">Видео</a></h2>
            </div>
            <article class="grid-container">
              <div class="grid-x grid-margin-x">
                {$video=[]}
                {lent '/tools/video' 3 var='news'}
                {$video[] = $news}
                <div class="cell small-4">
                  <div class="box-shadow"></div>
                  <div class="video">
                    <div class="this_video">
                      <iframe class="video-iframe-index" src="//www.youtube.com/embed/{$news->printAttr("55")}" allowfullscreen></iframe>
                    </div>
                    <div class="info">
                      <div class="statistic">
                        <div class="date">
                          {$news->getPublished()->format('d.m.y')}
                        </div>
                        <div class="views">
                          <img src="/i/views.png">
                          {$news->getViews()}
                        </div>
                      </div>
                      <h4><a href="{$news->getPath()}">{$news->getTitle()}</a></h4>
                    </div>
                  </div>
                </div>
                {/lent}
              </div>
            </article>
          </section>
        </div>
      </div>
    </div>
