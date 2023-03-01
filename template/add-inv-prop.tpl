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



		.proposal__discounts {
			display: grid;
			gap: 14px;
			margin-bottom: 20px;
		}

		@media screen and (min-width: 480px) {
			.proposal__discounts.--grid {
				grid-template-columns: 1fr 1fr;
			}
		}

		.proposal__discounts-item {
			display: flex;
			align-items: center;
		}

		.proposal__discounts-icon {
			margin-right: 12px;
			width: 44px;
		}

		.proposal__discounts h3,
		.proposal__discounts p {
			margin: 0;
			padding: 0;
			font-size: 14px;
			line-height: 1.4;
		}

		.proposal__discounts-title {
			font-weight: 700;
		}

		.proposal__discounts-title.--blue {
			color: #5e87b3;
		}
	</style>

	<section class="investor-proposals">
		<div class="container">
			<div class="investor-proposals__header">
				<div>
					<h1 class="investor-proposals__title">
						{if $lang === 'ru'}
							Привлечение инвестиций, продажа бизнеса и коммерческой недвижимости в
							Украине
						{elseif $lang === 'uk'}
							Залучення інвестицій, продаж бізнесу та комерційної нерухомості в
							Україні
						{else}
							Services for Raising Capital & Sell a Business
						{/if}
					</h1>
					<div class="investor-proposals__description">


						<p>
							За более чем 10 лет работы на инвестиционном рынке Украины, мы
							разработали действенные инструменты по
							привлечению инвестиций, продаже бизнеса, франшиз и коммерческой
							недвижимости.
						</p>
						<p class="mt-2 font-bold">
							Выберите подходящий Вам формат сотрудничества:
						</p>

					</div>
				</div>
			</div>
			<div class="investor-proposals__form">
				<div class="investor-proposals__proposal proposal">
					<h2 class="proposal__title">Рекламный подход</h2>
					<p class="proposal__description">

						Подойдет для продажи малого или среднего бизнеса, объекта
						недвижимости, франшизы или стартапа, когда требуется
						донести информацию до широкого круга инвесторов.

					</p>
					<h3 class="proposal__features-title">Вы получите:</h3>
					<ul class="proposal__features-list">
						<li>Размещение на инвестиционном портале InVenture</li>
						<li>Размещение в журнале «Инвестиционный дайджест InVenture»</li>
						<li>Рекламный баннер на инвестиционном портале InVenture</li>
						<li>Продвижение в соцсетях (Facebook, LinkedIn, Telegram)</li>
						<li>Настройка контекстной рекламы Google Ads</li>
						<li>Размещение на специализированных интернет площадках и досках
							объявлений</li>
						<li>Размещение в отраслевом аналитическом исследовании</li>
						<li>Рассылка по крупнейшей базе инвесторов</li>
					</ul>
					{* advert-packages-min.svg
commission-payment-min.svg
discount-small-business-min.svg
free-military-min.svg *}
					<div class="proposal__discounts --grid">
						<div class="proposal__discounts-item">
							<img alt="Иконка" class="lazyimg proposal__discounts-icon"
								data-src="/images/advert-packages-min.svg" width="44"
								height="44" />
							<div>
								<h3 class="proposal__discounts-title --blue">Рекламные пакеты</h3>
								<p>от $350</p>
							</div>
						</div>
						<div class="proposal__discounts-item">
							<img alt="Иконка" class="lazyimg proposal__discounts-icon"
								data-src="/images/free-military-min.svg" width="44" height="44" />
							<div>
								<h3 class="proposal__discounts-title --blue">Бесплатно</h3>
								<p>для military tech проектов</p>
							</div>
						</div>
						<div class="proposal__discounts-item">
							<img alt="Иконка" class="lazyimg proposal__discounts-icon"
								data-src="/images/discount-small-business-min.svg" width="44"
								height="44" />
							<div>
								<h3 class="proposal__discounts-title --blue">Скидка 20%</h3>
								<p>для малого бизнеса (до $50 000)</p>
							</div>
						</div>
					</div>
					<button data-deal-id="adv" data-deal-name="Рекламное продвижение"
						data-remodal-target="approach"
						class="btn btn--blue btn--blue-text w-full add-inv-prop-btn">
						Получить условия
					</button>
				</div>
				<div class="investor-proposals__proposal proposal proposal--blue">
					<h2 class="proposal__title">Полное сопровождение</h2>
					<p class="proposal__description">

						Подойдет для продажи среднего и крупного бизнеса, привлечения
						инвестиций в масштабные инвестпроекты, когда
						требуется индивидуальный и комплексный подход по поиску инвестора.

					</p>
					<h3 class="proposal__features-title">Вы получите:</h3>
					<ul class="proposal__features-list proposal__features-list--light">

						<li>Профессиональную презентацию для работы с инвесторами</li>
						<li>Рекомендации по предпродажной подготовке бизнеса</li>
						<li>Прямые продажи и целенаправленный поиск инвесторов</li>
						<li>Индивидуальный комплекс продвижения инвестиционного предложения
						</li>
						<li>Консультационное сопровождение на всех этапах сделки</li>

						<li>Координация процесса Due Diligence</li>
						<li>Медиация в переговорных процессах</li>
					</ul>

					<button data-deal-id="ind" data-deal-name="Индивидуальный подход"
						data-remodal-target="approach"
						class="btn btn--white btn--blue-text w-full add-inv-prop-btn">

						Получить условия

					</button>
				</div>
			</div>

			<div class="investor-proposals__statistics statistics">
				<div class="statistics__block">
					<div class="statistics__number">300 000+</div>
					<div class="statistics__caption">Посетителей в месяц</div>
				</div>
				<div class="statistics__block">
					<div class="statistics__number">16 700+</div>
					<div class="statistics__caption">База email подписчиков</div>
				</div>
				<div class="statistics__block">
					<div class="statistics__number">23 000+</div>
					<div class="statistics__caption">Подписчиков в соцсетях</div>
				</div>
				<div class="statistics__block">
					<div class="statistics__number">45+</div>
					<div class="statistics__caption">Закрытых сделок</div>
				</div>
				<div class="statistics__block">
					<div class="statistics__number">$170+</div>
					<div class="statistics__caption">Стоимость закрытых сделок</div>
				</div>
			</div>

		</div>
	</section>


	{include 'components/reviews' category='add-inv-prop'}

	<div class="remodal callback" data-remodal-id="approach">
		<button data-remodal-action="close" class="remodal-close"></button>
		<div class="remodal__title">

			Заполните контактные данные и мы направим условия сотрудничества

		</div>
		<div class="callback__form">
			{form 'approach'}
		</div>
	</div>

	<div class="remodal callback" data-remodal-id="successModal">
		<button data-remodal-action="close" class="remodal-close"></button>
		<div class="text-left callback__form">
			<p>
				Мы отправили Вам на почту презентацию с описанием условий сотрудничества.
			</p>
			<p>
				Наш менеджер свяжется с Вами в течение одного рабочего дня.
			</p>
			<a id="openNowLink" target="_blank"
				href="https://drive.google.com/open?id=1sFGhi5u4wVwNH8-pJat4EX8ufHSBIXVS"
				class="w-full blue_but cell-but small-12" type="submit">Открыть
				призентацию</a>
			<button data-remodal-action="close" type='button'
				class="w-full blue_but cell-but  small-12 close__popup">Закрыть</button>
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