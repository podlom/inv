
function submitDigest()
{
    console.log('+4 submitDigest()');

    let form = $('.subscription__form');
    let formData = {};
    let fData = $('.subscription__form').serializeArray();
    $(fData).each(function(index, obj) {
        formData[obj.name] = obj.value;
    });
    console.log('+12 formData: ', formData);

    if ($('#phone2').length && $('#error-msg2').length && !$('#error-msg2').hasClass('hide')) {
        console.log('+15 prevent wrong phone inputmask value submit');
        $('#phone2').focus();
        return;
    }

    $.post('/email-subscribe.php', formData).done((data) => {
        console.log('+21 got data: ', data);

        if (data.status) {
            form.trigger('reset');
            $('.my_popup').removeClass('opened');
            $('.dark_bg').removeClass('opened');
            $('html').removeClass('page-locked');

            if (document.documentElement.lang == 'ru') {
                Swal.fire({
                    title:'Спасибо!',
                    text:'Теперь вы подписаны на нашу рассылку',
                    type:'success',
                    confirmButtonText: 'Закрыть'
                });
            } else {
                Swal.fire({
                    title:'Thank you!',
                    text:'You have successfully subscribed',
                    type:'success',
                    confirmButtonText: 'Close'
                });
            }
        } else {
            if (document.documentElement.lang == 'ru') {
                Swal.fire({
                    title:'Что-то пошло не так...',
                    text:data.errors.join(', '),
                    type:'error',
                    confirmButtonText: 'Попробовать еще раз'
                });
            } else {
                Swal.fire({
                    title:'Something went wrong!',
                    text:'You have not been subscribed',
                    type:'error',
                    confirmButtonText: 'Try again'
                });
            }
        }
    });
}

$(document).ready(function() {
    console.log('+64 $(document).ready()');

    let sForm = $('form.subscribe');
    if (sForm.length) {
        console.log('+68 found form.subscribe');
        if (!$('form.subscribe').hasClass('subscription__form')) {
            console.log('+70 fixed form.subscribe classes');
            $('form.subscribe').addClass('subscription__form');
        }
    } else {
        console.log('+74 form.subscribe was not found.');
    }

    $('.subscription__form').submit(function (e){
        console.log('+78 .subscription__form.submit()');
        e.preventDefault();
        if ($('#phone2').length && $('#error-msg2').length && !$('#error-msg2').hasClass('hide')) {
            console.log('+81 prevent wrong phone inputmask value submit');
            $('#phone2').focus();
            return;
        }

        var form = $(this);
        var formdata = $(this).serializeArray();
        var data = {};
        $(formdata ).each(function(index, obj){
            data[obj.name] = obj.value;
        });

        $.post('/email-subscribe.php', data).done((data) => {
            console.log('+94 got data: ', data);

            if (data.status) {
                form.trigger('reset');
                $('.my_popup').removeClass('opened');
                $('.dark_bg').removeClass('opened');
                $('html').removeClass('page-locked');

                if (document.documentElement.lang == 'ru') {
                    Swal.fire({
                        title:'Спасибо!',
                        text:'Теперь вы подписаны на нашу рассылку',
                        type:'success',
                        confirmButtonText: 'Закрыть'
                    });
                } else {
                    Swal.fire({
                        title:'Thank you!',
                        text:'You have successfully subscribed',
                        type:'success',
                        confirmButtonText: 'Close'
                    });
                }
            } else {
                if (document.documentElement.lang == 'ru') {
                    Swal.fire({
                          title:'Что-то пошло не так...',
                          text:data.errors.join(', '),
                          type:'error',
                          confirmButtonText: 'Попробовать еще раз'
                    });
                } else {
                    Swal.fire({
                          title:'Something went wrong!',
                          text:'You have not been subscribed',
                          type:'error',
                          confirmButtonText: 'Try again'
                    });
                }
            }
        });
    });

    $("img.lazy").lazyload({effect : "fadeIn", skip_invisible:false, failure_limit : 5, threshold : 10});

    $('.instrumentQuestionMain, .instrumentQuestion').click(function() {
        var id = $(this).attr('data-expert-id');
        $("#questionForm form").find('input:first[type=hidden]').attr('value', id);
    });
    $("#search-block .pointer").click(function() {
        $(".large-3.columns.search-block").toggle('slow');
    });
    $(".main_nav>li").hoverIntent(function(e) {
        $(".main_nav>li ul.active").not($(this)).removeClass('active');
        $(".main_nav>li ul.active").not($(this)).toggle("fast");
        $(this).children("ul").addClass("active");
        $(".main_nav>li ul.active").toggle("600");
        e.preventDefault();
        return false;
    });
    $(".js-news_slider").owlCarousel({
        items: 4,
        pagination: false,
        navigation: true,
        navigationText: ["", ""],
        lazyLoad: true
    });
    $(".js-gallery").owlCarousel({
        items: 4,
        pagination: false,
        navigation: true,
        navigationText: ["", ""],
        lazyLoad: true
    });
    $('.subMenuButton').click(function() {
        menu = $(this).parent().parent().find('.Nav').toggleClass('open');
        if (menu.is('.open')) {
            menu.show();
            menu.animate({
                opacity: 1
            }, 400);
        } else {
            menu.animate({
                opacity: 0
            }, 400, function() {
                menu.hide();
            });
        }
    });
    $('.linkShow').click(function() {
        $(".contactSotrudniki").slideToggle();
    });
    $(".search-block .btn-right-dropdown").click(
            function() {
                $(".search-block .btn-right-dropdown").not($(this)).parent().children(".search-block .sub-right-dropdown.active").removeClass("active").toggle("slow");
                $(this).parent().children(".search-block .sub-right-dropdown").toggle("slow").toggleClass("active ");

            }
    );
    $(".search-block .sub-right-dropdown ul li").click(function() {
        //$(this).parent().children(".search-block .btn-right-dropdown").css("color: black");
        var $clone = $(this).clone().text();
        $(this).parent().parent().parent().children(".search-block .btn-right-dropdown").html($clone);
        $(".search-block .sub-right-dropdown.active").hide();
        $(".search-block .sub-right-dropdown.active").removeClass("active");
    });
    $(function() {
        $('.vote-block:first .acc-content').addClass('active');
        $('.acc-content').not('.active').hide();
        $('.acc-caption').click(function() {
            $('.acc-content').not($(this).next('.acc-content')).removeClass('active').slideUp(600); // сворачиваем элементы
            $(this).next('.acc-content').addClass('active').slideDown(600);
            //$('.acc-content').hasClass('active').parent($(this).css("color", "black"));
        });

    });
    $('#archiveFormYear, #archiveFormMonths').change(function(e) {
        link = $('#digest a.y' + $('#archiveFormYear').val() + '.m' + $('#archiveFormMonths').val());
        if (link.length == 0) {
            $('#archiveFormButton').attr('disabled', true).attr('href', '#');
        } else {
            $('#archiveFormButton').attr('disabled', false).attr('href', link.attr('href'));
        }
    }).change();
    $('#archiveFormButton').click(function(e) {
        if ($(this).attr('disabled'))
            e.preventDefault();
    });

    $(".label-click").click(function() {
        $(this).parent().parent().find(".tged").slideToggle();
    });
    $("form[name='inventure-form'] .label-click").click(function() {
        $(this).parent().parent().children(".tged").slideToggle();
    });

    $('.show_res').click(function() {
        if ($(this).parent().find(".answer").hasClass("margin-answer")) {
            $(this).parent().find(".answer").removeClass("margin-answer");
        } else {
            $(this).parent().find(".answer").addClass("margin-answer");
        }
        $(this).parent().toggleClass("result")
        $(this).parent().find("input").toggle("slow");
        $(this).parent().find(".is-pool-block").toggle("slow");
    });

    $('.viewbox-cnt-body table').wrap('<div class="table-responsive">');
});
