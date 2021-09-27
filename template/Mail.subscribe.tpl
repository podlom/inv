{* prefilter=off *}
{assign var="reqUri" value=($request->getPathInfo())}
<!-- @ts:reqUri: [{$reqUri}] -->

{if $reqUri != '/analytics/digest'}
    {assign var="hideForm" value=(true)}
{elseif $reqUri == '/'}
    {assign var="hideForm" value=(false)}
{else}
    {assign var="hideForm" value=(false)}
{/if}

{$form->attr('class', 'subscribe')->open()}
{if $form->getErrors()}
    <div class="callout alert">
        <h3 class="section__title text-center">Вы успешно подписаны на рассылку</h3>

        {foreach $form->getErrors() as $err}
            <!-- div>{$err.1}</div -->
        {/foreach}
    </div>
{/if}
{if $lang == 'en'}
    <div class="digest-subscribe-msg lang-en" {if $hideForm}style="display:none;"{/if}>
        {$form->getField('name')->getInput()->attr('id', 'subscribeName')->attr('placeholder', 'First Name & Surname')}
        {$form->getField('company')->getInput()->attr('id', 'subscribeCompany')->attr('placeholder', 'Company')}
        {$form->getField('job')->getInput()->attr('id', 'subscribeJob')->attr('placeholder', 'Position')}
        {$form->getField('email')->getInput()->attr('id', 'subscribeMail')->attr('placeholder', 'E-mail')}
        {* $form->getField('phone')->getInput()->attr('id', 'subscribeTel')->attr('placeholder', 'Phone') *}
        {literal}
            <div class="input-aproach">
            <input type="tel" id="phone" name="subscribe[phone]" required>
            <span id="valid-msg" class="hide">✓ Valid</span>
            <span id="error-msg" class="hide"></span>
            <script>
            var input = document.querySelector("#phone");
            window.intlTelInput(input, {
            dropdownContainer: document.body,
            utilsScript: "/js/utils.js",
            });
            </script>
            </div>
        {/literal}
        <input type="checkbox" name="subscribe[lang][]" value="en" checked="checked" style="display: none;">

        <input type="hidden" name="subscribe[ga_utm]" value="">

        <div class='grid-x'><button class="blue_but cell-but small-12 w-full" type="submit" id="subscribeButton">Subscribe</button></div>
        <div class='grid-x'><button type='button' class="blue_but cell-but  small-12 close__popup">Close</button></div>
    </div>
{else}
    <div class="digest-subscribe-msg lang-ru" {if $hideForm}style="display:none;"{/if}>
        {if isset($smarty.get.id) && isset($smarty.get.email)}
            <p>Вы успешно отписаны от рассылки</p>
        {else}
            {$form->getField('name')->getInput()->attr('id', 'subscribeName')->attr('placeholder', $form->getField('name')->getLabel())}
            {$form->getField('company')->getInput()->attr('id', 'subscribeCompany')->attr('placeholder', $form->getField('company')->getLabel())}
            {$form->getField('job')->getInput()->attr('id', 'subscribeJob')->attr('placeholder', $form->getField('job')->getLabel())}
            {$form->getField('email')->getInput()->attr('id', 'subscribeMail')->attr('placeholder', $form->getField('email')->getLabel())}
            {$form->getField('phone')->getInput()->attr('id', 'subscribeTel')->attr('placeholder', $form->getField('phone')->getLabel())}
            {$form->getField('lang')}

            <input type="hidden" name="subscribe[ga_utm]" value="">

            <div class='grid-x'>
                <button class="blue_but cell-but small-12 w-full" type="submit" id="subscribeButton">Подписаться</button>
            </div>
            <div class='grid-x'><button type='button' class="blue_but cell-but  small-12 close__popup">Закрыть</button></div>
        {/if}
    </div>

{/if}
{$form->protection()}
{$form->close()}