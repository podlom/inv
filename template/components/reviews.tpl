<section class="reviews">
	<div class="container">
		<h2 class="reviews__title">
			{if $title}
				{$title}
			{else}
				{if $lang === 'ru'}
					Вот что клиенты говорят о нас
				{else if $lang === 'en'}
					What Our Clients Say About Us
				{else}
					Що говорять про нас наші клієнти
				{/if}
			{/if}
		</h2>

		<div class="reviews__slider glide">
			<div class="glide__arrows" data-glide-el="controls">
				<div class="glide__arrow glide__arrow--left" data-glide-dir="<">
					<img src="/images/icons/left-arrow.svg" class="swiper-arrow" alt="" />
				</div>
				<div class="glide__arrow glide__arrow--right" data-glide-dir=">">
					<img src="/images/icons/right-arrow.svg" class="swiper-arrow" alt="" />
				</div>
			</div>
			<div class="glide__track" data-glide-el="track">
				<ul class="glide__slides">
					<!-- { @ts -->
					{rlent '/review' 20 var='review' analytics=0 category=$category }
					<li class="glide__slide">
						<div class="reviews__slide">
							<div class="reviews__header">
								<img src="/images/icons/quote1.svg" alt="Qoute icon" class="reviews__qoute" />
								{* <div class="reviews__logo">
                  <img src="{$review->getImageUrl()}" alt="{$review->getFullName()}" />
                </div> *}
								<img src="/images/icons/quote2.svg" alt="Qoute icon" class="reviews__qoute" />
							</div>
							<div class="reviews__text">
								<p>
									{$review->getRtext()}
								</p>
							</div>
							<div class="reviews__footer">
								<img src="{$review->getImageUrl()}" class="reviews__avatar" alt="" />
								<div class="reviews__name"> {$review->getFullName()}</div>
								<div class="reviews__position">
									{$review->getCompany()}, {$review->getJob()}
								</div>
								<div class="reviews__socials">
									{if $review->getFacebookUrl()}
										<a target="_blank" class="reviews__socials-link" draggable="true"
											data-href="{$review->getFacebookUrl()}" href="{$review->getFacebookUrl()}">
											<img src="/images/icons/fb-icon.svg" class="reviews__socials-icon" alt="" />
										</a>
									{/if}
									{if $review->getLinkedinUrl()}
										<a href="#" class="reviews__socials-link" draggable="true"
											data-href="{$review->getLinkedinUrl()}" href="{$review->getLinkedinUrl()}">
											<img src="/images/icons/in-icon.svg" class="reviews__socials-icon"
												alt="{$review->getFullName()}" />
										</a>
									{/if}
								</div>
							</div>
						</div>
					</li>
					{/rlent}
					<!-- } -->

				</ul>
			</div>

			<div class=" glide__bullets" data-glide-el="controls[nav]">
				{assign "count" "0"}
				{rlent '/review' 20 var='review' analytics=0 category=$category}
				<button class="glide__bullet" data-glide-dir="={$count}"></button>
				{assign "count" $count+1}
				{/rlent}
			</div>
		</div>
	</div>
</section>

{* 
<link rel="stylesheet" href="https://unpkg.com/swiper/css/swiper.min.css">
<script src="https://unpkg.com/swiper/js/swiper.min.js"></script> *}

<style>
	.glide__arrows {
		position: absolute;
		z-index: 1;
		width: 100%;
		top: 50%;
	}

	@media only screen and (max-width:1023px) {
		.glide__arrows {
			display: none;
		}
	}

	.glide__slide {
		padding: 20px;
	}

	.glide__arrow--left {
		left: -4em;
	}

	.glide__arrow--right {
		right: -4em;
	}

	.glide__arrow {
		min-width: 54px;
		min-height: 54px;
		display: flex;
		align-items: center;
		justify-content: center;
		border-radius: 50%;
	}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Glide.js/3.4.1/glide.min.js"></script>
<script>
	var config = {
		type: "carousel",
		perView: 1,
		gap: 20,
		focusAt: 'center',
	};

	new Glide(".glide", config).mount();
</script>

<div id="reviews-data"
	data-reviews='[{assign "reviewCount" 0}{rlent '/review' 20 var='review' analytics=0 category=$category}{if $reviewCount > 0},{/if}{"id":{$review->getId()},"fullName":"{$review->getFullName()|escape:'html'}","company":"{$review->getCompany()|escape:'html'}","job":"{$review->getJob()|escape:'html'}","text":"{$review->getRtext()|escape:'html'}","imageUrl":"{$review->getImageUrl()}","facebookUrl":"{$review->getFacebookUrl()}","linkedinUrl":"{$review->getLinkedinUrl()}"}{assign "reviewCount" $reviewCount+1}{/rlent}]'>
</div>

<script>
	document.addEventListener("DOMContentLoaded", function() {
		const reviewsElement = document.getElementById('reviews-data');
		window.reviewsData = JSON.parse(reviewsElement.dataset.reviews);
	});
</script>