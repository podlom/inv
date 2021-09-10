<!-- @ts Croudinvesting.index.tpl -->
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
    <div class="buttons">
        <a href="{$controller->getUrlGenerator()->generate('add')}" class="green button">Добавить</a>
    </div>
    <div class="breadcrumbs">
        <h3>Краудинвестинг</h3>
        <div>
            <a href="/admin"><i class="fa fa-home"></i>Главная</a> <span>></span> Краудинвестинг
        </div>
    </div>
    <div class="table" id="croudivest_admin1">
    </div>
</div>


{script_code require=["jquery"] name="croudinvesting"}

    console.log('+57');

{literal}
    $('#croudivest_admin1').on("submit", '#edit_croud1', {}, croudEditSubmit);

    function croudEditSubmit()
    {
        console.log('+64 croudEditSubmit()');

        var formData = $('#edit_croud1').serialize();

        $.post(
            '/croudinvest.php',
            { action: 'croudEditSubmit', data: formData },
            function() {
                console.log('+72 ajax status: success');
            },
        ).done(function(d7) {
            $('#croudivest_admin1').empty();
            $('#croudivest_admin1').html(d7);
        });

        return false;
    }
{/literal}

    let pos = window.location.href.indexOf('?/edit/');
    console.log('+60 pos: ', pos);

    if (pos !== -1) {
        let id = window.location.href.substring(pos + 7);
        console.log('+64 id: ', id);

        if (id.length > 0) {

{literal}
$.get('/croudinvest.php', { 'action': 'croudAdminEdit', 'id': id }, function(dt59){
    $('#croudivest_admin1').html(dt59);
});
{/literal}

        }
    } else {

{literal}
$.get('/croudinvest.php', { 'action': 'croudAdminIndex' }, function(dt60){
    $('#croudivest_admin1').html(dt60);
});
{/literal}

    }
    
{/script_code}
