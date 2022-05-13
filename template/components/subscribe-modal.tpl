<div class="remodal callback subscribe" id="subscribe" data-remodal-id="subscribe">
  <button data-remodal-action="close" class="remodal-close"></button>
  <div class="remodal__title">
  {if $lang == 'en'}Fill in the contact details to receive the monthly newsletter!
  {elseif $lang == 'uk'}Заповніть, будь ласка, ваші контактні дані, щоб отримати щомісячну розсилку!
  {else}Заполните, пожалуйста, ваши контактные данные, чтобы получать ежемесячную рассылку!
  {/if}
  </div>
  {#mod Mail}
    <div class="callback__form">
      {subscribe}
    </div>
  {#/mod}
</div>