// $(document).foundation();

if (document.getElementById('check-en')) {
	document.getElementById('check-en').checked = false;
}
if (document.getElementById('check-ru')) {
	document.getElementById('check-ru').checked = true;
}

const LIMITED_CHECKBOX =
	'input[name="sf_investor[types][]"], input[name="sf_investor[profit][]"]';
if ($(LIMITED_CHECKBOX).length) {
	$(LIMITED_CHECKBOX).click(function() {
		var selector = `input[name="${$(this).attr('name')}"]`;
		$(this).attr('disabled', false);
		if ($(selector + ':checked').length >= 3) {
			$(selector + ':not(:checked)').attr('disabled', true);
		} else {
			$(selector).attr('disabled', false);
		}
	});
}

function changeCheckBox(lang) {
	if (lang == 'ru') {
		document.getElementById('check-ru').checked = !document.getElementById(
			'check-ru',
		).checked;
		document
			.getElementById('check-box-ru')
			.classList.toggle('subscription__check-box--active');
	}
	if (lang == 'en') {
		document.getElementById('check-en').checked = !document.getElementById(
			'check-en',
		).checked;
		document
			.getElementById('check-box-en')
			.classList.toggle('subscription__check-box--active');
	}
}

function redirectPost(location, args) {
	var form = '';
	for (let arg of args) {
		form +=
			'<input type="hidden" name="' +
			arg['name'] +
			'" value="' +
			arg['value'] +
			'">';
	}
	$('<form action="' + location + '" method="POST">' + form + '</form>')
		.appendTo($(document.body))
		.submit();
}

$('form.subscribe').submit(function(e) {
	e.preventDefault();
	// @sr 2020-01-22 do not send form with wrong phone inputmask value
	if (!$('#error-msg').hasClass('hide')) {
		console.log('+98 prevent wrong phone inputmask value submit');
		$('#phone').focus();
		return;
	}
	if (
		$('#phone2').length &&
		$('#error-msg2').length &&
		!$('#error-msg2').hasClass('hide')
	) {
		console.log('+98 prevent wrong phone inputmask value submit');
		$('#phone2').focus();
		return;
	}
	//
	var serialize = $(this).serializeArray();
	var action = $(this).attr('action');
	var form = $(this);
	$.post(action, $(this).serialize(), function() {
		console.log('success');
	}).done(function(data) {
		console.log('Data Loaded: ' + data);
		if (data.indexOf('tpl: index') === -1) {
			var redirect = action;
			redirectPost(window.location.origin + '/!Mail', serialize);
		} else {
			form.trigger('reset');
			$('.my_popup').removeClass('opened');
			$('.dark_bg').removeClass('opened');
			$('html').removeClass('page-locked');
			if (document.documentElement.lang == 'ru') {
				Swal.fire({
					title: 'Спасибо!',
					text: 'Теперь вы подписаны на нашу рассылку',
					type: 'success',
					confirmButtonText: 'Закрыть',
				});
			} else {
				Swal.fire({
					title: 'Thank you!',
					text: 'You have successfully subscribed',
					type: 'success',
					confirmButtonText: 'Close',
				});
			}
		}
	});
});

/* $('#inv_cb').submit(function(e1){
	e1.preventDefault();
	// @rs 2020-01-21 do not send form with wrong phone inputmask value
	if (!$('#error-msg').hasClass('hide')) {
		console.log('+86 prevent wrong phone inputmask value submit');
		$('#phone').focus();
		return;
	}
	//
}); */

$(
	'form[action="/form/approach"], form[action="/form/investor"], form[action="/form/investor_en"], form[action="/form/investment_callback"]',
).submit(function(e) {
	e.preventDefault();
	// @ts 2020-01-17 do not send form with wrong phone inputmask value
	if (!$('#error-msg').hasClass('hide')) {
		console.log('+98 prevent wrong phone inputmask value submit');
		$('#phone').focus();
		return;
	}
	if (
		$('#phone2').length &&
		$('#error-msg2').length &&
		!$('#error-msg2').hasClass('hide')
	) {
		console.log('+98 prevent wrong phone inputmask value submit');
		$('#phone2').focus();
		return;
	}

	var serialize = $(this).serializeArray();
	var action = '/invest.php';
	var form = $(this);
	$.post(action, $(this).serialize(), function() {
		form.trigger('reset');
		$('.my_popup').removeClass('opened');
		$('.dark_bg').removeClass('opened');
		$('html').removeClass('page-locked');

		/* import swal from 'sweetalert2'; */
		window.Swal = swal;

		if (document.documentElement.lang == 'ru') {
			Swal.fire({
				title: 'Благодарим за Ваш запрос!',
				text: '<p> bundle.js \n' +
					'\t\t\tМы отправили Вам на почту презентацию с описанием условий сотрудничества.\n' +
					'\t\t</p>\n' +
					'\t\t<p> \n' +
					'\t\t\tНаш менеджер свяжется с Вами в течение одного рабочего дня.\n' +
					'\t\t</p>\n' +
					'\t\t<a id="openNowLink" target="_blank" href="https://drive.google.com/file/d/1qiYiahSH65a88GP7VU2CMb3ZTKu3LGIn/view?usp=sharing" class="w-full blue_but cell-but small-12" type="submit">Открыть сейчас</a>\n' +
					'\t\t<button data-remodal-action="close" type=\'button\' class="w-full blue_but cell-but  small-12 close__popup">Закрыть</button>',
				type: 'success',
				confirmButtonText: 'Закрыть',
			});
		} else {
			Swal.fire({
				title: 'Thank you for your apply!',
				text: '',
				type: 'success',
				confirmButtonText: 'Close',
			});
		}
	});
});

$(document.body).ready(function() {
	if ($('.section__category').length) {
		const url_string = window.location.href;
		const url = new URL(url_string);
		const activeParent = url.searchParams.get('filter[category][parent]');
		const sortType = url.searchParams.get('filter[sort]');
		const region = url.searchParams.get('region');

		$('input[name="region"]').val(region);
		$('.section__category').each(function(el) {
			if (
				$(this)
					.attr('href')
					.indexOf(activeParent) !== -1
			) {
				$(this).addClass('section__category--active');
			}
			if (sortType) {
				const link = $(this).attr('href');
				$(this).attr('href', `${link}?filter[sort]=${sortType}`);
			}
		});
	}

	if ($('.preview__name-category').length) {
		let link = $('.preview__name-category a').attr('href');
		link = link.split('/').filter((i) => !!i);
		if (
			Array.isArray(link) &&
			link.length &&
			(link[0] === 'investments' || link[1] === 'investments')
		) {
			$('.preview__name-category a').attr(
				'href',
				`/investments?filter[category][parent]=${link[1]}`,
			);
		}
	}
	if (window.location.pathname.indexOf('/investments') !== -1) {
		const search = window.location.search;
		let query = search ? `${search}&action=get` : `?action=get`;
		let link = `/invest.php${query}`;
		$.get(link).then((data) => {
			if (data) {
				$('#cards__list').html(data);
			}
		});
		loadScript(
			'https://unpkg.com/smartphoto@1.1.0/js/smartphoto.min.js',
		).then(() => {
			new SmartPhoto('.js-smartphoto');
		});
	}

	// Youtube lazy loading
	var youtube = document.querySelectorAll('.youtube');

	for (var i = 0; i < youtube.length; i++) {
		var source =
			'https://img.youtube.com/vi/' +
			youtube[i].dataset.embed +
			'/sddefault.jpg';

		var image = new Image();
		image.src = source;
		image.addEventListener(
			'load',
			(function() {
				youtube[i].appendChild(image);
			})(i),
		);

		youtube[i].addEventListener('click', function() {
			var iframe = document.createElement('iframe');

			iframe.setAttribute('frameborder', '0');
			iframe.setAttribute('allowfullscreen', '');
			iframe.setAttribute(
				'src',
				'https://www.youtube.com/embed/' +
					this.dataset.embed +
					'?rel=0&showinfo=0&autoplay=1',
			);

			this.innerHTML = '';
			this.appendChild(iframe);
		});
	}

	var r = $('#gm_callback');
	var state = 'init';
	var storage = window.sessionStorage || window.localStorage;
	var is_sent = (storage && storage.getItem('callback_send')) || false;
	var close = function() {
		state = 'close';
		r.removeClass('gm_open').removeClass('gm_done');
	};
	var open = function() {
		state = 'open';
		r.removeClass('gm_done').addClass('gm_open');
	};

	$('#gm_callback .gm_call').click(open);
	$('#gm_callback .gm_close').click(close);
	$('#gm_callback input[type=tel]')
		.keydown(function(e) {
			var t = e.target.value;
			var r = '+' + t.replace(/[^0-9]/g, '');
			if (r != t) e.target.value = r;

			var offset = e.target.selectionStart;
			t = new RegExp('[0-9' + (offset == 0 ? '+' : '') + ']');
			if (e.key.length == 1 && !t.test(e.key)) {
				e.preventDefault();
				e.stopPropagation();
				return false;
			}
		})
		.focus(function(e) {
			if (e.target.value == '') {
				e.target.value = '+';
			}
		})
		.blur(function(e) {
			if (e.target.value == '+') {
				e.target.value = '';
			}
		});
	$('#gm_callback form').submit(function(e) {
		// e.preventDefault();
		// e.stopPropagation();
		console.log('+221 #gm_callback form submit');

		var tel3 = $('#phone3').val();
		if (tel3.length < 13) {
			$('#error-msg3')
				.text('Number is too short')
				.removeClass('hide');
			$('#phone3').focus();
			return;
		} else if (tel3.length >= 14) {
			$('#error-msg3')
				.text('Number is too long')
				.removeClass('hide');
			$('#phone3').focus();
			return;
		} else {
			console.log('+233 tel lenght is OK: ' + tel3.length);
			$('#error-msg3')
				.text('')
				.addClass('hide');
		}

		if (
			$('#phone3').length &&
			$('#error-msg3').length &&
			!$('#error-msg3').hasClass('hide')
		) {
			console.log('+220 prevent wrong phone inputmask value submit');
			$('#phone3').focus();
			return;
		}
		if (storage) {
			storage.setItem('callback_send', true);
		}
		r.removeClass('gm_open').addClass('gm_done');

		$('[data-remodal-id=callback]')
			.remodal()
			.close();
	});
});
$(document).ready(function() {
	$('#gm_callback').fadeIn(300);
});
$(document).ready(function() {
	$('.mobile_menu form [data-submit]').click(function() {
		$(this)
			.parents('form')
			.submit();
		console.log(this.form);
	});

	$('#nav .menu-item1').hover(
		function() {
			// $('#nav .menu-item1').show();
			$('.hover_bg').addClass('visible');
		},
		function() {
			// $('#nav .menu-item1').hide();
			$('.hover_bg').removeClass('visible');
		},
	);
	$('#nav .menu-item2').hover(
		function() {
			$('#nav .menu-item2 .submenu').show();
			$('.hover_bg').addClass('visible');
		},
		function() {
			$('#nav .menu-item2 .submenu').hide();
			$('.hover_bg').removeClass('visible');
		},
	);
	$('#nav .menu-item3').hover(
		function() {
			$('#nav .menu-item3 .submenu').show();
			$('.hover_bg').addClass('visible');
		},
		function() {
			$('#nav .menu-item3 .submenu').hide();
			$('.hover_bg').removeClass('visible');
		},
	);

	$('.header .right .search, .header .search').click(function() {
		$('.header').hide();
		$('.header_search').show();
	});
	$('#close').click(function() {
		$('.header_search').hide();
		$('.header').show();
	});
	$('.open_popup').click(function() {
		$('.my_popup').addClass('opened');
		$('.dark_bg').addClass('opened');
		if (window.innerWidth < 500) {
			$('html').addClass('page-locked');
		}
	});
	$('.my_popup i, .close__popup, .dark_bg').click(function() {
		$('.my_popup').removeClass('opened');
		$('.dark_bg').removeClass('opened');
		$('html').removeClass('page-locked');
	});
	$('.my_popup').click(function(e) {
		var container = $('.my_popup__wrapper');

		if (!container.is(e.target) && container.has(e.target).length === 0) {
			$('.my_popup').removeClass('opened');
			$('.dark_bg').removeClass('opened');
		}
	});
	$('#archiveFormYear, #archiveFormMonths')
		.change(function(e) {
			link = $(
				'#digest a.y' +
					$('#archiveFormYear').val() +
					'.m' +
					$('#archiveFormMonths').val(),
			);
			if (link.length == 0) {
				$('#archiveFormButton')
					.attr('disabled', true)
					.attr('href', '#');
			} else {
				$('#archiveFormButton')
					.attr('disabled', false)
					.attr('href', link.attr('href'));
			}
		})
		.change();
	$('#archiveFormButton').click(function(e) {
		if ($(this).attr('disabled')) e.preventDefault();
	});

	$('.owl-carousel').owlCarousel({
		margin: 10,
		items: 1,
		loop: true,
		mouseDrag: false,
		nav: true,
		autoHeight: true,
	});

	$('.pgwSlideshow').pgwSlideshow();

	var i = $('.investment_single iframe').parent();
	i.parent().css('text-align', 'center');

	$('.board_page .accordion .toggle_btn').on('click', togg);
	var c = $('.board_page .accordion' + location.hash + ' .block');
	if (location.hash.length > 0 && c.length > 0) {
		c.slideDown(0);
		$('html,body').animate(
			{
				scrollTop: c.parents('.the_preview').offset().top - 80,
			},
			50,
		);

		$('.board_page .accordion' + location.hash + ' .toggle_btn').addClass(
			'opened',
		);
	}

	function togg() {
		$(this).toggleClass('opened');
		$('.board_page .accordion .block')
			.not($(this).next())
			.slideUp(400);
		$(this)
			.next()
			.slideToggle(400);
		$(this)
			.children()
			.toggle();
	}
	$('.board_page .accordion .toggle_btn')
		.next(':visible')
		.prev()
		.children()
		.toggle();

	$('.tabs__caption a[href^="#"]').click(function(event) {
		event.preventDefault();
		elementClick = $(this).attr('href');
		destination = $(elementClick).offset().top - 100;
		$('html, body').animate({ scrollTop: destination }, 1000);
	});

	$('.up').click(function() {
		$('html, body').animate({ scrollTop: 0 }, 600);
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
			.addClass('active')
			.siblings()
			.removeClass('active')
			.closest('div.tabs')
			.find('div.tabs__content')
			.removeClass('active')
			.eq($(this).index())
			.addClass('active');
	});

	$('.label-click1 .open').click(function() {
		$(this).hide();
		$('.tged1').removeClass('hide');
		$('.label-click1 .close').show();
	});
	$('.label-click1 .close').click(function() {
		$(this).hide();
		$('.tged1').addClass('hide');
		$('.label-click1 .open').show();
	});
	$('.label-click2 .open').click(function() {
		$(this).hide();
		$('.tged2').removeClass('hide');
		$('.label-click2 .close').show();
	});
	$('.label-click2 .close').click(function() {
		$(this).hide();
		$('.tged2').addClass('hide');
		$('.label-click2 .open').show();
	});
	$('.label-click3 .open').click(function() {
		$(this).hide();
		$('.tged3').removeClass('hide');
		$('.label-click3 .close').show();
	});
	$('.label-click3 .close').click(function() {
		$(this).hide();
		$('.tged3').addClass('hide');
		$('.label-click3 .open').show();
	});
	$('.label-click4 .open').click(function() {
		$(this).hide();
		$('.tged4').removeClass('hide');
		$('.label-click4 .close').show();
	});
	$('.label-click4 .close').click(function() {
		$(this).hide();
		$('.tged4').addClass('hide');
		$('.label-click4 .open').show();
	});
	$('.label-click6 .open').click(function() {
		$(this).hide();
		$('.tged6').show();
		$('.label-click6 .close').show();
	});
	$('.label-click6 .close').click(function() {
		$(this).hide();
		$('.tged6').hide();
		$('.label-click6 .open').show();
	});

	$('.menu_icons .fa-bars').click(function() {
		$('.mobile_menu').slideToggle();
		if (window.innerWidth < 500) {
			$('html').toggleClass('page-locked');
		}
		$(this)
			.toggleClass('fa-bars')
			.toggleClass('fa-close');
	});

	$('.mobile_menu .investments .fa-plus').click(function() {
		$(this).hide();
		$('.mobile_menu .investments .fa-minus').show();
		$('.mobile_menu .investments ul').show();
	});
	$('.mobile_menu .investments .fa-minus').click(function() {
		$(this).hide();
		$('.mobile_menu .investments .fa-plus').show();
		$('.mobile_menu .investments ul').hide();
	});
	$('.mobile_menu .news .fa-plus').click(function() {
		$(this).hide();
		$('.mobile_menu .news .fa-minus').show();
		$('.mobile_menu .news ul').show();
	});
	$('.mobile_menu .news .fa-minus').click(function() {
		$(this).hide();
		$('.mobile_menu .news .fa-plus').show();
		$('.mobile_menu .news ul').hide();
	});

	$('.mobile_menu .analytics .fa-plus').click(function() {
		$(this).hide();
		$('.mobile_menu .analytics .fa-minus').show();
		$('.mobile_menu .analytics ul').show();
	});
	$('.mobile_menu .analytics .fa-minus').click(function() {
		$(this).hide();
		$('.mobile_menu .analytics .fa-plus').show();
		$('.mobile_menu .analytics ul').hide();
	});

	$('.mobile_category > i, .mobile_category > a').click(function() {
		$('.mobile_category i').toggle();
		$('.mobile_category ul').toggle();
	});

	if ($('#newsletter__archive').length) {
		$('#last-news-link').attr(
			'href',
			$('#newsletter__archive a:last-of-type').attr('href'),
		);
	}

	$('#hidden-digest div').each(function() {
		var month = $(this).attr('data-month'),
			year = $(this).attr('data-year'),
			link = $(this).text();
		$('#digest__month-' + year + ' li:nth-of-type(' + month + ') a').attr(
			'href',
			link,
		);
	});

	$('.digest__years li').click(function() {
		$('.digest__years li.active').removeClass('active');
		$('.digest__month.active').removeClass('active');
		$('#digest__month-' + $(this).text()).addClass('active');
		$(this).addClass('active');
	});

	function loadScript(src) {
		return new Promise((resolve) => {
			const script = document.createElement('script');
			script.src = src;
			script.type = 'text/javascript';
			script.async = true;
			script.onload = resolve;
			document.body.appendChild(script);
		});
	}

	if ($('[data-tippy-content]').length) {
		Promise.all([
			loadScript(
				'https://unpkg.com/@popperjs/core@2.4.4/dist/umd/popper.min.js',
			),
			loadScript('https://unpkg.com/tippy.js@6'),
		]).then(() => {
			tippy('[data-tippy-content]');
		});
	}

	if ($('#events').length || $('.event_list').length) {
		$('.event_list .cards').addClass('cards--event');
		const pathname = window.location.pathname;
		const action = pathname.includes('tools/events') ? 'events' : 'home';
		let search = window.location.search;
		if (!!search) search = `&${search.substring(1)}`;
		$.get(`/event.php?action=${action}${search}`).then((data) => {
			if (data) {
				$('#events .cards, .event_list .cards').html(data);
			}
		});
	}

	loadScript(
		'https://cdnjs.cloudflare.com/ajax/libs/remodal/1.1.1/remodal.min.js',
	);

	var selectConfig = {
		selectAll: false,
		formatCountSelected: function(count, total) {
			const fromStr =
				document.documentElement.lang === 'ru' ? ' из ' : ' of ';
			return count + fromStr + total;
		},
		formatAllSelected: function() {
			return document.documentElement.lang === 'ru'
				? 'Все выбраны'
				: 'All selected';
		},
	};

	/*function renderDisabledPrice (){
	const minPrice = $('select[name="price1"]')[0].value;
	const maxPrice = $('select[name="price2"]')[0].value;
	const arr = $('select[name="price1"] option').map((_, e) => e.value);


	let isDisabled = false;
	$('select[name="price1"] option').each((counter, option) => {
			if(option.value === maxPrice){
				isDisabled = true
			}
			if(isDisabled){
				option.disabled = true;
			}else{
				option.disabled = false;
			}
	})
}*/
	const groupParamsByKey = (params) =>
		[...params.entries()].reduce((acc, tuple) => {
			// getting the key and value from each tuple
			const [key, val] = tuple;
			if (acc.hasOwnProperty(key)) {
				// if the current key is already an array, we'll add the value to it
				if (Array.isArray(acc[key])) {
					acc[key] = [...acc[key], val];
				} else {
					// if it's not an array, but contains a value, we'll convert it into an array
					// and add the current value to it
					acc[key] = [acc[key], val];
				}
			} else {
				// plain assignment if no special case is present
				acc[key] = val;
			}

			return acc;
		}, {});
	if (
		$('#branch').length ||
		$('#filter__type').length ||
		$('#regions').length
	) {
		if (window.matchMedia('(max-width: 1024px)').matches) {
			$(document.body).append($('#invest-filter').detach());
			$('#invest-filter').addClass('mobile');
		}

		const params = new URLSearchParams(window.location.search);
		const paramsArray = groupParamsByKey(params);

		for (const key in paramsArray) {
			const val = paramsArray[key];

			if (val) {
				$(`[name="${key}"] option`).each((_, el) => {
					const optionSelected =
						(Array.isArray(val) && val.includes(el.value)) ||
						val == el.value;
					if (optionSelected) el.selected = 'selected';
				});
			}
		}

		if ($('.content table').length) {
			loadScript(
				'https://cdn.datatables.net/1.10.21/js/jquery.dataTables.js',
			).then(() => {
				$('.content table').addClasss('stripe');
				$('.content table').DataTable();
			});
		}

		loadScript('/js/multiple-select.min.js').then(() => {
			if ($('#branch').length) {
				$('#branch').multipleSelect(selectConfig);
			}
			if ($('#filter__type').length) {
				$('#filter__type').multipleSelect(selectConfig);
			}
			if ($('#regions').length) {
				$('#regions').multipleSelect(selectConfig);
			}
			if ($('.multiple-select[name="price1"]').length) {
				$('.multiple-select[name="price1"]').multipleSelect({
					position: 'top',
				});
			}
			if ($('.multiple-select[name="price2"]').length) {
				$('.multiple-select[name="price2"]').multipleSelect({
					position: 'top',
				});
			}
		});
	}

	$('#invest-sort').change(() => {
		const sortType = $('#invest-sort').val();
		window.location.href = sortType;
	});

	$('.toggle-filter').click(function() {
		$('.filter__wrapper').toggleClass('active');
		$('html, body').toggleClass('is-locked');
	});

	// "filter[category][parent]"
	// new URLSearchParams(window.location.search).get(key)

	// ========= HEADER =========
	var $lateral_menu_trigger = $('#cd-menu-trigger'),
		$content_wrapper = $('.cd-main-content'),
		$navigation = $('header');

	//open-close lateral menu clicking on the menu icon
	$lateral_menu_trigger.on('click', function(event) {
		event.preventDefault();

		$lateral_menu_trigger.toggleClass('is-clicked');
		$navigation.toggleClass('lateral-menu-is-open');
		$content_wrapper
			.toggleClass('lateral-menu-is-open')
			.one(
				'webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend',
				function() {
					// firefox transitions break when parent overflow is changed, so we need to wait for the end of the trasition to give the body an overflow hidden
					$('body').toggleClass('overflow-hidden');
				},
			);
		$('#cd-lateral-nav').toggleClass('lateral-menu-is-open');

		//check if transitions are not supported - i.e. in IE9
		if ($('html').hasClass('no-csstransitions')) {
			$('body').toggleClass('overflow-hidden');
		}
	});

	//close lateral menu clicking outside the menu itself
	$content_wrapper.on('click', function(event) {
		if (!$(event.target).is('#cd-menu-trigger, #cd-menu-trigger span')) {
			$lateral_menu_trigger.removeClass('is-clicked');
			$navigation.removeClass('lateral-menu-is-open');
			$content_wrapper
				.removeClass('lateral-menu-is-open')
				.one(
					'webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend',
					function() {
						$('body').removeClass('overflow-hidden');
					},
				);
			$('#cd-lateral-nav').removeClass('lateral-menu-is-open');
			//check if transitions are not supported
			if ($('html').hasClass('no-csstransitions')) {
				$('body').removeClass('overflow-hidden');
			}
		}
	});

	//open (or close) submenu items in the lateral menu. Close all the other open submenu items.
	$('.item-has-children')
		.children('a')
		.on('click', function(event) {
			event.preventDefault();
			$(this)
				.toggleClass('submenu-open')
				.next('.sub-menu')
				.slideToggle(200)
				.end()
				.parent('.item-has-children')
				.siblings('.item-has-children')
				.children('a')
				.removeClass('submenu-open')
				.next('.sub-menu')
				.slideUp(200);
		});

	function openMenu() {
		$('#mobile-nav').addClass('mobile-nav--opened');
		$('body, html').addClass('modal-open');
		$('#open-mobile-menu')
			.addClass('header__btn--close')
			.removeClass('header__btn--burger');
	}
	function closeMenu() {
		$('#open-mobile-menu')
			.removeClass('header__btn--close')
			.addClass('header__btn--burger');
		$('body, html').removeClass('modal-open');
		$('#mobile-nav').removeClass('mobile-nav--opened');
	}
	$('#open-mobile-menu').click(function() {
		$('#open-mobile-menu').hasClass('header__btn--close')
			? closeMenu()
			: openMenu();
	});
	if ($('#search-page #sort-select').length) {
		const activeClass = 'sort__item--active';
		$('#sort-select li').click(function(e) {
			e.preventDefault();
			const sortType = $(this).attr('data-value');
			$('#sort-select li').removeClass(activeClass);
			$('input#sort').attr('value', sortType);
			$(this).addClass('sort__item--active');
		});
		let sortType = $('input#sort').attr('value');
		if (!sortType) sortType = 'rel';
		$(`#sort-select li[data-value="${sortType}"]`).addClass(activeClass);
	}

	if ($('.post__video').length) {
		const postId = $('.post__video').attr('data-id');
		const elementToHide = document.getElementById('hide-if-text-empty');
		if (elementToHide) {
			$.get(`/page-attr-data.php?page_id=${postId}&action=get_text`).then(
				(data) => {
					if (!data) elementToHide.classList.add('hidden');
				},
			);
		}
	}

	const upload = ({ link, fileName }) => {
		var a = $('<a>')
			.attr('href', `${window.location.origin}/${link}`)
			.attr('download', fileName)
			.appendTo('body');
		a[0].click();
		a.remove();
	};

	$('.preview__slider-download').click(function() {
		const link = $(this).attr('data-link');
		const fileName = link.substring(link.lastIndexOf('/') + 1);
		upload({ link, fileName });
	});

	// loadScript(
	//   'https://cdnjs.cloudflare.com/ajax/libs/JavaScript-autoComplete/1.0.4/auto-complete.min.js',
	// ).then(() => {
	//   new autoComplete({
	//     selector: 'input[name="filter[attr_10]"]',
	//     source: function(addr, response) {
	//       $.getJSON('/geocoding.php', { addr }, function(data) {
	//         console.log({ data });
	//         response([data]);
	//       });
	//     },
	//   });
	// });

	if (window.location.pathname.indexOf('msb') !== -1) {
		loadScript(
			'https://cdn.jsdelivr.net/npm/sweet-modal@1.3.2/dist/min/jquery.sweet-modal.min.js',
		).then(() => {
			$.sweetModal.defaultSettings.confirm.ok.label = 'Выбрать';
			$.sweetModal.defaultSettings.confirm.cancel.label = 'Отменить';
		});

		const questions = [
			{
				title: 'Срок существования бизнеса',
				answers: ['до 1 года', 'от 1 до 5 лет', 'более 5 лет'],
			},
			{
				title: 'Выберите формат вашего бизнеса?',
				answers: [
					'Производство',
					'Интернет-магазин',
					'Оптовые продажи',
					'Работаю, как агент',
					'Услуги',
					'Офлайн продажи',
					'Инфобизнес',
					'B2B',
				],
				hasOther: true,
			},

			{
				title: 'Ежемесячный оборот вашей компании?',
				answers: [
					'0 – 50’000 грн',
					'50’000 – 100’000 грн',
					'100’000 – 400’000 грн',
					'400’000 – 1’000’000 грн',
					'1’000’000 – 3’000’000 грн',
					'3’000’000 – 5’000’000 грн',
					'Более 5’000’000 грн',
				],
			},

			{
				title:
					'Укажите задачу, которую вам бы хотелось решить в первую очередь',
				answers: [
					'Запустить новый проект',
					'Получать больше доход',
					'Создать компанию №1, в отрасли/мире',
					'Выйти из операционных процессов',
				],
			},

			{
				title:
					'Укажите проблему, решив которую, мы создадим для вас существенное облегчение?',
				answers: [
					'Не знаю за что взяться, нужен план действий',
					'Деньги в кассе есть, а прибыли в кармане нет',
					'Бардак и хаос – нет системы управления',
					'Все тащу один, нет сильной команды',
					'У компании большие финансовые обязательства',
					'Не могу расти органически, нужен инвестор',
					'Мне приходится докладывать свои деньги (кассовые разрывы)',
					'Не могу эффективно контролировать бухгалтера',
					'Большая клиентская нагрузка, не контролирую оплаты',
				],
				hasOther: true,
			},
		];

		class Quiz {
			constructor(questions) {
				this.questions = questions;
			}
			start() {
				const html = this.generate();
				this.insert(html);
			}
			insert(html) {
				const parent = document.getElementById('calc-form');
				parent.insertAdjacentHTML('afterbegin', html);
			}
			getOption(option, question) {
				return `
				<div class="question__item">
					<span>${option}</span>
					<input type="radio" name="${question.title}" value="${option}" checked="checked"/>
				</div>`;
			}
			generate() {
				let list = this.questions.map((i, counter) => {
					return `
					<div
						id="step${counter}"
						class="question_hide ${counter === 0 ? 'active' : ''} ${
						i.hasOther ? 'has-other' : ''
					}"
					>
						<h3 class="text-center mb-4">
							${i.title}
						</h3>
						<div class="question_one">
							${i.answers.map((option) => this.getOption(option, i)).join('')}
							${
								i.hasOther
									? `<div data-id="step${counter}" data-question="${i.title}" class="question__other">Другое</div>`
									: ''
							}
						</div>

					</div>`;
				});
				return list.join('');
			}
		}

		new Quiz(questions).start();

		$('.question__other').click(function(e) {
			console.log('question__other clicked');
			$.sweetModal.prompt('Введите ваш вариант', null, null, (option) => {
				if (option) {
					const createdDate = new Date().getTime();
					const id = `option__${createdDate}`;
					const questionTitle = $(this).attr('data-question');
					const html = `
							 <div class="question__item" id="${id}">
							 <span>${option}</span>
							 <input type="radio" name="${questionTitle}" value="${option}" checked="checked"/>
						 </div>`;
					$(this).before(html);

					$(`#${id}`).on('click', select);
					$(`#${id}`).click();
				}
			});
		});

		let step = 1;
		let progress_plus = 0;
		let count_percent = 0;
		let stepItem = $('.calculation_price_form .question_hide');
		const stepsLength = questions.length;
		const percent = 100 / stepsLength;

		function select() {
			$(this)
				.parent()
				.children('.active')
				.removeClass('active');
			$(this).addClass('active');
			if (step > stepsLength) {
				return;
			}
			$(stepItem[step]).addClass('active');
			$(stepItem[step - 1]).removeClass('active');
			step++;
			if (step == stepsLength + 1) {
				$('.calculation_text_finis').css('display', 'block');
				$('.calculation_text_finis').html(
					`Мы найдём правильные решения для вас, и обсудим их по телефону в ближайшее время. Пожалуйста оставьте Ваши контактные данные.`,
				);
			}
			progress_plus++;
			count_percent++;
			$('.progress-bar').css('width', '' + progress_plus * percent + '%');
			$('.sr-only').text(Math.round(count_percent * percent) + '%');
		}
		$('.next_calc,.question__item').on('click', select);
		$('.back_calc').on('click', function() {
			if (step <= 1) {
				return;
			}
			progress_plus--;
			count_percent--;
			step--;
			if (step == stepsLength) {
				$('.calculation_text_finis').css('display', 'none');
				$('.calculation_text_finis').text('');
			}
			$(stepItem[step - 1]).addClass('active');
			$(stepItem[step]).removeClass('active');
			$('.progress-bar').css(
				'width',
				'' + 100 - (100 - progress_plus * percent) + '%',
			);
			$('.sr-only').text(
				Math.round(100 - (100 - count_percent * percent)) + '%',
			);
		});

		$('.scroll-to-contact').click(function() {
			$('html, body').animate(
				{
					scrollTop: $('#contact-form').offset().top - 82,
				},
				2000,
			);
		});

		$('.reveal-list').click(function() {
			$(this)
				.next()
				.removeClass('hidden');
			$(this).addClass('hidden');
		});

		function successCalculatorRequest() {
			let modal = $.sweetModal({
				content: 'Спасибо! Наши менеджеры скоро свяжутся с вами.',
				icon: $.sweetModal.ICON_SUCCESS,
			});
			setTimeout(function() {
				modal.close();
			}, 2 * 1000);

			step = 1;
			progress_plus = 0;
			count_percent = 0;
			stepItem = $('.calculation_price_form .question_hide');
			$('.calculation_text_finis').text('');
			document.getElementById('calc-form').reset();
			$('.question_hide, .question__item').removeClass('active');
			$('.question_hide:first-of-type').addClass('active');
		}
		function successContactRequest() {
			let modal = $.sweetModal({
				content: 'Спасибо! Наши менеджеры скоро свяжутся с вами.',
				icon: $.sweetModal.ICON_SUCCESS,
			});
			setTimeout(function() {
				modal.close();
			}, 2 * 1000);
			document.getElementById('contact-form').reset();
		}

		$('#contact-form').submit(function(e) {
			e.preventDefault();
			// ¡Call request here!
			const name = $('#contact-form input[name="fullname"]').val();
			const tel = $('#contact-form input[name="phone"]').val();
			if (!name || !tel) return;
			const formData = new FormData();
			formData.append('sf_msb_form1[name]', name);
			formData.append('sf_msb_form1[tel]', tel);

			$.ajax({
				url: '/invest.php',
				type: 'POST',
				data: formData,
				processData: false,
				contentType: false,
				success: function(data, textStatus, jqXHR) {},
				error: function(jqXHR, textStatus, errorThrown) {},
			});

			successContactRequest();
		});
		$('#calc-form').submit(function(e) {
			e.preventDefault();
			const selectedOptions = $('.question__item.active input');
			let quizAnswers = [];
			selectedOptions.each(function(i) {
				quizAnswers.push({
					question: $(this).attr('name'),
					answer: $(this).attr('value'),
				});
			});
			const quizAnswersText = quizAnswers
				.map(({ question, answer }) => `${question}: ${answer}`)
				.join(', \n');
			const name = $('#calc-form input[name="fullname"]').val();
			const tel = $('#calc-form input[name="phone"]').val();

			// ¡Call request here!
			if (!name || !tel) return;
			const formData = new FormData();
			formData.append('sf_msb_form2[name]', name);
			formData.append('sf_msb_form2[tel]', tel);
			formData.append('sf_msb_form2[quiz]', quizAnswersText);

			$.ajax({
				url: '/invest.php',
				type: 'POST',
				data: formData,
				processData: false,
				contentType: false,
				success: function(data, textStatus, jqXHR) {},
				error: function(jqXHR, textStatus, errorThrown) {},
			});
			// $.post('/invest.php', {
			// 	sf_msb_form2: { name, tel },
			// }).then((response) => console.log(response));

			successCalculatorRequest();
		});
	}
});
