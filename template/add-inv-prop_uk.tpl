{extends 'Page.view'}
{block 'breadcrumbs'}{/block}
{block 'page.class' append} add-inv-prop{/block}
{block 'content.text'}
	<style>
		#openNowLink {
			font-size: 20px;
			font-weight: bold;
		}

		.tablet_buttons {
			display: none;
		}

		@media screen and (min-width:1024px) {
			.investor-proposals__header:after {
				position: absolute;
				content: url("/images/rocket.svg");
				z-index: -1;
				top: -20px;
				right: 30px;
				max-width: 515px;
				display: block;
			}
		}
	</style>

	<section class="investor-proposals">
		<div class="container">
			<div class="investor-proposals__header">
				<div>
					<h1 class="investor-proposals__title">
						Залучення інвестицій, продаж бізнесу та комерційної нерухомості в Україні
					</h1>
					<div class="investor-proposals__description">
						<p>
							За більш ніж 10 років роботи на інвестиційному ринку України, ми розробили дієві інструменти із залучення
							інвестицій, продажу бізнесу, франшиз та комерційної нерухомості.
						</p>
						<p class="mt-2 font-bold">
							Виберіть відповідний формат співпраці:
						</p>

					</div>
				</div>
			</div>
			<div class="investor-proposals__form">
				<div class="investor-proposals__proposal proposal">
					<h2 class="proposal__title">Рекламний підхід</h2>
					<p class="proposal__description">Підійде для продажу малого або середнього бізнесу, об'єкта нерухомості,
					франшизи або стартапу, коли потрібно донести інформацію до широкого кола інвесторів.</p>
				<h3 class="proposal__features-title">Ви отримаєте:</h3>
				<ul class="proposal__features-list">
					<li>Розміщення на інвестиційному порталі InVenture</li>
					<li>Розміщення у журналі «Інвестиційний дайджест InVenture»</li>
					<li>Рекламний банер на інвестиційному порталі InVenture</li>
					<li>Просування у соцмережах (Facebook, LinkedIn, Telegram)</li>
					<li>Налаштування контекстної реклами Google Ads</li>
					<li>Розміщення на спеціалізованих інтернет майданчиках та дошках оголошень</li>
					<li>Розміщення у галузевому аналітичному дослідженні</li>
					<li>Розсилка по найбільшій базі інвесторів</li>
				</ul>

				<button data-deal-id="adv" data-deal-name="Рекламное продвижение" data-remodal-target="approach"
					class="btn btn--blue btn--blue-text w-full add-inv-prop-btn">
					Отримати умови
				</button>
			</div>
			<div class="investor-proposals__proposal proposal proposal--blue">
				<h2 class="proposal__title">Повний супровід</h2>
				<p class="proposal__description">
					Підійде для продажу середнього та великого бізнесу, залучення інвестицій у масштабні інвестпроекти, коли
					потрібен індивідуальний та комплексний підхід щодо пошуку інвестора.
				</p>
				<h3 class="proposal__features-title">Ви отримаєте:</h3>
				<ul class="proposal__features-list proposal__features-list--light">
					<li>Професійну презентацію для роботи з інвесторами</li>
					<li>Рекомендації щодо передпродажної підготовки бізнесу</li>
					<li>Прямі продажі та цілеспрямований пошук інвесторів</li>
					<li>Індивідуальний комплекс просування інвестиційної пропозиції</li>
					<li>Консультаційний супровід на всіх етапах угоди</li>
					<li>Координація процесу Due Diligence</li>
					<li>Медіація у переговорних процесах</li>
				</ul>

				<button data-deal-id="ind" data-deal-name="Индивидуальный подход" data-remodal-target="approach"
					class="btn btn--white btn--blue-text w-full add-inv-prop-btn">
					Отримати умови
				</button>
			</div>
		</div>

		<div class="investor-proposals__statistics statistics">
			<div class="statistics__block">
				<div class="statistics__number">300 000+</div>
				<div class="statistics__caption">Відвідувачів на місяць</div>
			</div>
			<div class="statistics__block">
				<div class="statistics__number">16 700+</div>
				<div class="statistics__caption">База email</div>
			</div>
			<div class="statistics__block">
				<div class="statistics__number">23 000+</div>
				<div class="statistics__caption">Підписники у соцмережах</div>
			</div>
			<div class="statistics__block">
				<div class="statistics__number">45+</div>
				<div class="statistics__caption">Закриті угоди</div>
			</div>
			<div class="statistics__block">
				<div class="statistics__number">$170+</div>
				<div class="statistics__caption">Вартість закритих угод</div>
			</div>
		</div>

	</div>
</section>


{include 'components/reviews' category='add-inv-prop'}

<div class="remodal callback" data-remodal-id="approach">
	<button data-remodal-action="close" class="remodal-close"></button>
	<div class="remodal__title">
		Заповніть контактні дані та ми направимо умови співпраці
	</div>
	<div class="callback__form">
		{form 'approach'}
	</div>
</div>

<div class="remodal callback" data-remodal-id="successModal">
	<button data-remodal-action="close" class="remodal-close"></button>
	<div class="text-left callback__form">
		<p>
			Ми надіслали Вам на пошту презентацію з описом умов співпраці.
		</p>
		<p>
			Наш менеджер зв'яжеться з Вами протягом одного робочого дня.
			</p>
			<a id="openNowLink" target="_blank" href="https://drive.google.com/open?id=1sFGhi5u4wVwNH8-pJat4EX8ufHSBIXVS"
				class="w-full blue_but cell-but small-12" type="submit">Відкрити презентацію</a>
			<button data-remodal-action="close" type='button'
				class="w-full blue_but cell-but  small-12 close__popup">Закрити</button>
		</div>
	</div>

{/block}

{* 
<div class="my_popup">
    <div class="my_popup__wrapper">
        <h5>Заполните пожалуйста Ваши контактные данные и мы направим условия сотрудничества</h5>
        <i class="fa fa-close"></i>
        {form 'approach'}
    </div>
</div> 
*}