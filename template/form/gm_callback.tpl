{$form->open()}
    <div class="gm_row">
        <input type="text" name="sf_callback[firstname]" placeholder="Имя" value="" required="required">
        <input type="text" name="sf_callback[lastname]" placeholder="Фамилия" value="" required="required">

        {literal}
            <input name="sf_callback[tel]" type="text" class="subscription__input" id="phone3" required>
            <span id="valid-msg3" class="hide">✓ Valid</span>
            <span id="error-msg3" class="hide"></span>
            <script>
            var input3 = document.querySelector("#phone3");
            window.intlTelInput(input3, {dropdownContainer: document.body, utilsScript: "/js/utils.js",});
            </script>
        {/literal}
        <button>Заказать</button>
    </div>

    <input type="hidden" name="sf_callback[ga_utm]" value="">

{$form->protection()}
{$form->close()}

<style>
.gm_row .iti--allow-dropdown{
    width:100%!important;
}
</style>