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
                        Адрес раздела сайта (URI)
                        {$form->getField('uri')->getInput()}
                    </label>
                </div>

                <div class="full-info">
                    <label>
                        SEO Текст:
                        {* $form->getField('text')->getInput()->setAttr('placeholder','SEO Текст')->setAttr('data-group', 'text') *}
                        {$form->getField('text')->getInput()->setAttr('placeholder','SEO Текст')->setAttr('qtype','Html')->setAttr('data-group', 'text')}
                    </label>
                </div>

                <div>
                    Даты создания и редактирования:
                    <div>
                        <div class="date-range">
                            <a href=""><i class="fa fa-calendar"></i></a>
                            {$form->getField('added_at')->getInput()}
                        </div>

                        <div class="date-range">
                            <a href=""><i class="fa fa-calendar"></i></a>
                            {$form->getField('updated_at')->getInput()}
                        </div>
                    </div>
                </div>
            </div>
        </div>

        {block 'submit'}
            {$form->getSubmit()->addClass('button green')->setAttr('value', t('Сохранить'))}
        {/block}
        {$form->close()}
    </div>
</div>
