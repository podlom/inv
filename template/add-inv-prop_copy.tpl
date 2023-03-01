{extends 'Page.view'}
{block 'breadcrumbs'}{/block}
{block 'page.class' append} add-inv-prop{/block}
{block 'content.text'}
	<style>
		.tablet_buttons {
			display: none;
		}
	</style>
	<div class="section__heading">
		<p class="section__text">
			Основываясь на многолетнем и успешном опыте работы на инвестиционном рынке,
			InVenture разработала для соискателей
			инвестиций и продавцов бизнеса комплекс технологических инструментов,
			направленных на скорейшую продажу компаний
			и привлечение капитала в инвестиционные проекты.
		</p>
	</div>

	<div class="services__wrapper">
		<div class="services__blocks">
			<div class="services__block services__block--green">
				<div class="services__block-wrapper">
					<div class="services__heading">
						Реклама и продвижение
					</div>
					<ul class="services__list">
						<li>Размещение на инвестиционном портале InVenture</li>
						<li>Размещение в журнале «Инвестиционный дайджест InVenture»</li>
						<li>Рекламный баннер на инвестиционном портале InVenture</li>
						<li>Продвижение в Facebook, LinkedIn, Telegram</li>
						<li>Размещение на специализированных интернет площадках и досках
							объявлений</li>
						<li>Рассылка по базе инвесторов</li>
					</ul>
					<button class="services__button open_popup"
						data-dealName="Реклама и продвижение" data-src="#dealName"
						data-action="updateInfo">Получить условия</button>
				</div>
			</div>

			<div class="services__block services__block--blue">
				<div class="services__heading">
					Индивидуальный подход
				</div>
				<ul class="services__list">
					<li>Индивидуальный комплекс продвижения и рекламы инвестиционного
						предложения</li>
					<li>Разработка профессиональной презентации для работы с инвесторами
					</li>
					<li>Консультационное сопровождение на всех этапах сделки</li>
					<li>Прямые продажи</li>
				</ul>
				<button class="services__button open_popup"
					data-dealName="Индивидуальный подход" data-src="#dealName"
					data-action="updateInfo">Получить условия</button>

			</div>
			{* <div class="services__block services__block--blue services__block--advert" > 
            <div class="services__heading">Размещение на доске объявлений InVenture</div>  
            <a href='/bulletin/add' class="services__button">Разместить </a>
        </div> *}
		</div>
		<div class="services__achives">
			<div class="services__achive">
				<div class="services__achive-num">200 000+</div>
				<div class="services__achive-title">посетителей в месяц</div>
			</div>
			<div class="services__achive">
				<div class="services__achive-num">16 700+</div>
				<div class="services__achive-title">база email подписчиков</div>
			</div>
			<div class="services__achive">
				<div class="services__achive-num">15 000+</div>
				<div class="services__achive-title">подписчиков в соцсетях</div>
			</div>
			<div class="services__achive">
				<div class="services__achive-num">3 500+</div>
				<div class="services__achive-title">база инвесторов (Украина, СНГ, ЕС,
					США, Азия)</div>
			</div>
			<div class="services__achive">
				<div class="services__achive-num">500+</div>
				<div class="services__achive-title">клиентов нашли выход на инвесторов
				</div>
			</div>
			<div class="services__achive">
				<div class="services__achive-num">45+</div>
				<div class="services__achive-title">закрытых сделок</div>
			</div>
			<div class="services__achive">
				<div class="services__achive-num">$300+ млн</div>
				<div class="services__achive-title">стоимость закрытых сделок</div>
			</div>
		</div>
	</div>
	{* <p class="add-inv-prop__heading">InVenture, основываясь на многолетнем и успешном опыте работы на инвестиционном
    рынке, разработала для соискателей инвестиций и продавцов бизнеса комплекс технологических инструментов,
    направленных на скорейшую продажу компаний и привлечение капитала в инвестиционные проекты.</p>
<div class="grid-x price-table">
    <div class="cell large-4 price text-center ">
        <div class="price__header">
            <div class="price__title">Доска объявлений</div>
            <div class="price__subtitle">для малого бизнеса</div>
        </div>
        <ul class="price__advantages">
            <li><i class="fa fa-check-circle"></i> Размещение на доске объявлений InVenture</li>
        </ul>
        <div class="price__button-wrapper grid-x">
            <a href='/bulletin/add'
                class="blue_but cell-but price__button  small-12  medium-4 large-12 medium-offset-4 large-offset-0">Разместить</a>
        </div>
    </div>
    <div class="cell large-4 price text-center ">
        <div class="price__header">
            <div class="price__title">Реклама и продвижение</div>
            <div class="price__subtitle">для малого и среднего бизнеса</div>
        </div>
        <ul class="price__advantages">
            <li><i class="fa fa-check-circle"></i>
                <p>Размещение на инвестиционном портале InVenture <span> – 150 000+ посетителей в месяц</span></p>
            </li>
            <li><i class="fa fa-check-circle"></i>
                <p> Размещение в журнале «Инвестиционный дайджест InVenture» <span> с рассылкой по базе 13 700+
                        подписчиков</span></p>
            </li>
            <li><i class="fa fa-check-circle"></i>
                <p> Рассылка по базе инвесторов <span> - 3200+ инвесторов (Украина, СНГ, ЕС, США, Азия)</span></p>
            </li>
            <li><i class="fa fa-check-circle"></i>
                <p> Продвижение в Facebook, LinkedIn, Telegram <span>- 15 000+ подписчиков</span></p>
            </li>
            <li><i class="fa fa-check-circle"></i>
                <p> Размещение на специализированных интернет площадках и досках объявлений <span> – 5 сайтов</span></p>
            </li>
            <li><i class="fa fa-check-circle"></i>
                <p> Рекламный баннер на инвестиционном портале InVenture <span> – отображение на всех страницах портала
                    </span></p>
            </li>
        </ul>
        <div class="price__button-wrapper grid-x">
            <button
                class="blue_but cell-but price__button  small-12 medium-4 large-12 medium-offset-4 large-offset-0 open_popup"
                data-dealName="Реклама и продвижение" data-src="#dealName" data-action="updateInfo">Подробнее</button>
        </div>
    </div>
    <div class="cell large-4 price text-center ">
        <div class="price__header">
            <div class="price__title">Индивидуальный подход</div>
            <div class="price__subtitle">для среднего и крупного бизнеса</div>
        </div>
        <ul class="price__advantages">
            <li><i class="fa fa-check-circle"></i>
                <p>Индивидуальный комплекс продвижения и рекламы инвестиционного предложения <span> (усиленная рекламная
                        кампания, завуалированное предложение)
                    </span></p>
            </li>
            <li><i class="fa fa-check-circle"></i>
                <p>Разработка профессиональной презентации для работы с инвесторами <span>(инвестиционный меморандум /
                        тизер) </span></p>
            </li>
            <li><i class="fa fa-check-circle"></i>
                <p> Прямые продажи <span> (анализ целевой аудитории и выход на потенциальных инвесторов, проведение
                        профессиональной презентации, организация поездок для показа активов, совместные встречи с
                        инвесторами и медиация переговорного процесса) </span></p>
            </li>
            <li><i class="fa fa-check-circle"></i>
                <p>Консультационное сопровождение на всех этапах сделки <span>(предпродажная подготовка, оценка активов,
                        медиация в переговорных процессах, юридическая схема сделки и др.)</span> </p>
            </li>
        </ul>
        <div class="price__button-wrapper grid-x">
            <button
                class="blue_but cell-but price__button  small-12  medium-4 large-12 medium-offset-4 large-offset-0 open_popup"
                data-dealName="Индивидуальный подход" data-src="#dealName" data-action="updateInfo">Подробнее</button>
        </div>
    </div>
</div>

*}

	<div class="reviews__list first">
		<div class="reviews__heading">
			<h2 class="reviews__title">Отзывы клиентов InVenture</h2>
		</div>
		<div class="glide">
			<div class="glide__arrows" data-glide-el="controls">
				<button class="glide__arrow glide__arrow--left" data-glide-dir="<">
					<?xml version="1.0" encoding="UTF-8"?>
					<svg enable-background="new 0 0 492 492" version="1.1"
						viewBox="0 0 492 492" xml:space="preserve"
						xmlns="http://www.w3.org/2000/svg">
						<path fill="fff"
							d="m198.61 246.1 184.06-184.06c5.068-5.056 7.856-11.816 7.856-19.024 0-7.212-2.788-13.968-7.856-19.032l-16.128-16.12c-5.06-5.072-11.824-7.864-19.032-7.864s-13.964 2.792-19.028 7.864l-219.15 219.14c-5.084 5.08-7.868 11.868-7.848 19.084-0.02 7.248 2.76 14.028 7.848 19.112l218.94 218.93c5.064 5.072 11.82 7.864 19.032 7.864 7.208 0 13.964-2.792 19.032-7.864l16.124-16.12c10.492-10.492 10.492-27.572 0-38.06l-183.85-183.85z" />
					</svg>
				</button>
				<button class="glide__arrow glide__arrow--right" data-glide-dir=">">
					<svg style="transform:rotate(180deg);"
						enable-background="new 0 0 492 492" version="1.1"
						viewBox="0 0 492 492" xml:space="preserve"
						xmlns="http://www.w3.org/2000/svg">
						<path fill="fff"
							d="m198.61 246.1 184.06-184.06c5.068-5.056 7.856-11.816 7.856-19.024 0-7.212-2.788-13.968-7.856-19.032l-16.128-16.12c-5.06-5.072-11.824-7.864-19.032-7.864s-13.964 2.792-19.028 7.864l-219.15 219.14c-5.084 5.08-7.868 11.868-7.848 19.084-0.02 7.248 2.76 14.028 7.848 19.112l218.94 218.93c5.064 5.072 11.82 7.864 19.032 7.864 7.208 0 13.964-2.792 19.032-7.864l16.124-16.12c10.492-10.492 10.492-27.572 0-38.06l-183.85-183.85z" />
					</svg>
				</button>
			</div>
			<div class="glide__track" data-glide-el="track">
				<ul class="glide__slides">
					<!-- { @ts -->
					{rlent '/review' 20 var='review' analytics=0 category='add-inv-prop'}
					<li class="glide__slide">
						{* <div>
                            <span class="published">{$review->getPublished()->format('d.m.y')}</span>
                            {$review->getTitle()|truncate:100:"  ..."}
                        </div> *}

						<div class="reviews__list-item">

							<div class="reviews__text-block">
								<div class="reviews__author-info">
									<img src="{$review->getImageUrl()}" alt=""
										class="reviews__photo">
									<div>
										<p class="reviews__author-name">
											{$review->getFullName()}
											<br>
											<span>{$review->getCompany()}, {$review->getJob()}</span>
										</p>
										<div class="reviews__block-sm">
											{if $review->getFacebookUrl()}
												<a target="_blank" class="reviews__sm-link" draggable="true"
													data-href="{$review->getFacebookUrl()}"
													href="{$review->getFacebookUrl()}">
													<img src="/images/icon/fb.svg" alt=""
														class="reviews__sm-icon">
												</a>
											{/if}
											{if $review->getLinkedinUrl()}
												<a target="_blank" class="reviews__sm-link" draggable="true"
													data-href="{$review->getLinkedinUrl()}"
													href="{$review->getLinkedinUrl()}">
													<img src="/images/icon/in.svg" alt=""
														class="reviews__sm-icon">
												</a>
											{/if}
										</div>
									</div>
								</div>

								<img src="/images/quotes.svg" alt="" class="reviews__block-icon">
								<p class="reviews__text">
									{$review->getRtext()}
								</p>

							</div>
						</div>
					</li>
					{/rlent}
					<!-- } -->

				</ul>
			</div>

			<div class="glide__bullets" data-glide-el="controls[nav]">

				{assign "count" "0"}
				{rlent '/review' 20 var='review' analytics=0 category='add-inv-prop'}
				<button class="glide__bullet" data-glide-dir="={$count++}"></button>
				{/rlent}
			</div>


		</div>
	</div>
	</div>


	<div class="dark_bg"></div>
	<div class="my_popup">
		<div class="my_popup__wrapper">
			<h5>Заполните пожалуйста Ваши контактные данные и мы направим условия
				сотрудничества</h5>
			<i class="fa fa-close"></i>
			{form 'approach'}
		</div>
	</div>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Glide.js/3.4.1/glide.min.js">
	</script>
	<script>
		var config = {
			type: "carousel",
			perView: 2,
			gap: 0,
			breakpoints: {
				1340: {
					perView: 2,
					gap: 0
				},

				1024: {
					perView: 1,
					gap: 0
				}
			}
		};

		if (document.querySelectorAll('.glide__slide').length) {
			new Glide(".glide", config).mount();
		} else {
			document.querySelector('.reviews__list').style.display = 'none'
		}
	</script>
{/block}