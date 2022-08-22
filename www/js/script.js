function getFilledSubscriptionForm() {
	const subscriptionForms = $('.subscription__form').splice(0);
	return subscriptionForms.find((formElement) => {
		const firstName = $(formElement).find(
			'input[name="subscribe[firstname]"]',
		);
		const firstNameValue = firstName?.[0]?.value;
		const email = $(formElement).find('input[name="subscribe[email]"]');
		const emailValue = email?.[0]?.value;
		return firstNameValue && emailValue;
	});
}
$('button[data-callback="submitDigest"]').click((e) => {
	const form = $(e.target).closest('form')[0];

	function getRequiredFields() {
		let fields = [];
		$(form)
			.children('*[required]')
			.each((idx, el) => fields.push($(el).attr('name')));
		return fields;
	}
	function checkRequiredUnfilledInputs() {
		const requiredFieldNames = getRequiredFields();
		let serializedForm = $(form).serializeArray();
		return requiredFieldNames.some((fieldName) => {
			const fieldObject = serializedForm.find(
				(field) => field.name === fieldName,
			);
			return !fieldObject.value;
		});
	}
	const hasUnfilledInputs = checkRequiredUnfilledInputs();
	if (hasUnfilledInputs) {
		console.log('hasUnfilledInputs');
		e.preventDefault();
		grecaptcha.reset();
	}
});
function submitDigest(token) {
	console.log('+4 submitDigest() token: ', token);
	const filledFormElement = getFilledSubscriptionForm();
	console.log('filledFormElement', filledFormElement);
	if (!filledFormElement) return grecaptcha.reset();
	let form = $(filledFormElement);
	console.log('form', form);
	let formData = {};
	let fData = $(filledFormElement).serializeArray();
	console.log('fData', fData);
	$(fData).each(function (index, obj) {
		formData[obj.name] = obj.value;
		if (obj.name == 'email') {
			if (obj.value.length == 0) {
				console.log('+13 error: email can`t be empty');
				return false;
			}
		}
	});

	// Substitute token if input with name g-recaptcha-response is empty
	if (!formData['g-recaptcha-response']) {
		formData['g-recaptcha-response'] = token;
	}

	console.log('+18 formData: ', formData);

	if (
		$('#phone2').length &&
		$('#error-msg2').length &&
		!$('#error-msg2').hasClass('hide')
	) {
		console.log('+21 prevent wrong phone inputmask value submit');
		$('#phone2').focus();
		return;
	}

	$.post('/email-subscribe.php', formData).done((data) => {
		console.log('+27 got data: ', data);

		if (data.status) {
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
		} else {
			if (document.documentElement.lang == 'ru') {
				Swal.fire({
					title: 'Что-то пошло не так...',
					text: data.errors.join(', '),
					type: 'error',
					confirmButtonText: 'Попробовать еще раз',
				});
			} else {
				Swal.fire({
					title: 'Something went wrong!',
					text: 'You have not been subscribed',
					type: 'error',
					confirmButtonText: 'Try again',
				});
			}
		}
	});
}

$(document).ready(function () {
	console.log('+71 $(document).ready()');

	let sForm = $('form.subscribe');
	if (sForm.length) {
		console.log('+75 found form.subscribe');
		if (!$('form.subscribe').hasClass('subscription__form')) {
			console.log('+77 fixed form.subscribe classes');
			$('form.subscribe').addClass('subscription__form');
		}
	} else {
		console.log('+81 form.subscribe was not found.');
	}

	$('.subscription__form').submit(function (e) {
		console.log('+85 .subscription__form.submit()');
		e.preventDefault();
		if (
			$('#phone2').length &&
			$('#error-msg2').length &&
			!$('#error-msg2').hasClass('hide')
		) {
			console.log('+88 prevent wrong phone inputmask value submit');
			$('#phone2').focus();
			return false;
		}

		var form = $(this);
		var formdata = $(this).serializeArray();
		var data = {};
		$(formdata).each(function (index, obj) {
			data[obj.name] = obj.value;
			if (obj.name == 'email') {
				console.log('+101 email value: ', obj.value);
				if (obj.value.length == 0) {
					console.log('+103 error: email can`t be empty');
					return false;
				}
			}
		});

		$.post('/email-subscribe.php', data).done((data) => {
			console.log('+110 got data: ', data);

			if (data.status) {
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
			} else {
				if (document.documentElement.lang == 'ru') {
					Swal.fire({
						title: 'Что-то пошло не так...',
						text: data.errors.join(', '),
						type: 'error',
						confirmButtonText: 'Попробовать еще раз',
					});
				} else {
					Swal.fire({
						title: 'Something went wrong!',
						text: 'You have not been subscribed',
						type: 'error',
						confirmButtonText: 'Try again',
					});
				}
			}
		});
	});
	$('.instrumentQuestionMain, .instrumentQuestion').click(function () {
		var id = $(this).attr('data-expert-id');
		$('#questionForm form')
			.find('input:first[type=hidden]')
			.attr('value', id);
	});
	$('#search-block .pointer').click(function () {
		$('.large-3.columns.search-block').toggle('slow');
	});
	$('.main_nav>li').hoverIntent(function (e) {
		$('.main_nav>li ul.active').not($(this)).removeClass('active');
		$('.main_nav>li ul.active').not($(this)).toggle('fast');
		$(this).children('ul').addClass('active');
		$('.main_nav>li ul.active').toggle('600');
		e.preventDefault();
		return false;
	});

	$('.subMenuButton').click(function () {
		menu = $(this).parent().parent().find('.Nav').toggleClass('open');
		if (menu.is('.open')) {
			menu.show();
			menu.animate(
				{
					opacity: 1,
				},
				400,
			);
		} else {
			menu.animate(
				{
					opacity: 0,
				},
				400,
				function () {
					menu.hide();
				},
			);
		}
	});
	$('.linkShow').click(function () {
		$('.contactSotrudniki').slideToggle();
	});
	$('.search-block .btn-right-dropdown').click(function () {
		$('.search-block .btn-right-dropdown')
			.not($(this))
			.parent()
			.children('.search-block .sub-right-dropdown.active')
			.removeClass('active')
			.toggle('slow');
		$(this)
			.parent()
			.children('.search-block .sub-right-dropdown')
			.toggle('slow')
			.toggleClass('active ');
	});
	$('.search-block .sub-right-dropdown ul li').click(function () {
		//$(this).parent().children(".search-block .btn-right-dropdown").css("color: black");
		var $clone = $(this).clone().text();
		$(this)
			.parent()
			.parent()
			.parent()
			.children('.search-block .btn-right-dropdown')
			.html($clone);
		$('.search-block .sub-right-dropdown.active').hide();
		$('.search-block .sub-right-dropdown.active').removeClass('active');
	});
	$(function () {
		$('.vote-block:first .acc-content').addClass('active');
		$('.acc-content').not('.active').hide();
		$('.acc-caption').click(function () {
			$('.acc-content')
				.not($(this).next('.acc-content'))
				.removeClass('active')
				.slideUp(600); // сворачиваем элементы
			$(this).next('.acc-content').addClass('active').slideDown(600);
			//$('.acc-content').hasClass('active').parent($(this).css("color", "black"));
		});
	});
	$('#archiveFormYear, #archiveFormMonths')
		.change(function (e) {
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
	$('#archiveFormButton').click(function (e) {
		if ($(this).attr('disabled')) e.preventDefault();
	});

	$('.label-click').click(function () {
		$(this).parent().parent().find('.tged').slideToggle();
	});
	$("form[name='inventure-form'] .label-click").click(function () {
		$(this).parent().parent().children('.tged').slideToggle();
	});

	$('.show_res').click(function () {
		if ($(this).parent().find('.answer').hasClass('margin-answer')) {
			$(this).parent().find('.answer').removeClass('margin-answer');
		} else {
			$(this).parent().find('.answer').addClass('margin-answer');
		}
		$(this).parent().toggleClass('result');
		$(this).parent().find('input').toggle('slow');
		$(this).parent().find('.is-pool-block').toggle('slow');
	});

	$('.viewbox-cnt-body table').wrap('<div class="table-responsive">');
});
