$(document).foundation();
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
	if(c.length > 0){
		c.slideDown(0);
		$('html,body').animate({
	        scrollTop: c.parents('.the_preview').offset().top - 80
	    }, 50);
	}
	

	function togg() {
		$('.board_page .accordion .block').not($(this).next()).slideUp(400);
		$(this).next().slideToggle(400);
	}
	if ($('.board_page .accordion .toggle_btn').next().is(':visible')) {
		$('.board_page .accordion .toggle_btn').text('Скрить');
	} 

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

	$('.investment .mobile_category .fa-chevron-right').click(function() {
		$(this).hide();
		$('.investment .mobile_category .fa-chevron-down').show();
		$('.investment .mobile_category ul').show();
	})

	$('.investment .mobile_category .fa-chevron-down').click(function() {
		$(this).hide();
		$('.investment .mobile_category .fa-chevron-right').show();
		$('.investment .mobile_category ul').hide();
	})

	$('.all_news .mobile_category .fa-chevron-right').click(function() {
		$(this).hide();
		$('.all_news .mobile_category .fa-chevron-down').show();
		$('.all_news .mobile_category ul').show();
	})

	$('.all_news .mobile_category .fa-chevron-down').click(function() {
		$(this).hide();
		$('.all_news .mobile_category .fa-chevron-right').show();
		$('.all_news .mobile_category ul').hide();
	})

	$('.all_read .mobile_category .fa-chevron-right').click(function() {
		$(this).hide();
		$('.all_read .mobile_category .fa-chevron-down').show();
		$('.all_read .mobile_category ul').show();
	})

	$('.all_read .mobile_category .fa-chevron-down').click(function() {
		$(this).hide();
		$('.all_read .mobile_category .fa-chevron-right').show();
		$('.all_read .mobile_category ul').hide();
	})
	$('.news_list .mobile_category .fa-chevron-right').click(function() {
		$(this).hide();
		$('.news_list .mobile_category .fa-chevron-down').show();
		$('.news_list .mobile_category ul').show();
	})

	$('.news_list .mobile_category .fa-chevron-down').click(function() {
		$(this).hide();
		$('.news_list .mobile_category .fa-chevron-right').show();
		$('.news_list .mobile_category ul').hide();
	})

	$('.inventure_list .mobile_category .fa-chevron-right').click(function() {
		$(this).hide();
		$('.inventure_list .mobile_category .fa-chevron-down').show();
		$('.inventure_list .mobile_category ul').show();
	})

	$('.inventure_list .mobile_category .fa-chevron-down').click(function() {
		$(this).hide();
		$('.inventure_list .mobile_category .fa-chevron-right').show();
		$('.inventure_list .mobile_category ul').hide();
	})
	$('.investment_single .mobile_category .fa-chevron-right').click(function() {
		$(this).hide();
		$('.investment_single .mobile_category .fa-chevron-down').show();
		$('.investment_single .mobile_category ul').show();
	})

	$('.investment_single .mobile_category .fa-chevron-down').click(function() {
		$(this).hide();
		$('.investment_single .mobile_category .fa-chevron-right').show();
		$('.investment_single .mobile_category ul').hide();
	})
	$('.news_single .mobile_category .fa-chevron-right').click(function() {
		$(this).hide();
		$('.news_single .mobile_category .fa-chevron-down').show();
		$('.news_single .mobile_category ul').show();
	})

	$('.news_single .mobile_category .fa-chevron-down').click(function() {
		$(this).hide();
		$('.news_single .mobile_category .fa-chevron-right').show();
		$('.news_single .mobile_category ul').hide();
	})

})












