<footer class="footer" itemscope itemtype="http://schema.org/Organization">
      <div itemprop="address" itemscope itemtype="https://schema.org/PostalAddress">
            <meta itemprop="addressCountry" content="UA">
            <meta itemprop="addressRegion" content="місто Київ">
            <meta itemprop="addressLocality" content="Київ">
            <meta itemprop="streetAddress" content="вулиця Старовокзальна, 24">
            <meta itemprop="postalCode" content="01054">
            <meta itemprop="telephone" content="+380677136571">
      </div>
      <div class="container">
        <div class="footer__logo">
          <img class="lazyimg" data-src="/images/logo-footer.svg" itemprop="logo">
        </div>
        {block 'footer_menu'}
        <div class="footer__wrapper">
          <div class="cell">
            <p class="font-bold mb-4"><a href="https://inventure.ua{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{else}/{/if}" target="_blank" itemprop="url">InVenture <span>Investment Group</span></a></p>
            <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/about">{if $lang === 'ru'}О проекте{elseif $lang === 'uk'}Про проект{else}About project{/if}</a></p>
            <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/about/advertising">{if $lang === 'ru'}Реклама{elseif $lang === 'uk'}Реклама{else}Advertising{/if}</a></p>
            
            <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/investor">{if $lang === 'ru'}Сервисы для инвестора{elseif $lang === 'uk'}Сервіси для інвестора{else}Services for Investors{/if}</a></p>
            <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/tools/events">{if $lang === 'ru'}Мероприятия{elseif $lang === 'uk'}Заходи{else}Events{/if}</a></p>
            <p><a href="https://www.inventure.ua{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{else}/ru{/if}/management" target="_blank">{if $lang === 'ru'}Команда{elseif $lang === 'uk'}Команда{else}Team{/if}</a></p>
            <p><a href="https://inventure.ua{if $lang === 'en'}/en/{elseif $lang === 'uk'}/uk/{else}/{/if}vacancies/" target="_blank">{if $lang === 'ru'}Вакансии{elseif $lang === 'uk'}Вакансії{else}Vacancies{/if}</a></p>
            <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/board">{if $lang === 'ru'}Доска объявлений{elseif $lang === 'uk'}Дошка оголошень{else}Board{/if}</a></p>
            <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/about/faq">{if $lang === 'ru'}Часто задаваемые вопросы{elseif $lang === 'uk'}Часті запитання{else}FAQ{/if}</a></p>
              <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/usloviya-ispolzovaniya">{if $lang === 'ru'}Условия использования{elseif $lang === 'uk'}Умови використання{else}Terms{/if}</a></p>
              <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/politika-konfidencialnosti">{if $lang === 'ru'}Политика конфиденциальности{elseif $lang === 'uk'}Політика конфіденційності{else}Privacy Policy{/if}</a></p>
            <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/about/contacts">{if $lang === 'ru'}Контакты{elseif $lang === 'uk'}Контакти{else}Contacts{/if}</a></p>
						<p><a class="footer__btn" href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/add-inv-prop">
							<svg height="20px" fill="white" enable-background="new 0 0 512 512" version="1.1" viewBox="0 0 512 512" xml:space="preserve" xmlns="http://www.w3.org/2000/svg">
									<path d="m492 236h-216v-216c0-11.046-8.954-20-20-20s-20 8.954-20 20v216h-216c-11.046 0-20 8.954-20 20s8.954 20 20 20h216v216c0 11.046 8.954 20 20 20s20-8.954 20-20v-216h216c11.046 0 20-8.954 20-20s-8.954-20-20-20z"/>
							</svg>
							{if $lang === 'ru'}Разместить объявление{elseif $lang === 'uk'}Розмістити оголошення{else}Services for Raising Capital & Sell a Business{/if}
						</a></p>
          </div>
            <div class="cell">
              <p class="font-bold mb-4"><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/investments">{if $lang === 'ru'}Инвестиционные предложения{elseif $lang === 'uk'}Інвестиційні пропозиції{else}Investment proposals{/if}</a></p>
              <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/investments?filter[category][parent]=7860">{if $lang === 'ru'}Инвестиционные проекты и стартапы{elseif $lang === 'uk'}Інвестиційні проекти та стартапи{else}Investment Projects and Startups{/if}</a></p>
              <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/investments?filter[category][parent]=7861"> {if $lang === 'ru'}Продажа бизнеса{elseif $lang === 'uk'}Продаж бізесу{else}Business for Sale{/if} </a></p>
              <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/investments?filter[category][parent]=7862">{if $lang === 'ru'}Недвижимость{elseif $lang === 'uk'}Нерухомість{else}Commercial Property{/if}</a></p>
              <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/investments?filter[category][parent]=7863">{if $lang === 'ru'}Земля{elseif $lang === 'uk'}Земля{else}Land{/if}</a></p>
              <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/investments?filter[category][parent]=19303">{if $lang === 'ru'}Франчайзинг{elseif $lang === 'uk'}Франчайзинг{else}Franchising{/if}</a></p>
              <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/investments?filter[category][parent]=7864">{if $lang === 'ru'}Предложения инвесторов{elseif $lang === 'uk'}Інвестиційні пропозиції{else}Investor Offers{/if}</a></p>
              <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/add-inv-prop">{if $lang === 'ru'}Привлечение инвестиций / продажа бизнеса{elseif $lang === 'uk'}Залучення інвестицій / продаж бізнесу{else}Services for Raising Capital & Sell a Business{/if}</a></p>
              <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/project">{if $lang === 'ru'}Сервисы для инвестора{elseif $lang === 'uk'}Сервіси для інвестора{else}Services for Investors{/if}</a></p>
          </div>
          <div class="cell">
           	<p class="font-bold mb-4"><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/news">{if $lang === 'ru'}Новости{elseif $lang === 'uk'}Новини{else}News{/if}</a></p>
            <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/news/investments">{if $lang === 'ru'}Прямые инвестиции и M&A{elseif $lang === 'uk'}Прямі інвестиції та M&A{else}Private Equity & M&amp;A{/if}</a></p>
            <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/news/startup">{if $lang === 'ru'}Стартапы{elseif $lang === 'uk'}Стартапи{else}Venture Capital &amp; Startups{/if}</a></p>
            <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/news/government">{if $lang === 'ru'}Макроинвестиции{elseif $lang === 'uk'}Макроінвестиції{else}Macroeconomics{/if}</a></p>
            <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/news/banking">{if $lang === 'ru'}Кредитование{elseif $lang === 'uk'}Кредитування{else}Banking{/if}</a></p>
            <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/news/stock">{if $lang === 'ru'}Фондовый рынок{elseif $lang === 'uk'}Фондовий ринок{else}Stock Market &amp; IPO{/if}</a></p>
            <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/news/realestate">{if $lang === 'ru'}Недвижимость{elseif $lang === 'uk'}Нерухомість{else}Commercial Property{/if}</a></p>
          </div>
          <div class="cell">
            <p class="font-bold mb-4"><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/analytics">{if $lang === 'ru'}Аналитика{elseif $lang === 'uk'}Аналітика{else}Analytics{/if}</a></p>
            <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/analytics/digest">{if $lang === 'ru'}Инвестиционный дайджест{elseif $lang === 'uk'}Інвестиційний дайджест{else}Investment digest{/if}</a></p>
            <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/analytics/investments">{if $lang === 'ru'}Исследования{elseif $lang === 'uk'}Дослідження{else}Research{/if}</a></p>
            <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/analytics/articles">{if $lang === 'ru'}Статьи{elseif $lang === 'uk'}Статті{else}Articles{/if}</a></p>
            <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/analytics/formula">{if $lang === 'ru'}Интервью{elseif $lang === 'uk'}Інтерв`ю{else}Investment interview{/if}</a></p>
            <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/analytics/we-invest-in-ukraine">{if $lang === 'ru'}Инвестируем в Украину{elseif $lang === 'uk'}Інвестуємо в Україну{else}We invest in Ukraine{/if}</a></p>
            <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/tools/database">{if $lang === 'ru'}Рейтинги{elseif $lang === 'uk'}Рейтинги{else}Ratings{/if}</a></p>
            <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/tools/library">{if $lang === 'ru'}Библиотека{elseif $lang === 'uk'}Бібліотека{else}Library{/if}</a></p>
            <p><a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/tools/investors">{if $lang === 'ru'}Инвесторы{elseif $lang === 'uk'}Інвестори{else}Investors{/if}</a></p>
          </div>
        </div>
        {/block}
       <div class="footer__socials">
          <a itemprop="sameAs" href="https://www.facebook.com/inventure.com.ua" target="_blank"><i class="fa fa-facebook-square" aria-hidden="true"></i></a>
          <a itemprop="sameAs" href="https://www.linkedin.com/groups/4386794/" target="_blank"><i class="fa fa-linkedin-square" aria-hidden="true"></i></a>
          <a itemprop="sameAs" href="https://twitter.com/inventure_ua" target="_blank"><i class="fa fa-twitter-square" aria-hidden="true"></i></a>
          <a itemprop="sameAs" href="https://t.me/inventure" target="_blank"><i class="fa fa-telegram" aria-hidden="true"></i></a>
        </div>
        <div class="footer__copyright">
            {block 'copyright'}
            {if $lang === 'ru'}
              Публикация материалов InVenture разрешается только при условии размещения активной ссылки - https://inventure.com.ua
            {elseif $lang === 'uk'}
                Публікація матеріалів InVenture дозволяється тільки за умови розміщення активного посилання - https://inventure.com.ua/uk
            {else}
              Reproduction or distribution of InVenture's content is allowed by inserting link - https://inventure.com.ua/en
            {/if}
              <br>© 2010-2022 InVenture™ All Rights Reserved
            {/block}
        </div>
      </div>
    </footer>
