

<div class="investor-form__header">
    <div class="investor-form__heading">Уважаемые Господа!
        <br>
    Предлагаем Вам пройти короткую регистрацию инвестора и получить следующие преимущества:</div>
    <ol class="grid-x" start="1">
        <li class="cell medium-4 small-12"><img src="/images/hosting.svg" alt="">Доступ к крупнейшей базе инвестиционных проектов и готового бизнеса</li>
        <li class="cell medium-4 small-12"><img src="/images/cloud-computing.svg" alt="">Оповещение о поступлении инвестиционных предложений согласно Вашим критериям инвестирования</li>
        <li class="cell medium-4 small-12"><img src="/images/stadistics.svg" alt="">Бесплатную подписку на получение ежемесячного инвестиционного дайджеста InVenture</li>
        <li class="cell medium-4 small-12"><img src="/images/id-card.svg" alt="">Статус члена закрытого инвестиционного клуба Investment Mosaic</li>
        <li class="cell medium-4 small-12"><img src="/images/search.svg" alt="">Возможность разместить запрос о поиске инвестиционных активов</li>
        <li class="cell medium-4 small-12"><img src="/images/coupon.svg" alt="">Скидку на инвестиционно-консалтинговые услуги InVenture Investment Group</li>
    </ol>
    
    
</div>



{$form->open()}
{foreach $form->getErrors(true) as $error}
   <div class="alert-box error error">{$error}</div>
{/foreach}
<fieldset>
    <h3>Персональные контактные данные инвестора</h3>
        <div class="row">
            {$form->getField('name')->getInput()}
            {$form->getField('company')->getInput()}
        </div>
        <div class="row">
            {$form->getField('job')->getInput()}
            {$form->getField('phone')->getInput()}
        </div>
        <div class="row">
            {$form->getField('skype')->getInput()}
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
        	{$form->getSubmit()->addClass('my_but')}
    	</center>

        <div class="investor-form__subtext">
        <p>
            Заполнение представленной выше онлайн формы, позволит нам идентифицировать Ваши предпочтения и инвестиционные критерии. При этом мы гарантируем соблюдение полной конфиденциальности предоставленной Вами информации и контактных данных.
        </p>
        <p>
            При отборе инвестиционных предложений для Вас мы будем руководствоваться предоставленными данными и информировать Вас о наиболее подходящих предложениях.
        </p>
    </div>
    </div>
</div>
{$form->protection()}
{$form->close()}