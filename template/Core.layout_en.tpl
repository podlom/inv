{extends 'Core.layout'}
{* {block 'menu'}
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
        <a href="/en/investor">Services for Investors</a>
      </div>
    </div>
  </li>
  <li class="menu-item2">
    <span><a href="/en/news">News</a></span>
    <div class="submenu">
      <div class="block1">
        <a href="/en/news/investments">Private Equity & M&A</a>
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
{/block}
{block 'mobile_menu'}
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
            <li><a href="/en/news/investments">Private equity and M&A</a></li>
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
{/block}
{block 'side_buttons'}
    <a href="/investor" class="tablet_button1">invest</a>
    <a href="/add-inv-prop" class="tablet_button2">find an investor</a>
{/block}
{block 'footer_menu'}
<div class="grid-x grid-margin-x">
  <div class="cell small-6 medium-3">
    <h6><a href="http://inventure.ua/">InVenture <span>Investment Group</span></a></h6>
    <p><a href="/en/about">About</a></p>
    <p><a href="/en/about/advertising">Adversiting</a></p>
    <p><a href="/en/add-inv-prop">Services for Raising Capital</a></p>
    <p><a href="/en/investor">Services for Investors</a></p>
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
    <p><a href="/en/news/investments">Private Equity & M&A</a></p>
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
{/block}
{block 'copyright'}
© 2010-2018 InVenture™  All Rights Reserved
{/block}

 *}