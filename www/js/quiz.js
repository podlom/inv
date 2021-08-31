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
		successCalculatorRequest();
	});
}
