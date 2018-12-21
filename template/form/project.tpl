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
    <div class="grid-x grid-margin-x ">
        <div class="medium-6 small-12 cell">{$form->getField('name')}</div>
        <div class="medium-6 small-12 cell">{$form->getField('job')}</div>
        <div class="medium-6 small-12 cell">{$form->getField('email')}</div>
        <div class="medium-6 small-12 cell">{$form->getField('phone')}</div>
    </div>
</fieldset>
<fieldset>
    <legend>Общая информация об инвестиционном проекте</legend>
    <div class="grid-x grid-margin-x ">
        <div class="medium-6 small-12 cell">{$form->getField('company')}</div>
        <div class="medium-6 small-12 cell">{$form->getField('period')}</div>
        <div class="medium-6 small-12 cell">{$form->getField('site')}</div>
        <div class="medium-6 small-12 cell">{$form->getField('region')}</div>
        <div class="medium-6 small-12 cell end">{$form->getField('stage')}</div>
    </div>
</fieldset>

<fieldset>
    <legend>{$form->getField('types')->getLabel()}</legend>
    <div class="grid-x grid-margin-x ">
        <div class="medium-6 small-12 cell"><div class="row"><label>{$form->getField('types')->getInput()}</label></div></div>
        <div class="medium-6 small-12 cell"><div class="row"><label>{$form->getField('types_other')->getInput()}</label></div></div>
    </div>
</fieldset>
<div class="grid-x grid-margin-x ">
    <div class="medium-6 small-12 cell">{$form->getField('cost')}</div>
    <div class="medium-6 small-12 cell">{$form->getField('money')}</div>
    <div class="medium-6 small-12 cell">{$form->getField('actives')}</div>
    <div class="medium-6 small-12 cell">{$form->getField('price')}</div>
</div>
<div class="grid-x grid-margin-x ">
    <div class="medium-6 small-12 cell">{$form->getField('conditions')}</div>
    <div class="medium-6 small-12 cell">{$form->getField('curs')}</div>
</div>
<div class="grid-x grid-margin-x ">
    <div class="medium-6 small-12 cell">{$form->getField('plan_stage')}</div>
    <div class="medium-6 small-12 cell">{$form->getField('plan_done')}</div>
</div>
<fieldset>
    <legend>Текущие финансово-экономические показатели проекта</legend>
    <div class="grid-x grid-margin-x ">
        <div class="medium-6 small-12 cell">{$form->getField('gross_income')}</div>
        <div class="medium-6 small-12 cell">{$form->getField('clean_income')}</div>
    </div>
</fieldset>
<fieldset>
    <legend>Показатели эффективности инвестиционного проекта</legend>
    <div class="grid-x grid-margin-x ">
        <div class="medium-6 small-12 cell">{$form->getField('irr')}</div>
        <div class="medium-6 small-12 cell">{$form->getField('nvp')}</div>
        <div class="medium-6 small-12 cell">{$form->getField('pi')}</div>
        <div class="medium-6 small-12 cell">{$form->getField('pp')}</div>
        <div class="medium-6 small-12 cell end">{$form->getField('dpp')}</div>
    </div>
</fieldset>
{$form->getField('request')}
<fieldset>
    <legend>Расширенная информация о проекте</legend>
    <div class="grid-x grid-margin-x ">
        <div class="medium-6 small-12 cell">{$form->getField('concept')}</div>
        <div class="medium-6 small-12 cell">{$form->getField('product')}</div>
        <div class="medium-6 small-12 cell">{$form->getField('concurent')}</div>
        <div class="medium-6 small-12 cell">{$form->getField('marketing')}</div>
        <div class="medium-6 small-12 cell">{$form->getField('risk')}</div>
        <div class="medium-6 small-12 cell">{$form->getField('team')}</div>
        <div class="medium-6 small-12 cell">{$form->getField('strategy')}</div>
        <div class="medium-6 small-12 cell">{$form->getField('other_info')}</div>
    </div>
</fieldset>
{$form->getSubmit()->addClass('blue_but')}
{$form->protection()}
{$form->close()}