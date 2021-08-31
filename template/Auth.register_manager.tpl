<div class="registerManagerPage">
    <div class="user_login">
        <div id="msg"></div>
        <div class="user_login__wrapper">
            <form method="post" id="reg1" autocomplete="off">
            <h1>Регистрация менеджера</h1>

            <div class="large-12">
                <label>E-mail
                    <input type="email" id="_reg_email" name="reg[email]" autocomplete="off" required="" placeholder="E-mail">
                </label>
            </div>
	
            <div class="large-12">
                <label>Пароль
                    <input type="password" id="_reg_pass" name="reg[password]" autocomplete="off" pattern="^(.*[a-zA-Z]+.*)$" maxlength="32" required="" placeholder="Пароль">
                </label>
            </div>

            <div>
                <input type="hidden" id="_reg_status" name="reg[status]" value="0">
                <input type="submit" value="Регистрация" class="blue_but">
            </div>
            </form>
        </div>
    </div>
</div>

{script_code require=["jquery"] name="regauth"}

console.log('+29 Script loaded');

{literal}

    $('#reg1').submit(function(e1){
        console.log('+34 #reg1 submit handler');
        e1.preventDefault();
        var eml = $('#_reg_email').val();
        var pas = $('#_reg_pass').val();
        $.post(
            '/auth-attr-data.php',
            {'action':'register','email':eml,'pass':pas},
            function(res){ console.log('+41 Got result: ' + res); $('#msg').empty().append(res); $('#_reg_email').val(''); $('#_reg_pass').val(''); }
        );
        return false;
    });

{/literal}

{/script_code}