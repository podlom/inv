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
<div class="breadcrumbs">
    <h3>Перенаправления</h3>
    <div>
        <a href="/admin"><i class="fa fa-home"></i>Главная</a> <span>></span> Перенаправления
    </div>
</div>
<div class="edit light-form redirect-edit-form">
    {$form->open()}
        {$form->getField('from')}
        {$form->getField('to')}
        {$form->getField('status')}
        <input type="submit" name="" class="button green">
    {$form->close()}
	<div style="margin-top: 30px">{t('#redirect.301 Permanent, u will never be able to change this')}</div>
	<div style="margin-top: 10px">{t('#redirect.302 Temporary Redirect, used as 307 in most browsers, depricated')}</div>
	<div style="margin-top: 10px">{t('#redirect.303 See other (recomended) open other page without resending POST/PUT data (files,forms)')}</div>
	<div style="margin-top: 10px">{t('#redirect.307 Temporary Redirect, repeat request with another URL')}</div>
</div>
</div>
