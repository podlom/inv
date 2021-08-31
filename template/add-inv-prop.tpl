{extends 'Page.view'}
{block 'breadcrumbs'}{/block}
{block 'page.class' append} add-inv-prop{/block}
{block 'content.text'}
<style>
.tablet_buttons {
    display: none;
}
@media screen and (min-width:1024px){
    .investor-proposals__header:after{
        position:absolute;
        content:url("/images/rocket.svg");
        z-index:-1;
        top:-20px;
        right:30px;
        max-width:515px;
        display:block;
    }
}
</style>

<section class="investor-proposals">
    <div class="container">
        <div class="investor-proposals__header">
            <div>
            <h1 class="investor-proposals__title">
            {if $lang === 'ru'}
                Привлечение инвестиций, продажа бизнеса и коммерческой недвижимости в Украине
            {else}
                Services for Raising Capital & Sell a Business
            {/if}
                
            </h1>
            <div class="investor-proposals__description">
                
                {if $lang === 'ru'}
                    <p>
                    За более чем 10 лет работы на инвестиционном рынке Украины, мы разработали действенные инструменты по привлечению инвестиций, продаже бизнеса, франшиз и коммерческой недвижимости.
                    </p>
                    <p class="mt-2 font-bold">
                    Выберите подходящий Вам формат сотрудничества:
                    </p>
                {else}
                    <p>
                        For more than 10 years of work in the investment market of Ukraine, we have developed effective tools for investment seekers and business sellers.
                    </p>
                    <p>
                        Choose the format of cooperation that suits for you to speed up sell a business or raise a capital.
                    </p>
                {/if}
            </div>
        </div>
    </div>
    <div class="investor-proposals__form">
        <div class="investor-proposals__proposal proposal">
        <h2 class="proposal__title">{if $lang === 'ru'}Рекламный подход{else}Investment advertising and promotion{/if}</h2>
        <p class="proposal__description">
            {if $lang === 'ru'}
                Подойдет для продажи малого или среднего бизнеса, объекта недвижимости, франшизы или стартапа, когда требуется донести информацию до широкого круга инвесторов.
            {else}
                Suitable for small or medium businesses, real estate or start-ups when it is required to bring information to a large number of investors 
            {/if}
        </p>
        <h3 class="proposal__features-title">Вы получите:</h3>
        <ul class="proposal__features-list">
            <li>{if $lang === 'ru'}Размещение на инвестиционном портале InVenture{else}Placing an offer on the largest Investment portal InVenture   <span> - 150 000+ visitors per month </span> {/if}</li>
            <li>{if $lang === 'ru'}Размещение в журнале «Инвестиционный дайджест InVenture»{else}Placing an offer in the monthly magazine “Investment Digest InVenture”   <span> - 13 700+ subscribers </span> {/if}</li>
            <li>{if $lang === 'ru'}Рекламный баннер на инвестиционном портале InVenture{else}Weekly newsletter through InVenture’s investors a database   <span> - 3200+ investors (Ukraine, CIS, EU, US, Asia) </span> {/if}</li>
            <li>{if $lang === 'ru'}Продвижение в соцсетях (Facebook, LinkedIn, Telegram){else}Promotion of the offer in own investment communities Facebook, LinkedIn, Telegram   <span> (15 000+ subscribers) </span> {/if}</li>
            {if $lang === 'ru'}<li>Настройка контекстной рекламы Google Ads</li>{/if}
            <li>{if $lang === 'ru'}Размещение на специализированных интернет площадках и досках объявлений{else}Placing an offer manually on specialized websites and investment advertising boards  <span>  - 5 sites </span> {/if}</li>
            {if $lang === 'ru'}<li>Размещение в отраслевом аналитическом исследовании</li>{/if}
            <li>{if $lang === 'ru'}Рассылка по крупнейшей базе инвесторов{else}Placing an advertising banner on the Investment portal InVenture   <span> (150,000+ target audience hits per month) </span> {/if}</li>
        </ul>

        <button data-deal-name="Рекламное продвижение" data-remodal-target="approach" class="btn btn--blue btn--blue-text w-full add-inv-prop-btn">
            {if $lang === 'ru'}
                Получить условия
            {else}
                Get terms
            {/if}
        </button>
        </div>
        <div class="investor-proposals__proposal proposal proposal--blue">
        <h2 class="proposal__title">{if $lang === 'ru'}Полное сопровождение{else}Individual approach{/if}</h2>
        <p class="proposal__description">
            {if $lang === 'ru'}
                Подойдет для продажи среднего и крупного бизнеса, привлечения инвестиций в масштабные инвестпроекты, когда требуется индивидуальный и комплексный подход по поиску инвестора.
            {else}
                Suitable for medium and large businesses or large-scale investment projects where an individual and comprehensive approach to investor relations is required.
            {/if}
        </p>
        <h3 class="proposal__features-title">Вы получите:</h3>
        <ul class="proposal__features-list proposal__features-list--light">
						{if $lang === 'ru'}<li>Профессиональную презентацию для работы с инвесторами</li>{/if}
						{if $lang === 'ru'}<li>Рекомендации по предпродажной подготовке бизнеса</li>{/if}
            <li>{if $lang === 'ru'}Прямые продажи и целенаправленный поиск инвесторов{else}Consulting support at all stages of the transaction {/if}</li>
            <li>{if $lang === 'ru'}Индивидуальный комплекс продвижения инвестиционного предложения{else}Individual complex of promotion and advertising of the investment proposal {/if}</li>
            <li>{if $lang === 'ru'}Консультационное сопровождение на всех этапах сделки{else}Direct sales and individual promotion </span>{/if}</li>
            {if $lang !== 'ru'}<li>Development of a professional presentation for investors</li>{/if}
						{if $lang === 'ru'}<li>Координация процесса Due Diligence</li>{/if}
						{if $lang === 'ru'}<li>Медиация в переговорных процессах</li>{/if}
        </ul>

        <button data-deal-name="Индивидуальный подход" data-remodal-target="approach" class="btn btn--white btn--blue-text w-full add-inv-prop-btn">
            {if $lang === 'ru'}
                Получить условия
            {else}
                Get terms
            {/if}
        </button>
        </div>
    </div>
    {if $lang === 'ru'}
      <div class="investor-proposals__statistics statistics">
        <div class="statistics__block">
        <div class="statistics__number">300 000+</div>
        <div class="statistics__caption">Посетителей в месяц</div>
        </div>
        <div class="statistics__block">
        <div class="statistics__number">16 700+</div>
        <div class="statistics__caption">База email подписчиков</div>
        </div>
        <div class="statistics__block">
        <div class="statistics__number">23 000+</div>
        <div class="statistics__caption">Подписчиков в соцсетях</div>
        </div>
        <div class="statistics__block">
        <div class="statistics__number">45+</div>
        <div class="statistics__caption">Закрытых сделок</div>
        </div>
        <div class="statistics__block">
        <div class="statistics__number">$170+</div>
        <div class="statistics__caption">Стоимость закрытых сделок</div>
        </div>
    </div>{else}
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
        <div class="statistics__number">23 000+</div>
        <div class="statistics__caption">Subscribers in social media</div>
        </div>
        <div class="statistics__block">
        <div class="statistics__number">45+</div>
        <div class="statistics__caption">Closed deals</div>
        </div>
        <div class="statistics__block">
        <div class="statistics__number">$170+</div>
        <div class="statistics__caption">Стоимость закрытых сделок</div>
        </div>
    </div>{/if}

    </div>
</section>


{include 'components/reviews' category='add-inv-prop'}

<div class="remodal callback" data-remodal-id="approach">
  <button data-remodal-action="close" class="remodal-close"></button>
  <div class="remodal__title">
    {if $lang === 'ru'}
        Заполните контактные данные и мы направим условия сотрудничества
    {else}
        Please fill in your contact details and we will send the terms of cooperation
    {/if}
  </div>
  <div class="callback__form">
    {form 'approach'}
  </div>
</div>

<div class="remodal callback" data-remodal-id="successModal">
  <button data-remodal-action="close" class="remodal-close"></button>
  <div class="remodal__title">
      Благодарим за Ваш запрос!
  </div>
	<div class="text-left callback__form">
		<p>
			Мы отправили Вам на почту презентацию с описанием условий сотрудничества.
		</p>
		<p> 
			Наш менеджер свяжется с Вами в течение одного рабочего дня.
		</p>
		<a target="_blank" href="/" class="w-full blue_but cell-but small-12" type="submit">Открыть сейчас</a>
		<button data-remodal-action="close" type='button' class="w-full blue_but cell-but  small-12 close__popup">Закрыть</button>
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
