{$form->open()}

{$t = $form->getField('curs')->getInput()->getChilds()}
{$t = $form->getField('curs')->getInput()->addChild(
    $form->getField('curs_other')
    ->getInput()
    ->setNameSpace($form->getName())
    ->setBaseName('curs_other')
)}
{foreach $form->getErrors(true) as $error}
   <div class="alert-box error error">{$error}</div>
{/foreach}
<fieldset>
    <legend>Данные об инциаторе инвестиционного проекта</legend>
    <div class="row medium-uncollapse">
        <div class="large-6 medium-6 columns">{$form->getField('name')}</div>
        <div class="large-6 medium-6 columns">{$form->getField('job')}</div>
        <div class="large-6 medium-6 columns">{$form->getField('email')}</div>
        <div class="large-6 medium-6 columns">{$form->getField('phone')}</div>
    </div>
</fieldset>
<fieldset>
    <legend>Общая информация об инвестиционном проекте</legend>
    <div class="row medium-uncollapse">
        <div class="large-6 medium-6 columns">{$form->getField('company')}</div>
        <div class="large-6 medium-6 columns">{$form->getField('period')}</div>
        <div class="large-6 medium-6 columns">{$form->getField('site')}</div>
        <div class="large-6 medium-6 columns">{$form->getField('region')}</div>
        <div class="large-6 medium-6 columns end">{$form->getField('stage')}</div>
    </div>
</fieldset>

<fieldset>
    <legend>{$form->getField('types')->getLabel()}</legend>
    <div class="row medium-uncollapse">
        <div class="large-6 medium-6 columns"><div class="row"><label>{$form->getField('types')->getInput()}</label></div></div>
        <div class="large-6 medium-6 columns"><div class="row"><label>{$form->getField('types_other')->getInput()}</label></div></div>
    </div>
</fieldset>
<div class="row medium-uncollapse">
    <div class="large-6 medium-6 columns">{$form->getField('cost')}</div>
    <div class="large-6 medium-6 columns">{$form->getField('money')}</div>
    <div class="large-6 medium-6 columns">{$form->getField('actives')}</div>
    <div class="large-6 medium-6 columns">{$form->getField('price')}</div>
</div>
<div class="row medium-uncollapse">
    <div class="large-6 medium-6 columns">{$form->getField('conditions')}</div>
    <div class="large-6 medium-6 columns">{$form->getField('curs')}</div>
</div>
<div class="row medium-uncollapse">
    <div class="large-6 medium-6 columns">{$form->getField('plan_stage')}</div>
    <div class="large-6 medium-6 columns">{$form->getField('plan_done')}</div>
</div>
<fieldset>
    <legend>Текущие финансово-экономические показатели проекта</legend>
    <div class="row medium-uncollapse">
        <div class="large-6 medium-6 columns">{$form->getField('gross_income')}</div>
        <div class="large-6 medium-6 columns">{$form->getField('clean_income')}</div>
    </div>
</fieldset>
<fieldset>
    <legend>Показатели эффективности инвестиционного проекта</legend>
    <div class="row medium-uncollapse">
        <div class="large-6 medium-6 columns">{$form->getField('irr')}</div>
        <div class="large-6 medium-6 columns">{$form->getField('nvp')}</div>
        <div class="large-6 medium-6 columns">{$form->getField('pi')}</div>
        <div class="large-6 medium-6 columns">{$form->getField('pp')}</div>
        <div class="large-6 medium-6 columns end">{$form->getField('dpp')}</div>
    </div>
</fieldset>
{$form->getField('request')}
<fieldset>
    <legend>Расширенная информация о проекте</legend>
    <div class="row medium-uncollapse">
        <div class="large-6 medium-6 columns">{$form->getField('concept')}</div>
        <div class="large-6 medium-6 columns">{$form->getField('product')}</div>
        <div class="large-6 medium-6 columns">{$form->getField('concurent')}</div>
        <div class="large-6 medium-6 columns">{$form->getField('marketing')}</div>
        <div class="large-6 medium-6 columns">{$form->getField('risk')}</div>
        <div class="large-6 medium-6 columns">{$form->getField('team')}</div>
        <div class="large-6 medium-6 columns">{$form->getField('strategy')}</div>
        <div class="large-6 medium-6 columns">{$form->getField('other_info')}</div>
    </div>
</fieldset>
{$form->getSubmit()->addClass('blue_but')}
{$form->protection()}
{$form->close()}