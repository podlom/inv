{load_digests}
{assign var=digest value=$digests|@end}

<div class="newsletter">
  <div class="container ">
    <div class="newsletter__wrapper ">
      <h2 class="newsletter__title">{if $lang === 'ru'}Хотите получать ежемесячную рассылку?{elseif $lang == 'uk'}Хочете отримувати щомісячну розсилку?{else}Do you want to receive monthly newsletters?{/if}</h2>
      <p class="newsletter__text">
      {if $lang === 'ru'}
        Инвестиционный дайджест InVenture - все самое важное в сфере инвестиций за месяц, на 10 страницах, всего за 5 минут!
      {elseif $lang == 'uk'}
        Інвестиційний дайджест InVenture – все найважливіше у сфері інвестицій за місяць, на 10 сторінках, всього за 5 хвилин!
      {else}
        InVenture Investment Digest - an electronic professional journal that provides monthly overview in sphere of direct investment and venture capital.
      {/if}
      </p>
      <div class="desktop-flex desktop-items-center">
        <button class="open_popup newsletter__btn font-semibold" data-remodal-target="subscribe">{if $lang === 'ru'}Подписаться{elseif $lang == 'uk'}Підписатися{else}Subscribe{/if}</button>
        <a href="{if true eq isset($digest) && true eq is_object($digest) && $digest instanceof Digest}{$digest->getUrl()}{/if}" target="_blank" class="newsletter__download-link">
          <svg class="newsletter__download-link-icon" width="24" height="25" viewBox="0 0 24 25" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M22.6912 1.57614C21.8471 0.732053 20.7249 0.267184 19.5313 0.267184L4.46878 0.26709C2.00466 0.26723 0 2.27218 4.6875e-05 4.73642L0 19.8008C4.6875e-05 22.2651 2.00475 24.27 4.46883 24.27H19.5313C21.9953 24.27 24 22.2651 24 19.8007V4.73646C24 3.54265 23.5352 2.42027 22.6912 1.57614ZM22.5938 19.8007C22.5938 21.4896 21.2199 22.8636 19.5313 22.8636H4.46883C2.78016 22.8636 1.4063 21.4896 1.40625 19.8007L1.4063 4.73637C1.40625 3.04759 2.78011 1.67361 4.46883 1.67351L19.5313 1.67361C20.3493 1.67361 21.1184 1.99216 21.6968 2.57062C22.2752 3.14913 22.5938 3.9183 22.5938 4.73646V19.8007Z" fill="white"></path>
            <path d="M16.225 10.4628C15.9505 10.1883 15.5052 10.1882 15.2307 10.4628L12.7032 12.9903L12.7032 5.48975C12.7032 5.10143 12.3884 4.78662 12.0001 4.78662C11.6118 4.78662 11.2969 5.10143 11.2969 5.48975L11.297 12.9904L8.7694 10.4629C8.49485 10.1883 8.04963 10.1883 7.77504 10.4629C7.50044 10.7375 7.50044 11.1827 7.77504 11.4573L11.5029 15.185C11.6348 15.3169 11.8136 15.391 12.0001 15.391C12.1865 15.391 12.3654 15.3169 12.4973 15.185L16.2251 11.4572C16.4996 11.1826 16.4996 10.7374 16.225 10.4628Z" fill="white"></path>
            <path d="M18.7782 18.3442H5.22192C4.83361 18.3442 4.5188 18.6591 4.5188 19.0474C4.5188 19.4357 4.83361 19.7505 5.22192 19.7505H18.7782C19.1665 19.7505 19.4813 19.4357 19.4813 19.0474C19.4813 18.659 19.1665 18.3442 18.7782 18.3442Z" fill="white"></path>
            </svg> <p class="newsletter__download-link-text">
              {if $lang === 'ru'}
                Скачать последний выпуск
              {elseif $lang == 'uk'}
                Скачати останній випуск
              {else}
                Download last edition of the newsletter
              {/if}
            </p>
        </a>
      </div>
    </div>
    <img data-src="images/inVenture-magazine-cuted.png" class="lazyload newsletter__mag mobile-only" alt="Фото инвестиционного дайджеста InVenture">
  </div>
</div>

{* <div class="newsletter">
      <div class="container grid-container">
        <div class="newsletter__title">Хотите получать нашу ежемесячную рассылку?</div>
        <p class="newsletter__text">Инвестиционный дайджест InVenture - все самое важное в сфере инвестиций за месяц, на 10 страницах, всего за 5 минут! <br><a target="_blank" id='last-news-link' href="/" class="newsletter__link">Скачать последний выпуск журнала</a></p>
        <div class="newsletter__buttons">
          <button class="newsletter__button newsletter__button--white open_popup">Подписаться</button>
          <a href="/analytics/digest" class="newsletter__button newsletter__button--darken">Смотреть архив</a>
        </div>
      </div>
      <div id="newsletter__archive" hidden>
        {load_digests}
        
        {assign var=digest value=$digests|@end} 
        <a class="m{$digest->getPubDate()->format('n')} y{$digest->getPubDate()->format('Y')}" href="{$digest->getUrl()}"></a>
      </div>
    </div> *}
