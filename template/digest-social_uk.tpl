{extends 'Page.view'}
{block 'breadcrumbs'}{/block}
{block 'page.class' append} digest-social{/block}
{block 'content.text' prepend}
	<section class="subscription">
		<div class="subscription__top">
			<div class="container grid-container">
				<div class="subscription__wrapper">
					<h1 class="subscription__title">
						Інвестиційний дайджест InVenture
					</h1>
					<p class="subscription__text--white subscription__text">
						Щомісячний інвестиційний журнал у сфері прямих інвестицій та венчурного капіталу.
					</p>
				</div>
			</div>
		</div>
		<div class="subscription__bottom container grid-container">
			<div class="subscription__info">
				<h2 class="subscription__subtitle">
					ОСНОВНІ ПЕРЕВАГИ
				</h2>
				<p class="subscription__text">Компактність та зручність для читача – «Все найважливіше у сфері інвестицій – за 1
					місяць – на 10 сторінках – за 5 хвилин» (для ділових людей, коли обмежений час на читання ділової преси).</p>
				<p class="subscription__text">Різноплановий контент: від новинної та аналітичної інформації до актуальних
					інвестиційних пропозицій.</p>
				<p class="subscription__text">Унікальна цільова аудиторія передплатників, база яких формується протягом понад 20
					років діяльності в галузі інвестиційного бізнесу (станом на 01.01.2019 – 13 700+ передплатників).</p>
				<p class="subscription__text">Активне поповнення бази передплатників - безкоштовна онлайн підписка.</p>
				<p class="subscription__text">Інвестиційний дайджест знайшов схвалення з боку великої кількості передплатників та
					сприяв укладенню безлічі інвестиційних угод.</p>
			</div>
			<form action="/!Mail" class="subscription__form">
				<img src="/images/magazine.jpg" alt="" class="subscription__img">
				<div class="subscription__tablet">
					<div class="subscription__title">
						Інвестиційний дайджест InVenture
					</div>
					<p class="subscription__text--white subscription__text">
						Щомісячний інвестиційний журнал у сфері прямих інвестицій та венчурного капіталу.
					</p>
				</div>
				<div class="subscription__row">
					<label>
						Ім'я
				</label>
				<input name="subscribe[firstname]" type="text" class="subscription__input" required>
			</div>
			<div class="subscription__row">
				<label>
					Прізвище
				</label>
				<input name="subscribe[lastname]" type="text" class="subscription__input" required>
			</div>
			<div class="subscription__row">
				<label>
					Компанія
				</label>
				<input name="subscribe[company]" type="text" class="subscription__input" required>
			</div>
			<div class="subscription__row">
				<label>
					Посада
				</label>
				<input name="subscribe[jobtitle]" type="text" class="subscription__input" required>
			</div>
			<div class="subscription__row">
				<label>
					E-mail
				</label>
				<input name="subscribe[email]" type="email" class="subscription__input" required>
			</div>
			<div class="subscription__row">
				<label>
					Номер телефону
				</label>
				{literal}
				<div class="input-aproach">
					<input name="subscribe[phone]" type="text" class="subscription__input" id="phone" required>
					<span id="valid-msg" class="hide">✓ Valid</span>
					<span id="error-msg" class="hide"></span>
				</div>
				{/literal}
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
						Російська
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
						Англійська
					</span>
					<input type="checkbox" value="en" name="subscribe[lang][]" id="check-en" hidden>
				</div>
			</div>
			<input name="subscribe[ga_utm]" hidden type="hidden">
			<button type="submit" class="subscription__button g-recaptcha digest-social"
				data-sitekey="6Le8bI8fAAAAAFT1lTrt6gL31hrhm8mFfc4nKmbX" data-callback="submitDigest">
				Підписатися
			</button>
		</form>


	</div>
</section>
<section class="archive mb-16">

	<div class="subscription__bottom container grid-container">
		{load_digests}
		{$month = [1=>'Січень','Лютий','Березень','Квітень','Травень','Червень','Липень','Серпень','Вересень','Жовтень','Листопад','Грудень']}
		{$first = reset($digests)}
		{if $first}
		<div class="w-full" style="position: relative;">
			<div class="digest">
				<div class="digest__header  flex-col mb-4">
					<h2 class="subscription__subtitle mb-2">
						Архів дайджесту
					</h2>
					<ul class="digest__years">
						{for $y=intval($now->format('Y')) to intval($first->getPubDate()->format('Y')) step -1}
						<li{if $now->format('Y')==$y} class='active' {/if}>{$y}</li>
						{/for}
					</ul>
				</div>
				<div class="digest__wrapper">
					<div class="digest__months">
						{foreach array_reverse($digests) as $digest}
						{if !$prev || $prev->getPubDate()->format('Y') != $digest->getPubDate()->format('Y')}
						{if $prev}</ul>{/if}
						<ul class="digest__month{if !$prev} active{/if}" id="digest__month-{$digest->getPubDate()->format('Y')}">
							{/if}
							<li><a target="_blank" href='{$digest->getUrl()}'><img
										src="{if $digest->getImage()}{$digest->getImage()->thumbup(120,170)->getUrl()}{else}/img/thumbup.120.170/images/newsletters/{$digest->getPubDate()->format('Y-n')}.png{/if}"
										alt="">{$month[intval($digest->getPubDate()->format('n'))]}</a></li>
							{$prev = $digest}
							{/foreach}
						</ul>
					</div>
				</div>
			</div>
		</div>
		{/if}

		<div id="hidden-digest" hidden>

		</div>
	</div>
</section>

{include 'components/reviews' category='digest-social' title="Відгуки про дайджест"}
{* <section class="digest__reviews">
    <div class="container grid-container">
        <h2 class="subscription__subtitle">
            Отзывы о дайджесте
        </h2>
        <div class="reviews__list first">
            <div class="glide">
                <div class="glide__arrows" data-glide-el="controls">
                    <button class="glide__arrow glide__arrow--left" data-glide-dir="<"><?xml version="1.0" encoding="UTF-8"?>
                        <svg enable-background="new 0 0 492 492" version="1.1" viewBox="0 0 492 492" xml:space="preserve" xmlns="http://www.w3.org/2000/svg">
                            <path fill="fff" d="m198.61 246.1 184.06-184.06c5.068-5.056 7.856-11.816 7.856-19.024 0-7.212-2.788-13.968-7.856-19.032l-16.128-16.12c-5.06-5.072-11.824-7.864-19.032-7.864s-13.964 2.792-19.028 7.864l-219.15 219.14c-5.084 5.08-7.868 11.868-7.848 19.084-0.02 7.248 2.76 14.028 7.848 19.112l218.94 218.93c5.064 5.072 11.82 7.864 19.032 7.864 7.208 0 13.964-2.792 19.032-7.864l16.124-16.12c10.492-10.492 10.492-27.572 0-38.06l-183.85-183.85z"/>
                        </svg>
                    </button>
                    <button class="glide__arrow glide__arrow--right" data-glide-dir=">">
                        <svg style="transform:rotate(180deg);" enable-background="new 0 0 492 492" version="1.1" viewBox="0 0 492 492" xml:space="preserve" xmlns="http://www.w3.org/2000/svg">
                            <path fill="fff" d="m198.61 246.1 184.06-184.06c5.068-5.056 7.856-11.816 7.856-19.024 0-7.212-2.788-13.968-7.856-19.032l-16.128-16.12c-5.06-5.072-11.824-7.864-19.032-7.864s-13.964 2.792-19.028 7.864l-219.15 219.14c-5.084 5.08-7.868 11.868-7.848 19.084-0.02 7.248 2.76 14.028 7.848 19.112l218.94 218.93c5.064 5.072 11.82 7.864 19.032 7.864 7.208 0 13.964-2.792 19.032-7.864l16.124-16.12c10.492-10.492 10.492-27.572 0-38.06l-183.85-183.85z"/>
                        </svg>
                    </button>
                </div>
                <div class="glide__track" data-glide-el="track">
                    <ul class="glide__slides">
                    <!-- { @ts -->
                    {rlent '/review' 20 var='review' analytics=0 category='digest-social'}
                    <li class="glide__slide">
                        <div class="reviews__list-item">
                            <div class="reviews__text-block">
                                <div class="reviews__author-info">
                                    <img src="{$review->getImageUrl()}" alt="" class="reviews__photo">
                                    <div>
                                        <p class="reviews__author-name">
                                            {$review->getFullName()}
                                            <br>
                                            <span>{$review->getCompany()}, {$review->getJob()}</span>
                                        </p>
                                        <div class="reviews__block-sm">
                                            {if $review->getFacebookUrl()}
                                                <a target="_blank" class="reviews__sm-link" draggable="true" data-href="{$review->getFacebookUrl()}" href="{$review->getFacebookUrl()}">
                                                    <img src="/images/icon/fb.svg" alt="" class="reviews__sm-icon">
                                                </a>
                                            {/if}
                                            {if $review->getLinkedinUrl()}
                                            <a target="_blank" class="reviews__sm-link" draggable="true" data-href="{$review->getLinkedinUrl()}" href="{$review->getLinkedinUrl()}">
                                                <img src="/images/icon/in.svg" alt="" class="reviews__sm-icon">
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
	    </div>
	</section> *}


{/block}