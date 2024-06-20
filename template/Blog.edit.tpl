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
        {$form->setId('frm1')->open()}
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
                        {$form->getField('announce')->getField('h1')->getInput()->setAttr('placeholder','Название')->setAttr('data-group', 'title')->setAttr('data-source', true)}
                    </label>
                    <label>
                        Описание:
                        {$form->getField('announce')->getField('short_text')->getInput()->setAttr('placeholder','Описание')->setAttr('data-group', 'text')->setAttr('data-source', true)}
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
                        {$form->getField('content')->getField('title')->getInput()->setAttr('placeholder','Заголовок')->setAttr('data-group', 'title')}
                    </label>
                    <label>
                        Описание:
                        {$form->getField('content')->getField('text')->getInput()->setAttr('placeholder','Описание')->setAttr('data-group', 'text')}
                    </label>
                </div>
                <div id="pg_attr0" class="attributes">
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
                                <a href="#"><i class="fa fa-calendar"></i></a>
                                {$form->getField('advanced')->getField('published')->getInput()}
                            </div>
                        </div>
                    </label>
                    {if $form->getField('advanced')->getField('lang')}
                        {$form->getField('advanced')->getField('lang')}
                    {/if}
                </div>
                {if $form->getField('category')}
                    <div class="category">
                        <h3>{$form->getField('category')->getField('parent')->getLabel()}</h3>
                        <label>{$form->getField('category')->getField('parent')->getInput()}</label>
                    </div>
                    {if $form->getField('category')->getField('rubric')}
                    <div class="category">
                        <h3>{$form->getField('category')->getField('rubric')->getLabel()}</h3>
                        <label>{$form->getField('category')->getField('rubric')->getInput()}</label>
                    </div>
                    {/if}
                {/if}
                {#mod Metadata}
                <div class="metadata">
                    <h3>Метаданные</h3>
                    <label>
                        Заголовок:
                        {$form->getField('meta')->getField('title')->getInput()->setAttr('placeholder','Заголовок')->setAttr('data-group', 'title')}
                    </label>
                    <label>
                        Ключевые слова:
                        {$form->getField('meta')->getField('keywords')->getInput()->setAttr('placeholder','Ключевые слова')}
                    </label>
                    <label>
                        Описание:
                        {$form->getField('meta')->getField('description')->getInput()->setAttr('placeholder','Описание')->setAttr('data-group', 'text')}
                    </label>
                    <label>
                        SEO текст:
                        {$form->getField('meta')->getField('seo')->getInput()->setAttr('placeholder','SEO текст')->setAttr('data-group', 'text')}
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

{script_code require=["jquery"] name="blogtitles"}

console.log('Script loaded +152');

var avatarImg = '';

$('[data-source]').focus(function(e){
    $(e.target).data('val', e.target.value);
}).change(function(e){
    var g = $(e.target).attr('data-group');
    var v = $(e.target).data('val') || null;
    console.log(v);
    $('[data-group="'+g+'"]').each(function(k,i){
        if(!i.value || i.value === v){
            i.value = e.target.value;
        }
    });
});

console.log( '+169 window.location.href: ' + window.location.href );
var wlh = window.location.href;
var lio = wlh.lastIndexOf("/");
var pid = wlh.substring(lio + 1, wlh.length);
console.log( '+173 pid: ' + pid );

function getAdvertValue() {

{literal}

    $.post(
        '/page-attr-data.php',
        {'action':'get','page_id':pid,'attr_id':'64'},
        function(res815){
            $('input[name="page[attr][attr_64]"]').val(res815);
            if (res815 == 1 && !$('#attr_64').is(':checked')) {
                $('#attr_64').prop('checked', true);
            }
        }
    );

{/literal}

}

function getExclusiveValue() {

{literal}

    $.post(
        '/page-attr-data.php',
        {'action':'get','page_id':pid,'attr_id':'65'},
        function(res805) {
        $('input[name="page[attr][attr_65]"]').val(res805);
            if (res805 == 1 && !$('#attr_65').is(':checked')) {
                $('#attr_65').prop('checked', true);
            }
        }
    );

{/literal}

}

if ((wlh.indexOf("/admin/blog/11/edit/") > -1) || (wlh.indexOf("/admin/blog/9/edit/") > -1) ) {
    console.log('+214 it is News or Analytics admin section');

    var in811 = $('input[name="page[attr][attr_64]"]');
    $(in811).parent().remove();
    var le811 = $('#pg_attr0 fieldset:first' ).find(in811);
    if (!le811.length) {
        $('div#pg_attr0 fieldset:first').append('<div class="row"><label>На правах рекламы: <input type="checkbox" id="attr_64" name="page[attr][attr_64]" value="0"></label></div>');
    }
    setTimeout(getAdvertValue, 951);
    var in801 = $('input[name="page[attr][attr_65]"]');
    $(in801).parent().remove();
    var le801 = $('#pg_attr0 fieldset:first' ).find(in801);
    if (!le801.length) {
        $('div#pg_attr0 fieldset:first').append('<div class="row"><label>Эксклюзивный материал InVenture: <input type="checkbox" id="attr_65" name="page[attr][attr_65]" value="0"></label></div>');
    }
    setTimeout(getExclusiveValue, 975);
}

$('#attr_64').click(function(){
    if ($('#attr_64').is(':checked')) {
        $('#attr_64').val(1);
    } else {
        $('#attr_64').val(0);
    }
    var v811 = $('#attr_64').val();
    console.log('+196 Advert checkbox with name = "page[attr][attr_64]" val: ' + v811);

{literal}

    $.post(
        '/page-attr-data.php',
        {'action':'set','page_id':pid,'attr_id':'64','value':v811},
        function(re811){ console.log('+201 Got result: ' + re811); }
    );

{/literal}

});

$('#attr_65').click(function(){
    if ($('#attr_65').is(':checked')) {
        $('#attr_65').val(1);
    } else {
        $('#attr_65').val(0);
    }
    var v801 = $('#attr_65').val();
    console.log('+261 Exclusive checkbox with name = "page[attr][attr_65]" val: ' + v801);

{literal}

    $.post(
        '/page-attr-data.php',
        {'action':'set','page_id':pid,'attr_id':'65','value':v801},
        function(re801){ console.log('+201 Got result: ' + re801); }
    );

{/literal}

});

/* TODO: check slug JS logic was here */

function getRandomInt(max) {
    return Math.floor(Math.random() * Math.floor(max));
}

var cpv = $( "select[name='page[category][parent]']" ).val();
console.log('Current page category parent: ' + cpv);

switch (cpv) {
    case '15088':
        setTimeout(function(){ console.log( ' old text: ' + $('span.svr-prefix').text() ); $('span.svr-prefix').text('board/projects-15088'); }, 2500);
    break;
    case '15090':
        setTimeout(function(){ console.log( ' old text: ' + $('span.svr-prefix').text() ); $('span.svr-prefix').text('board/realestate-15090'); }, 2500);
    break;
    case '15091':
        setTimeout(function(){ console.log( ' old text: ' + $('span.svr-prefix').text() ); $('span.svr-prefix').text('board/land-15091'); }, 2500);
    break;
    case '15092':
        setTimeout(function(){ console.log( ' old text: ' + $('span.svr-prefix').text() ); $('span.svr-prefix').text('board/offer-15092'); }, 2500);
    break;
    case '15089':
        setTimeout(function(){ console.log( ' old text: ' + $('span.svr-prefix').text() ); $('span.svr-prefix').text('board/business-15089'); }, 2500);
    break;
}

    var in101 = $( '#adm_mgr1' );
    var le101 = $( '#pg_attr0 fieldset:first' ).find( in101 );
    if (le101.length) {
        console.log('+197 Found select with id #adm_mgr1 in #pg_attr0');
    } else {
        console.log('+199 Not found select with id #adm_mgr1 in #pg_attr0');

{literal}

    $.post(
        '/auth-attr-data.php',
        {'action':'check_admin'},
        function(res0){ console.log('+198 got html result: ' + res0); $( 'div#pg_attr0 fieldset' ).prepend(res0); }
    );

    $('div#pg_attr0 fieldset').on('change', '#adm_mgr1', function(){
        var v0 = $(this).val();
        console.log('+214 New select value: ' + v0);
        if (v0.length > 0) {
            $.post(
                '/auth-attr-data.php',
                {'action':'admin_get_manager_contacts','manager_id':v0},
                function(re1){ console.log('+219 Got result: ' + re1);
                    $("input[name='page[attr][attr_5]']").val(re1.name);
                    $("input[name='page[attr][attr_4]']").val(re1.email);
                    $("input[name='page[attr][attr_3]']").val(re1.phone);
                    $("input[name='page[attr][attr_63]']").val(re1.avatar);
                    avatarImg = re1.avatar;
                    $.post(
                        '/page-attr-data.php',
                        {'action':'set','page_id':pid,'attr_id':'63','value':re1.avatar},
                        function(re114){ console.log('+216 Got result: ' + re114); }
                    );
                },
                "json"
            );
        }
    });

{/literal}

    }

    var in911 = $( 'input[name="page[attr][attr_63]"]' );
    var le911 = $( '#pg_attr0 fieldset:first' ).find( in911 );
    if (le911.length) {
        console.log('+243 found Avatar input with name = "page[attr][attr_63]"');

        if (pid == 'add') {
            console.log('+246 add new entry');

{literal}

    $.post(
        '/auth-attr-data.php',
        {'action':'check_manager'},
        function(res){
            console.log('+254 got json result: ' + res);
            $("input[name='page[attr][attr_5]']").val(res.name);
            $("input[name='page[attr][attr_4]']").val(res.email);
            $("input[name='page[attr][attr_3]']").val(res.phone);
            $("input[name='page[attr][attr_63]']").val(res.avatar);
            /*

            if (res.avatar.length) {
                $.post(
                    '/page-attr-data.php',
                    {'action':'set','page_id':pid,'attr_id':'63','value':res.avatar},
                    function(re115){ console.log('+262 Got result: ' + re115); }
                );
            }

            */
        },
        "json"
    );

{/literal}

        }

    } else {
        console.log('+233 Avatar input with name = "page[attr][attr_63]" was not found');

        $( 'div#pg_attr0 fieldset:first' ).append( '<div class="row"><label>Avatar: <input type="text" name="page[attr][attr_63]" value=""></label></div>' );

    if (pid == 'add') {
        console.log('+272 add new entry');

{literal}

    $.post(
        '/auth-attr-data.php',
        {'action':'check_manager'},
        function(res){
            console.log('+278 got json result: ' + res);
            $("input[name='page[attr][attr_5]']").val(res.name);
            $("input[name='page[attr][attr_4]']").val(res.email);
            $("input[name='page[attr][attr_3]']").val(res.phone);
            $("input[name='page[attr][attr_63]']").val(res.avatar);
        },
        "json"
    );

    } else {
        console.log('+298 edit existing entry');

        $.post(
            '/page-attr-data.php',
            {'action':'get','page_id':pid,'attr_id':'63'},
            function(re112){
                console.log('+303 Got result: ' + re112);
                $('input[name="page[attr][attr_63]"]').val(re112);
                var curVal = $('input[name="page[attr][attr_63]"]').val();
                console.log('+306 current avatar img value: ' + curVal + '; avatarImg: ' + avatarImg);
                if (avatarImg.length && !curVal.length) {
                    $('input[name="page[attr][attr_63]"]').val(avatarImg);
                } else {
                    if (!curVal.length) {
                        $.post(
                            '/auth-attr-data.php',
                            {'action':'check_manager'},
                            function(r13){
                                console.log('+314 got json result: ' + r13);
                                $("input[name='page[attr][attr_63]']").val(r13.avatar);
                                $.post(
                                    '/page-attr-data.php',
                                    {'action':'set','page_id':pid,'attr_id':'63','value':r13.avatar},
                                    function(r20){ console.log('+320 got result: ' + r20); }
                                );
                            },
                            "json"
                        );
                    }
                }
            }
        );

    }

    $( "input[name='page[attr][attr_63]']" ).change(function() {
        var v63 = $(this).val();
        console.log('+312 New field value: ' + v63);
        $.post(
            '/page-attr-data.php',
            {'action':'set','page_id':pid,'attr_id':'63','value':v63},
            function(re113){ console.log('+316 Got result: ' + re113); }
        );
    });

{/literal}

    }

$( "select[name='page[category][parent]']" ).change(function(e1) {

    var cv1 = $( this ).val();
    var ct1 = $( "select[name='page[category][parent]'] option:selected" ).text();

    console.log( '+316 cv1: ' + cv1 + '; ct1: ' + ct1 );

    if (cv1 == 19303) {
        if (pid == 'add') {
            document.querySelector('#mceu_2 > button').click();
            $('#frm1').submit();
        }

        var in8 = $( 'input[name="page[attr][attr_15]"]' );
        var le8 = $( 'div.attributes' ).find( in8 );
        if (le8.length) {
            console.log('Found Цена input with name = "page[attr][attr_15]"');
        } else {
            console.log('Not Found Цена input with name = "page[attr][attr_15]"');
            $( 'div.attributes fieldset' ).append( '<div class="row"><label>Цена: <input type="number" step="any" name="page[attr][attr_15]" value=""></label></div>' );

{literal}

    $.post(
        '/page-attr-data.php',
        {'action':'get','page_id':pid,'attr_id':'15'},
        function(res1){ console.log('+216 Got result: ' + res1); $('input[name="page[attr][attr_15]"]').val(res1); }
    );

    $('input[name="page[attr][attr_15]"]').focusout(function(){
        var v1 = $(this).val();
        console.log('+221 New field value: ' + v1);
        $.post(
            '/page-attr-data.php',
            {'action':'set','page_id':pid,'attr_id':'15','value':v1},
            function(res2){ console.log('+225 Got result: ' + res2); }
        );
    });

{/literal}

        }

        var in9 = $( 'input[name="page[attr][attr_16][0]"]' );
        var le9 = $( 'div.attributes' ).find( in9 );
        if (le9.length) {
            console.log('Found Отрасль input with name = "page[attr][attr_16][0]"');
        } else {
            console.log('Not Found Отрасль input with name = "page[attr][attr_16][0]"');
            $( 'div.attributes fieldset' ).append( '<div class="row"><label>Отрасль: <select name="page[attr][attr_16][0]" data-level="0" ui-id="5"><option value="0" label="Сельское хозяйство">Сельское хозяйство</option><option value="1" label="Добывающая промышленность">Добывающая промышленность</option><option value="2" label="Энергообеспечение">Энергообеспечение</option><option value="3" label="Водообеспечение и переработка отходов">Водообеспечение и переработка отходов</option><option value="4" label="Строительство и недвижимость">Строительство и недвижимость</option><option value="5" label="Потребительские услуги">Потребительские услуги</option><option value="6" label="Бизнес услуги">Бизнес услуги</option><option value="7" label="Государственное управление">Государственное управление</option><option value="8" label="Деревообработка">Деревообработка</option><option value="9" label="Здравоохранение и социальная помощь">Здравоохранение и социальная помощь</option><option value="10" label="Искусство, развлечения, спорт и отдых">Искусство, развлечения, спорт и отдых</option><option value="11" label="Машиностроение">Машиностроение</option><option value="12" label="Металлургия">Металлургия</option><option value="13" label="Образование">Образование</option><option value="14" label="Оптовая торговля">Оптовая торговля</option><option value="15" label="Организации и ассоциации">Организации и ассоциации</option><option value="16" label="Пищевая промышленность">Пищевая промышленность</option><option value="17" label="Гостиницы и общественное питание">Гостиницы и общественное питание</option><option value="18" label="Розничная торговля">Розничная торговля</option><option value="19" label="ИТ и телекоммуникации">ИТ и телекоммуникации</option><option value="20" label="Текстильная промышленность">Текстильная промышленность</option><option value="21" label="Транспорт и складское хозяйство">Транспорт и складское хозяйство</option><option value="22" label="Финансовая деятельность">Финансовая деятельность</option><option value="23" label="Нефтехимическая промышленность">Нефтехимическая промышленность</option><option value="24" label="Инновации и высокие технологии">Инновации и высокие технологии</option><option label="Значение не указано" value=""></option></select></label></div>' );

{literal}

    $.post(
        '/page-attr-data.php',
        {'action':'get','page_id':pid,'attr_id':'16','level':'0'},
        function(res160){ console.log('+247 Selecting option with value: ' + res160); $('select[name="page[attr][attr_16][0]"] option:eq(' + res160 + ')').prop('selected', true); }
    );

    $('select[name="page[attr][attr_16][0]"]').focusout(function(){
        var v1 = $(this).val();
        console.log('+252 New select value: ' + v1);
        $.post(
            '/page-attr-data.php',
            {'action':'set','page_id':pid,'attr_id':'16','level':'0','value':v1},
            function(res161){ console.log('+256 Got result: ' + res161); }
        );
    });

{/literal}

        }

        {* var in0 = $( 'input[name="page[attr][attr_16][1]"]' );
        var le0 = $( 'div.attributes' ).find( in0 );
        console.log( 'le0: ' + le0 );
        if (le0.length) {
            console.log('Found Отрасль input with name = "page[attr][attr_16][1]"');
        } else {
            console.log('Not Found Отрасль input with name = "page[attr][attr_16][1]"');
            $( 'div.attributes fieldset' ).append( '<div class="row"><label>Отрасль: <select name="page[attr][attr_16][1]" data-level="1" ui-id="6"><option value="0"></option><option value="129" label="Банковская деятельность">Банковская деятельность</option><option value="130" label="Финансовый лизинг">Финансовый лизинг</option><option value="131" label="Страхование">Страхование</option><option value="132" label="Инвестиционно-банковская деятельность">Инвестиционно-банковская деятельность</option><option value="133" label="Другие виды финансовых услуг">Другие виды финансовых услуг</option></select></label></div>' );
        } *}

        var in7 = $( 'input[name="page[attr][attr_32]"]' );
        var le7 = $( 'div.attributes' ).find( in7 );
        if (le7.length) {
            console.log('Found project_stage input with name = "page[attr][attr_32]"');
        } else {
            console.log('Not Found project_stage input with name = "page[attr][attr_32]"');
            $( 'div.attributes fieldset' ).append( '<div class="row"><label>project_stage: <select name="page[attr][attr_32]"><option value="0" label="Стартап">Стартап</option><option value="1" label="Ранняя стадия">Ранняя стадия</option><option value="2" selected="" label="Стадия роста и расширения">Стадия роста и расширения</option><option value="3" label="Поздние стадии">Поздние стадии</option><option value="4" label="Проблемный актив">Проблемный актив</option><option value="" label="Значение не указано"></option></select></label></div>' );

{literal}

    $.post(
        '/page-attr-data.php',
        {'action':'get','page_id':pid,'attr_id':'32'},
        function(res3){ console.log('+285 Selecting optionv with value: ' + res3); $('select[name="page[attr][attr_32]"] option:eq(' + res3 + ')').prop('selected', true); }
    );

    $('select[name="page[attr][attr_32]"]').focusout(function(){
        var v1 = $(this).val();
        console.log('+290 New select value: ' + v1);
        $.post(
            '/page-attr-data.php',
            {'action':'set','page_id':pid,'attr_id':'32','value':v1},
            function(res4){ console.log('+276 Got result: ' + res4); }
        );
    });

{/literal}

        }

        var in6 = $( 'input[name="page[attr][attr_33]"]' );
        var le6 = $( 'div.attributes' ).find( in6 );
        if (le6.length) {
            console.log('Found investments input with name = "page[attr][attr_33]"');
        } else {
            console.log('Not Found investments input with name = "page[attr][attr_33]"');
            $( 'div.attributes fieldset' ).append( '<div class="row"><label>investment_type: <select name="page[attr][attr_33]"><option value="0" label="Участие в капитале">Участие в капитале</option><option value="1" label="Кредитование">Кредитование</option><option value="2" selected="" label="Другое">Другое</option><option value="" label="Значение не указано"></option></select></label></div>' );

{literal}

    $.post(
        '/page-attr-data.php',
        {'action':'get','page_id':pid,'attr_id':'33'},
        function(res5){ console.log('+315 Selecting optionv with value: ' + res5); $('select[name="page[attr][attr_33]"] option:eq(' + res5 + ')').prop('selected', true); }
    );

    $('select[name="page[attr][attr_33]"]').focusout(function(){
        var v1 = $(this).val();
        console.log('+320 New select value: ' + v1);
        $.post(
            '/page-attr-data.php',
            {'action':'set','page_id':pid,'attr_id':'33','value':v1},
            function(res6){ console.log('+324 Got result: ' + res6); }
        );
    });

{/literal}
    
        }

        var in5 = $( 'input[name="page[attr][attr_34]"]' );
        var le5 = $( 'div.attributes' ).find( in5 );
        if (le5.length) {
            console.log('Found investments input with name = "page[attr][attr_34]"');
        } else {
            console.log('Not Found investments input with name = "page[attr][attr_34]"');
            $( 'div.attributes fieldset' ).append( '<div class="row"><label>investments: <input type="number" step="any" name="page[attr][attr_34]" value=""></label></div>' );

{literal}

    $.post(
        '/page-attr-data.php',
        {'action':'get','page_id':pid,'attr_id':'34'},
        function(res7){ console.log('+345 Got result: ' + res7); $('input[name="page[attr][attr_34]"]').val(res7); }
    );

    $('input[name="page[attr][attr_34]"]').focusout(function(){
        var v1 = $(this).val();
        console.log('+350 New field value: ' + v1);
        $.post(
            '/page-attr-data.php',
            {'action':'set','page_id':pid,'attr_id':'34','value':v1},
            function(res8){ console.log('+354 Got result: ' + res8); }
        );
    });

{/literal}

        }

        var in4 = $( 'input[name="page[attr][attr_35]"]' );
        var le4 = $( 'div.attributes' ).find( in4 );
        if (le4.length) {
            console.log('Found investor_part input with name = "page[attr][attr_35]"');
        } else {
            console.log('Not Found investor_part input with name = "page[attr][attr_35]"');
            $( 'div.attributes fieldset' ).append( '<div class="row"><label>investor_part: <input type="number" step="any" name="page[attr][attr_35]" value=""></label></div>' );

{literal}

    $.post(
        '/page-attr-data.php',
        {'action':'get','page_id':pid,'attr_id':'35'},
        function(res9){ console.log('+375 Got result: ' + res9); $('input[name="page[attr][attr_35]"]').val(res9); }
    );

    $('input[name="page[attr][attr_35]"]').focusout(function(){
        var v1 = $(this).val();
        console.log('+380 New field value: ' + v1);
        $.post(
            '/page-attr-data.php',
            {'action':'set','page_id':pid,'attr_id':'35','value':v1},
            function(res10){ console.log('+384 Got result: ' + res10); }
        );
    });

{/literal}

        }

        var in3 = $( 'input[name="page[attr][attr_36]"]' );
        var le3 = $( 'div.attributes' ).find( in3 );
        if (le3.length) {
            console.log('Found payback_time input with name = "page[attr][attr_36]"');
        } else {
            console.log('Not Found payback_time input with name = "page[attr][attr_36]"');
            $( 'div.attributes fieldset' ).append( '<div class="row"><label>payback_time: <input type="number" step="any" name="page[attr][attr_36]" value=""></label></div>' );

{literal}

    $.post(
        '/page-attr-data.php',
        {'action':'get','page_id':pid,'attr_id':'36'},
        function(res11){ console.log('+405 Got result: ' + res11); $('input[name="page[attr][attr_36]"]').val(res11); }
    );

    $('input[name="page[attr][attr_36]"]').focusout(function(){
        var v1 = $(this).val();
        console.log('+410 New field value: ' + v1);
        $.post(
            '/page-attr-data.php',
            {'action':'set','page_id':pid,'attr_id':'36','value':v1},
            function(res12){ console.log('+414 Got result: ' + res12); }
        );
    });

{/literal}

        }

        var in2 = $( 'input[name="page[attr][attr_37]"]' );
        var le2 = $( 'div.attributes' ).find( in2 );
        if (le2.length) {
            console.log('Found IRR input with name = "page[attr][attr_37]"');
        } else {
            console.log('Not Found IRR input with name = "page[attr][attr_37]"');
            $( 'div.attributes fieldset' ).append( '<div class="row"><label>IRR: <input type="number" step="any" name="page[attr][attr_37]" value=""></label></div>' );

{literal}

    $.post(
        '/page-attr-data.php',
        {'action':'get','page_id':pid,'attr_id':'37'},
        function(res13){ console.log('+435 Got result: ' + res13); $('input[name="page[attr][attr_37]"]').val(res13); }
    );

    $('input[name="page[attr][attr_37]"]').focusout(function(){
        var v1 = $(this).val();
        console.log('+440 New field value: ' + v1);
        $.post(
            '/page-attr-data.php',
            {'action':'set','page_id':pid,'attr_id':'37','value':v1},
            function(res14){ console.log('+444 Got result: ' + res14); }
        );
    });

{/literal}

        }

        var in1 = $( 'input[name="page[attr][attr_38]"]' );
        var le1 = $( 'div.attributes' ).find( in1 );
        if (le1.length) {
            console.log('Found NPV input with name = "page[attr][attr_38]"');
        } else {
            console.log('Not Found NPV input with name = "page[attr][attr_38]"');
            $( 'div.attributes fieldset' ).append( '<div class="row"><label>NPV: <input type="number" step="any" name="page[attr][attr_38]" value=""></label></div>' );

{literal}

    $.post(
        '/page-attr-data.php',
        {'action':'get','page_id':pid,'attr_id':'38'},
        function(res15){ console.log('+465 Got result: ' + res15); $('input[name="page[attr][attr_38]"]').val(res15); }
    );

    $('input[name="page[attr][attr_38]"]').focusout(function(){
        var v1 = $(this).val();
        console.log('+470 New field value: ' + v1);
        $.post(
            '/page-attr-data.php',
            {'action':'set','page_id':pid,'attr_id':'38','value':v1},
            function(res16){ console.log('+474 Got result: ' + res16); }
        );
    });

{/literal}

        }
    }
});
$( "select[name='page[category][parent]']" ).trigger('change');

{literal}

    setTimeout(function(){ console.log('+691 set timeout 7500');
        var s2 = $('select');
        if (s2.length > 0) {
            for (var i = 0; i < s2.length; i ++) {
                var i2 = $(s2[i]).attr('id');
                if ((i > 0) && (i2 === 'adm_mgr1')) {
                    console.log('+698 ' + i + ' id: ' + i2);
                    $(s2[i]).parent().parent().remove();
                }
            }
        }
    }, 7500);

{/literal}

var oMark = $('input[name="page[attr][attr_13]"]');
if (oMark.length) {
    $(oMark[0]).attr('min', 1).attr('max', 10);
}

{/script_code}