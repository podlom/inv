<!DOCTYPE html>
<!--[if lt IE 7]><html class="lt-ie9 lt-ie8 lt-ie7" /> <![endif]-->
<!--[if IE 7]><html class="lt-ie9 lt-ie8" /> <![endif]-->
<!--[if IE 8]><html class="lt-ie9" /> <![endif]-->
<!--[if gt IE 8]><!--><html lang="{$lang|default:'ru'}"><!--<![endif]-->
<head>
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
    {if $post}
        {meta 'og.1' property='og:title'  content=html_entity_decode($post->getH1()) raw=1}
        {meta 'og.2' property='og:description'  content=html_entity_decode($post->getShortText()) raw=1}
        {meta 'og.3' property='og:type'  content='website' raw=1}
        {meta 'og.4' property='og:url'  content=full_link($post->getPath()) raw=1}
        {if $post->hasImage()}
        {meta 'og1' property='og:image' content=full_link($post->getImage()->getUrl()) raw=1}
        {meta 'og2' property='og:image' content=full_link($post->getImage()->thumbup(600,315)->getUrl()) raw=1}
        {meta 'og3' property='og:image' content=full_link($post->getImage()->thumbup(180,110)->getUrl()) raw=1}
        {meta 'twitter:title' html_entity_decode($post->getH1())}
        {meta 'twitter:description' html_entity_decode($post->getShortText())}
        {meta "twitter:card" "summary_large_image"}
        {meta "twitter:site" "@inventure_ua"}
        {meta "twitter:creator" "@inventure_ua"}
        {meta 'twitter:image' full_link($post->getImage()->getUrl())}
        {/if}
    {else}
        {meta 'og:5' raw=1  property='og:image' content=full_link('/i/inventure_corp.png')}
    {/if}


    {meta 'fb1' property='fb:app_id' content='160711107658620' raw=1}
    {*style '/css/foundation.min.css'*}
    {style '/css/libs.css'}
    {style '/css/main.css'}
    {style '//fonts.googleapis.com/css?family=Open+Sans:400italic,400,500,600' async=true}
    {style '//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css' async=true}
    {style '//fonts.googleapis.com/css?family=Montserrat:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&amp;subset=cyrillic,cyrillic-ext,latin-ext' async=true}
    
    {head}
    {script 'jquery'}
    {script "foundation2"}
    {script src="/js/libs.min.js" require="jquery" name="libs" }

    {script src="/js/common.js" require="libs" name="common"}
    {script src="/js/jquery.lazyload.min.js" require="jquery" name="lazyload" }
    {script src="/js/autosize.min.js" require="jquery" name="autosize" }

    {script src="/js/jquery.hoverIntent.minified.js" name="hoverIntent" require="jquery" }
    {script src="/js/script.js" require="jquery,hoverIntent,autosize" name="script"}
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
          <div class="inv_logo"><a href="/{if $lang!='ru'}{$lang}{/if}"><img src="/i/logo_header.png"></a></div>
          <div class="menu">
            {block 'menu'}
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
            {/block}
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
                {block 'login'}
                {if !$user || !$user->getId()}
                <a href="/user/login">Вход</a>
                {else}
                <a href="/bulletin" class="my_adv">Мои объявления</a>
                <a href="/user/logout" class="logout">Выйти</a>
                {/if}
                {/block}
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
              <img class="lazyimg" data-src="/i/logo_footer.png">
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
    {block 'mobile_menu'}
    <div class="mobile_menu">
        <div class="search">
            <form method="GET" action="/search">
                <input type="search" name="q" placeholder="Поиск" />
                <i class="fa fa-search" data-submit></i>
            </form>
        </div>
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
            <a href="/investments">Инвестиционные предложения </a><i class="fa fa-plus"></i><i class="fa fa-minus"></i>
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
            <a href="/news">Новости</a><i class="fa fa-plus"></i><i class="fa fa-minus"></i>
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
            <a href="/analytics">Аналитика</a><i class="fa fa-plus"></i><i class="fa fa-minus"></i>
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
    {/block}
    <div class="grid-container tablet_buttons">
      <div class="grid-x grid-margin-x">
    {block 'side_buttons'}
        <a href="/investor" class="tablet_button1">инвестировать</a>
        <a href="/add-inv-prop" class="tablet_button2">Найти инвестора</a>
    {/block}
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
    <ul class="small-block-grid-1 medium-block-grid-2 large-block-grid-2">
        <li>
            {widget_slot 'footer_1 (728x90)' size=[729, 90]}
        </li>
        <li>
            {widget_slot 'footer_2 (728x90)' size=[729, 90]}
        </li>
    </ul>
    {#/mod}
    <footer itemscope itemtype="http://schema.org/Organization">
      <div itemprop="address" itemscope itemtype="https://schema.org/PostalAddress">
            <meta itemprop="addressCountry" content="UA">
            <meta itemprop="addressRegion" content="місто Київ">
            <meta itemprop="addressLocality" content="Київ">
            <meta itemprop="streetAddress" content="вулиця Старовокзальна, 24">
            <meta itemprop="postalCode" content="01054">
            <meta itemprop="telephone" content="+380677136571">
      </div>
      <div class="grid-container">
        <div class="logo">
          <img class="lazyimg" data-src="/i/logo_footer.png" itemprop="logo">
        </div>
        {block 'footer_menu'}
        <div class="grid-x grid-margin-x">
          <div class="cell small-6 medium-3">
            <h6 itemprop="name"><a href="http://inventure.ua/" itemprop="url">InVenture <span>Investment Group</span></a></h6>
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
        {/block}
       <div class="social">
          <a itemprop="sameAs" href="https://www.facebook.com/inventure.com.ua" target="_blank"><i class="fa fa-facebook-square" aria-hidden="true"></i></a>
            <a itemprop="sameAs" href="http://goo.gl/3WiX8K" target="_blank"><i class="fa fa-google-plus-square" aria-hidden="true"></i></a>
            <a itemprop="sameAs" href="http://www.linkedin.com/groups/Investments-Ventures-in-Ukraine-4386794" target="_blank"><i class="fa fa-linkedin-square" aria-hidden="true"></i></a>
            <a itemprop="sameAs" href="https://twitter.com/inventure_ua" target="_blank"><i class="fa fa-twitter-square" aria-hidden="true"></i></a>
            <a itemprop="sameAs" href="https://t.me/inventure" target="_blank"><i class="fa fa-telegram" aria-hidden="true"></i></a>
        </div>
        <div class="copyright">
            {block 'copyright'}
            Публикация материалов InVenture разрешается только при условии размещения активной ссылки - https://inventure.com.ua <br>© 2010-2019 InVenture™ All Rights Reserved
            {/block}
        </div>
      </div>
    </footer>
    <div class="up" style="display: none;">
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
{*
<div id="questionForm" class="reveal-modal questionFormCenter" data-reveal style="display:none">
    <h2>Задать вопрос</h2>
    {form callback}
    <a class="close-reveal-modal">&#215;</a>
</div>
*}
{if $user && $user->canAccess('Page.publish') && ($page || $post || $blog)}
<div class="admin_edit">
    <a href="{if $page}/admin/page/edit/{$page->getId()}{else}{if $post}/admin/blog/{$blog->getId()}/edit/{$post->getId()}{else}/admin/blog/{$blog->getId()}{/if}{/if}" title="edit" class="icon-edit">Редактировать</a>
</div>
{/if}

<div id="gm_callback">
    <div class="gm_call"></div>
    <div class="gm_form">
        <div class="gm_text">Обратный звонок</div>
        {form 'callback' template="gm_callback"}
        <div class="gm_close"></div>
    </div>
    <div class="gm_result">Спасибо! Мы с вами свяжемся. <div class="gm_close"></div>
    </div>
</div>

<script>
    
  
document.addEventListener("DOMContentLoaded", function() {
  var lazyloadImages;    

  if ("IntersectionObserver" in window) {
    lazyloadImages = document.querySelectorAll(".lazyimg");
    var imageObserver = new IntersectionObserver(function(entries, observer) {
      entries.forEach(function(entry) {
        if (entry.isIntersecting) {
          var image = entry.target;
          image.src = image.dataset.src;
          image.classList.remove("lazyimg");
          imageObserver.unobserve(image);
        }
      });
    });

    lazyloadImages.forEach(function(image) {
      imageObserver.observe(image);
    });
  } else {  
    var lazyloadThrottleTimeout;
    lazyloadImages = document.querySelectorAll(".lazyimg");
    
    function lazyload () {
      if(lazyloadThrottleTimeout) {
        clearTimeout(lazyloadThrottleTimeout);
      }    

      lazyloadThrottleTimeout = setTimeout(function() {
        var scrollTop = window.pageYOffset;
        lazyloadImages.forEach(function(img) {
            if(img.offsetTop < (window.innerHeight + scrollTop)) {
              img.src = img.dataset.src;
              img.classList.remove('lazyimg');
            }
        });
        if(lazyloadImages.length == 0) { 
          document.removeEventListener("scroll", lazyload);
          window.removeEventListener("resize", lazyload);
          window.removeEventListener("orientationChange", lazyload);
        }
      }, 20);
    }

    document.addEventListener("scroll", lazyload);
    window.addEventListener("resize", lazyload);
    window.addEventListener("orientationChange", lazyload);
  }
});
</script>
</body>
</html>
