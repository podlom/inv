<div class="investor-form__header">
    <div class="investor-form__heading">Dear Sirs!
        <br>
    Please fill up an investor registration form and get the following benefits:</div>
    <ol class="grid-x" start="1">
        <li class="cell medium-4 small-12"><img src="/images/hosting.svg" alt="">Access to the largest database of investment projects, startups and business proposals</li>
        <li class="cell medium-4 small-12"><img src="/images/cloud-computing.svg" alt="">Notification of investment proposals according to your investment criteria</li>
        <li class="cell medium-4 small-12"><img src="/images/stadistics.svg" alt="">Free subscription to a monthly newsletter - InVenture Investment Digest</li>
        <li class="cell medium-4 small-12"><img src="/images/id-card.svg" alt="">Member status of Investment club «Investment Mosaic»</li>
        <li class="cell medium-4 small-12"><img src="/images/search.svg" alt="">Opportunity to place your investment request</li>
        <li class="cell medium-4 small-12"><img src="/images/coupon.svg" alt="">Discounts on investment and consulting services of InVenture Investment Group</li>
    </ol>
    
    
</div>


{$form->open()}
{foreach $form->getErrors(true) as $error}
   <div class="alert-box error error">{$error}</div>
{/foreach}
<fieldset>
    <h3>Investor`s personal contact information</h3>
        <div class="row">
            {$form->getField('firstname')->getInput()}
            {$form->getField('company')->getInput()}
        </div>
        <div class="row">
            {$form->getField('lastname')->getInput()}
            {* $form->getField('phone')->getInput()->setAttr('data-plugin-inputmask', 'inputmask_5de8d519')->setAttr('id', 'tel_1') *}
            {literal}
            <div class="input-investor">
            <input style="width: 520px !important;" type="tel" id="phone" name="sf_investor[phone]" required>
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
        </div>
        <div class="row">
            {$form->getField('job')->getInput()}
            {$form->getField('email')->getInput()}
        </div>
</fieldset>
<div class="checkbox">
	{foreach ['types','stage','location','strong','size','inv'] as $t}
    <h3>{$form->getField($t)->getLabel()}</h3>
    <div class="grid-x grid-margin-x">
        {$arr=$form->getField($t)->getInput()->getChilds()}
        {$count = round(count($arr)/2)}
        {$arr1 = array_slice($arr,0,$count)}
        {$arr2 = array_slice($arr,$count)}
        <div class="large-6 medium-6 cell check-row">{foreach $arr1 as $f}{$f}{/foreach}</div>
        <div class="large-6 medium-6 cell check-row">{foreach $arr2 as $f}{$f}{/foreach}</div>
    </div>
    {/foreach}

    <div class="info">
        <div>{$form->getField('info')}</div>


        <center>
        	{$form->getSubmit()->addClass('my_but')->setAttr('value','Send')}
    	</center>

        <!-- <div class="investor-form__subtext">
        <p>
            Заполнение представленной выше онлайн формы, позволит нам идентифицировать Ваши предпочтения и инвестиционные критерии. При этом мы гарантируем соблюдение полной конфиденциальности предоставленной Вами информации и контактных данных.
        </p>
        <p>
            При отборе инвестиционных предложений для Вас мы будем руководствоваться предоставленными данными и информировать Вас о наиболее подходящих предложениях.
        </p>
    </div> -->
    </div>
</div>
{$form->protection()}

<input type="hidden" name="sf_investor[ga_utm]" value="">
<input type="hidden" name="ga_utm" value="">
<input type="hidden" name="action" value="add">

{$form->close()}