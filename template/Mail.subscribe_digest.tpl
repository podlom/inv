{if $lang == 'en'}
    {$form->attr('class', 'subscribe_digest')->open()}
        {$form->getField('name')->getInput()->attr('id', 'subscribeName')->attr('placeholder', 'First Name & Surname')->addClass('pad')}
        {$form->getField('company')->getInput()->attr('id', 'subscribeCompany')->attr('placeholder', 'Company')}
        {$form->getField('job')->getInput()->attr('id', 'subscribeJob')->attr('placeholder', 'Position')}
        {$form->getField('email')->getInput()->attr('id', 'subscribeMail')->attr('placeholder', 'E-mail')}
        {$form->getField('phone')->getInput()->attr('id', 'subscribeTel')->attr('placeholder', 'Phone')}
        <input type="checkbox" name="subscribe[lang][]" value="en" checked="checked" style="display: none;">
        <button class="blue_but cell-but" type="submit" id="subscribeButton">Subscribe</button>
        {$form->protection()}
    {$form->close()}
{else}
    {$form->attr('class', 'subscribe_digest')->open()}
        <div class="row">
            <div class="small-12 medium-6 column">
                {$form->getField('name')->getInput()->attr('id', 'subscribeName')->attr('placeholder', $form->getField('name')->getLabel())}
            </div>
            <div class="small-12 medium-6 column">
                {$form->getField('company')->getInput()->attr('id', 'subscribeCompany')->attr('placeholder', $form->getField('company')->getLabel())}
            </div>
            <div class="small-12 medium-6 column">
                {$form->getField('job')->getInput()->attr('id', 'subscribeJob')->attr('placeholder', $form->getField('job')->getLabel())}
            </div>
            <div class="small-12 medium-6 column">
                {$form->getField('email')->getInput()->attr('id', 'subscribeMail')->attr('placeholder', $form->getField('email')->getLabel())}
            </div>
            <div class="small-12 column">
                {$form->getField('phone')->getInput()->attr('id', 'subscribeTel')->attr('placeholder', $form->getField('phone')->getLabel())}
            </div>
            <div class="small-12 column">
                <h6>Язык подписки</h6>
                {$form->getField('lang')->getInput()}
            </div>
        </div>
        <button class="blue_but cell-but" type="submit" id="subscribeButton">Подписаться</button>
        {$form->protection()}
    {$form->close()}
{/if}