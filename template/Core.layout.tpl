<!DOCTYPE html>
<!--[if lt IE 7]><html class="lt-ie9 lt-ie8 lt-ie7" /> <![endif]-->
<!--[if IE 7]><html class="lt-ie9 lt-ie8" /> <![endif]-->
<!--[if IE 8]><html class="lt-ie9" /> <![endif]-->
<!--[if gt IE 8]><!--><html lang="ru"><!--<![endif]-->
<head itemscope itemtype="http://schema.org/Article">
{if $sm}
{$user = $sm->getUser()}
{/if}
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="google-site-verification" content="LfVoNUP8eiLhw36D_ybQCjOCMGpC2A3l39tbZpaHP5A" />
    <meta name="google-site-verification" content="-6zzop7KDzhnKh2o5OdjWKynXd1cQol6feh7N75LVmk" />
    <!-- Favicons -->
    <link rel="apple-touch-icon" href="/images/theme/favicon/touch-icon-iphone.png" />
    <link rel="apple-touch-icon" sizes="76x76" href="/images/theme/favicon/touch-icon-ipad.png" />
    <link rel="apple-touch-icon" sizes="120x120" href="/images/theme/favicon/touch-icon-iphone-retina.png" />
    <link rel="apple-touch-icon" sizes="152x152" href="/images/theme/favicon/touch-icon-ipad-retina.png" />
    <link rel="shortcut icon" href="/images/theme/favicon/favicon.ico" type="image/x-icon" />
    <link rel="alternate"  href="http://beta.inventure.com.ua/" hreflang="ru">
    {if $post}
        {meta 'og:title' html_entity_decode($post->getH1())}
        {meta 'og:description' html_entity_decode($post->getShortText())}
        {meta 'og:type' 'website'}
        {if $post->hasImage()}
        {meta 'og:image' full_link($post->getImage()->getUrl())}
        {/if}
        <meta itemscope itemtype="http://schema.org/Article" />
        <meta itemprop="headline" content="{$post->getH1()}" />
        <meta itemprop="description" content="{$post->getShortText()}" />
    {else}
        {meta 'og:image' full_link('https://inventure.com.ua/i/inventure_corp.png')}
    {/if}


    {meta 'fb:app_id' '160711107658620'}
    {style '/css/foundation.min.css'}
    {style '/css/libs.css'}
    {style '/css/main.css'}
    {style '//fonts.googleapis.com/css?family=Open+Sans:400italic,400,500,600' async=true}
    {style '//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css' async=true}
    {style '//fonts.googleapis.com/css?family=Montserrat:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&amp;subset=cyrillic,cyrillic-ext,latin-ext' async=true}

    {head}
    {script 'jquery'}
    {script "foundation2"}
    {script src="/js/libs.min.js" require="jquery" name="libs" }
    {script src="/js/jquery.lazyload.min.js" require="jquery" name="lazyload" }
    {script src="/js/autosize.min.js" require="jquery" name="autosize" }

    {script src="/js/jquery.hoverIntent.minified.js" name="hoverIntent" require="jquery" }
    {script src="/js/script.js" require="jquery,hoverIntent,autosize" }
    {script src="/js/common.js" require="libs" }
    {script src="/js/owl.carousel.min.js" require="jquery" }
    {script_code require=['foundation2', 'jquery']}$(document).foundation();{/script_code}
</head>
<body>
    <div class="hover_bg"></div>
<div class="header_container">
    <header class="header">
      <div class="grid-container">
        <div class="grid-x grid-margin-x">
          <div class="menu_icons">
              <i class="fa fa-bars"></i>
          </div>
          <div class="inv_logo"><a href="/"><img src="/i/logo_header.png"></a></div>
          <div class="menu">
            <nav id="nav">
              <li class="menu-item1">
                <span><a href="/investments">Инвестиционные предложения</a></span>
                <div class="submenu">
                  <div class="block1">
                    <a href="/investments/projects">Инвестиционные проекты и стартапы</a>
                    <a href="/investments/business">Продажа бизнеса</a>
                    <a href="/investments/realestate">Недвижимость</a>
                    <a href="/investments/land">Земельные участки</a>
                    <a href="/investments/offer">Предложения инвесторов</a>
                  </div>
                  <div class="block2">
                    <a href="/add-inv-prop">Привлечение инвестиций / продажа бизнеса</a>
                    <a href="/investor">Сервисы для инвестора </a>
                  </div>
                </div>
              </li>
              <li class="menu-item2">
                <span><a href="/news">Новости</a></span>
                <div class="submenu">
                  <div class="block1">
                    <a href="/news/investments">Прямые инвестиции и M&A</a>
                    <a href="/news/startup">Стартапы</a>
                    <a href="/news/government">Макроинвестиции</a>
                    <a href="/news/banking">Кредитование</a>
                    <a href="/news/stock">Фондовый рынок</a>
                    <a href="/news/realestate">Недвижимость</a>
                  </div>
                  <div class="block2">
                    <a href="/news/ukraine">Украина</a>
                    <a href="/news/world">Мир</a>
                  </div>
                </div>
              </li>
              <li class="menu-item3">
                <span><a href="/analytics">Аналитика</a></span>
                <div class="submenu">
                  <div class="block1">
                    <a href="/analytics/investments">Исследования</a>
                    <a href="/analytics/articles">Статьи</a>
                    <a href="/analytics/formula">Интервью</a>
                    <a href="/analytics/we-invest-in-ukraine">Инвестируем в Украину</a>
                    <a href="/tools/database">Рейтинги</a>
                    <a href="/tools/library">Библиотека</a>
                    <a href="/tools/investors">Инвесторы</a>
                  </div>
                  <div class="block2">
                    <a href="/analytics/digest">Инвестиционный дайджест</a>
                  </div>
                </div>
              </li>
            </nav>
          </div>
            <div class="right">
              <div class="search">
                <i class="fa fa-search" aria-hidden="true"></i>
              </div>|
              <div class="lang">
                {#mod 'Locale'}
                    {locale_data}
                    {foreach $locale_data as $lang=>$data}
                        {if !$data}{continue}{/if}
                        <a href="{$data.url|default:'#'}" {if $data}title="{$data['title']}"{/if}>
                            {if $lang=='ru'}
                                <img src="/i/ua.png" alt="РУС"> РУС
                            {elseif $lang=='en'}
                                <img src="/i/gb.jpg" alt="EN"> EN
                            {/if}
                        </a> |
                    {/foreach}
                {#/mod}
              </div>
                 <div class="social">
                {if !$user || !$user->getId()}
                <a href="/user/login">Вход</a>
                {else}
                <a href="/bulletin" class="my_adv">Мои объявления</a>
                <a href="/user/logout" class="logout">Выйти</a>
                {/if}
              </div>
            </div>
        </div>
      </div>
    </header>
    <div class="header_search">
      <div class="grid-container">
        <div class="grid-x grid-margin-x">
          <div class="cell small-3">
            <div class="logo">
              <img src="/i/logo_footer.png">
            </div>
          </div>
          <div class="cell small-9">
            <div class="search_input">
               <form action="/search" method="get" class="search_frm">
                    <button><i class="fa fa-search" aria-hidden="true"></i></button>
                    <input name="q" type="search" value="{$query}" placeholder="Поиск среди  20 000 материалов в области инвестиций" />
                    <i class="fa fa-close" aria-hidden="true" id="close"></i>

                </form>
            </div>
          </div>
        </div>
      </div>
    </div>
</div>
    <div class="mobile_menu">
        <div class="lang_switch">
            <a href="{$data.url|default:'#'}" {if $data}title="{$data['title']}"{/if} {if !$data}disabled{/if}>Switch to English</a>
        </div>
                         <div class="social">
                {if !$user || !$user->getId()}
                <a href="/user/login">Вход</a>
                {else}
                <a href="/bulletin" class="my_adv">Мои обьявления</a>
                {/if}
              </div>
        <div class="investments">
            <a href="/investments">Инвестиционные предложения </a><i class="fa fa-chevron-right"></i><i class="fa fa-chevron-down"></i>
            <ul class="ul1">
                <li><a href="/investments/projects">Инвестиционные проекты и стартапы</a></li>
                <li><a href="/investments/business">Продажа бизнеса</a></li>
                <li><a href="/investments/realestate">Недвижимость</a></li>
                <li><a href="/investments/land">Земельные участки</a></li>
                <li><a href="/investments/offer">Предложения инвесторов</a></li>
            </ul>
            <ul class="ul2">
                <li><a href="/add-inv-prop">Привлечение инвестиций / продажа бизнеса</a></li>
                <li><a href="/project">Сервисы для инвестора </a></li>
            </ul>
        </div>
        <div class="news">
            <a href="/news">Новости</a><i class="fa fa-chevron-right"></i><i class="fa fa-chevron-down"></i>
            <ul class="ul1">
                <li><a href="/news/investments">Прямые инвестиции и M&A</a></li>
                <li><a href="/news/startup">Стартапы</a></li>
                <li><a href="/news/government">Макроинвестиции</a></li>
                <li><a href="/news/banking">Кредитование</a></li>
                <li><a href="/news/stock">Фондовый рынок</a></li>
                <li><a href="/news/realestate">Недвижимость</a></li>
            </ul>
            <ul class="ul2">
                <li><a href="/news/ukraine">Украина</a></li>
                <li><a href="/news/world">Мир</a></li>
            </ul>
        </div>
        <div class="analytics">
            <a href="/analytics">Аналитика</a><i class="fa fa-chevron-right"></i><i class="fa fa-chevron-down"></i>
            <ul class="ul1">
                <li><a href="/analytics/investments">Исследования</a></li>
                <li><a href="/analytics/articles">Статьи</a></li>
                <li><a href="/analytics/formula">Интервью</a></li>
                <li><a href="/analytics/we-invest-in-ukraine">Инвестируем в Украину</a></li>
                <li><a href="/tools/database">Рейтинги</a></li>
                <li><a href="/tools/library">Библиотека</a></li>
                <li><a href="/tools/investors">Инвесторы</a></li>
            </ul>
            <ul class="ul2">
                <li><a href="/analytics/digest">Инвестиционный дайджест</a></li>
            </ul>
        </div>
    </div>
    <div class="grid-container tablet_buttons">
      <div class="grid-x grid-margin-x">
        <a href="/investor" class="tablet_button1">инвестировать</a>
        <a href="/add-inv-prop" class="tablet_button2">Найти инвестора</a>
      </div>
    </div>
    <div class="off-canvas-wrap" data-offcanvas="">
        <div class="inner-wrap">
            {block content}
                {$content}
            {/block}
            <a class="exit-off-canvas" href="#"></a>
        </div>
    </div>
    {#mod 'Widget'}
    <div class="row">
        <div class="columns">
            <ul class="small-block-grid-1 medium-block-grid-2 large-block-grid-2">
                <li>
                    {widget_slot 'footer_1 (728x90)' size=[729, 90]}
                </li>
                <li>
                    {widget_slot 'footer_2 (728x90)' size=[729, 90]}
                </li>
            </ul>
        </div>
    </div>
    {#/mod}
    <footer>
      <div class="grid-container">
        <div class="logo">
          <img src="/i/logo_footer.png">
        </div>
        <div class="grid-x grid-margin-x">
          <div class="cell small-6 medium-3">
            <h6><a href="http://inventure.ua/">InVenture <span>Media Group</span></a></h6>
            <p><a href="/about">О проекте</a></p>
            <p><a href="/about/advertising">Реклама</a></p>
            <p><a href="/board">Доска объявлений</a></p>
            <p><a href="/add-inv-prop">Сервисы по привлечению инвестиций</a></p>
            <p><a href="/investor">Сервисы для инвестора</a></p>
            <p><a href="/tools/events">Мероприятия</a></p>
            <p><a href="https://www.inventure.ua/management" target="_blank">Команда</a></p>
            <p><a href="/about/jobs">Вакансии</a></p>
            <p><a href="/about/faq">Часто задаваемые вопросы</a></p>
            <p><a href="/about/contacts">Контакты</a></p>
          </div>
          <div class="cell small-6 medium-3">
            <h6><a href="/investments">Инвестиционные предложения</a></h6>
            <p><a href="/investments/projects">Инвестиционные проекты и стартапы</a></p>
            <p><a href="/investments/business">Продажа бизнеса</a></p>
            <p><a href="/investments/realestate">Недвижимость</a></p>
            <p><a href="/investments/land">Земельные участки</a></p>
            <p><a href="/investments/offer">Инвесторы</a></p>
          </div>
          <div class="cell small-6 medium-3">
           <h6><a href="/news">Новости</a></h6>
            <p><a href="/news/investments">Прямые инвестиции и M&A</a></p>
            <p><a href="/news/startup">Венчурные инвестиции и стартапы</a></p>
            <p><a href="/news/government">Макроэкономика</a></p>
            <p><a href="/news/banking">Банки и кредитование</a></p>
            <p><a href="/news/stock">Фондовый рынок и IPO</a></p>
            <p><a href="/news/realestate">Недвижимость</a></p>
          </div>
          <div class="cell small-6 medium-3">
            <h6><a href="/analytics">Аналитика</a></h6>
            <p><a href="/analytics/digest">Инвестиционный дайджест</a></p>
            <p><a href="/analytics/investments">Исследования</a></p>
            <p><a href="/analytics/articles">Статьи</a></p>
            <p><a href="/analytics/formula">Интервью</a></p>
            <p><a href="/analytics/we-invest-in-ukraine">Инвестируем в Украину</a></p>
            <p><a href="/tools/database">Рейтинги</a></p>
            <p><a href="/tools/library">Библиотека</a></p>
            <p><a href="/tools/investors">Инвесторы</a></p>
          </div>
        </div>
       <div class="social">
          <a href="https://www.facebook.com/inventure.com.ua" target="_blank"><i class="fa fa-facebook-square" aria-hidden="true"></i></a>
            <a href="http://goo.gl/3WiX8K" target="_blank"><i class="fa fa-google-plus-square" aria-hidden="true"></i></a>
            <a href="http://www.linkedin.com/groups/Investments-Ventures-in-Ukraine-4386794" target="_blank"><i class="fa fa-linkedin-square" aria-hidden="true"></i></a>
            <a href="https://twitter.com/inventure_ua" target="_blank"><i class="fa fa-twitter-square" aria-hidden="true"></i></a>
            <a href="https://t.me/inventure" target="_blank"><i class="fa fa-telegram" aria-hidden="true"></i></a>
        </div>
        <div class="copyright">
            Публикация материалов InVenture разрешается только при условии размещения активной ссылки - https://inventure.com.ua
<br>© 2010-2018 InVenture™  All Rights Reserved
        </div>
      </div>
    </footer>
    <div class="up">
        <img src="/i/up.png" alt="Вверх" title="Вверх">
    </div>



<!-- Scripts on loading page -->
{literal}
    <!-- Google Analytics -->
    <script>
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })
        (window,document,'script','//www.google-analytics.com/analytics.js','ga');

    ga('create', 'UA-42378215-1', 'inventure.com.ua');
    ga('send', 'pageview');
    </script>
    <!-- Google Analytics End -->
{/literal}
<!-- Scripts on loading page  End -->
</div><!-- wrapper end -->

    <div id="questionForm" class="reveal-modal questionFormCenter" data-reveal>
        <h2>Задать вопрос</h2>
        {form callback}
        {*if $form}
        {$s = $form->getSubmit()->setAttr('value', 'Задать вопрос')}
        {$s = $form->getSubmit()->addClass('blue_but right')}
        {$form}
        {/if*}
        <a class="close-reveal-modal">&#215;</a>
    </div>
{if $user && $user->canAccess('Page.publish') && ($page || $post || $blog)}
<div class="admin_edit">
    <a href="{if $page}/admin/page/edit/{$page->getId()}{else}{if $post}/admin/blog/{$blog->getId()}/edit/{$post->getId()}{else}/admin/blog/{$blog->getId()}{/if}{/if}" title="edit" class="icon-edit">Редактировать</a>
</div>
{/if}

</body>
</html>
