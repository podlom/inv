{extends 'Page.view'}
{block 'breadcrumbs'}{/block}
{block 'page.class' append} add-inv-prop{/block}
{block 'content.text'}
	<style>
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
						Services for Raising Capital & Sell a Business

					</h1>
					<div class="investor-proposals__description">

						<p>
							For more than 10 years of work in the investment market of Ukraine,
							we have developed effective tools for
							investment seekers and business sellers.
						</p>
						<p>
							Choose the format of cooperation that suits for you to speed up sell
							a business or raise a capital.
						</p>

					</div>
				</div>
			</div>
			<div class="investor-proposals__form">
				<div class="investor-proposals__proposal proposal">
					<h2 class="proposal__title">Investment advertising and promotion</h2>
					<p class="proposal__description">

						Suitable for small or medium businesses, real estate or start-ups when
						it is required to bring information to
						a large number of investors

					</p>
					<h3 class="proposal__features-title">You will get:</h3>
					<ul class="proposal__features-list">
						<li>
							Placing an offer on the largest Investment portal InVenture
							<span> - 150 000+ visitors per month </span>
						</li>

						<li>
							Placing an offer in the monthly magazine “Investment Digest
							InVenture”
							<span> - 13 700+ subscribers </span>
						</li>

						<li>
							Weekly newsletter through InVenture’s investors a database
							<span> - 3200+ investors (Ukraine, CIS, EU, US, Asia) </span>
						</li>

						<li>
							Promotion of the offer in own investment communities Facebook,
							LinkedIn, Telegram
							<span> (15 000+ subscribers) </span>
						</li>

						<li>
							Placing an offer manually on specialized websites and investment
							advertising boards
							<span> - 5 sites </span>
						</li>


						<li>
							Placing an advertising banner on the Investment portal InVenture
							<span> (150,000+ target audience hits per month) </span>
						</li>

					</ul>

					<div class="proposal__discounts-divider"></div>
					<div class="proposal__discounts --grid">
						<div class="proposal__discounts-item">
							<img alt="Icon" class="lazyimg proposal__discounts-icon"
								data-src="/images/advert-packages-min.svg" width="44"
								height="44" />
							<div>
								<h3 class="proposal__discounts-title --blue">
									Advertising packages
								</h3>
								<p>from $350</p>
							</div>
						</div>
						<div class="proposal__discounts-item">
							<img alt="Icon" class="lazyimg proposal__discounts-icon"
								data-src="/images/free-military-min.svg" width="44" height="44" />
							<div>
								<h3 class="proposal__discounts-title --blue">For free</h3>
								<p>military tech projects</p>
							</div>
						</div>
						<div class="proposal__discounts-item">
							<img alt="Icon" class="lazyimg proposal__discounts-icon"
								data-src="/images/discount-small-business-min.svg" width="44"
								height="44" />
							<div>
								<h3 class="proposal__discounts-title --blue">20% discount</h3>
								<p>for small businesses <small>(up to $50,000)</small></p>
							</div>
						</div>
					</div>

					<button data-deal-name="Рекламное продвижение"
						data-remodal-target="approach"
						class="btn btn--blue btn--blue-text w-full add-inv-prop-btn">

						Get terms

					</button>
				</div>
				<div class="investor-proposals__proposal proposal proposal--blue">
					<h2 class="proposal__title">Individual approach</h2>
					<p class="proposal__description">

						Suitable for medium and large businesses or large-scale investment
						projects where an individual and
						comprehensive approach to investor relations is required.

					</p>
					<h3 class="proposal__features-title">You will get:</h3>
					<ul class="proposal__features-list proposal__features-list--light">

						<li>Consulting support at all stages of the transaction </li>
						<li>Individual complex of promotion and advertising of the investment
							proposal</li>
						<li>Direct sales and individual promotion</li>
						<li>Development of a professional presentation for investors</li>

					</ul>


					<div class="proposal__discounts-divider --white"></div>
					<div class="proposal__discounts --double-rows">
						<div class="proposal__discounts-item --white">
							<img alt="Иконка" class="lazyimg proposal__discounts-icon"
								data-src="/images/commission-payment-min.svg" width="44"
								height="44" />
							<div>
								<h3 class="proposal__discounts-title --blue">Success fee</h3>
								<p>% + advance payment, starting from $5,000</p>
							</div>
						</div>
					</div>


					<button data-deal-name="Индивидуальный подход"
						data-remodal-target="approach"
						class="btn btn--white btn--blue-text w-full add-inv-prop-btn">
						Get terms
					</button>
				</div>
			</div>

			<div class="investor-proposals__statistics statistics">
				<div class="statistics__block">
					<div class="statistics__number">300 000+</div>
					<div class="statistics__caption">Visitors per month</div>
				</div>
				<div class="statistics__block">
					<div class="statistics__number">16 700+</div>
					<div class="statistics__caption">Subscribers</div>
				</div>
				<div class="statistics__block">
					<div class="statistics__number">35 000+</div>
					<div class="statistics__caption">Subscribers in social media</div>
				</div>
				<div class="statistics__block">
					<div class="statistics__number">45+</div>
					<div class="statistics__caption">Closed deals</div>
				</div>
				<div class="statistics__block">
					<div class="statistics__number">$300+ mln</div>
					<div class="statistics__caption">
						Amount of closed deals
					</div>
				</div>
			</div>

		</div>
	</section>


	{include 'components/reviews' category='add-inv-prop'}

	<div class="remodal callback" data-remodal-id="approach">
		<button data-remodal-action="close" class="remodal-close"></button>
		<div class="remodal__title">

			Please fill in your contact details and we will send the terms of
			cooperation

		</div>
		<div class="callback__form">
			{form 'approach'}
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