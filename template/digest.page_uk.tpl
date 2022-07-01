{* prefilter=off *}
{extends 'Page.view'}
{block 'page.class' append} digest{/block}
{block 'aside.digest'}{/block}
{block 'aside.subscribe'}{/block}
{block 'page.title'}{/block}
{block 'breadcrumbs'}{/block}
{block 'content'}
	{load_digests}

	<section class="archive mb-12">

		<div class="subscription__bottom grid-container container">
			{load_digests}
			{$month = [1=>'Січень','Лютий','Березень','Квітень','Травень','Червень','Липень','Серпень','Вересень','Жовтень','Листопад','Грудень']}
			{$first = reset($digests)}

			<div class="w-full" style="position: relative;">
				<h1 class="section__title text-center">Інвестиційний дайджест InVenture</h1>
				<p style="max-width: 640px;text-align: center;margin: 0 auto 20px;">Інвестиційний дайджест InVenture -
					найважливіше в галузі інвестицій за місяць, на 10 сторінках, всього за 5 хвилин!</p>
				<button data-remodal-target="subscribe"
					class="btn btn--normal btn--blue pl-6 pr-6 mobile-mb-2 ml-auto mr-auto">Підписатись</button>

				{if $first}

					<div class="digest__header mt-8 mb-4 ml-auto mr-auto block">
						<ul class="digest__years">
							{for $y=intval($now->format('Y')) to intval($first->getPubDate()->format('Y')) step -1}
								<li{if $now->format('Y')==$y} class='active' {/if}>{$y}</li>
								{/for}
						</ul>
					</div>
					<div class="digest">
						<div class="digest__wrapper">
							<div class="digest__months">
								{foreach array_reverse($digests) as $digest}
									{if !$prev || $prev->getPubDate()->format('Y') != $digest->getPubDate()->format('Y')}
										{if $prev}</ul>{/if}
										<ul class="digest__month{if !$prev} active{/if}" id="digest__month-{$digest->getPubDate()->format('Y')}">
										{/if}
										<li><a target="_blank" href='{$digest->getUrl()}'><img
													src="{if $digest->getImage()}{$digest->getImage()->getUrl()}{else}/images/newsletters/{$digest->getPubDate()->format('Y-n')}.png{/if}"
													alt="">{$month[intval($digest->getPubDate()->format('n'))]}</a></li>
										{$prev = $digest}
										{* 180,260 *}
									{/foreach}
								</ul>
							</div>
						</div>
					</div>

				{/if}
			</div>
		</div>
	</section>

	<div id="hidden-digest" hidden>

	</div>
	{include 'components/reviews' category='digest-social' title="Відгуки про дайджест"}
{/block}