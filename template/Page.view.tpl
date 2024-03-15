{script src="https://ws.sharethis.com/button/buttons.js" name="share_button"}
{script_code require="share_button"}
stLight.options({
publisher: "4251639a-288c-4b8a-a294-b65b62a0c7e1",
doNotHash: false,
doNotCopy: false,
hashAddressBar: false,
popup:true,
servicePopup: true
});
{/script_code}
{if !$page}{$page = $post}{/if}
{if !$page}{$page = $category}{/if}
{if !$page}{$page = $rubric}{/if}
{if !$page}{$page = $blog}{/if}
{block 'config'}{/block}

{assign "isFullView" value=(
    $request->getPathInfo() == '/en/analytics/digest' || 
    $request->getPathInfo() == '/uk/analytics/digest' || 
    $request->getPathInfo() == '/analytics/digest' || 
    $request->getPathInfo() === '/about/contacts' || 
    $request->getPathInfo() === '/en/about/contacts' || 
    $request->getPathInfo() === '/uk/about/contacts' || 
    $request->getPathInfo() === '/add-inv-prop' || 
    $request->getPathInfo() === '/en/add-inv-prop' || 
    $request->getPathInfo() === '/uk/add-inv-prop' || 
    $request->getPathInfo() === '/investor' || 
    $request->getPathInfo() ==='/en/investor' || 
    $request->getPathInfo() ==='/uk/investor' || 
    $request->getPathInfo()|strpos:'/digest-social' !== false || 
    $request->getPathInfo()|strpos:'/analytics/digest' || 
    $request->getPathInfo()|strpos:'/about' !== false
)}

{* || $request->getPathInfo() == '/about/contacts' *}

{assign "isInvestmentsPage" value=($request->getPathInfo()|strpos:'/investments' === 0 || $request->getPathInfo()|strpos:'/en/investments' === 0 || $request->getPathInfo()|strpos:'/uk/investments' === 0)}
{assign "isCustomTitle" value=(
	$request->getPathInfo() === '/add-inv-prop' 
	|| $request->getPathInfo() === '/en/add-inv-prop' 
	|| $request->getPathInfo() === '/uk/add-inv-prop' 
	|| $request->getPathInfo() === '/about/contacts' 
	|| $request->getPathInfo() === '/en/about/contacts'
	|| $request->getPathInfo() === '/uk/about/contacts'
	)}
{assign "isDigest" value=($request->getPathInfo()|strpos:'/analytics/digest')}
{assign "isInvestmentsPost" value=(($request->getPathInfo()|strpos:'/investments' || $request->getPathInfo()|strpos:'/investments/' === 0 || $request->getPathInfo()|strpos:'/en/investments' || $request->getPathInfo()|strpos:'/en/investments/' === 0) && $request->getPathInfo()|strpos:'analytics/investments/' === false)}

{assign "isPost" value=($page|strpos:'Post') }
{assign "isPlainText" value=(
    $request->getPathInfo() == '/about' || 
    $request->getPathInfo() == '/en/about' || 
    $request->getPathInfo() == '/uk/about' || 
    $request->getPathInfo() == '/about/advertising' || 
    $request->getPathInfo() == '/en/about/advertising' || 
    $request->getPathInfo() == '/uk/about/advertising' || 
    $request->getPathInfo() == '/about/faq' || 
    $request->getPathInfo() == '/en/about/faq' || 
    $request->getPathInfo() == '/uk/about/faq' || 
    $request->getPathInfo() == '/usloviya-ispolzovaniya' || 
    $request->getPathInfo() == '/en/usloviya-ispolzovaniya' || 
    $request->getPathInfo() == '/uk/usloviya-ispolzovaniya' || 
    $request->getPathInfo() == '/politika-konfidencialnosti' ||
    $request->getPathInfo() == '/en/politika-konfidencialnosti' ||
    $request->getPathInfo() == '/uk/politika-konfidencialnosti'
)}

<div data-is-post="{$isPost}" data-is-investments-post="{$isInvestmentsPost}" data-path-info="{$request->getPathInfo()}"
	data-is-full-view="{$isFullView}"></div>
{if $isInvestmentsPost && $isPost}
	{include 'components/previews/invest-project'}
	<div class="bg-white pb-6 pt-6">
	{/if}

	<div itemscope itemtype="http://schema.org/WebPage" class="
									{block 'page.class'}container container--main






			{if ($request->getPathInfo() == '/investor' || $request->getPathInfo() == '/en/investor' || $request->getPathInfo() == '/uk/investor'  )}
																							investor-form






			{else}
																							container--post the_post z-0 relative






			{/if}






			{if $isFullView}
																							container--full






			{/if}






		{/block}
									">
			{if $isPlainText}
				<div class="container container--main container--post the_post the_post flex  {if !$isFullView}pl-0 pr-0{/if}">
					<div class="post__wrapper post__wrapper--shadow">
						<div class="post__preview">
							{include 'components/previews/plain-text'}
						</div>
						<div class="post__container">
							<div class="line mb-6 mt-6 s"></div>
							{block 'content'}
								<div class="wrapper" itemprop="mainEntity"
									{block 'page.scope'}itemtype="http://schema.org/CreativeWork" {/block} itemscope>
									<div class="post__content content pb-6">
										{block 'content.text'}
											{content $editable attr=['class'=>'the_post_content', 'itemprop'=>'text']}
										{/block}
									</div>
								</div>
							{/block}
						</div>
					</div>
				</div>
			{else}
				<main class="main {if $isFullView}w-full{else}large-9{/if} {if $isDigest}container{/if}">
					{block 'page.title'}
						{if !$isCustomTitle}
							<div class="{if $isFullView}section__title{else}clearfix border-bottom{/if}">
								{content $editable part="title" tag="h1" attrs=['itemprop'=>'headline']}
							</div>
						{/if}
					{/block}
					{block 'breadcrumbs'}
						{* <div class="clearfix">
								<ul class="breadcrumbs-box">
									<li><a href="/">{site_name()}</a></li>
									<li class="current">{$page->getH1()|truncate:75:" ..."|trim}</li>
								</ul>
							</div> *}
					{/block}
					{block 'menu'}{/block}
					{block 'filter'}{/block}
					{block 'content'}
						<div class="wrapper" itemprop="mainEntity" {block 'page.scope'}itemtype="http://schema.org/CreativeWork"
							{/block} itemscope>
							<div class="viewbox-cnt-body m_b-20">
								{block 'content.text'}
									{content $editable attr=['class'=>'the_post_content', 'itemprop'=>'text']}
								{/block}
							</div>
						</div>
					{/block}
					{block 'main'}{/block}
				</main>
			{/if}

			{if !$isFullView}
				{include 'components/sidebar'}
			{/if}

		</div>
		{if $isInvestmentsPost}
	</div>{/if}

	{* 
{if !$isFullView}
    <div class="dark_bg"></div>
    <div class="my_popup ">
      {#mod Mail}

          <div class="my_popup__wrapper">
            {if $lang == 'en'}
                <h5>Fill in the contact details to receive the monthly newsletter!</h5>
            {else}
                <h5>Заполните, пожалуйста, ваши контактные данные, чтобы получать ежемесячную рассылку!</h5>
            {/if}

              <i class="fa fa-close"></i>
              {subscribe}
          </div>
      {#/mod}
    </div>
{/if} *}

	{include 'components/subscribe-modal'}

