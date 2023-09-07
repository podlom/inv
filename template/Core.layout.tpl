{if $request->getPathInfo() == '/uk'}
	{$lang='uk'}
{/if}

<!DOCTYPE html>
<!--[if lt IE 7]><html class="lt-ie9 lt-ie8 lt-ie7" prefix="og: https://ogp.me/ns#" /> <![endif]-->
<!--[if IE 7]><html class="lt-ie9 lt-ie8" prefix="og: https://ogp.me/ns#" /> <![endif]-->
<!--[if IE 8]><html class="lt-ie9" prefix="og: https://ogp.me/ns#" /> <![endif]-->
<!--[if gt IE 8]><!-->
<html lang="{$lang|default:'ru'}" prefix="og: https://ogp.me/ns#">
<!--<![endif]-->

<head>

	<!-- @ts:$request->getPathInfo(): '{$request->getPathInfo()}' -->
	<!-- @ts:$lang: '{$lang}' -->

	{if $sm}
		{$user = $sm->getUser()}
	{/if}
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="google-site-verification" content="LfVoNUP8eiLhw36D_ybQCjOCMGpC2A3l39tbZpaHP5A" />
	<meta name="google-site-verification" content="-6zzop7KDzhnKh2o5OdjWKynXd1cQol6feh7N75LVmk" />
	<!-- Favicons -->
	<link rel="apple-touch-icon" href="/images/theme/favicon/touch-icon-iphone.png" />
	<link rel="apple-touch-icon" sizes="76x76" href="/images/theme/favicon/touch-icon-ipad.png" />
	<link rel="apple-touch-icon" sizes="120x120" href="/images/theme/favicon/touch-icon-iphone-retina.png" />
	<link rel="apple-touch-icon" sizes="152x152" href="/images/theme/favicon/touch-icon-ipad-retina.png" />
	<link rel="shortcut icon" href="/images/theme/favicon/favicon.ico" type="image/x-icon" />

	<link rel="preload" href="/css/font-awesome.min.css" as="style">
	<link rel="dns-prefetch" href="https://fonts.gstatic.com/">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link rel="preload" as="style"
		href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,500,600,700&display=swap&subset=cyrillic,latin">
	<link rel="stylesheet"
		href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,500,600,700&display=swap&subset=cyrillic,latin"
		media="print" onload="this.media='all'">
	<noscript>
		<link rel="stylesheet"
			href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,500,600,700&display=swap&subset=cyrillic,latin">
	</noscript>

	<link rel="dns-prefetch" href="//netdna.bootstrapcdn.com">
	<link rel="alternate" hreflang="x-default" href="https://inventure.com.ua/" />

{literal}
<!-- Google Tag Manager -->
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-MHZGQ4C');</script>
<!-- End Google Tag Manager -->
{/literal}

	{if $post}
		{meta 'og.1' property='og:title'  content=html_entity_decode($post->getH1()) raw=1}
		{meta 'og.2' property='og:description'  content=html_entity_decode($post->getShortText()) raw=1}
		{meta 'og.3' property='og:type'  content='website' raw=1}
		{meta 'og.4' property='og:url'  content=full_link($post->getPath()) raw=1}
		{if $post->hasImage()}
			{meta property='og:image' content=full_link($post->getImage()->getUrl()) raw=1}
			{meta 'og2' property='og:image' content=full_link($post->getImage()->thumbup(600,315)->getUrl()) raw=1}
			{meta 'og3' property='og:image' content=full_link($post->getImage()->thumbup(180,110)->getUrl()) raw=1}
			{meta 'twitter:title' html_entity_decode($post->getH1())}
			{meta 'twitter:description' html_entity_decode($post->getShortText())}
			{meta "twitter:card" "summary_large_image"}
			{meta "twitter:site" "@inventure_ua"}
			{meta "twitter:creator" "@inventure_ua"}
			{meta 'twitter:image' full_link($post->getImage()->getUrl())}
		{/if}
	{else}
		{meta 'og:5' raw=1  property='og:image' content=full_link('/i/inventure_corp.png')}
	{/if}



	{meta 'fb1' property='fb:app_id' content='160711107658620' raw=1}
	{*style '/css/foundation.min.css'*}

	{assign "isNewStylesAvaible" value=(true)}
	{literal}
		<style>
			html,body,div,span,iframe,h1,h2,p,a,img,i,ul,li,fieldset,form,label,aside,header,nav{margin:0;padding:0;border:0;font-size:100%;vertical-align:baseline}:focus{outline:0}aside,header,nav{display:block}body{line-height:1}ul{list-style:none}input[type='search']::-webkit-search-cancel-button,input[type='search']::-webkit-search-decoration,input[type='search']::-webkit-search-results-button,input[type='search']::-webkit-search-results-decoration{-webkit-appearance:none;-moz-appearance:none}input[type='search']{-webkit-appearance:none;-moz-appearance:none;-webkit-box-sizing:content-box;box-sizing:content-box}[hidden]{display:none}html{font-size:100%;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%}img{border:0;-ms-interpolation-mode:bicubic}form{margin:0}fieldset{border:1px solid #c0c0c0;margin:0 2px;padding:0.35em 0.625em 0.75em}button,input,select{font-size:100%;margin:0;vertical-align:baseline;*vertical-align:middle}button,input{line-height:normal}button,select{text-transform:none}button{-webkit-appearance:button;*overflow:visible}input[type='checkbox']{-webkit-box-sizing:border-box;box-sizing:border-box;padding:0;*height:13px;*width:13px}input[type='search']{-webkit-appearance:textfield;-webkit-box-sizing:content-box;box-sizing:content-box}input[type='search']::-webkit-search-cancel-button,input[type='search']::-webkit-search-decoration{-webkit-appearance:none}button::-moz-focus-inner,input::-moz-focus-inner{border:0;padding:0}html,button,input,select{color:#222}img{vertical-align:middle}fieldset{border:0;margin:0;padding:0}.font-medium{font-weight:500!important}.font-semibold{font-weight:600!important}.text-xs{font-size:0.75rem!important}.text-sm{font-size:0.875rem!important}:root{--main-accent-color: #5e87b3;--main-accent-color-darken: #476e97;--secondary-accent-color: #db8686;--secondary-accent-color-darken: #e4646c;--main-bg-color: #fafafa;--swiper-theme-color: #5e87b3 !important}html{-webkit-box-sizing:border-box;box-sizing:border-box}*,*::after,*::before{-webkit-box-sizing:inherit;box-sizing:inherit}a{text-decoration:none;color:#000000}body{min-width:320px;overflow:scroll;background-color:var(--main-bg-color);font-family:Montserrat,sans-serif;line-height:140%}.container{padding:0 10px;max-width:510px;margin:0 auto}.container--main{display:-webkit-box;display:-ms-flexbox;display:flex;-webkit-box-orient:vertical;-webkit-box-direction:normal;-ms-flex-direction:column;flex-direction:column}@media (min-width:1024px){.container--main{display:grid;grid-template-columns:1fr 270px;gap:30px}}.container .sidebar--index .filter__wrapper{height:calc(100% - 115px)}.container .sidebar .btn{min-height:56px}@media (min-width:1024px){.container{max-width:1335px;padding:0 25px}}@media (min-width:1024px){.inner-wrap{padding-top:2em}}.flex{display:-webkit-box;display:-ms-flexbox;display:flex}.z-0{z-index:0!important}.opacity-75{opacity:0.75!important}.bd-radius--default{border-radius:4px!important}.line-clamp{display:-webkit-box;-webkit-line-clamp:3;-webkit-box-orient:vertical;overflow:hidden}.line-clamp--2{-webkit-line-clamp:2}.border-4{border-radius:4px!important}body{padding-top:60px}.up{position:fixed;bottom:10px;right:10px;-webkit-box-shadow:0 10px 10px rgba(0,0,0,0.1);box-shadow:0 10px 10px rgba(0,0,0,0.1);border-radius:50%}@media screen and (min-width:1024px){.up{bottom:20px;right:20px}}.up img{height:40px}@media screen and (min-width:1024px){.up img{height:50px}}.relative{position:relative}.remodal,[data-remodal-id]{display:none}.remodal{position:relative;outline:0;-webkit-text-size-adjust:100%;-ms-text-size-adjust:100%;-moz-text-size-adjust:100%;text-size-adjust:100%}.remodal{-webkit-box-sizing:border-box;box-sizing:border-box;width:100%;margin-bottom:10px;padding:25px;border-radius:4px;margin:auto;-webkit-transform:translate3d(0,0,0);transform:translate3d(0,0,0);color:#2b2e38;background:#fff}.remodal-close,.remodal-close:before{position:absolute;top:0;right:0;display:block;width:65px}.remodal-close{overflow:visible;margin:0;text-decoration:none;outline:0;border:0}.remodal{vertical-align:middle}.remodal-close{height:65px;padding:0;color:#95979c;background:0 0}.remodal-close:before{font-family:Arial,'Helvetica CY','Nimbus Sans L',sans-serif!important;font-size:25px;line-height:65px;content:'\00d7';text-align:center}.remodal-close::-moz-focus-inner{padding:0;border:0}@media only screen and (min-width:641px){.remodal{max-width:480px}}.remodal__title{font-size:20px;margin:0 0 10px;text-align:left;font-weight:bold;padding-right:20px}.section__controls-btn{background:#ffffff;-webkit-box-shadow:0px 1px 4px rgba(0,0,0,0.15);box-shadow:0px 1px 4px rgba(0,0,0,0.15);border-radius:4px;border:none;min-height:32px;min-width:32px}.section__title-categories{padding-bottom:7px;font-weight:600;font-size:24px;line-height:1.2}.section__categories{padding-bottom:8px;display:-webkit-box;display:-ms-flexbox;display:flex;-ms-flex-wrap:nowrap;flex-wrap:nowrap;overflow-x:auto;margin-top:4px;margin-bottom:4px;margin:0}@media screen and (min-width:1024px) and (max-width:1329px){.section__categories{max-width:calc(100vw - 350px)}}@media screen and (min-width:1330px){.section__categories{max-width:calc(100vw - (100vw - 1340px) - 350px)}}.section__categories-overlay{content:'';right:0;background:-webkit-gradient(linear,left top,right top,from(rgba(250,250,250,0)),to(#fafafa));background:linear-gradient(90deg,rgba(250,250,250,0),#fafafa);width:100px;height:100%;position:absolute;z-index:99;top:0;bottom:0}.section__category{white-space:nowrap;margin-right:16px;font-weight:600;font-size:12px!important}.show-more{position:relative;width:100%;display:-webkit-box;display:-ms-flexbox;display:flex;-webkit-box-pack:center;-ms-flex-pack:center;justify-content:center;margin-top:24px;margin-bottom:40px}@media screen and (max-width:1023px){.show-more{margin-left:-10px;margin-right:-10px;width:calc(100% + 20px)}}.show-more:before{content:'';position:absolute;left:0;right:0;top:50%;height:1px;-webkit-transform:translateY(-50%);-ms-transform:translateY(-50%);transform:translateY(-50%);z-index:-1;background:#e1e1e1}.show-more__btn{font-size:14px;padding:0.5em 1em;border-radius:4px;border:1px solid #d4d4d4;background-color:var(--main-bg-color);color:#7d7d7d}.cards{padding-top:16px;grid-template-columns:1fr;gap:16px;display:grid}@media screen and (min-width:1024px){.cards{grid-template-columns:repeat(2,1fr);gap:16px}}@media screen and (min-width:1180px){.cards{grid-template-columns:repeat(3,1fr);gap:16px}}.cards__img-wrapper{position:relative;width:calc(100% + 20px);display:block;margin:0 -10px;border-top-left-radius:4px;border-top-right-radius:4px;overflow:hidden;padding-top:66.66%}.cards__img{max-height:100%;position:relative}.cards__img-wrapper .cards__img{position:absolute;top:0;left:0;bottom:0;right:0;width:100%;height:100%;-o-object-fit:cover;object-fit:cover}.cards__title{margin-top:8px;margin-bottom:8px;font-size:16px;line-height:140%;font-weight:600;font-style:normal;display:block}.cards__meta{display:-webkit-box;display:-ms-flexbox;display:flex;-webkit-box-pack:justify;-ms-flex-pack:justify;justify-content:space-between;padding-top:8px;margin-top:auto;font-weight:600;color:#808080}.cards__item{background-color:#ffffff;padding:0 10px 10px;border-radius:4px;-webkit-box-shadow:0px 1px 4px rgba(0,0,0,0.1);box-shadow:0px 1px 4px rgba(0,0,0,0.1);display:-webkit-box;display:-ms-flexbox;display:flex;-webkit-box-orient:vertical;-webkit-box-direction:normal;-ms-flex-direction:column;flex-direction:column;height:100%;position:relative}.cards__item--big .cards__img-wrapper{padding-bottom:20px}.cards__item--big .cards__img{padding-top:0;margin-bottom:8px;border-top-left-radius:4px;border-top-right-radius:4px}@media screen and (max-width:1023px){.cards__item--horizontal-sm .cards__img-wrapper{width:100%;margin:0}}@media screen and (min-width:1024px){.cards__item--horizontal-sm{padding:10px;display:-webkit-box;display:-ms-flexbox;display:flex;-webkit-box-orient:horizontal;-webkit-box-direction:normal;-ms-flex-direction:row;flex-direction:row}.cards__item--horizontal-sm .cards__img-wrapper{width:140px;min-width:140px;height:95px;padding:0;display:block;display:-webkit-box;display:-ms-flexbox;display:flex;margin:0;margin-right:10px}}@media screen and (min-width:1024px) and (max-width:1160px){.cards__item--horizontal-sm .cards__meta{padding:0;display:-webkit-box;display:-ms-flexbox;display:flex;-webkit-box-orient:vertical!important;-webkit-box-direction:normal!important;-ms-flex-direction:column!important;flex-direction:column!important}.cards__item--horizontal-sm .cards__meta div{margin-left:0!important}}.btn{-webkit-box-shadow:0px 1px 4px rgba(0,0,0,0.1);box-shadow:0px 1px 4px rgba(0,0,0,0.1);border-radius:4px;min-height:40px;display:-webkit-box;display:-ms-flexbox;display:flex;-webkit-box-align:center;-ms-flex-align:center;align-items:center;-webkit-box-pack:center;-ms-flex-pack:center;justify-content:center;font-family:Montserrat;font-style:normal;font-weight:600;font-size:16px;text-align:center;letter-spacing:0.5px}@media (min-width:1024px){.btn{min-height:56px}}.btn--normal{letter-spacing:normal}@media (min-width:1024px){.btn--normal{min-height:46px}}.btn--blue{background:var(--main-accent-color);color:#fff;border:none}.w-full{width:100%!important}.callback__form .gm_row{display:-webkit-box;display:-ms-flexbox;display:flex;-webkit-box-orient:vertical;-webkit-box-direction:normal;-ms-flex-direction:column;flex-direction:column}.callback__form input{width:100%;height:40px;background:#ffffff;border-radius:4px;border:0;padding:0 15px;font-size:14px;line-height:40px;color:#000000;border:1px solid #ccc;margin:10px 0}.callback__form input::-webkit-input-placeholder{font-size:14px;line-height:40px;color:#000000;opacity:0.4}.callback__form input::-ms-input-placeholder{font-size:14px;line-height:40px;color:#000000;opacity:0.4}.callback__form button{height:40px;background:var(--main-accent-color);border:0;border-radius:4px;margin:10px 0 0;color:white;font-size:16px}
			.callback__form fieldset input{width:auto;height:1em}.header{background-color:#ffffff;position:fixed;top:0;width:100%;left:0;right:0}.header__logo img{max-height:26px}.header__nav{display:-webkit-box;display:-ms-flexbox;display:flex}.header li{list-style-type:none}.header__wrapper{min-height:60px;padding:0;display:-webkit-box;display:-ms-flexbox;display:flex;-webkit-box-pack:justify;-ms-flex-pack:justify;justify-content:space-between;-webkit-box-align:center;-ms-flex-align:center;align-items:center;-webkit-box-shadow:0px 1px 12px rgba(0,0,0,0.1);box-shadow:0px 1px 12px rgba(0,0,0,0.1);background:white;z-index:2;width:100%;font-size:14px}.header--mobile{z-index:10!important}.header--mobile .header__wrapper{padding:0 10px}.header__btn{width:36px;height:36px;display:-webkit-box;display:-ms-flexbox;display:flex;-webkit-box-align:center;-ms-flex-align:center;align-items:center;-webkit-box-pack:center;-ms-flex-pack:center;justify-content:center;border-radius:4px;border:none;background-color:#f4f4f4;position:relative}.header__btn svg{min-width:18px;width:19px}.header__btn--blue{background-color:var(--main-accent-color)}.header__btn--burger::after{content:'';width:19px;height:1.5px;border-radius:1px;position:absolute;background-color:#ababab;top:12px;left:8px;-webkit-box-shadow:0 5px 0 0 #ababab,0 10px 0 0 #ababab;box-shadow:0 5px 0 0 #ababab,0 10px 0 0 #ababab}.header .header__right{display:-webkit-box;display:-ms-flexbox;display:flex;-webkit-box-align:center;-ms-flex-align:center;align-items:center;font-weight:bold}@media screen and (max-width:1340px){.header .header__right{margin__right:20px;margin-left:-20px}}@media screen and (max-width:1280px){.header .header__right{margin__right:60px;margin-left:-60px}}.header .header__right-item{display:-webkit-box;display:-ms-flexbox;display:flex;-webkit-box-align:center;-ms-flex-align:center;align-items:center;padding:0 5px!important;margin:0 5px;opacity:0.8}@media screen and (max-width:1200px){.header .header__right-item{margin:0}}.header .header__right-item a,.header .header__right-item path,.header .header__right-item span{color:var(--main-accent-color)}.header .header__right-item path{fill:var(--main-accent-color)}.header .header__right-item--social path{stroke:var(--main-accent-color)}.header .header__right-item--lang{font-weight:500}.header__container{max-width:1335px;width:100%;display:-webkit-box;display:-ms-flexbox;display:flex;-webkit-box-pack:justify;-ms-flex-pack:justify;justify-content:space-between;-webkit-box-align:center;-ms-flex-align:center;align-items:center}.header--desktop{position:fixed;width:100%}.header__nav-item span a{height:60px;display:-webkit-box;display:-ms-flexbox;display:flex;-webkit-box-align:center;-ms-flex-align:center;align-items:center;margin:0 10px;font-weight:600}@media screen and (max-width:1160px){.header__nav-item span a{margin:0 6px;font-size:13px!important}}@media screen and (max-width:1120px){.header__nav-item span a{margin:0 4px;font-size:12px!important}}.header,.header .grid-container{background:white;z-index:2}.menu-item1{border-bottom:2px solid #fff}.menu-item{background:white;width:100%;display:-webkit-box;display:-ms-flexbox;display:flex;-webkit-box-shadow:0px 8px 9px rgba(0,0,0,0);box-shadow:0px 8px 9px rgba(0,0,0,0);position:absolute;left:0;right:0;top:100%;z-index:-1;border-top:1px solid #f0f2f3;-webkit-transform:translateY(-500px);-ms-transform:translateY(-500px);transform:translateY(-500px);will-change:transform}@media (min-width:1024px){.menu-item:after{content:'';z-index:0;position:absolute;top:0;right:0;width:1000%;height:100%;background-color:#f0f2f3;-webkit-transform:translateX(97%);-ms-transform:translateX(97%);transform:translateX(97%)}}.menu-item .grid-container{display:-webkit-box;display:-ms-flexbox;display:flex;padding:0!important}@media screen and (max-width:1230px){.menu-item .grid-container{margin:0!important}}.menu-item a{text-decoration:none;color:#1f2e35;font-size:14px!important}.menu-item__list-wrapper{display:-webkit-box;display:-ms-flexbox;display:flex;padding:30px 0 0;margin-right:80px;margin-bottom:20px}.menu-item__list{display:grid;grid-template-columns:1fr 1fr;gap:80px;row-gap:20px;-webkit-box-align:center;-ms-flex-align:center;align-items:center}.menu-item__list:last-of-type{display:-webkit-box;display:-ms-flexbox;display:flex;-webkit-box-orient:vertical;-webkit-box-direction:normal;-ms-flex-direction:column;flex-direction:column}.menu-item__list--world{-webkit-box-align:initial;-ms-flex-align:initial;align-items:initial}.menu-item__advert{background:#d6d8d9;display:-webkit-box;display:-ms-flexbox;display:flex;width:580px}.menu-item__advert img{-webkit-transform:translate(0px,0px);-ms-transform:translate(0px,0px);transform:translate(0px,0px)}.menu-item__left{padding:40px 0 0 0;width:700px;margin-left:0;margin-right:25px}@media screen and (max-width:1230px){.menu-item__left{padding-right:20px;padding-left:20px;margin-right:0}}@media screen and (max-width:1160px){.menu-item__left{width:560px}}.menu-item__left-top{display:grid;grid-template-columns:5fr 2fr;border-bottom:1px solid #f0f2f3;margin:0!important}.menu-item__info{padding-right:30px}.menu-item__info-text{font-weight:600;line-height:140%;margin-bottom:40px;text-transform:initial!important}.menu-item__info-link{color:var(--main-accent-color)!important;margin-top:20px;font-weight:bold;padding:5px 0!important;border-bottom:2px solid var(--main-accent-color);display:inline-block!important}.menu-item__left-bottom{padding:20px 0;margin:0!important}.menu-item__right{background:#f0f2f3;width:540px;display:-webkit-box;display:-ms-flexbox;display:flex;-webkit-box-align:center;-ms-flex-align:center;align-items:center;padding:20px 0 20px 40px;position:relative;z-index:1;margin-left:25px;margin-right:0}@media screen and (max-width:1160px){.menu-item__right{padding:20px 0 20px 30px}}.menu-item__right img{opacity:1!important;width:100%;min-width:240px}.menu-item__right .menu-item__info-link{padding:5px 0!important}.menu-item a{padding:0!important;text-transform:initial!important}.menu-item a li{font-weight:500!important}.menu-item a.font-weight-bold li{font-weight:600!important}.menu-item li{display:-webkit-box;display:-ms-flexbox;display:flex;-webkit-box-align:center;-ms-flex-align:center;align-items:center;margin-bottom:18px;padding:0!important;font-weight:500!important}.menu-item li svg{margin-right:12px;max-width:22px}.menu-item .invest-ukraine path{stroke:none!important}.menu-item1,.menu-item2,.menu-item3,.menu{position:static!important}.menu-item2 .menu-item li{margin-bottom:0}.menu-item2 .menu-item:after{display:none}.franchising-svg path{stroke:none!important}.menu-item3 .menu-item__left{margin-bottom:30px}.menu-item3 .menu-item__left-top{border:0;grid-template-columns:1fr 1fr}.menu-item3 .menu-item__info-text{border:none;margin-bottom:0}.menu-item2 .grid-container{margin:0 auto!important}.filter__label{font-size:12px!important;font-weight:bold;margin-bottom:4px!important;display:block}.filter__heading-filter{display:none}@media screen and (max-width:1024px){.filter__heading-filter{display:block}}.filter__heading-filter .fa-close{font-size:20px}.filter__input{background:#f7f7f7;border:1px solid #ccc;padding:0 10px;height:46px;border-radius:4px;border-radius:4px;color:#1c2e36!important;border-color:#ebebeb;background:#f7f7f7;width:100%;font-size:14px}.filter__selector{width:100%}.filter__selector:not(.filter__selector--price){max-height:72px}.filter__selector--price{display:-webkit-box;display:-ms-flexbox;display:flex;-webkit-box-orient:vertical;-webkit-box-direction:normal;-ms-flex-direction:column;flex-direction:column}.filter__selector--price .filter__row{width:100%}.filter__selectors{display:-webkit-box;display:-ms-flexbox;display:flex;-webkit-box-orient:vertical;-webkit-box-direction:normal;-ms-flex-direction:column;flex-direction:column;padding:0 20px}.filter__selectors::-webkit-scrollbar{-webkit-appearance:none;width:0;height:0}@media screen and (max-width:540px){.filter__selectors{overflow:auto}}.filter__row .multiple-select{width:100%;-webkit-appearance:none;line-height:36px;font-size:14px}.filter__row select{max-width:100%;height:46px;line-height:46px;border-radius:4px;color:#1c2e36!important;border-color:#ebebeb;background:#f7f7f7;border:1px solid #ebebeb;padding:0 3px;overflow:hidden!important}.filter__row select option{font-size:14px;line-height:14px;display:-webkit-box;display:-ms-flexbox;display:flex;margin:0;line-height:32px!important;height:38px;-webkit-box-align:center;-ms-flex-align:center;align-items:center;color:transparent!important}.filter__title{font-weight:bold;font-weight:600;font-size:16px;margin-bottom:10px;display:-webkit-box;display:-ms-flexbox;display:flex;-webkit-box-pack:justify;-ms-flex-pack:justify;justify-content:space-between}@media screen and (min-width:1024px){.filter__title{-webkit-box-pack:center;-ms-flex-pack:center;justify-content:center;border-bottom:1px solid #d4d3d3;margin:0 -20px 1em;padding:16px 10px;font-weight:600}}.filter__wrapper{bottom:0;margin:0 auto;display:-webkit-box;display:-ms-flexbox;display:flex;-webkit-box-orient:vertical;-webkit-box-direction:normal;-ms-flex-direction:column;flex-direction:column;width:100%;background:white;top:100%;z-index:1;padding:0;margin-bottom:20px;-webkit-box-shadow:0px 1px 4px rgba(0,0,0,0.1);box-shadow:0px 1px 4px rgba(0,0,0,0.1);border-radius:4px;width:100%}@media screen and (max-width:1023px){.filter__wrapper{position:fixed;left:0;right:0;top:0;-webkit-transform:translateY(-100%);-ms-transform:translateY(-100%);transform:translateY(-100%);max-height:calc(100vh - 100px);overflow:auto}}.filter__wrapper label span{text-transform:initial}.filter__wrapper button{width:100%}.filter__wrapper label span{font-size:14px;margin-bottom:6px}
			.mobile-nav{position:fixed;width:100%;top:0;left:0;bottom:0;right:0;-webkit-transform:translateX(0);-ms-transform:translateX(0);transform:translateX(0);overflow:scroll;background:var(--main-bg-color);z-index:9;top:60px;border-top:1px solid rgba(0,0,0,0.1);-webkit-transform:translateX(100%);-ms-transform:translateX(100%);transform:translateX(100%)}.mobile-nav .search{border:0}.mobile-nav .search__input{border:0;padding:10px;background:white;margin:15px 10px;border:1px solid #ccc;border-radius:4px;padding-right:32px}.mobile-nav .search__button{border:none;position:absolute;background:transparent;height:100%;right:0;padding:20px}.mobile-nav__divider{width:100%;height:1px;background:rgba(0,0,0,0.1)!important}.mobile-nav__header{display:-webkit-box!important;display:-ms-flexbox!important;display:flex!important;-webkit-box-pack:justify;-ms-flex-pack:justify;justify-content:space-between;-webkit-box-align:center;-ms-flex-align:center;align-items:center;padding:1em 12px!important;border-bottom:1px solid rgba(0,0,0,0.1)}.mobile-nav a{color:#000;text-decoration:none;line-height:1.2;display:block;padding:8px 12px}.mobile-nav ul{list-style:none;padding:0;margin-bottom:8px}.mobile-nav .sub-menu{width:100%;background:var(--main-bg-color);margin:0}.mobile-nav__socials{display:-webkit-box;display:-ms-flexbox;display:flex}.mobile-nav__socials svg{width:2em;height:2em}.mobile-nav .cd-navigation{background:white}.mobile-nav .cd-single-item-wrapper{background:var(--main-bg-color)}.sort{display:-webkit-box;display:-ms-flexbox;display:flex;background:white;-webkit-box-shadow:0px 1px 4px rgba(0,0,0,0.1);box-shadow:0px 1px 4px rgba(0,0,0,0.1);font-size:14px}.sort__item{border-radius:4px;border:1px solid white}.sort__item a{padding:0.6em 1.2em;color:rgba(0,0,0,0.4);display:block}.sort__item--active{border-color:var(--main-accent-color)}.sort__item--active a{color:var(--main-accent-color)}.mobile-sort{display:block;font-size:14px;font-weight:700;color:rgba(0,0,0,0.4);line-height:1.3;padding:0.6em 1.4em 0.5em 0.8em;width:100%;max-width:100%;-webkit-box-sizing:border-box;box-sizing:border-box;margin:0;border:0;-moz-appearance:none;-webkit-appearance:none;appearance:none;background-color:#fff;-webkit-box-shadow:0px 1px 6px rgba(0,0,0,0.15);box-shadow:0px 1px 6px rgba(0,0,0,0.15);border-radius:4px;background-image:url("data:image/svg+xml;charset=US-ASCII,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%22292.4%22%20height%3D%22292.4%22%3E%3Cpath%20fill%3D%22%23007CB2%22%20d%3D%22M287%2069.4a17.6%2017.6%200%200%200-13-5.4H18.4c-5%200-9.3%201.8-12.9%205.4A17.6%2017.6%200%200%200%200%2082.2c0%205%201.8%209.3%205.4%2012.9l128%20127.9c3.6%203.6%207.8%205.4%2012.8%205.4s9.2-1.8%2012.8-5.4L287%2095c3.5-3.5%205.4-7.8%205.4-12.8%200-5-1.9-9.2-5.5-12.8z%22%2F%3E%3C%2Fsvg%3E"),-webkit-gradient(linear,left top,left bottom,from(#fff),to(#fff));background-image:url("data:image/svg+xml;charset=US-ASCII,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%22292.4%22%20height%3D%22292.4%22%3E%3Cpath%20fill%3D%22%23007CB2%22%20d%3D%22M287%2069.4a17.6%2017.6%200%200%200-13-5.4H18.4c-5%200-9.3%201.8-12.9%205.4A17.6%2017.6%200%200%200%200%2082.2c0%205%201.8%209.3%205.4%2012.9l128%20127.9c3.6%203.6%207.8%205.4%2012.8%205.4s9.2-1.8%2012.8-5.4L287%2095c3.5-3.5%205.4-7.8%205.4-12.8%200-5-1.9-9.2-5.5-12.8z%22%2F%3E%3C%2Fsvg%3E"),linear-gradient(to bottom,#fff 0%,#fff 100%);background-repeat:no-repeat,repeat;background-position:right 0.7em top 50%,0 0;background-size:0.65em auto,100%}.mobile-sort::-ms-expand{display:none}.mobile-sort option{font-weight:normal}.promo-links{padding-top:15px}.promo-links__wrapper{display:-webkit-box;display:-ms-flexbox;display:flex;-webkit-box-pack:justify;-ms-flex-pack:justify;justify-content:space-between;-webkit-box-align:center;-ms-flex-align:center;align-items:center}.promo-links__btn-desc{line-height:1;font-weight:normal;text-transform:none}.promo-links__btn{font-style:normal;font-weight:bold;font-size:10px;line-height:25px;color:#ffffff;text-align:center;min-width:130px;width:calc(50% - 5px);height:100px;border-radius:4px;border:none;display:-webkit-box;display:-ms-flexbox;display:flex;-webkit-box-orient:vertical;-webkit-box-direction:normal;-ms-flex-direction:column;flex-direction:column;-webkit-box-pack:center;-ms-flex-pack:center;justify-content:center;-webkit-box-align:center;-ms-flex-align:center;align-items:center;-webkit-box-shadow:0px 1px 4px rgba(0,0,0,0.1);box-shadow:0px 1px 4px rgba(0,0,0,0.1);text-transform:uppercase;padding:10px 0}.promo-links__btn--blue{background-color:var(--main-accent-color)}.promo-links__btn--red{background-color:var(--secondary-accent-color)}.without-promo-links .promo-links{display:none!important}.newsletter{background-color:#5e87b3;overflow:hidden;z-index:1}@media screen and (min-width:1024px){.newsletter{padding-bottom:2em;background-color:#5e87b3;position:relative}.newsletter .newsletter__wrapper{max-width:640px}.newsletter *{z-index:2;position:relative}.newsletter:after{content:'';background:url("/images/newsletter-full.png");background-position:left;background-size:cover;position:absolute;top:0;right:0;bottom:0;z-index:1;width:600px}}@media screen and (min-width:1024px) and (min-width:1260px){.newsletter:after{right:calc((100vw - 1375px) / 2);background-size:cover;background-position-x:center;width:640px}}.newsletter__title{color:#ffffff;margin:0px;padding-top:40px;padding-bottom:8px;font-weight:600;font-size:24px;line-height:25px}.newsletter__text{font-size:16px;line-height:140%;color:#ffffff;margin:0px;padding-bottom:24px}.newsletter__btn{background-color:#ffffff;min-width:270px;min-height:55px;border:none;border-radius:4px;-webkit-box-shadow:0px 1px 4px rgba(0,0,0,0.1);box-shadow:0px 1px 4px rgba(0,0,0,0.1)}.newsletter__download-link{display:-webkit-box;display:-ms-flexbox;display:flex;-webkit-box-align:center;-ms-flex-align:center;align-items:center;padding-top:16px}@media screen and (min-width:1024px){.newsletter__download-link{padding:0.5em 0 0.5em 1em}}.newsletter__download-link-text{padding-left:10px;color:#ffffff}.newsletter__mag{-webkit-transform:translateX(-1.5em);-ms-transform:translateX(-1.5em);transform:translateX(-1.5em)}.price-tag{background:var(--main-accent-color-darken)!important;padding:0 8px;color:white;border-radius:50px;width:-webkit-max-content;width:-moz-max-content;width:max-content}.invest-projects__grid{grid-template-columns:1fr}@media screen and (min-width:1024px){.invest-projects__grid{grid-template-columns:repeat(2,1fr)}}.invest-projects__list .cards__item:not(:last-of-type){margin-bottom:1em}@media screen and (min-width:1024px){.invest-projects__list .cards__item:not(:last-of-type){margin-bottom:0.5em}}.remodal.subscribe fieldset{display:-webkit-box;display:-ms-flexbox;display:flex}.remodal.subscribe fieldset input{min-width:2em}.remodal.subscribe fieldset label{-webkit-box-align:center!important;-ms-flex-align:center!important;align-items:center!important;margin-right:1em;display:-webkit-box;display:-ms-flexbox;display:flex}.subscription__input{border-radius:4px;font-size:16px;padding:10px;outline:0;height:36px;width:100%;-webkit-box-shadow:none;box-shadow:none;height:46px;line-height:46px;border-radius:4px;color:#1c2e36!important;border:1px solid;border-color:#ebebeb;background:#f7f7f7}.header_search{background-color:#23262f;margin-bottom:40px;display:none;min-height:64.5px;top:0;position:fixed;width:100%;z-index:100}.header_search .small-3{border-right:2px solid #fff}.header_search .logo{padding:19px 0;position:static}.header_search .search_input{padding-top:14px}.header_search .search_input button{position:static;width:auto;height:auto;padding:0;background-color:#23262f}.header_search .search_input input{display:inline-block;max-width:700px;border:0;background-color:#23262f;color:#fff;margin-bottom:0;-webkit-box-shadow:none;box-shadow:none}.header_search .search_input input::-webkit-input-placeholder{color:rgba(255,255,255,0.42);font-weight:500}.header_search .search_input input::-ms-input-placeholder{color:rgba(255,255,255,0.42);font-weight:500}.header_search .search_input i{color:#fff;font-size:18px}.header_search .search_input #close{float:right;margin-top:9px}.inline{display:inline!important}.flex{display:-webkit-box!important;display:-ms-flexbox!important;display:flex!important}@media screen and (min-width:1024px){.desktop-flex{display:-webkit-box!important;display:-ms-flexbox!important;display:flex!important}}.flex-row{-webkit-box-orient:horizontal!important;-webkit-box-direction:normal!important;-ms-flex-direction:row!important;flex-direction:row!important}.flex-col{-webkit-box-orient:vertical!important;-webkit-box-direction:normal!important;-ms-flex-direction:column!important;flex-direction:column!important}.items-center{-webkit-box-align:center!important;-ms-flex-align:center!important;align-items:center!important}@media screen and (min-width:1024px){.desktop-items-center{-webkit-box-align:center!important;-ms-flex-align:center!important;align-items:center!important}}.justify-center{-webkit-box-pack:center!important;-ms-flex-pack:center!important;justify-content:center!important}.justify-between{-webkit-box-pack:justify!important;-ms-flex-pack:justify!important;justify-content:space-between!important}@media (min-width:1024px){.mobile-only{display:none!important}}@media (max-width:1023px){.desktop-only{display:none!important}}:root{--swiper-theme-color: #007aff}:root{--swiper-navigation-size: 44px}.mb-0{margin-bottom:0em!important}.mb-2{margin-bottom:.5em!important}.mb-4{margin-bottom:1em!important}.mb-12{margin-bottom:3em!important}.mt-0{margin-top:0em!important}.mt-2{margin-top:.5em!important}.mt-3{margin-top:.75em!important}.mt-4{margin-top:1em!important}.mt-6{margin-top:1.5em!important}.ml-2{margin-left:.5em!important}.mr-2{margin-right:.5em!important}.mr-4{margin-right:1em!important}.mr-6{margin-right:1.5em!important}.mt-auto{margin-top:auto!important}.ml-auto{margin-left:auto!important}
			@media screen and (min-width:1024px){.desktop-mb-0{margin-bottom:0em!important}.desktop-mt-0{margin-top:0em!important}}@media screen and (max-width:1023px){.mobile-mt-0{margin-top:0em!important}.mobile-mt-2{margin-top:.5em!important}}.pb-0{padding-bottom:0em!important}.pt-0{padding-top:0em!important}.pr-4{padding-right:1em!important}.hide{display:none}
		</style>
	{/literal}

	{style '/css/style-v2.css' async=true}
	{style '/css/font-awesome.min.css' async=true}
	{* {style '//fonts.googleapis.com/css?family=Montserrat:400,400i,500,600,700&display=swap&subset=cyrillic,latin' async=true} *}

	{head}

	{* <script src="/js/intlTelInput-min.js"></script> *}

	{script name="intlTelInput" async="" src="/js/intlTelInput-min.js"}
	{script name="iti-load-utils" async="" src="/js/utils.js"}
	{script name="lbx_script" async="" src="/js/lbx_script.js"}
	{script name="sweetalert2" async="" src="https://cdn.jsdelivr.net/npm/sweetalert2@8"}
	{script name="lazysizes" async="" src="https://cdnjs.cloudflare.com/ajax/libs/lazysizes/5.2.2/lazysizes.min.js"}
	{script name="remodal" require="jquery" async="" src="https://cdnjs.cloudflare.com/ajax/libs/remodal/1.1.1/remodal.min.js"}
	{script name="isValidNumber" require="intlTelInput,iti-load-utils" async="" src="/js/isValidNumber.js"}

	{script 'jquery' async=""}

	{script src="/js/utm_widget1.js" async="" require="jquery" name="utm_widget1"}
	{* {script src="/js/ui.min.js" async="" require="jquery,google_maps_api" name="ui_js" } *}

	{* {script src="/js/libs.min.js" async="" require="jquery" name="libs" } *}
	{script src="/js/common-min.js" require="jquery" name="common"}

	{script src="/js/jquery.hoverIntent.minified.js" async="" name="hoverIntent" require="jquery" }
	{script src="/js/script.js" async="" require="jquery,hoverIntent" name="script"}
	{script src="/js/invest.js" async="" require="jquery" name="invest" }

	{* {script_code require=['foundation2', 'jquery']}$(document).foundation();{/script_code} *}

</head>

<body>

{literal}
<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-MHZGQ4C"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->
{/literal}

	<!-- @ts:$isNewStylesAvaible: '{$isNewStylesAvaible}' -->
	<!-- @ts:$lang+166: '{$lang}' -->

	{if $isNewStylesAvaible}
		{include 'components/header-desktop'}
		{include 'components/header-mobile'}

		<div class="mobile-only container mt-4">
			{block 'side_buttons'}
				{include 'components/promo-links'}
			{/block}
		</div>
	{else}
		{include 'components/header-desktop-old'}
		{include 'components/header-mobile-old'}
		<div class="grid-container tablet_buttons">
			<div class="grid-x grid-margin-x">
				{block 'side_buttons'}
					<a href="{if $lang=='en'}/en{elseif $lang=='uk'}/uk{/if}/investor"
						class="tablet_button1">{if $lang=='en'}invest{elseif $lang=='uk'}інвестувати{else}инвестировать{/if}</a>
					<a href="{if $lang=='en'}/en{elseif $lang=='uk'}/uk{/if}/add-inv-prop" class="tablet_button2">{if $lang=='en'}Find
					an investor{elseif $lang=='uk'}Знайти інвестора
					{else}Найти инвестора
					{/if}</a>
			{/block}
		</div>
	</div>
	{/if}

	<div class="off-canvas-wrap" data-offcanvas="">
		<div
			class="inner-wrap {if $request->getPathInfo() == '/add-inv-prop' || $request->getPathInfo() == '/investor' }pt-0{/if}">
			{block content}
				{$content}
			{/block}
			<a class="exit-off-canvas" href="#"></a>
		</div>
	</div>
	{#mod 'Widget'}
	<ul class="small-block-grid-1 medium-block-grid-2 large-block-grid-2">
		<li>
			{widget_slot 'footer_1 (728x90)' size=[729, 90]}
		</li>
		<li>
			{widget_slot 'footer_2 (728x90)' size=[729, 90]}
		</li>
	</ul>
	{#/mod}

	{if $isNewStylesAvaible}
		{include 'components/footer'}
	{else}
		{include 'components/footer-old'}
	{/if}



	<div class="up" style="display: none;">
		<img src="/images/up.svg" alt="{if lang=='en'}Go up{else}Вверх{/if}" title="{if lang=='en'}Go up{else}Вверх{/if}">
		{* <img src="/i/up.png" alt="Вверх" title="Вверх"> *}
	</div>



	<!-- Scripts on loading page -->

	{literal}
		<!-- Google Analytics -->
		<script>
			(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
			(i[r].q = i[r].q || []).push(arguments)
			}, i[r].l = 1 * new Date();
			a = s.createElement(o),
				m = s.getElementsByTagName(o)[0];
			a.async = 1;
			a.src = g;
			m.parentNode.insertBefore(a, m)
			})
			(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

			ga('create', 'UA-42378215-1', 'inventure.com.ua');
			ga('send', 'pageview');
		</script>
		<!-- Google Analytics End -->
	{/literal}
	<!-- Scripts on loading page  End -->
	</div><!-- wrapper end -->
	{*
<div id="questionForm" class="reveal-modal questionFormCenter" data-reveal style="display:none">
    <h2>Задать вопрос</h2>
    {form callback}
    <a class="close-reveal-modal">&#215;</a>
</div>
*}
	{if $user && $user->canAccess('Page.publish') && ($page || $post || $blog)}
		<div class="admin_edit">
			<a href="{if $page}/admin/page/edit/{$page->getId()}{else}{if $post}/admin/blog/{$blog->getId()}/edit/{$post->getId()}{else}/admin/blog/{$blog->getId()}{/if}{/if}"
				title="edit" class="icon-edit">Редактировать</a>
		</div>

		{script_code require="jquery"}
		console.log('+815 content editable init');

		jQuery('.the_post_content').attr('contenteditable', true);
		jQuery('.admin_edit').append('<br><button class="save-inline-edits">Сохранить изменения</button>');
		jQuery('.save-inline-edits').click(function(){
		console.log('+821 save edits with new text: ' + jQuery('.the_post_content').html());
		console.log('+822 location path: ' + window.location.pathname);
		{literal}
			jQuery.post('/invest.php', {'action':'set','data':jQuery('.the_post_content').html(),'path':window.location.pathname},
			function(res1){ console.log('+824 Got result: ' + res1); });
		{/literal}
		});

		{/script_code}

	{/if}

	{if $isNewStylesAvaible}
		{include 'components/callback'}
	{else}
		{include 'components/callback-old'}
	{/if}



	<script>
		window.lazySizesConfig = window.lazySizesConfig || {};
		window.lazySizesConfig.customMedia = {
			'--mobile': '(max-width: 1023px)',
			'--desktop': '(min-width: 1024px)',
		};
	</script>
</body>

</html>