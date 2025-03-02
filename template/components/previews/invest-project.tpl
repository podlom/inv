<div class="preview preview--invest ">
	<div class="container">
		<div class="preview__wrapper preview__wrapper--none-bg-desktop pb-6">
			<div class="preview__wrapper-block flex flex-col">
				{* <p class="preview__name-category">
                  {$rubrics = $post->getRubrics()}
                  {$breadcrumbs = array_filter([$blog, $category,$rubrics[0]])}
                  {foreach $breadcrumbs as $item}
                  {/foreach}
                  <a href="{$post->getParent()->getPath()}">{$post->getParent()->getH1()}</a>
                </p> *}
				{if count($post->getImages())}
					<div class="preview__slider">
						<div class="swiper-container gallery-top">
							{if $post->getAttr(58) == 1}
								<div class="preview__status block">{if $lang == 'en'}Sold{else}Продано{/if}</div>
							{/if}
							{if $post->getAttr(73) == 1}
								<div class="preview__status block">{if $lang == 'en'}Verified{elseif $lang == 'ru'}Проверено{else}Перевірено{/if}</div>
							{/if}
							<div class="preview__info mobile-only">
								<p class="font-semibold text-sm">{$post->getPublished()->format('d.m.y')}</p>
								<!-- <div class="preview__slider-item--item"></div> -->
								<div class="preview__views">
									<svg width="16" height="11" viewBox="0 0 16 11" fill="none" xmlns="http://www.w3.org/2000/svg">
										<path
											d="M7.98888 0C2.6069 0 0 5.42316 0 5.42316C0 5.42316 2.59008 10.8463 7.98888 10.8463C13.3877 10.8463 15.9778 5.42316 15.9778 5.42316C15.9778 5.42316 13.3709 0 7.98888 0ZM7.98888 9.61685C5.6679 9.61685 3.80102 7.73053 3.80102 5.42316C3.80102 3.09895 5.68472 1.22947 7.98888 1.22947C10.293 1.22947 12.1767 3.11579 12.1767 5.42316C12.1767 7.74737 10.3099 9.61685 7.98888 9.61685Z"
											fill="white"></path>
										<path
											d="M9.95658 4.64973C9.30065 4.64973 8.76244 4.11078 8.76244 3.45394C8.76244 3.25183 8.81291 3.04973 8.91382 2.88131C8.6279 2.78026 8.30834 2.71289 7.98879 2.71289C6.49193 2.71289 5.26416 3.92552 5.26416 5.42447C5.26416 6.92342 6.47511 8.15289 7.98879 8.15289C9.48565 8.15289 10.6966 6.94026 10.6966 5.42447C10.6966 5.10447 10.6461 4.78447 10.5284 4.49815C10.377 4.5992 10.1752 4.64973 9.95658 4.64973Z"
											fill="white"></path>
									</svg>
									<p class="preview__views-number font-semibold text-sm">{$post->getViews()}</p>
								</div>
							</div>

							<div class="swiper-wrapper  mb-4">

								{if $post->hasImage()}
									{assign var="mainImageId" value="{($post->getImage()->getId())}"}
									<a href="{($post->getImage()->getUrl())}" class="js-smartphoto swiper-slide">
										{if $user && $user->canAccess('Page.publish')}
											<div class="preview__slider-download" data-link="{$post->getImage()->getUrl()}">
												<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
													x="0px" y="0px" viewBox="0 0 512 512" style="enable-background:new 0 0 512 512;"
													xml:space="preserve">
													<g>
														<path
															d="M484.078,27.923C466.072,9.917,442.131,0.001,416.666,0.002L95.334,0C42.766,0.002,0,42.769,0,95.333v321.333
                                                C0,469.233,42.768,512,95.334,512h321.332C469.233,512,512,469.233,512,416.666V95.335C512,69.87,502.084,45.929,484.078,27.923z
                                                M165.865,217.494c5.857-5.857,15.354-5.857,21.213,0L241,271.416l-0.002-160.017c0-8.284,6.716-15,15-15c8.285,0,15,6.716,15,15
                                                L271,271.412l53.918-53.92c5.857-5.857,15.355-5.857,21.213,0c5.858,5.857,5.858,15.355,0.001,21.213l-79.526,79.528
                                                c-2.814,2.814-6.629,4.394-10.607,4.394c-3.977,0-7.793-1.58-10.605-4.394l-79.527-79.526
                                                C160.007,232.85,160.007,223.352,165.865,217.494z M400.602,415.6H111.4c-8.283,0-15-6.716-15-15s6.717-15,15-15h289.201
                                                c8.283,0,15,6.716,15,15C415.602,408.884,408.885,415.6,400.602,415.6z" />
													</g>
												</svg>
											</div>
										{/if}
										<div class="img-overlay mobile-only opacity-75"></div>
										<img class="ts-main-post-image swiper-lazy"
											data-src="/img/thumbup.600.400{($post->getImage()->getUrl())}" alt="{$post->getH1()}">
										<div class="swiper-lazy-preloader"></div>
									</a>
								{/if}
								<!-- @ts mainImageId: {$mainImageId} -->

								{foreach $post->getImages() as $image }
								{* if $image@first}
                                  {continue}
                              {/if *}
								{if $image->getId() == $mainImageId}
									{continue}
								{/if}
								<a href="{($image->getUrl())}" class="js-smartphoto swiper-slide">
									{if $user && $user->canAccess('Page.publish')}
										<div class="preview__slider-download" data-link="{$image->getUrl()}">
											<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
												x="0px" y="0px" viewBox="0 0 512 512" style="enable-background:new 0 0 512 512;"
												xml:space="preserve">
												<g>
													<path d="M484.078,27.923C466.072,9.917,442.131,0.001,416.666,0.002L95.334,0C42.766,0.002,0,42.769,0,95.333v321.333
                                            C0,469.233,42.768,512,95.334,512h321.332C469.233,512,512,469.233,512,416.666V95.335C512,69.87,502.084,45.929,484.078,27.923z
                                            M165.865,217.494c5.857-5.857,15.354-5.857,21.213,0L241,271.416l-0.002-160.017c0-8.284,6.716-15,15-15c8.285,0,15,6.716,15,15
                                            L271,271.412l53.918-53.92c5.857-5.857,15.355-5.857,21.213,0c5.858,5.857,5.858,15.355,0.001,21.213l-79.526,79.528
                                            c-2.814,2.814-6.629,4.394-10.607,4.394c-3.977,0-7.793-1.58-10.605-4.394l-79.527-79.526
                                            C160.007,232.85,160.007,223.352,165.865,217.494z M400.602,415.6H111.4c-8.283,0-15-6.716-15-15s6.717-15,15-15h289.201
                                            c8.283,0,15,6.716,15,15C415.602,408.884,408.885,415.6,400.602,415.6z" />
												</g>
											</svg>
										</div>
									{/if}
									<div class="img-overlay mobile-only opacity-75"></div>
									<img class="swiper-lazy main-img-id-{$mainImageId} img-id-{($image->getId())}"
										data-src="/img/thumbup.600.400{($image->getUrl())}" alt="{$post->getH1()}">
									<div class="swiper-lazy-preloader"></div>
								</a>
							{/foreach}
						</div>
						<div class="swiper-button-next swiper-button-white"></div>
						<div class="swiper-button-prev swiper-button-white"></div>
					</div>

					{if count($post->getImages()) > 1}
						<div class="swiper-container gallery-thumbs mt-2">
							<div class="swiper-wrapper">
								{if $post->hasImage()}
									<div class="swiper-slide">
										<img class="swiper-lazy" data-src="/img/thumbup.350.254{$post->getImage()->getUrl()}"
											alt="{$post->getH1()}">
										<div class="swiper-lazy-preloader"></div>
									</div>
								{/if}
								{foreach $post->getImages() as $image }
								{* if $image@first}
                                    {continue}
                                {/if *}
								{if $image->getId() == $mainImageId}
									{continue}
								{/if}
								<div class="swiper-slide">
									<img class="swiper-lazy" data-src="/img/thumbup.350.254{($image->getUrl())}" alt="{$post->getH1()}">
									<div class="swiper-lazy-preloader"></div>
								</div>
							{/foreach}
						</div>
					</div>
					{/if}
				</div>
				{/if}

				<div class="desktop-only mt-auto pt-4 flex">

					<p class="flex items-center opacity-75 text-sm  mr-4 font-semibold text--grey">ID: <span
							class="postId1">{$post->getId()}</span></p>
					<p class="flex items-center opacity-75 text-sm  mr-4 font-semibold text--grey">
						{$post->getPublished()->format('d.m.y')}</p>

					{include 'components/share-btn'}
				</div>
			</div>

			<div class="preview__wrapper-main mobile-pl-0 mobile-pr-0">
				<p class="preview__name-category mobile-mt-4">
					{* {$breadcrumbs = array_filter([$blog, $category,$rubrics[0]])}
                  {foreach $breadcrumbs as $item}
                    <a href="{$item->getPath()}" itemprop="item">
                        {$item->geth1()|truncate:75}
                    </a>
                  {/foreach} *}

					<a href="{$post->getParent()->getPath()}">{$post->getParent()->getH1()}</a>
				</p>
				<div class="preview__text">
					<h1 class="preview__title">{$post->getH1()}</h1>
					<p class="preview__description">{$post->getShortText()}</p>
				</div>
				<div class="mobile-only  pb-2">
					{include 'components/share-btn'}
				</div>
				<div class="mb-4">
					<p class="font-bold ">{if $lang === 'ru'}Расположение:{elseif $lang === 'uk'}Розташування:{else}Location:{/if}
					</p>
					<p class="inline"> {$post->printAttr("10")}</p>
				</div>
				<div class="preview__characteristics content pb-0">
					{* <div class="line"></div> *}
					<ul class="preview__characteristics--grid">
						{include concat('inc/investments/',$post->getParent()->getSubpath())}
					</ul>
				</div>
				<div class="line mb-6 mt-6 mobile-only w-full ml-0 mr-0"></div>
			</div>
		</div>
	</div>


	{* <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"> *}


	<script>
		if (!document.querySelector('.preview__characteristics--grid').innerText.replace(/ /g, "").length) {
			document.querySelector('.preview__characteristics').classList.add('hidden')
		}

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
		loadScript('https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js').then(() => {
			if (document.querySelectorAll('.preview--invest').length) {

				if (document.querySelectorAll('.gallery-thumbs').length) {
					var galleryThumbs = new Swiper('.gallery-thumbs', {
						spaceBetween: 10,
						slidesPerView: 5,
						freeMode: true,
						watchSlidesVisibility: true,
						watchSlidesProgress: true,
						preloadImages: false,
						lazy: true
					});
					var galleryTop = new Swiper('.gallery-top', {
						slidesPerView: 1,
						navigation: {
							nextEl: '.swiper-button-next',
							prevEl: '.swiper-button-prev',
						},
						thumbs: {
							swiper: galleryThumbs
						},
						preloadImages: false,
						lazy: true
					});
				} else {
					var galleryTop = new Swiper('.gallery-top', {
						slidesPerView: 1,
						navigation: {
							nextEl: '.swiper-button-next',
							prevEl: '.swiper-button-prev',
						},
						preloadImages: false,
						lazy: true
					});
				}
			}
		})
	</script>


	<style>
		.swiper-container {
			width: 100%;
			height: 300px;
			margin-left: auto;
			margin-right: auto;
		}

		.swiper-slide {
			background-size: cover;
			background-position: center;
			display: -webkit-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			-webkit-box-pack: center;
			-ms-flex-pack: center;
			-webkit-justify-content: center;
			justify-content: center;
			-webkit-box-align: center;
			-ms-flex-align: center;
			-webkit-align-items: center;
			align-items: center;
			border-radius: 4px;
			overflow: hidden;
			position: relative;
			padding-top: 66.66%;
			height: 0 !important;
		}

		.swiper-slide img {
			position: absolute;
			top: 0;
			left: 0;
			bottom: 0;
			right: 0;
			width: 100%;
			height: 100%;
			-o-object-fit: cover;
			object-fit: cover;

			text-indent: -9999px;

		}

		.gallery-top {
			height: 100%;
			width: 100%;
			border-radius: 4px;
		}

		.gallery-thumbs {
			box-sizing: border-box;
			height: auto;
		}

		.gallery-thumbs .swiper-slide {
			height: 100%;
			opacity: 0.4;

			padding-top: calc(66.66% / 5) !important;
		}

		.gallery-thumbs .swiper-slide-thumb-active {
			opacity: 1;
		}
</style>