$(document).foundation();
$(document.body).ready(function(){
	var r = $('#gm_callback');
	var state = 'init';
	var storage = window.sessionStorage || window.localStorage;
	var is_sent = (storage && storage.getItem('callback_send')) || false;
	var close = function(){
		state='close';
		r.removeClass('gm_open').removeClass('gm_done');
	}
	var open = function(){
		state = 'open';
		r.removeClass('gm_done').addClass('gm_open');
	}

	$('#gm_callback .gm_call').click(open);
	$('#gm_callback .gm_close').click(close);
	$('#gm_callback input[type=tel]').keydown(function(e){
		var t = e.target.value;
		var r = '+'+t.replace(/[^0-9]/g, '');
		if(r != t)
			e.target.value = r;

	    var offset = e.target.selectionStart;
		t = new RegExp('[0-9'+(offset==0?'+':'')+']');
		if(e.key.length == 1 && !t.test(e.key)){
			e.preventDefault();
			e.stopPropagation();
			return false;
		}
	}).focus(function(e){
		if(e.target.value==''){
			e.target.value='+';
		}
	}).blur(function(e){
		if(e.target.value=='+'){
			e.target.value='';
		}
	});
	$('#gm_callback form').submit(function(e){
		$.post('/form/callback.json', {
			'sf_callback[_token]': $('#gm_callback input[name="sf_callback[_token]"]').val(),
			'sf_callback[tel]': $('#gm_callback input[type=tel]').val()
		});
		is_sent = true;
		if(storage)storage.setItem('callback_send', true);
		r.removeClass('gm_open').addClass('gm_done');
		e.preventDefault();
		e.stopPropagation();
		return false;
	});
	setTimeout(function(){
		var n = storage && storage.getItem('callback_show') || 0;
		if(state=='init' && !is_sent && n < 2){
			open();
			n++;
			storage && storage.setItem('callback_show', n);
		}
	}, 15000);
});
$(document).ready(function(){
	$('#gm_callback').fadeIn(300);
});
$(document).ready(function() {

	$('#nav .menu-item1').hover(function() {
		$('#nav .menu-item1 .submenu').show();
		$('.hover_bg').show()
	}, function() {
		$('#nav .menu-item1 .submenu').hide();
		$('.hover_bg').hide()
	})
	$('#nav .menu-item2').hover(function() {
		$('#nav .menu-item2 .submenu').show();
		$('.hover_bg').show()
	}, function() {
		$('#nav .menu-item2 .submenu').hide();
		$('.hover_bg').hide()
	})
	$('#nav .menu-item3').hover(function() {
		$('#nav .menu-item3 .submenu').show();
		$('.hover_bg').show()
	}, function() {
		$('#nav .menu-item3 .submenu').hide();
		$('.hover_bg').hide()
	})

	$('.header .right .search i').click(function() {
		$('.header').hide();
		$('.header_search').show()
	})
	$('#close').click(function() {
		$('.header_search').hide()
		$('.header').show();
	})
	$('.open_popup').click(function() {
		$('.my_popup').show()
		$('.dark_bg').show()
	})
	$('.my_popup i').click(function() {
		$('.my_popup').hide()
		$('.dark_bg').hide()
	})
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



	$('.owl-carousel').owlCarousel({
    margin:10,
    items: 1,
    loop:true,
    mouseDrag: false,
    nav:true,
    autoHeight: true,
})

	 $('.pgwSlideshow').pgwSlideshow();

	var i = $('.investment_single iframe').parent(); i.parent().css('text-align','center');

	$('.board_page .accordion .toggle_btn').on('click', togg);
	var c = $('.board_page .accordion'+location.hash+' .block');
	if(location.hash.length > 0 && c.length > 0){
		c.slideDown(0);
		$('html,body').animate({
	        scrollTop: c.parents('.the_preview').offset().top - 80
	    }, 50);
	}


	function togg() {
		$('.board_page .accordion .block').not($(this).next()).slideUp(400);
		$(this).next().slideToggle(400);
		$(this).children().toggle();
	}
	$('.board_page .accordion .toggle_btn').next(':visible').prev().children().toggle();

	$('.tabs__caption a[href^="#"]').click(function(event) {
		event.preventDefault();
		elementClick = $(this).attr("href");
		destination = $(elementClick).offset().top - 100;
		$('html, body').animate({scrollTop: destination}, 1000)

	})

	$('.up').click(function() {
		$('html, body').animate({scrollTop: 0}, 600);
		return false;
	});
	$(window).scroll(function() {
		if ($(this).scrollTop() > 800) {
			$('.up').fadeIn();
		} else {
			$('.up').fadeOut();
		}
	});

	$('ul.tabs__caption').on('click', 'li:not(.active)', function() {
		$(this)
			.addClass('active').siblings().removeClass('active')
			.closest('div.tabs').find('div.tabs__content').removeClass('active').eq($(this).index()).addClass('active');
	});

	$('.label-click1 .open').click(function() {
		$(this).hide()
		$('.tged1').removeClass('hide');
		$('.label-click1 .close').show();
	})
	$('.label-click1 .close').click(function() {
		$(this).hide()
		$('.tged1').addClass('hide');
		$('.label-click1 .open').show();
	})
	$('.label-click2 .open').click(function() {
		$(this).hide()
		$('.tged2').removeClass('hide');
		$('.label-click2 .close').show();
	})
	$('.label-click2 .close').click(function() {
		$(this).hide()
		$('.tged2').addClass('hide');
		$('.label-click2 .open').show();
	})
	$('.label-click3 .open').click(function() {
		$(this).hide()
		$('.tged3').removeClass('hide');
		$('.label-click3 .close').show();
	})
	$('.label-click3 .close').click(function() {
		$(this).hide()
		$('.tged3').addClass('hide');
		$('.label-click3 .open').show();
	})
	$('.label-click4 .open').click(function() {
		$(this).hide()
		$('.tged4').removeClass('hide');
		$('.label-click4 .close').show();
	})
	$('.label-click4 .close').click(function() {
		$(this).hide()
		$('.tged4').addClass('hide');
		$('.label-click4 .open').show();
	})
	$('.label-click6 .open').click(function() {
		$(this).hide()
		$('.tged6').show();
		$('.label-click6 .close').show();
	})
	$('.label-click6 .close').click(function() {
		$(this).hide()
		$('.tged6').hide();
		$('.label-click6 .open').show();
	})

	$('.menu_icons .fa-bars').click(function() {
		$('.mobile_menu').slideToggle();
	})

	$('.mobile_menu .investments .fa-chevron-right').click(function() {
		$(this).hide();
		$('.mobile_menu .investments .fa-chevron-down').show();
		$('.mobile_menu .investments ul').show()
	})
	$('.mobile_menu .investments .fa-chevron-down').click(function() {
		$(this).hide();
		$('.mobile_menu .investments .fa-chevron-right').show();
		$('.mobile_menu .investments ul').hide();
	})

	$('.mobile_menu .news .fa-chevron-right').click(function() {
		$(this).hide();
		$('.mobile_menu .news .fa-chevron-down').show();
		$('.mobile_menu .news ul').show()
	})
	$('.mobile_menu .news .fa-chevron-down').click(function() {
		$(this).hide();
		$('.mobile_menu .news .fa-chevron-right').show();
		$('.mobile_menu .news ul').hide();
	})

	$('.mobile_menu .analytics .fa-chevron-right').click(function() {
		$(this).hide();
		$('.mobile_menu .analytics .fa-chevron-down').show();
		$('.mobile_menu .analytics ul').show()
	})
	$('.mobile_menu .analytics .fa-chevron-down').click(function() {
		$(this).hide();
		$('.mobile_menu .analytics .fa-chevron-right').show();
		$('.mobile_menu .analytics ul').hide();
	})

	$('.mobile_category > i, .mobile_category > a').click(function() {
		$('.mobile_category i').toggle();
		$('.mobile_category ul').toggle();
	})

})












