<!DOCTYPE html>
<!--[if lt IE 7]><html class="lt-ie9 lt-ie8 lt-ie7" /> <![endif]-->
<!--[if IE 7]><html class="lt-ie9 lt-ie8" /> <![endif]-->
<!--[if IE 8]><html class="lt-ie9" /> <![endif]-->
<!--[if gt IE 8]><!--><html lang="en"><!--<![endif]-->
<head>
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
    <link rel="alternate"  href="http://beta.inventure.com.ua/en/" hreflang="en">
      {if $post}
        {meta 'og:title' html_entity_decode($post->getH1())}
        {meta 'og:description' html_entity_decode($post->getShortText())}
        {meta 'og:type' 'website'}
        {meta 'og:image' url_fix($post->getImage()->getUrl())}
        {meta 'og:image:width' '180' }
        {meta 'og:image:height' '110' }
        <meta name="image" property="og:image" content="{$post->getImage()->getUrl()}">
        <meta itemscope itemtype="http://schema.org/Article" />
        <meta itemprop="headline" content="{$post->getH1()}" />
        <meta itemprop="description" content="{$post->getShortText()}" />
    {/if}
    {if !$post}
        {meta 'og:image' url_fix('https://inventure.com.ua/i/inventure_corp.png')}
    {/if}




    {meta 'fb:app_id' '160711107658620'}
    <!-- CSS & Stylesheet -->
    {style '/css/foundation.min.css'}
    {style '/css/libs.css'}
    {style '/css/main.css'}
    {style '//fonts.googleapis.com/css?family=Open+Sans:400italic,400,500,600' async=true}
    {style '//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css' async=true}
    {style '//fonts.googleapis.com/css?family=Montserrat:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&amp;subset=cyrillic,cyrillic-ext,latin-ext' async=true}

        <!--[if lte IE 10]>
            <link rel="stylesheet" href="/css/ie.css" />
        <![endif]-->

    <!-- Script & jQuery -->
    {head}
    {script 'jquery'}
    {script "foundation2"}
    {script src="/js/libs.min.js" require="jquery" name="libs"}
    {script src="/js/jquery.lazyload.min.js" require="jquery" name="lazyload"}
    {script src="/js/autosize.min.js" require="jquery" name="autosize"}

    {script src="/js/jquery.hoverIntent.minified.js" name="hoverIntent" require="jquery"}
    {script src="/js/script.js" require="jquery,hoverIntent,autosize"}
    {script src="/js/common.js" require="libs"}
    {script src="/js/owl.carousel.min.js" require="jquery"}
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
          <div class="inv_logo"><a href="/en"><img src="/i/logo_header.png"></a></div>
          <div class="menu">
            <nav id="nav">
              <li class="menu-item1">
                <span><a href="/en/investments">Investment proposals</a></span>
                <div class="submenu">
                  <div class="block1">
                    <a href="/en/investments/projects">Investment Projects and Startups</a>
                    <a href="/en/investments/business">Business for Sale</a>
                    <a href="/en/investments/realestate">Commercial Property</a>
                    <a href="/en/investments/land">Land</a>
                    <a href="/en/investments/offer">Investor Offers</a>
                  </div>
                  <div class="block2">
                    <a href="/en/add-inv-prop">Services for Raising Capital & Sell a Business</a>
                    <a href="en/investor">Services for Investors</a>
                  </div>
                </div>
              </li>
              <li class="menu-item2">
                <span><a href="/en/news">News</a></span>
                <div class="submenu">
                  <div class="block1">
                    <a href="/en/news/investments">Private Equity & M&amp;A</a>
                    <a href="/en/news/startup">Venture Capital &amp; Startups</a>
                    <a href="/en/news/government">Macroeconomics</a>
                    <a href="/en/news/banking">Banking</a>
                    <a href="/en/news/stock">Stock Market &amp; IPO</a>
                    <a href="/en/news/realestate">Commercial Property</a>
                  </div>
                  <div class="block2">
                    <a href="/en/news/ukraine">Ukraine</a>
                    <a href="/en/news/world">World</a>
                  </div>
                </div>
              </li>
              <li class="menu-item3">
                <span><a href="/en/analytics">Analytics</a></span>
                <div class="submenu">
                  <div class="block1">
                    <a href="/en/analytics/investments">Research</a>
                    <a href="/en/analytics/articles">Articles</a>
                    <a href="/en/analytics/formula">Investment interview</a>
                    <a href="/en/analytics/we-invest-in-ukraine">We invest in Ukraine</a>
                    <a href="/en/tools/database">Ratings</a>
                    <a href="/en/tools/library">Library</a>
                    <a href="/en/tools/investors">Investors</a>
                  </div>
                  <div class="block2">
                    <a href="/en/analytics/digest">Investment digest</a>
                  </div>
                </div>
              </li>
            </nav>
          </div>
            <div class="right">
              <div class="lang">
                   {locale_data}
                    {foreach $locale_data as $lang=>$data}
                        <a href="{$data.url|default:'#'}" {if $data}title="{$data['title']}"{/if} {if !$data}disabled{/if}>
                            {if $lang=='ru'}
                                <img src="/i/ua.png" alt="РУС"> РУС
                            {elseif $lang=='en'}
                                <img src="/i/gb.jpg" alt="EN"> EN
                            {/if}
                        </a> |
                    {/foreach}
              </div>
              <div class="search">
                <i class="fa fa-search" aria-hidden="true"></i>
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
            <a href="/"  {if !$data}disabled{/if}>Переключить на русский</a>
        </div>
        <div class="investments">
            <a href="/investments">Investment proposals</a><i class="fa fa-chevron-right"></i><i class="fa fa-chevron-down"></i>
            <ul class="ul1">
                <li><a href="/en/investments/projects">Investment projects</a></li>
                <li><a href="/en/investments/business">Business for sale</a></li>
                <li><a href="/en/investments/realestate">Commercial property</a></li>
                <li><a href="/en/investments/land">Lands</a></li>
                <li><a href="/en/investments/offer">Investor offers</a></li>
            </ul>
            <ul class="ul2">
                <li><a href="/en/add-inv-prop">Place investment proposal</a></li>
                <li><a href="/en/investor">Consultation on attracting investments </a></li>
            </ul>
        </div>
        <div class="news">
            <a href="/news">News</a><i class="fa fa-chevron-right"></i><i class="fa fa-chevron-down"></i>
            <ul class="ul1">
                <li><a href="/en/news/investments">Private equity and M&amp;A</a></li>
                <li><a href="/en/news/startup">Venture capital&amp; startups</a></li>
                <li><a href="/en/news/government">Goverment finance</a></li>
                <li><a href="/en/news/banking">Banking</a></li>
                <li><a href="/en/news/stock">Stock market &amp; IPO</a></li>
                <li><a href="/en/news/realestate">Commercial property</a></li>
            </ul>
            <ul class="ul2">
                <li><a href="/en/news/ukraine">Ukraine</a></li>
                <li><a href="/en/news/world">World</a></li>
            </ul>
        </div>
        <div class="analytics">
            <a href="/analytics">Analytics</a><i class="fa fa-chevron-right"></i><i class="fa fa-chevron-down"></i>
            <ul class="ul1">
                <li><a href="/en/analytics/investments">Investment analytics</a></li>
                <li><a href="/en/analytics/articles">Articles</a></li>
                <li><a href="/en/analytics/formula">Investment interview</a></li>
                <li><a href="/en/analytics/we-invest-in-ukraine">We invest in Ukraine</a></li>
                <li><a href="/en/tools/database">Ratings</a></li>
                <li><a href="/en/tools/library">Library</a></li>
                <li><a href="/en/tools/investors">Investors</a></li>
            </ul>
            <ul class="ul2">
                <li><a href="/analytics/digest">Investment digest</a></li>
            </ul>
        </div>
    </div>
    <div class="grid-container tablet_buttons">
      <div class="grid-x grid-margin-x">
        <a href="/investor" class="tablet_button1">invest</a>
        <a href="/add-inv-prop" class="tablet_button2">find an investor</a>
      </div>
    </div>
    <div class="off-canvas-wrap" data-offcanvas="">
        <div class="inner-wrap core_en">
            {block content}
                {$content}
            {/block}
            <a class="exit-off-canvas" href="#"></a>
        </div>
    </div>
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
    <footer>
      <div class="grid-container">
        <div class="logo">
          <img src="/i/logo_footer.png">
        </div>
        <div class="grid-x grid-margin-x">
          <div class="cell small-6 medium-3">
            <h6><a href="http://inventure.ua/">InVenture <span>Media Group</span></a></h6>
            <p><a href="/en/about">About</a></p>
            <p><a href="/en/about/advertising">Adversiting</a></p>
            <p><a href="/en/add-inv-prop">Services for Raising Capital</a></p>
            <p><a href="en/investor">Services for Investors</a></p>
            <p><a href="/en/tools/events">Events</a></p>
            <p><a href="https://www.inventure.ua/en/management" target="_blank">Team</a></p>
            <p><a href="/en/about/jobs">Careers</a></p>
            <p><a href="/en/about/faq">F.A.Q.</a></p>
            <p><a href="/en/about/contacts">Contacts</a></p>
          </div>
          <div class="cell small-6 medium-3">
            <h6><a href="/en/investments">Investment Proposals</a></h6>
            <p><a href="/en/investments/projects">Investment Projects and Sturtups</a></p>
            <p><a href="/en/investments/business">Business for Sale</a></p>
            <p><a href="/en/investments/realestate">Commercial Property</a></p>
            <p><a href="/en/investments/land">Land</a></p>
            <p><a href="/en/investments/offer">Investor Offers</a></p>
          </div>
          <div class="cell small-6 medium-3">
           <h6><a href="/en/news">News</a></h6>
            <p><a href="/en/news/investments">Private Equity & M&amp;A</a></p>
            <p><a href="/en/news/startup">Venture Capital &amp; startups</a></p>
            <p><a href="/en/news/government">Macroeconomics</a></p>
            <p><a href="/en/news/banking">Banking</a></p>
            <p><a href="/en/news/stock">Stock Market &amp; IPO</a></p>
            <p><a href="/en/news/realestate">Commercial Property</a></p>
          </div>
          <div class="cell small-6 medium-3">
            <h6><a href="/en/analytics">Analytics</a></h6>
            <p><a href="/en/analytics/digest">Investment digest</a>/</p>
            <p><a href="/en/analytics/investments">Research</a></p>
            <p><a href="/en/analytics/articles">Articles</a></p>
            <p><a href="/en/analytics/formula">Investment interview</a></p>
            <p><a href="/en/analytics/we-invest-in-ukraine">We invest in Ukraine</a></p>
            <p><a href="/en/tools/database">Ratings</a></p>
            <p><a href="/en/tools/library">Library</a></p>
            <p><a href="/en/tools/investors">Investors</a></p>
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
            © 2010-2018 InVenture™  All Rights Reserved
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
        <a class="close-reveal-modal">&#215;</a>
    </div>


{if $sm->getUser() && $sm->getUser()->canAccess('Page.publish') && ($page || $post || $blog)}
<div class="admin_edit">
    <a href="{if $page}/admin/page/edit/{$page->getId()}{else}{if $post}/admin/blog/{$blog->getId()}/edit/{$post->getId()}{else}/admin/blog/{$blog->getId()}{/if}{/if}" title="edit" class="icon-edit">Редактировать</a>
</div>
{/if}

</body>
</html>
