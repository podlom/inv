$(document).ready(function() {
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
    $('textarea').autosize();

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
