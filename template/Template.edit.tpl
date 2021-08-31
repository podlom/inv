<div class="bwrap">
    <nav class="navbar row mb-2">
        <h1 class="h4">Редактор шаблона Email
            <small class="text-muted">{$config['subject']}</small>
        </h1>
    </nav>

    <div class="card shadow-sm">
        <div class="card-body">

            {* react 'Template.TplEdit' props=['config'=>$config, 'text'=>file_get_contents($tplfile),'result'=>$result, 'template'=>$tplname, 'from'=>$from, 'url'=>'/admin/mail/mailing/server'] *}

            <div id="msg1" class="message" style="display: none;">
                Настройки сохранены
            </div>

            <div id="_R15db2c7248dbe8" class="react-wrap">
                <div class="tpl_edit">
                    <section class="mb-5">
                        <div class="tpl_config">
                            <form id="f1" action="" method="post">
                                <div class="form-group"><span class="input"><label>Тема письма</label><input class="form-control" placeholder="Тема письма" type="text" name="subject" value="{$config['subject']}"></span></div>
                                <div class="form-group"><span class="input"><label>От кого</label><input class="form-control" placeholder="От кого" type="text" name="from_name" value="{$config['from_name']}"></span></div>
                            </form>
                        </div>
                    </section>

                    <section class="mb-5">
                        <div id="inv1" style="display: none;">
                            <form id="f4" action="" method="post">
                                <h5>Интвестиционные предложения:</h5>
                                <div id="inv-prop-cont1"></div>
                                <input id="add-inv1" type="button" value="Добавить инвест предложение">
                                <input id="save-inv1" type="button" value="Сохранить инвест предложения">
                            </form>
                        </div>
                    </section>

                    <section class="mb-5">
                        {* @see https://stackoverflow.com/questions/40062450/how-to-correctly-use-smarty-server-http-hostsmarty-server-request-uri-in-s *}
                        <form id="f2" action="{$smarty.server.REQUEST_URI}" method="post">
                            <div class="form-group">
                                <span class="input">
                                    <label>Текст письма</label>
                                    {$form->getField('content')->getField('text')->getInput()->setAttr('placeholder', 'Описание')->setAttr('data-group', 'text')}
                                </span>
                            </div>

                            <textarea id="edit_text0" class="email-text-new-test" aria-hidden="true" style="visibility:hidden;">
                                {$emailTextNew}
                            </textarea>
                        </form>
                    </section>

                    <section class="mb-5">
                        <div class="tpl_config">
                            <form id="f3" action="" method="post">
                                <div class="form-group text-right"><button id="save-settings-btn1" class="btn btn-main save-settings"><i class="fa fa-floppy-o" aria-hidden="true"></i> Сохранить настройки</button></div>
                            </form>
                        </div>
                    </section>
                </div>
            </div>

        </div>
    </div>

    <div class="card shadow-sm">
        <div class="card-body">
            {if isset($smarty.get.back) && !empty($smarty.get.back)}
                <a href="{$smarty.get.back}">Вернуться к рассылке</a>
            {/if}
        </div>
    </div>
</div>

{assign var=mId value=$smarty.server.REQUEST_URI|regex_replace:"/\/admin\/template\/edit\/Mail\.mailing_(\d+)(.*)/":"\$1"}

{assign var=truncUri value=$smarty.server.REQUEST_URI|regex_replace:"/(.*)\?(.*)/":"\$0"}

{script_code require=["jquery"] name="edittemplate"}

console.log('Script loaded +70');

console.log('mID: mailing_{$mId}');

console.log('Ajax URI: {$truncUri|substr:0:($truncUri|strpos:"?")}.json');

function prepareData() {
    var d1 = $('#f1').serializeArray();
    console.dir( d1 );
    var re = {
        {* from: null, *}
        to: false,
        cc: false,
        bcc: false,
        subject: "inVenture Newsletter",
        from_name: "inVenture",
    };
    for (var i = 0; i < d1.length ; i ++) {
        var key = d1[i].name;
        console.log( 'name: ' + d1[i].name + '; value: ' + d1[i].value );
        re[ key ] = d1[i].value;
    }
    return re;
}

    $('#save-settings-btn1').click(function(e1){
        e1.preventDefault();
        console.log('#save-settings-btn1 click handler +54');

        var d0 = prepareData();
        if (d0.length == 0) {
            console.log('+80 Empty request data');
            return false;
        }

        $.ajax({
            type : "POST",
            url : "/yaml.php",
            data: {
                'action': 'set',
                'mailing_id': 'mailing_{$mId}',
                'new_data': d0
            },
            success : function(msg) {
                console.log('Настройки сохранены ' + msg);
                $('#msg1').show();
                $('#f2').submit();
            }
        });

        return false;
    });

console.log('Copy textarea text +137');
var t1 = $('#edit_text0');
if (t1.length) {
    $(document).ready(function() {
        console.log('+127 document.ready');
        var t2 = $('#edit_text0').text();
        $('#mce_0_ifr').ready(function() {
            console.log('+130 #mce_0_ifr.ready');
            $('#mce_0').text(t2);
            $('#mce_0_ifr').contents().html(t2);
        });
    });
}

    var numInputs = 0;
    $('#add-inv1').click(function(){
        if (numInputs > 0) {
            numInputs ++;
        } else {
            nDiv = $('#inv-prop-cont1').find('div');
            if (nDiv.length) {
                numInputs = nDiv.length + 1;
            }
        }
        console.log( '+160 numInputs: ' + numInputs );

        var lastField = $("#inv-prop-cont1 div:last");
        var lId = (lastField && lastField.length && lastField.length + 1) || 1;
        console.log( '+161 lId: ' + lId );

        var fieldWrapper = $("<div class=\"fieldwrapper\" id=\"field" + lId + "\"/>");

        var removeBtn = $("<input type=\"button\" value=\"[ - ]\"><br>");
        removeBtn.click(function() {
            $(this).parent().remove();
            $('#save-inv1').trigger('click');
        });
        fieldWrapper.append(removeBtn);

        var imgPath = $("<table><tr><td><label>Адрес картинки: </label></td><td><input type=\"text\" style=\"width: 500px;\" name=\"inv[" + numInputs + "][img]\"></td></tr>");
        fieldWrapper.append(imgPath);

        var titleInput = $("<tr><td><label>Заголовок предложения: </label></td><td><input type=\"text\" style=\"width: 500px;\" name=\"inv[" + numInputs + "][title]\"></td></tr>");
        fieldWrapper.append(titleInput);

        var regionInput = $("<tr><td><label>Регион: </label></td><td><input type=\"text\" style=\"width: 500px;\" name=\"inv[" + numInputs + "][region]\"></td></tr>");
        fieldWrapper.append(regionInput);

        var priceInput = $("<tr><td><label>Цена: </label></td><td><input type=\"text\" style=\"width: 500px;\" name=\"inv[" + numInputs + "][price]\"></td></tr>");
        fieldWrapper.append(priceInput);

        var pathInput = $("<tr><td><label>Адрес страницы предложения: </label></td><td><input type=\"text\" style=\"width: 500px;\" name=\"inv[" + numInputs + "][url]\"></td></tr></table>");
        fieldWrapper.append(pathInput);

        $("#inv-prop-cont1").append(fieldWrapper);
    });

    $('#save-inv1').click(function(){
        $.ajax({
            type: "POST",
            url: "/email-data.php",
            data: {
                'action': 'set',
                'mailing_id': '{$mId}',
                'parent_template_id': '{$mId}',
                'form_data': $('#f4').serialize()
            },
            success : function(msg) {
                console.log('Данные инвест предложений сохранены ' + msg);
                $('#msg1').text('Данные инвест предложений сохранены');
                $('#msg1').show();
            }
        });
    });

    $(document).ready(function(){
        $.ajax({
            type: "POST",
            url: "/email-data.php",
            data: {
                'action': 'get',
                'mailing_id': '{$mId}',
                'parent_template_id': '{$mId}'
            },
            success : function(msg) {
                console.log('Данные инвест получены ' + msg);
                $('#inv-prop-cont1').html(msg);
            }
        });

        $.ajax({
            type: "POST",
            url: "/email-data.php",
            data: {
                'action': 'get_type',
                'mailing_id': '{$mId}',
                'parent_template_id': '{$mId}'
            },
            success : function(msg) {
                console.log('Данные инвест получены ' + msg);
                if (msg == '2') {
                    $('#inv1').show();
                } else {
                    console.log('Не тот шаблон');
                }
            }
        });
    });

{/script_code}