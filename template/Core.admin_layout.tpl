<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!--<link rel="stylesheet" type="text/css"  href="/skynar/css/foundation.css" />
        <link rel="stylesheet" type="text/css"  href="/skynar/css/admin.css" />-->
        <link rel="stylesheet" type="text/css"  href="/css/admin.css" />
        <link rel="stylesheet" type="text/css"  href="/css/admin_dashboard.css" />
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
        <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,300i,400,400i,600,600i,700,700i,900,900i&amp;subset=cyrillic" rel="stylesheet">
         {head}

        {css "https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css"}
        {style '/css/admin_app.css'}

        <!--[if lt IE 9]><script src="js/html5shiv.js"></script><![endif]-->
        <!--[if lt IE 9]><link href="css/ie.css" rel="stylesheet" type="text/css" /><![endif]-->

        {script name='popper' src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js' integrity='sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1' require='jquery' crossorigin='anonymous'}

        {script name='bootstrapcdn' src='https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js' integrity='sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM' require='popper' crossorigin='anonymous'}

        {script require=['bootstrapcdn'] name='app' src='/js/admin_app.js' }

    </head>
    <body {if mb_substr($request->getPathInfo(),0,16) == '/admin/dashboard'}class="dashboard"{/if} >

        <aside>
        <div>
            <span class="text-hide"><a href="/admin" style="text-decoration: none;color: #fff;"><b>Admin</b> Inventure</a></span>
            <span class="text-show"><a href="/admin" style="text-decoration: none;color: #fff;">AI</a></span>
            <a class="button-burger button-burger-show"><i class="fa fa-bars"></i></a>
            <a class="button-burger button-burger-hide"><i class="fa fa-bars"></i></a>
        </div>
        <div>
            <div class="admin">
                {if !$user && $sm}
                    {$user = $sm->getUser()}
                {/if}
                {if !empty($user) && !is_null($user->getImage())}
                    {assign var=img_avatar value=$user->getImage()->getUrl()}
                {else}
                    {assign var=img_avatar value="/skynar/images/oleynikov.jpg"}
                {/if}
                <div><img src="{$img_avatar}"></div>
                <div>
                    <span class="text-hide">
                        <h6>
                            {if !$user && $sm}
                                {$user = $sm->getUser()}
                                {if !is_null($user)}
                                    {$user->getName()}
                                {/if}
                            {else}
                                Oleksiy Oleynikov
                            {/if}
                        </h6>
                    <p>Online</p></span>
                </div>
            </div>
            <div class="search text-hide">
                <form>
                    <input type="text" name="" placeholder="Search...">
                    <button type="submit">
                        <svg style="width:20px;height:20px" viewBox="0 0 24 24">
                            <path fill="#999" d="M9.5,3A6.5,6.5 0 0,1 16,9.5C16,11.11 15.41,12.59 14.44,13.73L14.71,14H15.5L20.5,19L19,20.5L14,15.5V14.71L13.73,14.44C12.59,15.41 11.11,16 9.5,16A6.5,6.5 0 0,1 3,9.5A6.5,6.5 0 0,1 9.5,3M9.5,5C7,5 5,7 5,9.5C5,12 7,14 9.5,14C12,14 14,12 14,9.5C14,7 12,5 9.5,5Z" />
                        </svg>
                    </button>
                </form>
            </div>
        </div>
        <div class="text-hide">
            main navigation
        </div>
        <ul>
            <li>
                <a href="/admin/dashboard" class="{if mb_substr($request->getPathInfo(),0,16) == '/admin/dashboard'}active{/if}"><i class="fa fa-tachometer"></i><span class="text-hide">Dashboard</span></a>
            </li>

            <li>
                <a href="/admin" class="{if $request->getPathInfo() == '/admin'}active{/if}"><i class="fa fa-home"></i><span class="text-hide">Главная</span></a>
            </li>

            {if !empty($user) && $user->canAccess('Page.moderate')}
                <li>
                    <a href="/admin/page" class="{if mb_substr($request->getPathInfo(),0,11) == '/admin/page'}active{/if}"><i class="fa fa-file"></i><span class="text-hide">Страницы</span></a>
                </li>

                <li>
                    <a href="/admin/blog" class="{if mb_substr($request->getPathInfo(),0,11) == '/admin/blog'}active{/if}"><i class="fa fa-folder-open"></i><span class="text-hide">Каталог</span></a>
                </li>
            {/if}

            {if !empty($user) && $user->canAccess('Auth.users') && $user->canAccess('Auth.permission')}
                <li>
                    <a href="/admin/user" class="{if mb_substr($request->getPathInfo(),0,11) == '/admin/user'}active{/if}"><i class="fa fa-user"></i><span class="text-hide">Пользователи</span></a>
                </li>
            {else}
                {if !empty($user)}
                    <li>
                        <a href="/admin/user/edit/{$user->getId()}" class="{if mb_substr($request->getPathInfo(),0,11) == '/admin/user'}active{/if}"><i class="fa fa-user"></i><span class="text-hide">Редактировать профиль</span></a>
                    </li>
                {/if}
            {/if}

            <li>
                <a href="/admin/attribute" class="{if mb_substr($request->getPathInfo(),0,16) == '/admin/attribute'}active{/if}"><i class="fa fa-wrench"></i><span class="text-hide">Атрибуты</span></a>
            </li>
            <li>
                <a href="/admin/redirect" class="{if mb_substr($request->getPathInfo(),0,15) == '/admin/redirect'}active{/if}"><i class="fa fa-repeat"></i><span class="text-hide">Перенаправления</span></a>
            </li>
            <li>
                <a href="/admin/digest" class="{if mb_substr($request->getPathInfo(),0,13) == '/admin/digest'}active{/if}"><i class="fa fa-newspaper-o"></i><span class="text-hide">Дайджест</span></a>
            </li>
            <li>
                <a href="/admin/mail?sort=!created" class="{if mb_substr($request->getPathInfo(),0,11) == '/admin/mail'}active{/if}"><i class="fa fa-envelope"></i><span class="text-hide">Почта</span></a>
            </li>

            {if !empty($user) && $user->canAccess('Payment.view')}
                <li>
                    <a href="/admin/payment" class="{if mb_substr($request->getPathInfo(),0,14) == '/admin/payment'}active{/if}"><i class="fa fa-credit-card"></i><span class="text-hide">Invoices</span></a>
                </li>
            {/if}

            <li>
                <a href="/admin/widget" class="{if mb_substr($request->getPathInfo(),0,13) == '/admin/widget'}active{/if}"><i class="fa fa-puzzle-piece"></i><span class="text-hide">Widgets</span></a>
            </li>

            {if !empty($user) && $user->canAccess('Page.moderate')}
                <li>
                    <a href="/admin/review" class="{if mb_substr($request->getPathInfo(),0,13) == '/admin/review'}active{/if}"><i class="fa fa-star"></i><span class="text-hide">Отзывы</span></a>
                </li>

                <li>
                    <a href="/admin/seotext" class="{if mb_substr($request->getPathInfo(),0,14) == '/admin/seotext'}active{/if}"><i class="fa fa-book"></i><span class="text-hide">SEO тексты</span></a>
                </li>
            {/if}
        </ul>
    </aside>

    <section>
        <div class="header">
            <ul class="right">
                <li class="messages">
                    <a><i class="fa fa-envelope-o"></i></a>
                    <div class="dropdown">
                        <p class="title">You have 4 messages</p>
                        <ul>
                        <li>
                            <a href="">
                                <div><img src="/skynar/images/oleynikov.jpg"></div>
                                <div>
                                    <h6>Support Team</h6>
                                    <p>Why not buy a new awesome theme?</p>
                                    <span><i class="fa fa-clock-o"></i> 5 min</span>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <div><img src="/skynar/images/oleynikov.jpg"></div>
                                <div>
                                    <h6>Support Team</h6>
                                    <p>Why not buy a new awesome theme?</p>
                                    <span><i class="fa fa-clock-o"></i> 5 min</span>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <div><img src="/skynar/images/oleynikov.jpg"></div>
                                <div>
                                    <h6>Support Team</h6>
                                    <p>Why not buy a new awesome theme?</p>
                                    <span><i class="fa fa-clock-o"></i> 5 min</span>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <div><img src="/skynar/images/oleynikov.jpg"></div>
                                <div>
                                    <h6>Support Team</h6>
                                    <p>Why not buy a new awesome theme?</p>
                                    <span><i class="fa fa-clock-o"></i> 5 min</span>
                                </div>
                            </a>
                        </li>
                    </ul>
                        <a href="" class="footer">See all messages</a>
                    </div>
                </li>
                <li class="notifications">
                    <a><i class="fa fa-bell-o"></i></a>
                    <div class="dropdown">
                        <p class="title">You have 10 notifications</p>
                        <ul>
                        <li>
                            <a href="">
                                <div><img src="/skynar/images/oleynikov.jpg"></div>
                                <div>
                                    <h6>5 new members joined today</h6>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <div><img src="/skynar/images/oleynikov.jpg"></div>
                                <div>
                                    <h6>5 new members joined today</h6>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <div><img src="/skynar/images/oleynikov.jpg"></div>
                                <div>
                                    <h6>5 new members joined today</h6>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="">
                                <div><img src="/skynar/images/oleynikov.jpg"></div>
                                <div>
                                    <h6>5 new members joined today</h6>
                                </div>
                            </a>
                        </li>
                    </ul>
                        <a href="" class="footer">View all</a>
                    </div>
                </li>
                <li class="tasks">
                    <a><i class="fa fa-flag-o"></i></a>
                    <div class="dropdown">
                        <p class="title">You have 9 tasks</p>
                        <ul>
                        <li>
                            <a href="" class="tasks">
                                <h6>Design some buttons <span>20%</span></h6>
                                <div class="progress"><span></span></div>
                            </a>
                        </li>
                        <li>
                            <a href="" class="tasks">
                                <h6>Design some buttons <span>20%</span></h6>
                                <div class="progress"><span></span></div>
                            </a>
                        </li>
                        <li>
                            <a href="" class="tasks">
                                <h6>Design some buttons <span>20%</span></h6>
                                <div class="progress"><span></span></div>
                            </a>
                        </li>
                        <li>
                            <a href="" class="tasks">
                                <h6>Design some buttons <span>20%</span></h6>
                                <div class="progress"><span></span></div>
                            </a>
                        </li>
                        <li>
                            <a href="" class="tasks">
                                <h6>Design some buttons <span>20%</span></h6>
                                <div class="progress"><span></span></div>
                            </a>
                        </li>
                    </ul>
                        <a href="" class="footer">View all</a>
                    </div>
                </li>
                <li class="admin">
                    {if !$user && $sm}
                        {$user = $sm->getUser()}
                    {/if}
                    {if !empty($user) && !is_null($user->getImage())}
                        {assign var=img_avatar value=$user->getImage()->getUrl()}
                    {else}
                        {assign var=img_avatar value="/skynar/images/oleynikov.jpg"}
                    {/if}
                    <a><div><img src="{$img_avatar}"></div>
                    <h6>{if !$user && $sm}
                            {$user = $sm->getUser()}
                            {if !is_null($user)}
                                {$user->getName()}
                            {/if}
                        {else}
                            Oleksiy Oleynikov
                        {/if}</h6></a>
                    <div class="dropdown">
                        <div>
							{if !empty($user) && !is_null($user->getImage())}
							{assign var=img_avatar value=$user->getImage()->getUrl()}
							{else}
							{assign var=img_avatar value="/skynar/images/oleynikov.jpg"}
							{/if}
                            <img src="{$img_avatar}">
                            <h5>{$user->getName()} {$user->get('job')}</h5>

                            <div class="free-memory-msg"></div>
                            
                        </div>
                        <div class="server-commands">
                            <a class="free-memory-btn" href="#">Free memory</a>

                            <!-- a href="">Sales</a -->
                            <!-- a href="">Friends</a -->
                        </div>
                        <div>
                            <a href="/admin/user/edit/{$user->getId()}">Profile</a>
                            <a href="/user/logout">Sing out</a>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
        <div class="container">
            {$content}
        </div>
    </section>

{script name='daterangepicker' src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js" require="jquery"}
{script_code 'datarangeinit' require=['jquery', 'moment', 'daterangepicker']}
$(function() {
    $("a.free-memory-btn").click(function(e19){
        console.log('+323 Free Memory Button click handler');

{literal}
        $.post(
            "/auth-attr-data.php",
            {'action':'free_memory'},
            function(res19) { console.log('+330 Got result: ' + res19); $(".free-memory-msg").hide().text("Через несколько минут память сервера будет освобождена").show(); }
        );
{/literal}

        e19.preventDefault();
        return false;
    });
});
$(function() {
  $('input[name="datetimes"]').daterangepicker({
    timePicker: true,
    startDate: moment().startOf('hour'),
    endDate: moment().startOf('hour').add(32, 'hour'),
    locale: {
      format: 'DD/MM/Y hh:mm A'
    }
  });
});
$(function() {
  $('input[name="birthday"]').daterangepicker({
    singleDatePicker: true,
    showDropdowns: true,
    minYear: 1901,
    maxYear: parseInt(moment().format('YYYY'),10)
  }, function(start, end, label) {
    var years = moment().diff(start, 'years');
  });
});
{/script_code}
    </body>
</html>
