{if $lang=='en'}
  <div id="gm_callback">
      <div class="gm_call"></div>
      <div class="gm_form">
          <div class="gm_text">Any questions?</div>
          {form 'callback' template="gm_callback_en"}
          <div class="gm_close"></div>
      </div>
      <div class="gm_result">Thank you! We will contact with you soon. <div class="gm_close"></div>
      </div>
  </div>
{else}
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
{/if}