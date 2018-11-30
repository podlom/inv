<div class="admin-pages">
    <div class="menu-blocks">   
        <div>
            <div>
                <p>Новости</p>
                <i class="fa fa-newspaper-o"></i>
            </div>
            <div>
                <a href="/admin/blog/11">Больше информации <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div>
            <div>
                <p>Инвестиционные предложения</p>
                <i class="fa fa-wpforms"></i>
            </div>
            <div>
                <a href="/admin/blog/7859">Больше информации <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div>
            <div>
                <p>Мероприятия</p>
                <i class="fa fa-calendar"></i>
            </div>
            <div>
                <a href="/admin/blog/34">Больше информации <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div>
            <div>
                <p>Доска объявлений</p>
                <i class="fa fa-list-alt"></i>
            </div>
            <div>
                <a href="/admin/blog/14976">Больше информации <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
    </div>
    <div class="edit">
        {$form->open()}
            <div class="buttons" style="margin-bottom: 30px;">
                <div class="language">
                    {if is_mod('Locale')}
                        {$form->getBound('locale')}
                    {/if}
                </div>
                 {if $entity && $entity->getId()}
                    <a class="blue button" href="{$link}">{t('Назад')}</a>
                    <a href="{$entity->getPath()}" class="green button" style="display:inline">{t('Просмотр')}</a>
                {/if}
            </div>
            <div class="flex-form">
            <div>
                <div class="preview">
                    <h3>Анонс</h3>
                    <label>
                        Название:
                        {$form->getField('announce')->getField('h1')->getInput()->setAttr('placeholder','Название')}
                    </label>
                    <label>
                        Описание:
                        {$form->getField('announce')->getField('short_text')->getInput()->setAttr('placeholder','Описание')}
                    </label>
                </div> 
                <div class="img-load">
                    <h3>Изображение</h3>
                    <label>
                        {$form->getField('images')->getInput()}
                    </label>
                </div>
                <div class="full-info">
                    <h3>Полное описание</h3>
                    <label>
                        Заголовок:
                        {$form->getField('content')->getField('title')->getInput()->setAttr('placeholder','Заголовок')}
                    </label>
                    <label>
                        Описание:
                        {$form->getField('content')->getField('text')->getInput()->setAttr('placeholder','Описание')}
                    </label>
                </div>
                <div class="attributes">
                    {if $form->getField('attr')}<h3>Атрибуты</h3>{/if}
                    {$form->getField('attr')}
                </div>
            </div>
           <div>
               <div class="url">
                    <h3>URL</h3>
                    <label class="label-url">
                        URL:
                        {$form->getField('advanced')->getField('url')->getInput()}
                    </label>
                    <label>
                        Публикация:
                        <div>
                            {$form->getField('advanced')->getField('visible')->getInput()->setId('visible')}
                            <div class="date-range">
                                <a href=""><i class="fa fa-calendar"></i></a>
                                {$form->getField('advanced')->getField('published')->getInput()}
                            </div>
                        </div>
                    </label>
                    {if $form->getField('advanced')->getField('lang')}
                        {$form->getField('advanced')->getField('lang')}
                    {/if}
                </div>
                <div class="category">
                    {if $form->getField('category')}<h3>Категории</h3>{/if}
                    {$form->getField('category')}
                </div>
                {#mod Metadata}
                <div class="metadata">
                    <h3>Метаданные</h3>
                    <label>
                        Заголовок:
                        {$form->getField('meta')->getField('title')->getInput()->setAttr('placeholder','Заголовок')}
                    </label>
                    <label>
                        Ключевые слова:
                        {$form->getField('meta')->getField('keywords')->getInput()->setAttr('placeholder','Ключевые слова')}
                    </label>
                    <label>
                        Описание:
                        {$form->getField('meta')->getField('description')->getInput()->setAttr('placeholder','Описание')}
                    </label>
                </div>
                {#/mod}
           </div>
        </div>
        {block 'submit'}
        {$link = $form->getBound('ref', $form->getBound('link'))}
        <button class="button green" name="ref" value="{$link}">{t('Сохранить и вернуться')}</button>
        {$form->getSubmit()->addClass('button green')->setAttr('value', t('Сохранить'))}
        <a class="button blue" href="{$link}">{t('Назад')}</a>
        {/block}
        {$form->close()}
    </div>
</div>
