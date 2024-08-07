{extends 'Page.view'}
{block 'breadcrumbs'}{/block}
{block 'page.class' append} contacts{/block}
{block 'content.text'}

<section class="contacts pb-0">
	<div class="container">
		<div class="contacts__header">
			<h1 class="section__title">
				{if $lang === 'en'}Contact information{elseif $lang == 'uk'}Контактна інформація{else}Контактная информация{/if}
			</h1>
			{* <p>Расскажите нам о своих предложениях, комментариях или жалобах</p> *}
		</div>
		<div class="contacts__links">
				
			<div class="contacts__link link">
				<a href="mailto:pr@inventure.ua">
					<h2 class="link__title">
						{if $lang === 'en'}
							Advertising of investment proposals
						{elseif $lang == 'uk'}
							З питань розміщення інвестиційних пропозицій
						{else}
							По вопросам размещения инвестиционных предложений
						{/if}
					</h2>
					<p class="link__description">
						{if $lang === 'en'}
							Sale of business and commercial real estate, investment projects and startups, franchises and other assets.
						{elseif $lang == 'uk'}
							Продаж бізнесу та комерційної нерухомості, інвестиційні проекти та стартапи, франшизи та інші активи.
						{else}
							Продажа бизнеса и коммерческой недвижимости, инвестиционные проекты и стартапы, франшизы и другие активы.
						{/if}
					</p>
				</a>
				<a href="mailto:info@inventure.ua" class="link__accent">info@inventure.ua</a>
			</div>

			<a href="mailto:pr@inventure.ua" class="contacts__link link">
				<h2 class="link__title">
					{if $lang === 'en'}
						Media advertising
					{elseif $lang == 'uk'}
						З питань розміщення реклами
					{else}
						По вопросам рекламы
					{/if}
				</h2>
				<p class="link__description">
					{if $lang === 'en'}
						Publication of PR materials, native advertising, banner advertising, advertising on social networks and messengers, placement of links to third-party sites, etc.
					{elseif $lang == 'uk'}
						Розміщення PR матеріалів, нативної реклами, банерної реклами, реклами в соціальних мережах та месенджерах, розміщення посилань на сторонні сайти та інше.
					{else}
						Размещение PR материалов, нативной рекламы, баннерной рекламы, рекламы в социальных сетях и мессенджерах, размещение ссылок на сторонние сайты и др.
					{/if}
				</p>
				<div class="link__accent">pr@inventure.ua</div>
			</a>
			<a href="mailto:pr@inventure.ua" class="contacts__link link">
				<h2 class="link__title">
					{if $lang === 'en'}
						Media cooperation
					{elseif $lang == 'uk'}
						З питань медіа співробітництва
					{else}
						По вопросам медиа сотрудничества
					{/if}
				</h2>
				<p class="link__description">
					{if $lang === 'en'}
						We publish high quality investment news and press releases on a free base, as well as author's columns on investment topics; we also cooperate with business events.
					{elseif $lang == 'uk'}
						Ми безкоштовно публікуємо новини інвестиційної тематики на основі якісних прес-релізів, а також авторські колонки на тему інвестицій; співробітництво по бізнес заходам.
					{else}
						Мы бесплатно публикуем новости инвестиционной тематики на основе качественных пресс-релизов, а также авторские колонки на тему инвестиций; сотрудничаем по бизнес мероприятиям.
					{/if}
				</p>
				<div class="link__accent">pr@inventure.ua</div>
			</a>
			
			<a rel="nofollow" href="https://inventure.ua{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{else}/{/if}" target="_blank" class="contacts__link link link--center">
				<svg width="36" height="36" viewBox="0 0 36 36" fill="none" xmlns="http://www.w3.org/2000/svg">
				<circle cx="18" cy="18" r="18" fill="#5187B0" fill-opacity="0.1"/>
				<path d="M15.6647 13.5333C13.5433 15.7281 14.0062 19.3705 16.4362 20.9841C16.5163 21.0373 16.6228 21.0267 16.6916 20.9595C17.2031 20.4597 17.6359 19.9755 18.0149 19.3597C18.0728 19.2655 18.0368 19.1433 17.9395 19.0906C17.5689 18.8898 17.2001 18.5133 16.9924 18.1155L16.9922 18.1157C16.7435 17.6204 16.6588 17.0653 16.7905 16.4919C16.7906 16.492 16.7907 16.492 16.7909 16.492C16.9424 15.758 17.7304 15.0751 18.3323 14.4436C18.331 14.4432 18.3298 14.4428 18.3286 14.4423L20.5836 12.1407C21.4823 11.2235 22.9605 11.216 23.8685 12.124C24.7857 13.0226 24.8008 14.5083 23.9022 15.4254L22.5363 16.8301C22.4731 16.8951 22.4526 16.9899 22.4821 17.0756C22.7966 17.9877 22.874 19.2736 22.6632 20.2452C22.6573 20.2724 22.6909 20.2902 22.7103 20.2703L25.6174 17.3032C27.4746 15.4077 27.4588 12.3217 25.5824 10.4454C23.6676 8.53048 20.5502 8.54641 18.655 10.4807L15.6763 13.5208C15.6724 13.525 15.6687 13.5292 15.6647 13.5333Z" fill="#5187B0"/>
				<path d="M21.1009 21.4015C21.1008 21.4016 21.1008 21.4017 21.1007 21.4018C21.1026 21.401 21.1043 21.4003 21.1062 21.3995C21.6995 20.3146 21.8163 19.0703 21.5382 17.8574L21.5369 17.8587L21.5356 17.8581C21.2715 16.7778 20.5471 15.7051 19.5632 15.0446C19.4786 14.9878 19.3434 14.9944 19.2641 15.0585C18.7658 15.4614 18.2779 15.9782 17.9561 16.6376C17.9055 16.7411 17.9434 16.8655 18.043 16.9233C18.4165 17.1402 18.7539 17.4577 18.9798 17.8793L18.9801 17.879C19.1562 18.1768 19.3296 18.7418 19.2173 19.349C19.2172 19.349 19.2171 19.349 19.217 19.349C19.1122 20.1539 18.2994 20.8922 17.6532 21.5575L17.6535 21.5578C17.1616 22.0608 15.9113 23.3355 15.4106 23.847C14.512 24.7642 13.0263 24.7793 12.1091 23.8807C11.192 22.982 11.1768 21.4964 12.0754 20.5792L13.4454 19.1704C13.5075 19.1065 13.5286 19.0137 13.501 18.929C13.1968 17.9957 13.1135 16.7387 13.3055 15.7683C13.3108 15.7412 13.2775 15.7239 13.2582 15.7436L10.3948 18.6661C8.51869 20.581 8.53459 23.6987 10.4302 25.5943C12.345 27.4704 15.4466 27.4387 17.3227 25.5239C17.9745 24.7948 20.7644 22.2117 21.1009 21.4015Z" fill="#5187B0"/>
				</svg>


				<h2 class="link__title">
					{if $lang === 'en'}
						Corporate website of the investment company InVenture
					{elseif $lang == 'uk'}
						Корпоративний сайт інвестиційної компанії InVenture
					{else}
						Корпоративный сайт инвестиционной компании InVenture
					{/if}
				</h2>
				<div class="link__accent">www.inventure.ua</div>
			</a>
			
			<a href="{if $lang === 'en'}
			https://inventure.com.ua/en{else}
			https://inventure.com.ua{/if}" class="contacts__link link link--center">
				<svg width="36" height="36" viewBox="0 0 36 36" fill="none" xmlns="http://www.w3.org/2000/svg">
				<circle cx="18" cy="18" r="18" fill="#5187B0" fill-opacity="0.1"/>
				<path d="M15.6647 13.5333C13.5433 15.7281 14.0062 19.3705 16.4362 20.9841C16.5163 21.0373 16.6228 21.0267 16.6916 20.9595C17.2031 20.4597 17.6359 19.9755 18.0149 19.3597C18.0728 19.2655 18.0368 19.1433 17.9395 19.0906C17.5689 18.8898 17.2001 18.5133 16.9924 18.1155L16.9922 18.1157C16.7435 17.6204 16.6588 17.0653 16.7905 16.4919C16.7906 16.492 16.7907 16.492 16.7909 16.492C16.9424 15.758 17.7304 15.0751 18.3323 14.4436C18.331 14.4432 18.3298 14.4428 18.3286 14.4423L20.5836 12.1407C21.4823 11.2235 22.9605 11.216 23.8685 12.124C24.7857 13.0226 24.8008 14.5083 23.9022 15.4254L22.5363 16.8301C22.4731 16.8951 22.4526 16.9899 22.4821 17.0756C22.7966 17.9877 22.874 19.2736 22.6632 20.2452C22.6573 20.2724 22.6909 20.2902 22.7103 20.2703L25.6174 17.3032C27.4746 15.4077 27.4588 12.3217 25.5824 10.4454C23.6676 8.53048 20.5502 8.54641 18.655 10.4807L15.6763 13.5208C15.6724 13.525 15.6687 13.5292 15.6647 13.5333Z" fill="#5187B0"/>
				<path d="M21.1009 21.4015C21.1008 21.4016 21.1008 21.4017 21.1007 21.4018C21.1026 21.401 21.1043 21.4003 21.1062 21.3995C21.6995 20.3146 21.8163 19.0703 21.5382 17.8574L21.5369 17.8587L21.5356 17.8581C21.2715 16.7778 20.5471 15.7051 19.5632 15.0446C19.4786 14.9878 19.3434 14.9944 19.2641 15.0585C18.7658 15.4614 18.2779 15.9782 17.9561 16.6376C17.9055 16.7411 17.9434 16.8655 18.043 16.9233C18.4165 17.1402 18.7539 17.4577 18.9798 17.8793L18.9801 17.879C19.1562 18.1768 19.3296 18.7418 19.2173 19.349C19.2172 19.349 19.2171 19.349 19.217 19.349C19.1122 20.1539 18.2994 20.8922 17.6532 21.5575L17.6535 21.5578C17.1616 22.0608 15.9113 23.3355 15.4106 23.847C14.512 24.7642 13.0263 24.7793 12.1091 23.8807C11.192 22.982 11.1768 21.4964 12.0754 20.5792L13.4454 19.1704C13.5075 19.1065 13.5286 19.0137 13.501 18.929C13.1968 17.9957 13.1135 16.7387 13.3055 15.7683C13.3108 15.7412 13.2775 15.7239 13.2582 15.7436L10.3948 18.6661C8.51869 20.581 8.53459 23.6987 10.4302 25.5943C12.345 27.4704 15.4466 27.4387 17.3227 25.5239C17.9745 24.7948 20.7644 22.2117 21.1009 21.4015Z" fill="#5187B0"/>
				</svg>

				<h2 class="link__title">
					{if $lang === 'en'}
						InVenture Investment Portal
					{elseif $lang == 'uk'}
						Інвестиційний портал InVenture
					{else}
						Инвестиционный портал InVenture
					{/if}
				</h2>
				<div class="link__accent">www.inventure.com.ua</div>
			</a>
			<a href="tel:+380977727292" class="contacts__link link link--center">
				<svg width="36" height="36" viewBox="0 0 36 36" fill="none" xmlns="http://www.w3.org/2000/svg">
				<circle cx="18" cy="18" r="18" fill="#5187B0" fill-opacity="0.1"/>
				<path d="M25.8921 17.1602H23.8271H23.5509C22.9404 17.1602 22.4453 17.6553 22.4453 18.2678V18.3878C22.4453 19.0009 22.9404 19.4963 23.5517 19.4963H25.6188H25.8921C26.5037 19.4963 27.0003 18.9989 27.0003 18.3878L26.9991 18.2663C27.0003 17.6553 26.5037 17.1602 25.8921 17.1602Z" fill="#5187B0"/>
				<path d="M25.8913 14.3973H25.4036V9.03878C25.4036 8.26863 24.7736 7.63867 24.0032 7.63867H14.7641C13.9939 7.63867 13.364 8.26893 13.364 9.03878V12.8833C11.5004 13.9368 9.57828 15.0373 9.57414 15.04C8.53071 15.4694 7.00195 16.855 7.00195 20.127C7.00195 20.4192 7.02118 20.6889 7.04809 20.9495C7.05667 21.0258 7.06613 21.0991 7.07648 21.1728C7.1034 21.3641 7.13711 21.5472 7.17734 21.7211C7.19183 21.7832 7.20307 21.848 7.21874 21.9074C7.27287 22.1085 7.33557 22.2972 7.40596 22.4767C7.44145 22.5658 7.47989 22.6468 7.51864 22.7302C7.56004 22.818 7.60175 22.9044 7.6464 22.9851C7.69816 23.0824 7.74992 23.1762 7.8067 23.2652C7.82031 23.2859 7.8351 23.3049 7.849 23.3259C9.19646 25.3627 11.6823 25.3719 11.6823 25.3719H13.364V26.9628C13.364 27.732 13.9939 28.362 14.7641 28.362H24.0029C24.7733 28.362 25.4033 27.7317 25.4033 26.9628V25.0223H25.6168V25.0211H25.8892C26.5017 25.0211 26.9983 24.5257 26.9971 23.9132L26.9983 23.7926C26.9971 23.1809 26.5017 22.687 25.8901 22.687H25.6168H23.8248H23.5486C22.937 22.687 22.4431 23.1821 22.4431 23.7934V23.9162C22.4431 24.526 22.9382 25.0232 23.5495 25.0232H24.4291V25.7726H14.3379V15.7196C14.8448 15.3981 15.3142 15.0888 15.5818 14.8814C16.9379 13.8327 18.225 12.9975 18.3992 12.24C18.626 11.2572 17.8716 10.4291 16.5628 11.1091C16.1506 11.3232 15.3044 11.7926 14.3379 12.3353V9.85743L24.4291 9.85891V14.3967H23.8248V14.3979H23.5501C22.9382 14.3979 22.4416 14.893 22.4416 15.5061V15.6261C22.4416 16.239 22.9382 16.7329 23.5486 16.7329H23.8234H25.6153H25.8907C26.5017 16.7329 26.9971 16.2378 26.9971 15.6261V15.5028C26.9983 14.8939 26.5032 14.3973 25.8913 14.3973ZM19.3823 26.2642C19.7703 26.2642 20.0832 26.5774 20.0832 26.9645C20.0832 27.3526 19.77 27.6646 19.3823 27.6646C18.9957 27.6646 18.6834 27.3517 18.6834 26.9645C18.684 26.5786 18.9972 26.2642 19.3823 26.2642ZM20.862 8.98673H17.9056C17.8127 8.98673 17.7358 8.91131 17.7358 8.81815C17.7358 8.7235 17.8127 8.64809 17.9056 8.64809H20.862C20.9548 8.64809 21.0305 8.72321 21.0305 8.81815C21.0305 8.91101 20.9548 8.98673 20.862 8.98673Z" fill="#5187B0"/>
				<path d="M25.8935 19.9219H25.6203H23.5523C22.9419 19.9219 22.4453 20.4184 22.4453 21.0298V21.151C22.4453 21.763 22.9407 22.258 23.5523 22.258H23.8271H25.6191H25.8929C26.5055 22.258 26.9994 21.763 27.0008 21.151V21.0298C27.0006 20.4184 26.5066 19.9219 25.8935 19.9219Z" fill="#5187B0"/>
				</svg>

				<h2 class="link__title">
					{if $lang === 'en'}
						Mobile phone
					{elseif $lang == 'uk'}
						Номер мобільного
					{else}
						Мобильный телефон
					{/if}
				</h2>
				<div class="link__accent">+38 097 772 72 92</div>
			</a>
		</div>
  </div>

	<div class="container mt-16">
		<div class="contacts__header">
			<h2 class="section__title block">
				{if $lang === 'en'}Address{elseif $lang == 'uk'}Наша адреса{else}Наш адрес{/if}
			</h2>
			<p>
			{if $lang === 'en'}
				24 Starovokzalnaya St (3 floor, office InVenture)., Kiev, 03150, Ukraine
			{elseif $lang == 'uk'}
				01032, Україна, м. Київ, вул. Старовокзальна 24, 3-й поверх, офіс InVenture
			{else}
				01032, Украина, г. Киев, ул. Старовокзальная 24, 3 этаж, офис InVenture
			{/if}
			 
			</p>
		</div>
	</div>
	<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2540.833281423579!2d30.487435451266673!3d50.44420597937374!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x40d4ce8cc3bc339b%3A0x302f3b5c3a1cc3c2!2sStarovokzalna%20St%2C%2024%2C%20Kyiv%2C%20Ukraine%2C%2002000!5e0!3m2!1sen!2ses!4v1612766181685!5m2!1sen!2ses"  height="450" frameborder="0" style="width:100%; border:0;" allowfullscreen="" aria-hidden="false" tabindex="0"></iframe>
</section>

{* 01032, Украина, г. Киев, ул. Старовокзальная 24, 3 этаж, офис InVenture *}
{/block}