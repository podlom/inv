<div class="grid-container add_adv_form">
     <div class="grid-x grid-margin-x">
            <div class="large-9 medium-12 cell" itemscope itemtype="http://schema.org/Article">
            {block 'breadcrumbs'}

                <div class="clearfix border-bottom">
                    <h2>Доска объявлений</h2>
                </div>

            {/block}
            {block 'content'}
    <div class="box-shadow"></div>
    <div class="viewbox-cnt-body board_edit">
        {if $post && $post->getId()}
        <h3>Редактировать объявление</h3>
        {else}
        <h3>Добавить объявление</h3>
        <div class="rules">
            <div>Цена размещения объявления – <b>99 грн</b></div>
            <div>Срок размещения объявления – <b>3 месяца</b></div>
            <div>Ознакомиться с <a href="/rules">правилами размещения объявлений</a></div>
        </div>
        {/if}
        {content $post}
        {foreach $form->getErrors() as $err}
            <div class="callout alert">
                {$err.1}
            </div>
        {/foreach}
		{$form->open()}
            <h4>Персональные данные</h4>
            <div class="personal_data grid-x grid-margin-x">
                <div class="cell medium-4 small-12">{$form->getField('attr')->getField('attr_5')->getInput()->setAttr('placeholder','Ф.И.О')}</div>
                <div class="cell medium-4 small-12">{$form->getField('attr')->getField('attr_3')->getInput()->setAttr('placeholder','Телефон')}</div>
                <div class="cell medium-4 small-12">{$form->getField('attr')->getField('attr_4')->getInput()->setAttr('placeholder','E-mail')}</div>
            </div>
            <h4>Данные об инвестиционном предложении</h4>
            <div class="proposals_data">
                <div class="grid-x grid-margin-x">
                    <div class="cell medium-4 small-12">{$form->getField('category')->getField('parent')->getInput()->setAttr('placeholder','Тип предложения')}</div>
                </div>
            <h4>Указать расположение</h4>
                <div>{$form->getField('attr')->getField('attr_10')->getInput()}</div>
                <div>{$form->getField('announce')->getField('h1')->getInput()->setAttr('placeholder','Название (не более 100 символов)')}</div>
                <div>{$form->getField('announce')->getField('short_text')->getInput()->setAttr('placeholder','Краткое описание (не более 200 символов)')}</div>
                <div>{$form->getField('meta')->getField('keywords')->getInput()->setAttr('placeholder','Введите через запятую 7 ключевых слов объявления')}</div>
            <h4>Полное описание</h4>
                <div>{$form->getField('content')->getField('text')->getInput()->setAttr('placeholder','Полное описание (не более 3000 символов)')}</div>
            </div>
            <h4>Цена / Инвестиции, $</h4>
                <div>{$form->getField('attr')->getField('attr_15')->getInput()->setAttr('placeholder','$')}</div>
            <div class="add_img">
                <label class="label_one">{$form->getField('image')->getInput()->setAttr('id','imgInput')}<span>Изменить изображение</span></label>
                <div></div>
                <p>Картинка не должна превышать размер<br> <b>2 Mb</b> и иметь <b>соотношение ширины/высоты 4:3</b> и следующие форматы <b>JPG, JPEG, PNG, TIFF</b> </p>
            </div>
            <input type="submit" name="" value="Отправить">
        {$form->close()}
    </div>
</div>
{/block}
<div class="cell large-3 medium-12">
  <aside class="sidebar">
    {if $lang == 'en'}
                <a href="/en/investor" class="invest_btn">invest</a>
            {else}
                <a href="/investor" class="invest_btn">инвестировать</a>
            {/if}
    {if $lang == 'en'}
                <a href="/en/add-inv-prop" class="invest_btn invest_btn1">find an investor</a>
            {else}
                <a href="/add-inv-prop" class="invest_btn invest_btn1">найти инвестора</a>
            {/if}
          <div class="box-shadow_form">
        <div class="box-shadow"></div>
        <div class="form">
            <div class="title">
                {if $lang == 'en'}<a href="/en/analytics/digest"> <i class="fa fa-rss"></i>Sign up for Digest</a>


            {else}
                <a href="/analytics/digest"> <i class="fa fa-rss"></i>Подписка на дайджест</a>
            {/if}
              </div>
              <div class="img"><img src="/i/digest_img.jpg"></div>
            {subscribe}
        </div>
      </div>
       <div class="box-shadow_archive">
        <div class="box-shadow"></div>
        <div class="archive">
            <div class="title">
               {if $lang == 'en'}<a href="/en/analytics/digest"> <img src="/i/download_icon.png" alt="Загрузить" title="Загрузить">Archive</a>


            {else}
               <a href="/analytics/digest"> <img src="/i/download_icon.png" alt="Загрузить" title="Загрузить">Архив выпусков</a>
            {/if}
              </div>
            <form name="archiveForm" method="post" action="#">
                <div class="d_n" id="digest">
                    {load_digests}
                    {foreach $digests as $digest}
                        <a class="m{$digest->getPubDate()->format('n')} y{$digest->getPubDate()->format('Y')}" href="{$digest->getUrl()}"></a>
                    {/foreach}
                </div>
                <div class="option">
                    <select name="archiveFormYear" id="archiveFormYear" class="select1">
                        {$now = date_create()}
                        {for $year=2012 to $now->format('Y')}
                            <option value="{$year}" label="{$year}"{if $digest->getPubDate()->format('Y')==$year} selected{/if}>{$year}</option>
                        {/for}
                    </select>
                    <select name="archiveFormMonths" id="archiveFormMonths" class="select2">
                      {if $lang == 'en'}
                         {foreach ["January","February", "March","April", "May", "June", "July", "August", "September", "October", "November", "December"] as $id => $name}
                            <option value="{$id+1}"{if $digest->getPubDate()->format('n')==$id+1} selected{/if} label="{$name}">{$name}</option>
                        {/foreach}
                      {else}
                          {foreach ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'] as $id => $name}
                            <option value="{$id+1}"{if $digest->getPubDate()->format('n')==$id+1} selected{/if} label="{$name}">{$name}</option>
                        {/foreach}
                      {/if}

                    </select>
                </div>
                    <a class="blue_but cell-but"  target="_blank" id="archiveFormButton" href="#" disabled="disabled">{if $lang == 'en'}
                Download
            {else}
                Скачать
            {/if}</a>
            </form>
        </div>
      </div>
    <div class="advertising" id="advertising">
    <div class="box-shadow"></div>
    {widget_slot 'main (370x450)' size=[370,450]}
    {widget_slot 'post_2 (370x450)' size=[370,450]}
    {widget_slot 'post_6 (270x350)' size=[270,350]}
  </div>
  </aside>
        </div>
     </div>
</div>

