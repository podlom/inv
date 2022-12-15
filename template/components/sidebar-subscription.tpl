{* sidebarSubscription *}

{* <div class="newsletter-side">
    <div class="box-shadow"></div>
    <img src="/images/newsletter-icon.svg" alt="" class="newsletter-side__img">
    <div class="newsletter-side__heading">Хотите получать нашу ежемесячную рассылку?</div>
    <button class="newsletter-side__button open_popup">Подписаться</button>
</div> *}
{load_digests}

{assign var=digest value=$digests|@end}

<form action="/!Mail" class="subscription__form sidebar {if $digest}mb-4{else}pt-6 mt-0{/if}">
	{if $digest}
		<a href="{$digest->getUrl()}">
			<img
				data-src="/img/thumbup.240.320{if $digest->getImage()}{$digest->getImage()->getUrl()}{else}/images/newsletters/{$digest->getPubDate()->format('Y-n')}.png{/if}"
				data-src="{if $digest->getImage()}{$digest->getImage()->thumbup(120,170)->getUrl()}{else}/img/thumbup.120.170/images/newsletters/{$digest->getPubDate()->format('Y-n')}.png{/if}"
				alt="Обложка последнего выпуска журнала" class="lazyload subscription__img">
			{* <img src="{if $digest->getImage()}{$digest->getImage()->thumbup(120,170)->getUrl()}{else}/img/thumbup.120.170/images/newsletters/{$digest->getPubDate()->format('Y-n')}.png{/if}" data-src="{if $digest->getImage()}{$digest->getImage()->thumbup(120,170)->getUrl()}{else}/img/thumbup.120.170/images/newsletters/{$digest->getPubDate()->format('Y-n')}.png{/if}" alt="" class="lazyload subscription__img"> *}
			<a>
			{/if}
			<div class="subscription__tablet">
				<a href="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/analytics/digest" class="subscription__title">
					{if $lang == 'ru'}
						Инвестиционный дайджест InVenture
					{elseif $lang == 'uk'}
						Інвестиційний дайджест InVenture
					{else}
						Investment Digest InVenture
					{/if}
				</a>
			</div>
			<div class="subscription__row">
				<label>
					{if $lang === 'ru'}Имя{else if $lang === 'en'}First name{else}Імʼя{/if}
				</label>
				<input name="subscribe[firstname]" type="text" class="subscription__input" required>
			</div>
			<div class="subscription__row">
				<label>
					{if $lang === 'ru'}
						Фамилия
					{else if $lang === 'en'}
						Last name
					{else}
						Прізвище
					{/if}
				</label>
				<input name="subscribe[lastname]" type="text" class="subscription__input">
			</div>
			<div class="subscription__row">
				<label>
					{if $lang === 'ru'}
						Компания
					{else if $lang === 'en'}
						Company
					{else}
						Компанія
					{/if}
				</label>
				<input name="subscribe[company]" type="text" class="subscription__input">
			</div>
			<div class="subscription__row">
				<label>
					{if $lang === 'ru'}
						Должность
					{else if $lang === 'en'}
						Position
					{else}
						Посада
					{/if}
				</label>
				<input name="subscribe[job]" type="text" class="subscription__input">
			</div>
			<div class="subscription__row">
				<label>
					E-mail
				</label>
				<input name="subscribe[email]" type="email" class="subscription__input" required>
			</div>
			<div class="subscription__row">
				<label>
					{if $lang === "ru"}
						Телефон
					{else if $lang === 'en'}
						Mobile phone
					{else}
						Телефон
					{/if}
				</label>
				<div class="pageviev-form">
					<input name="subscribe[phone]" type="text" class="subscription__input" id="phone2"
						data-plugin-inputmask="inputmask_5de8d519" required>
					<span id="valid-msg2" class="hide">✓ Valid</span>
					<span id="error-msg2" class="hide"></span>
				</div>
			</div>
			<div class="subscription__check-block">
				<div class="subscription__check-item" onclick="changeCheckBox('ru')">
					<div id="check-box-ru" class="subscription__check-box subscription__check-box--active">
						<svg width="14" height="11" viewBox="0 0 14 11" fill="none" xmlns="http://www.w3.org/2000/svg">
							<path fill-rule="evenodd" clip-rule="evenodd"
								d="M12.933 1.13796C12.5104 0.677973 11.8087 0.677973 11.3861 1.13796L5.16652 7.89884L2.62286 5.10422C2.1843 4.65292 1.49855 4.65292 1.05999 5.12158C0.64535 5.59024 0.64535 6.33663 1.06796 6.81397L4.34521 10.3637L4.39306 10.4244C4.82364 10.9017 5.51737 10.9017 5.94795 10.4244L12.933 2.82167C13.3557 2.35301 13.3557 1.59794 12.933 1.13796Z"
								fill="white" />
						</svg>
					</div>
					<span class="subscription__check-label">
						{if $lang === 'ru'}Русский{else if $lang === 'en'}Russian{else}Російська{/if}
					</span>
					<input type="checkbox" value="ru" name="subscribe[lang][]" id="check-ru" checked="true" hidden>
				</div>
				<div onclick="changeCheckBox('en')" class="subscription__check-item">
					<div id="check-box-en" class="subscription__check-box">
						<svg width="14" height="11" viewBox="0 0 14 11" fill="none" xmlns="http://www.w3.org/2000/svg">
							<path fill-rule="evenodd" clip-rule="evenodd"
								d="M12.933 1.13796C12.5104 0.677973 11.8087 0.677973 11.3861 1.13796L5.16652 7.89884L2.62286 5.10422C2.1843 4.65292 1.49855 4.65292 1.05999 5.12158C0.64535 5.59024 0.64535 6.33663 1.06796 6.81397L4.34521 10.3637L4.39306 10.4244C4.82364 10.9017 5.51737 10.9017 5.94795 10.4244L12.933 2.82167C13.3557 2.35301 13.3557 1.59794 12.933 1.13796Z"
								fill="white" />
						</svg>
					</div>
					<span class="subscription__check-label">
						{if $lang === 'ru'}Английский{else if $lang === 'en'}English{else}Англійська{/if}
					</span>
					<input type="checkbox" value="en" name="subscribe[lang][]" id="check-en" hidden>
				</div>
			</div>
			<input name="subscribe[ga_utm]" hidden type="hidden">
			<button type="submit" class="subscription__button g-recaptcha components-sidebar-subscription"
				data-sitekey="6Le8bI8fAAAAAFT1lTrt6gL31hrhm8mFfc4nKmbX" data-callback="submitDigest">
				{if $lang === 'ru'}Подписаться{else if $lang === 'en'}Subscribe{else}Підписатися{/if}
			</button>
</form>