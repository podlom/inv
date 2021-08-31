{* prefilter=off *}

<div class="admin-pages">
    <div class="buttons">
        <a href="{$controller->url('password', ['user_id'=>$entity->getId()])}" class="button green">Смена пароля</a>
    </div>
    <div class="edit">
    	{$form->toHtml()->addClass('row')->setAttr('id', 'auth_edit')->open()}
        <div class="flex-form">
        	<div>
        	<div>
        	    <div>
                    {$form->getSubmit()->addClass('button green')->setAttr('value', "Сохранить")}

                <label>phone: <div><input type="text" name="attr[phone]" id="_attr_phone" value="" required=""></div></label>
                <label>job: <div><input type="text" name="attr[job]" id="_attr_job" value="" required=""></div></label>
                
        		{foreach $form->toHtml()->getChilds() as $ch}
        			{if $ch@last}{else}{$ch}{/if}
        		{/foreach}

        	    </div>
        	</div>
        </div>
        {$form->close()}
	</div>
</div>

{script_code require=["jquery"] name="editauth"}

    console.log('+28 Script loaded');

    var wlh = window.location.href;
    var lio = wlh.lastIndexOf("/");
    var pid = wlh.substring(lio + 1, wlh.length);
    console.log( '+31 user_id: ' + pid );

{literal}

    $('#_attr_phone').focusout(function(){
        var v1 = $(this).val();
        console.log('+37 New field value: ' + v1);
        $.post(
            '/auth-attr-data.php',
            {'action':'set','attr':'phone','user_id':pid,'value':v1},
            function(res2){ console.log('+41 Got result: ' + res2); }
        );
    });

    $.post(
        '/auth-attr-data.php',
        {'action':'get','attr':'phone','user_id':pid},
        function(res1){ console.log('+48 Got result: ' + res1); $('#_attr_phone').val(res1); }
    );

    $('#_attr_job').focusout(function(){
        var v2 = $(this).val();
        console.log('+47 New field value: ' + v2);
        $.post(
            '/auth-attr-data.php',
            {'action':'set','attr':'job','user_id':pid,'value':v2},
            function(res3){ console.log('+51 Got result: ' + res3); }
        );
    });

    $.post(
        '/auth-attr-data.php',
        {'action':'get','attr':'job','user_id':pid},
        function(res4){ console.log('+48 Got result: ' + res4); $('#_attr_job').val(res4); }
    );

    function checkManagerStatus()
    {
        console.log('+75 checkManagerStatus() ');
        $.post(
            '/auth-attr-data.php',
            {'action':'check_if_superadmin'},
            function(res0){
                console.log('+81 got result: ' + res0);
                if (res0 == 0) {
                    console.log('+83 not super admin.');
                    var lbl = $('#auth_edit label');
                    if (lbl.length) {
                        $(lbl[6]).remove();
                        $(lbl[5]).remove();
                    }
                } else {
                    console.log('+90 you are super admin.');
                    var v4 = 1;
                    var v3 = $('input[name="entity[status]"]').attr('checked');
                    console.log('+92 Status checked attr: ' + v3);
                    if (v3 === 'checked') {
                        v4 = 0;
                    }
                    $.post(
                        '/auth-attr-data.php',
                        {'action':'set_status','user_id':pid,'value':v4},
                        function(res4){ console.log('+99 Set new manager status result: ' + res4); }
                    );
                }
            }
        );

        var inp = $('input');
        if (inp.length) {
            $(inp[3]).attr('required', 'required');
            $(inp[3]).attr('id', '_attr_name');

            $.post(
                '/auth-attr-data.php',
                {'action':'get','attr':'name','user_id':pid},
                function(r4){ console.log('+113 Got result: ' + r4); if (r4.length) { $('#_attr_name').val(r4); } }
            );

            $('#_attr_name').focusout(function(){
                var v3 = $(this).val();
                console.log('+118 New field value: ' + v3);
                $.post(
                    '/auth-attr-data.php',
                    {'action':'set','attr':'name','user_id':pid,'value':v3},
                    function(r3){ console.log('+122 Got result: ' + r3); }
                );
            });

            $(inp[4]).attr('required', 'required');
            $(inp[4]).attr('id', '_attr_email');
        }
    }
    $(document).ready(function(){ checkManagerStatus(); });

{/literal}

{/script_code}