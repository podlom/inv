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
              <li><a href="/investments/land">Земля</a></li>
              <li><a href="/investments/franchising">Франчайзинг</a></li>
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
              <li><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/analytics/digest">Инвестиционный дайджест</a></li>
          </ul>
      </div>
  </div>
{/block}