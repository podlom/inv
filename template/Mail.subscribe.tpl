{$form->attr('class', 'subscribe')->open()}
{if $form->getErrors()}
    <div class="callout alert">
    {foreach $form->getErrors() as $err}
        <div>{$err.1}</div>
    {/foreach}
    </div>
{/if}
{if $lang == 'en'}
    {$form->getField('name')->getInput()->attr('id', 'subscribeName')->attr('placeholder', 'First Name & Surname')}
    {$form->getField('company')->getInput()->attr('id', 'subscribeCompany')->attr('placeholder', 'Company')}
    {$form->getField('job')->getInput()->attr('id', 'subscribeJob')->attr('placeholder', 'Position')}
    {$form->getField('email')->getInput()->attr('id', 'subscribeMail')->attr('placeholder', 'E-mail')}
    {$form->getField('phone')->getInput()->attr('id', 'subscribeTel')->attr('placeholder', 'Phone')}
    <input type="checkbox" name="subscribe[lang][]" value="en" checked="checked" style="display: none;">
    <div class='grid-x'><button class="blue_but cell-but small-12" type="submit" id="subscribeButton">Subscribe</button></div>
    <div class='grid-x'><button type='button' class="blue_but cell-but  small-12 close__popup">Close</button></div>

{else}
    {$form->getField('name')->getInput()->attr('id', 'subscribeName')->attr('placeholder', $form->getField('name')->getLabel())}
    {$form->getField('company')->getInput()->attr('id', 'subscribeCompany')->attr('placeholder', $form->getField('company')->getLabel())}
    {$form->getField('job')->getInput()->attr('id', 'subscribeJob')->attr('placeholder', $form->getField('job')->getLabel())}
    {$form->getField('email')->getInput()->attr('id', 'subscribeMail')->attr('placeholder', $form->getField('email')->getLabel())}
    {$form->getField('phone')->getInput()->attr('id', 'subscribeTel')->attr('placeholder', $form->getField('phone')->getLabel())}
    {$form->getField('lang')}
    <div class='grid-x'>
        <button class="blue_but cell-but small-12" type="submit" id="subscribeButton">Подписаться</button>
    </div>
    <div class='grid-x'><button type='button' class="blue_but cell-but  small-12 close__popup">Закрыть</button></div>

{/if}
{$form->protection()}
{$form->close()}