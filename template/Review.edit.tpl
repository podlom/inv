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

        <div class="flex-form">
            <div>
                <div>
                    <label>
                        Категория
                        {* $form->getField('category')->getInput() *}

                        <select name="entity[category]">
                            <option value="add-inv-prop"{if $entity->getCategory()=='add-inv-prop'} selected{/if}>Найти инвестора</option>
                            <option value="digest-social"{if $entity->getCategory()=='digest-social'} selected{/if}>Подписка</option>
                        </select>
                    </label>
                </div>

                <div>
                    <label>
                        Адрес аватарки
                        {$form->getField('image_url')->getInput()}
                    </label>
                </div>

                <div>
                    <label>
                        Имя
                        {$form->getField('first_name')->getInput()}
                    </label>
                </div>

                <div>
                    <label>
                        Фамилия
                        {$form->getField('last_name')->getInput()}
                    </label>
                </div>

                <div>
                    <label>
                        Компания
                        {$form->getField('company')->getInput()}
                    </label>
                </div>

                <div>
                    <label>
                        Должность
                        {$form->getField('job')->getInput()}
                    </label>
                </div>

                <div>
                    <label>
                        Facebook
                        {$form->getField('facebook_url')->getInput()}
                    </label>
                </div>

                <div>
                    <label>
                        LinkedIn
                        {$form->getField('linkedin_url')->getInput()}
                    </label>
                </div>

                <div class="full-info">
                    <label>
                        Отзыв:
                        {$form->getField('rtext')->getInput()->setAttr('placeholder','Текст отзыва')->setAttr('data-group', 'text')}
                    </label>
                </div>

                <div>
                    Публикация:
                    <div>
                        {* $form->getField('status')->getInput()->setId('status') *}

                        <div class="date-range">
                            <a href=""><i class="fa fa-calendar"></i></a>
                            {$form->getField('published')->getInput()}
                        </div>

                        <div class="date-range">
                            <a href=""><i class="fa fa-calendar"></i></a>
                            {$form->getField('created')->getInput()}
                        </div>

                        <div class="date-range">
                            <a href=""><i class="fa fa-calendar"></i></a>
                            {$form->getField('updated')->getInput()}
                        </div>
                    </div>
                </div>

                <div>
                    <label>
                        Lang
                        <select name="entity[lang]" class="user-success" data-sci>
                            <option value="ru"{if $entity->getLang() == 'ru'} selected{/if}>Русский (ru)</option>
                            <option value="uk"{if $entity->getLang() == 'uk'} selected{/if}>Українська (uk)</option>
                            <option value="en"{if $entity->getLang() == 'en'} selected{/if}>English (en)</option>
                        </select>
                    </label>
                </div>

            </div>
        </div>

        {block 'submit'}
            {$form->getSubmit()->addClass('button green')->setAttr('value', t('Сохранить'))}
        {/block}
        {$form->close()}
    </div>
</div>


