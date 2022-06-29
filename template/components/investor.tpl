<section class="investor">
	<div class="investor__header mobile-pt-4 mobile-pb-4">
		<div class="container">
			<div class="investor__header-text">
				<h1 class="investor__title mb-1">
				{if $lang === 'ru'}
					Регистрация инвестора
				{else if $lang === 'en'}
					Investor Registration
				{else}
					Реєстрація інвестора
				{/if}
					</h1>
				<div class="investor__description">
					{if $lang === 'ru'}
						Заполните пожалуйста форму, это поможет нам определить ваши предпочтения и инвестиционные критерии для подбора
						наиболее подходящих предложений. Мы гарантируем соблюдение полной конфиденциальности.
					{else if $lang === 'en'}
						Please fill in the form, it will help us to define your preferences and investment criteria for selecting the
						most suitable offers. We guarantee your privacy.
					{else}
						Будь ласка, заповніть форму, це допоможе нам визначити ваші уподобання та інвестиційні критерії для вибору
						найбільш підходящих пропозицій. Ми гарантуємо дотримання конфіденційності.
					{/if}
				</div>
			</div>
		</div>
		<div class="investor__header-img"></div>
	</div>
	<form action="/form/investor" class="investor__form form ">
		<div class="container">
			<div class="form__body">
				<div class="form__section relative z-1">
					<div class="form__heading">
						<div class="form__title mb-8">
							{if $lang === 'ru'}
								Контактные данные
							{else if $lang === 'en'}
								Your contacts
							{else}
								Контактні дані
							{/if}
						</div>
					</div>
					<div class="form__fields form__fields--inputs">
						<div class="form__label-wrap floating-label-wrap">
							<input type="text" name="sf_investor[firstname]" class="floating-label-field floating-label-field--s2"
								placeholder="{if $lang === 'ru'}Ваше имя{else}First name{/if}" required />
							<label class="floating-label">
								{if $lang === 'ru'}
									Ваше имя
								{else if $lang === 'en'}
									First name
								{else}
									Ваше ім'я
								{/if}
							</label>
						</div>
						<div class="form__label-wrap floating-label-wrap">
							<input type="text" name="sf_investor[lastname]" class="floating-label-field floating-label-field--s2"
								placeholder="{if $lang === 'ru'}Фамилия{else}Last name{/if}" required />
							<label class="floating-label">
								{if $lang === 'ru'}
								Фамилия
								{else if $lang === 'en'}
								Last name
								{else}
								Прізвище
								{/if}
							</label>
						</div>
						<div class="form__label-wrap floating-label-wrap">
							<input type="text" name="sf_investor[company]" class="floating-label-field floating-label-field--s2"
								placeholder="{if $lang === 'ru'}
									Компания
								{else if $lang === 'en'}
								Company
								{else}
								Компанія
							{/if}" required />
							<label class="floating-label">
								{if $lang === 'ru'}Компания{else if $lang === 'en'}
								Company
								{else}
								Компанія{/if}
							</label>
						</div>
						<div class="form__label-wrap floating-label-wrap">
							<input type="text" name="sf_investor[job]" class="floating-label-field floating-label-field--s2"
								placeholder="{if $lang === 'ru'}
								Должность
								{else if $lang === 'en'}
								Position
								{else}
								Посада
							{/if}" required />
							<label class="floating-label">
								{if $lang === 'ru'}
								Должность
								{else if $lang === 'en'}
								Position
								{else}
								Посада
								{/if}
							</label>
						</div>
						<div class="form__label-wrap floating-label-wrap">
							<input type="email" name="sf_investor[email]" class="floating-label-field floating-label-field--s2"
								placeholder="E-mail" required />
							<label class="floating-label">E-mail</label>
						</div>
						<div class="form__label-wrap floating-label-wrap">
							{* <input
                type="text"
                name="sf_investor[phone]"
                class="floating-label-field floating-label-field--s2"
                placeholder="Телефон"
                required
              /> *}
							<input data-label="{if $lang === "ru"}
							Телефон
							{else if $lang === 'en'}
							Mobile phone
							{else}
							Телефон
							{/if}
							" class="floating-label-field floating-label-field--s2" type="tel" id="phone" name="sf_investor[phone]"
								required>
							<span id="error-msg" class="hide"></span>
							{literal}
							<script>
								var input = document.querySelector("#phone");
								window.intlTelInput(input, {
									dropdownContainer: document.body,
									utilsScript: "/js/utils.js",
								});
								setTimeout(() => {
									const label = `<label class="floating-label">${input.dataset.label}</label>`;
									document.getElementById('phone').insertAdjacentHTML('afterend', label)
								}, 1000)
							</script>
							{/literal}

						</div>
					</div>
				</div>
				<div id="insert-form" class="relative z-0"></div>
				<div class="form__section">
					<div class="form__heading ">
						<input class="inp-cbx" id="manager" name="sf_investor[manager]" type="checkbox" checked="checked" />
						<label class="cbx cbx--white cbx--medium" for="manager" type="checkbox">
							<span>
								<svg width="12px" height="10px">
									<use xlink:href="#check"></use>
								</svg>
							</span>
							<span>
								{if $lang === 'ru'}
								Заказать звонок от менеджера
								{else if $lang === 'en'}
								Order a call from the manager.
								{else}
								Замовити дзвінок від менеджера
								{/if}
							</span>
						</label>
					</div>
					<div class="form__fields form__fields--light form__fields--small">
						{if $lang === 'ru'}
						Выбирая эту функцию, Вы заказываете звонок от менеджера компании, который сможет предоставить дополнительную
						консультацию по интересующим Вас вопросам и ускорить процесс подбора подходящего предложения.
						{else if $lang === 'en'}
						By choosing, you order a call from a company manager, who will be able to provide additional advice on
						issues that interest you and speed up the process of selecting the right offer.
						{else}
						Вибираючи цю функцію, ви замовляєте дзвінок від менеджера компанії, який може надати додаткові
						консультації з питань, що цікавлять вас, та прискорюють процес вибору відповідної пропозиції.
						{/if}

					</div>
				</div>
			</div>
		</div>
		<div class="form__footer footer">
			<div class="container">
				<div class="footer__wrapper">
					<button class="btn form__submit btn--white">
						{if $lang === 'ru'}
						Отправить анкету
						{else if $lang === 'en'}
						Send a form
						{else}
						Відправити анкету
						{/if}
					</button>
					<div class="footer__agreement">
						<input class="inp-cbx" id="privacy" name="privacy" type="checkbox" checked="checked" required />
						<label class="cbx cbx--white" for="privacy" type="checkbox">
							<span>
								<svg width="12px" height="10px">
									<use xlink:href="#check"></use>
								</svg>
							</span>
							<span>
								{if $lang === 'ru'}
								Я соглашаюсь на обработку персональных данных согласно политике конфиденциальности.
								{else if $lang === 'en'}
								I agree processing personal data according to the privacy policy.
								{else}
								Я погоджуюся з обробкою персональних даних відповідно до Політики конфіденційності.
								{/if}

							</span>
						</label>
					</div>
				</div>
			</div>
		</div>
	</form>
</section>
{* $form->open()}
{foreach $form->getErrors(true) as $error}
   <div class="alert-box error error">{$error}</div>
{/foreach}
{foreach ['types','stage','profit','location','strong','capacity','size','inv','involvement'] as $t}
    <h3>{$form->getField($t)->getLabel()}</h3>
    <div class="grid-x grid-margin-x">
        {$arr=$form->getField($t)->getInput()->getChilds()}
        {foreach $arr as $f}{$f}{/foreach}
    </div>
  {/foreach}
{$form->protection()}
<input type="hidden" name="sf_investor[ga_utm]" value="">
{$form->close() *}

<!-- <div class="form__section">
  <div class="form__title">Приоритетные направления инвестирования</div> -->



{if $lang === 'ru'}
{literal}

<script>
	'use strict';


	const formFields = [{
			name: 'sf_investor[types][]',
			title: 'Приоритетные направления инвестирования',
			type: 'checkbox',
			fields: [
				'Сельское хозяйство',
				'Пищевая промышленность',
				'Добывающая промышленность',
				'Металлургия и металлообработка',
				'Машиностроение и производство электрооборудования',
				'Нефтехимическая промышленность',
				'Фармацевтическая промышленность',
				'Деревообработка и целлюлозно-бумажная промышленность',
				'Текстильная промышленность',
				'Строительство и недвижимость',
				'Финансовая деятельность',
				'Оптовая и розничная торговля',
				'Бизнес услуги',
				'Транспорт и складское хозяйство',
				'Телекоммуникации и связь',
				'Искусство, развлечения, спорт и отдых',
				'Электроэнергетика и топливная промышленность',
				'Водообеспечение и переработка отходов',
				'Информационные технологии и интернет проекты',
				'Инновации и высокие технологии',
				'Здравоохранение и социальная помощь',
				'Потребительские услуги',
				'Образование',
				'Организации и ассоциации'
			],
		},
		{
			name: 'sf_investor[stage][]',
			title: 'Стадии инвестирования',
			type: 'checkbox',
			fields: [
				'Стартап',
				'Ранняя стадия',
				'Стадия роста и расширения',
				'Проблемный актив',
			],
		},
		{
			name: 'sf_investor[profit][]',
			title: 'Планируемая доходность',
			type: 'checkbox',
			fields: ['10% – 15%', '15% – 20%', '20% – 25%', '25% – 30%', 'Свыше 30%'],
		},
		{
			name: 'sf_investor[location][]',
			title: 'Регион',
			type: 'checkbox',
			fields: [
				'Украина',
				'СНГ',
				'Центральная и Восточная Европа',
				'Западная европа',
				'США',
				'Азия',
			],
		},
		{
			name: 'sf_investor[strong][]',
			title: 'Сильные стороны',
			type: 'checkbox',
			fields: ['Финансы', 'Управление', 'Связи', 'Технологии', 'Недвижимость'],
		},
		{
			name: 'sf_investor[size][]',
			title: 'Объемы инвестирования',
			type: 'checkbox',
			fields: [
				'До $100 000',
				'От $100 000 до $500 000',
				'От $500 000 до $1 млн',
				'От $1 млн до $5 млн',
				'От $5 млн до $10 млн',
				'Более $10 млн',
			],
		},
		{
			name: 'sf_investor[inv][]',
			title: 'Форма инвестирования',
			type: 'checkbox',
			fields: [
				'Кредитование',
				'Сотрудничество',
				'Контрольный пакет (более 50% доли в бизнесе)',
				'Миноритарный пакет (менее 50% доли в бизнесе)',
			],
		},
		{
			name: 'sf_investor[involvement][]',
			title: 'Участие в проекте',
			type: 'checkbox',
			fields: ['Активное', 'Пассивное'],
		},
	];

	class InvestorForm {
		constructor(fields) {
			this.fields = fields;
		}
		generateHtml() {
			return this.fields
				.map(({ title, type, fields, name }) => {
					title = `<div class="form__heading"><div class="form__title mb-2">${title}</div></div>`;
					fields = fields
						.map((label, index) => this.generateField(label, type, name, index))
						.join('');
					const wrappedFields = this.wrapFields(fields, type);
					const section = this.wrapSection(title + wrappedFields);
					return section;
				})
				.join('');
		}
		wrapSection(html) {
			return `<div class="form__section">${html}</div>`;
		}
		wrapFields(html, type) {
			return `<div class="form__fields form__fields--${type}">${html}</div>`;
		}
		generateField(label, type, name, index) {
			if (type === 'checkbox') {
				return `
        <div class="form__field">
<input class="inp-cbx" id="${name}-${index}" name="${name}" value="${index}" type="checkbox"/>
<label class="cbx" for="${name}-${index}" type="checkbox">
            <span>
              <svg width="12px" height="10px">
                <use xlink:href="#check"></use>
              </svg>
            </span>
<span>${label}</span>
          </label>
        </div>`;
			}
			return `<div class="form__field><input class="form__input" type="${type}"/><label class="form__label">${label}</label></div>`;
		}
		insert(where, element) {
			const html = this.generateHtml();
			return element.insertAdjacentHTML(where, html);
		}
	}

	const formElement = document.querySelector('#insert-form');
	if (formElement) {
		const form = new InvestorForm(formFields).insert('beforeend', formElement);
	}
</script>
{/literal}

{else if $lang === 'en'}

{literal}
<script>
	'use strict';


	const formFields = [{
			name: 'sf_investor[types][]',
			title: 'Investment priorities',
			type: 'checkbox',
			fields: [
				'Agriculture',
				'Food processing',
				'Extraction and mining',
				'Metallurgy',
				'Machinery and production of electrical equipment',
				'Petrochemical industry',
				'Pharmacy',
				'Wood and paper',
				'Textile industry',
				'Construction and real estate',
				'Financial services',
				'Wholesale and retail',
				'Business services',
				'Transport & logistics',
				'Telecommunications',
				'Arts, entertainment, sports and recreation',
				'Energy and electricity',
				'Water supply and waste management',
				'ICT',
				'Innovation and high technology',
				'Hotels and restaurants',
				'Health care',
				'Consumer services',
				'Education',
				'Organizations and Associations',
				'Innovations and high-tech',
			],
		},
		{
			name: 'sf_investor[stage][]',
			title: 'Investment stage',
			type: 'checkbox',
			fields: [
				'Startup',
				'Early Stage',
				'Growth or Expansion',
				'Distressed Assets',
			],
		},
		{
			name: 'sf_investor[profit][]',
			title: 'Planned profitability',
			type: 'checkbox',
			fields: ['10% – 15%', '15% – 20%', '20% – 25%', '25% – 30%', 'Свыше 30%'],
		},
		{
			name: 'sf_investor[location][]',
			title: 'Region',
			type: 'checkbox',
			fields: [
				'Ukraine',
				'CIS',
				'Central and Eastern Europe',
				'Western Europe',
				'USA',
				'Asia',
			],
		},
		{
			name: 'sf_investor[strong][]',
			title: 'Strengths',
			type: 'checkbox',
			fields: ['Finance', 'Управление', 'Management', 'Technology', 'Real Estate'],
		},
		{
			name: 'sf_investor[size][]',
			title: 'Investment amount',
			type: 'checkbox',
			fields: [
				'up to $100K',
				'from $100K up to $500K',
				'from $500K up to $1 million',
				'from $1 million to $5 million',
				'from $5 million to $10 million',
				'more than $10 million',
			],
		},
		{
			name: 'sf_investor[inv][]',
			title: 'Форма инвестирования',
			type: 'checkbox',
			fields: [
				'Lending',
				'Cooperation',
				'Control stake (more than 50% of shares) ',
				'Minority package (less than 50% of shares)',
			],
		},
		{
			name: 'sf_investor[involvement][]',
			title: 'Project involvement',
			type: 'checkbox',
			fields: ['Active', 'Passive'],
		},
	];

	class InvestorForm {
		constructor(fields) {
			this.fields = fields;
		}
		generateHtml() {
			return this.fields
				.map(({ title, type, fields, name }) => {
					title = `<div class="form__heading"><div class="form__title mb-2">${title}</div></div>`;
					fields = fields
						.map((label, index) => this.generateField(label, type, name, index))
						.join('');
					const wrappedFields = this.wrapFields(fields, type);
					const section = this.wrapSection(title + wrappedFields);
					return section;
				})
				.join('');
		}
		wrapSection(html) {
			return `<div class="form__section">${html}</div>`;
		}
		wrapFields(html, type) {
			return `<div class="form__fields form__fields--${type}">${html}</div>`;
		}
		generateField(label, type, name, index) {
			if (type === 'checkbox') {
				return `
        <div class="form__field">
<input class="inp-cbx" id="${name}-${index}" name="${name}" value="${index}" type="checkbox"/>
<label class="cbx" for="${name}-${index}" type="checkbox">
            <span>
              <svg width="12px" height="10px">
                <use xlink:href="#check"></use>
              </svg>
            </span>
<span>${label}</span>
          </label>
        </div>`;
			}
			return `<div class="form__field><input class="form__input" type="${type}"/><label class="form__label">${label}</label></div>`;
		}
		insert(where, element) {
			const html = this.generateHtml();
			return element.insertAdjacentHTML(where, html);
		}
	}

	const formElement = document.querySelector('#insert-form');
	if (formElement) {
		const form = new InvestorForm(formFields).insert('beforeend', formElement);
	}
</script>
{/literal}


{else}
{literal}

<script>
	'use strict';


	const formFields = [{
			name: 'sf_investor[types][]',
			title: 'Пріоритетні інвестиційні сфери',
			type: 'checkbox',
			fields: [
				'Сільське господарство',
				'Харчова промисловість',
				'Видобувна промисловість',
				'Металургія та металообробка',
				'Інженерія та виробництво електричного обладнання',
				'Нафтохімічна промисловість',
				'Фармацевтична промисловість',
				'Деревообробка та целюлоза та паперова промисловість',
				'Текстильна промисловість',
				'Будівництво та нерухомість',
				'Фінансова діяльність',
				'Оптова та роздрібна торгівля',
				'Бізнес -послуги',
				'Транспорт та склад',
				'Телекомунікації та спілкування',
				'Мистецтво, розваги, спорт та відпочинок',
				'Електроенергія та паливна промисловість',
				'Водопостачання та переробка відходів',
				'Інформаційні технології та Інтернет -проекти',
				'Інновації та високі технології',
				'Охорона здоровʼя та соціальна допомога',
				'Послуги споживачів',
				'Освіта',
				'Організації та соціації'
			],
		},
		{
			name: 'sf_investor[stage][]',
			title: 'Етапи інвестицій',
			type: 'checkbox',
			fields: [
				'Стартап',
				'Початкова стадія',
				'Етап зростання та розширення',
				'Проблемний актив',
			],
		},
		{
			name: 'sf_investor[profit][]',
			title: 'Планована прибутковість',
			type: 'checkbox',
			fields: ['10% – 15%', '15% – 20%', '20% – 25%', '25% – 30%', 'більше 30%'],
		},
		{
			name: 'sf_investor[location][]',
			title: 'Область',
			type: 'checkbox',
			fields: [
				'Україна',
				'СНД',
				'Центральна та Східна Європа',
				'Західна Європа',
				'США',
				'Азія',
			],
		},
		{
			name: 'sf_investor[strong][]',
			title: 'Сильні сторони',
			type: 'checkbox',
			fields: ['Фінансовий', 'Управління', 'Звʼязки', 'Технології', 'Нерухомість'],
		},
		{
			name: 'sf_investor[size][]',
			title: 'Обсяги інвестицій',
			type: 'checkbox',
			fields: [
				'До $100 000',
				'Від $100 000 до $500 000',
				'Від $500 000 до $1 млн',
				'Від $1 млн до $5 млн',
				'Від $5 млн до $10 млн',
				'Більше $10 млн',
			],
		},
		{
			name: 'sf_investor[inv][]',
			title: 'Форма інвестицій',
			type: 'checkbox',
			fields: [
				'Кредитування',
				'Співпраця',
				'Контрольний пакет (більше 50% частки в бизнесі)',
				'Міноритарний пакет (менше 50% частки в бизнесі)',
			],
		},
		{
			name: 'sf_investor[involvement][]',
			title: 'Участь у проекті',
			type: 'checkbox',
			fields: ['Активна', 'Пасивна'],
		},
	];

	class InvestorForm {
		constructor(fields) {
			this.fields = fields;
		}
		generateHtml() {
			return this.fields
				.map(({ title, type, fields, name }) => {
					title = `<div class="form__heading"><div class="form__title mb-2">${title}</div></div>`;
					fields = fields
						.map((label, index) => this.generateField(label, type, name, index))
						.join('');
					const wrappedFields = this.wrapFields(fields, type);
					const section = this.wrapSection(title + wrappedFields);
					return section;
				})
				.join('');
		}
		wrapSection(html) {
			return `<div class="form__section">${html}</div>`;
		}
		wrapFields(html, type) {
			return `<div class="form__fields form__fields--${type}">${html}</div>`;
		}
		generateField(label, type, name, index) {
			if (type === 'checkbox') {
				return `
						<div class="form__field">
<input class="inp-cbx" id="${name}-${index}" name="${name}" value="${index}" type="checkbox"/>
<label class="cbx" for="${name}-${index}" type="checkbox">
								<span>
									<svg width="12px" height="10px">
										<use xlink:href="#check"></use>
									</svg>
								</span>
<span>${label}</span>
							</label>
						</div>`;
			}
			return `<div class="form__field><input class="form__input" type="${type}"/><label class="form__label">${label}</label></div>`;
		}
		insert(where, element) {
			const html = this.generateHtml();
			return element.insertAdjacentHTML(where, html);
		}
	}

	const formElement = document.querySelector('#insert-form');
	if (formElement) {
		const form = new InvestorForm(formFields).insert('beforeend', formElement);
		}
	</script>
{/literal}


{/if}

<svg class="inline-svg">
	<symbol id="check" viewbox="0 0 12 10">
		<polyline points="1.5 6 4.5 9 10.5 1"></polyline>
	</symbol>
</svg>
<style>
	.inner-wrap {
		padding-top: 0em;
	}
</style>