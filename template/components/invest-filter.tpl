<form action="{if $lang === 'en'}/en{elseif $lang === 'uk'}/uk{/if}/investments" id="invest-filter" class="filter__wrapper">
    <div class="filter__selectors {if $smarty.server.REQUEST_URI !== '/'}mb-4{/if}">
        <div class="filter__title"><span>{if $lang === 'ru'}Поиск{elseif $lang === 'uk'}Пошук{else}Search{/if}</span>
            <div class="filter__heading-filter toggle-filter">
                <i class="fa fa-close" aria-hidden="true"></i>
            </div>
        </div>
        <div class="filter__selector mt-4 mb-4">
        <label class="filter__row" for="">
            <span class="filter__label">{if $lang === 'ru'}Тип{elseif $lang === 'uk'}Тип{else}Category{/if}</span>
            <select class="" id="filter__type" name="filter[category][parent]" multiple="multiple">
                <option value="projects">{if $lang === 'ru'}Инвестиционные проекты и стартапы{elseif $lang === 'uk'}Інвестиційні проекти та стартапи{else}Investment Projects and Startups{/if}</option>
                <option value="business">{if $lang === 'ru'}Продажа бизнеса{elseif $lang === 'uk'}Продаж бізнесу{else}Business for Sale{/if} </option>
                <option value="realestate">{if $lang === 'ru'}Недвижимость{elseif $lang === 'uk'}Нерухомість{else}Commercial Property{/if}</option>
                <option value="land">{if $lang === 'ru'}Земля{elseif $lang === 'uk'}Земля{else}Land{/if}</option>
                <option value="franchising">{if $lang === 'ru'}Франчайзинг{elseif $lang === 'uk'}Франчайзинг{else}Franchising{/if}</option>
                <option value="offer">{if $lang === 'ru'}Предложения инвесторов{elseif $lang === 'uk'}Інвестиційні пропозиції{else}Investor Offers{/if}</option>
            </select>
        </label>
        </div>
        
        <div class="filter__selector mb-4">
        <label class="filter__row" for="">
            <span class="filter__label">{if $lang === 'ru'}Отрасль{elseif $lang === 'uk'}Галузь{else}Industry{/if}</span>
            <select class="" id="branch" name="filter[attr_16][0]" multiple="multiple">
                <option value="0">{if $lang === 'ru'}Сельское хозяйство{elseif $lang === 'uk'}Сільське господарство{else}Agriculture{/if}</option>
                <option value="16">{if $lang === 'ru'}Пищевая промышленность{elseif $lang === 'uk'}Харчова промисловість{else}Food processing{/if}</option>
                <option value="1">{if $lang === 'ru'}Добывающая промышленность{elseif $lang === 'uk'}Видобувна промисловість{else}Mining{/if}</option>
                <option value="12">{if $lang === 'ru'}Металлургия{elseif $lang === 'uk'}Металургія{else}Metallurgy{/if}</option>
                <option value="11">{if $lang === 'ru'}Машиностроение{elseif $lang === 'uk'}Машинобудування{else}Machinery{/if}</option>
                <option value="23">{if $lang === 'ru'}Химическая промышленность{elseif $lang === 'uk'}Хімічна промисловість{else}Сhemical{/if}</option>
                <option value="8">{if $lang === 'ru'}Деревообработка{elseif $lang === 'uk'}Деревообробка{else}Wood processing{/if}</option>
                <option value="20">{if $lang === 'ru'}Текстильная промышленность{elseif $lang === 'uk'}Текстильна промисловість{else}Textile{/if}</option>
                <option value="4">{if $lang === 'ru'}Строительство и недвижимость{elseif $lang === 'uk'}Будівництво та нерухомість{else}Construction and real estate{/if}</option>
                <option value="22">{if $lang === 'ru'}Финансовая деятельность{elseif $lang === 'uk'}Фінансова діяльність{else}Finance{/if}</option>
                <option value="6">{if $lang === 'ru'}Бизнес услуги{elseif $lang === 'uk'}Бізнес послуги{else}Business services{/if}</option>
                <option value="21">{if $lang === 'ru'}Транспорт и логистика{elseif $lang === 'uk'}Транспорт та логістика{else}Transport and logistic{/if}</option>
                <option value="19">{if $lang === 'ru'}ИТ и телекоммуникации{elseif $lang === 'uk'}ІТ та телекомунікації{else}IT and telecommunications{/if}</option>
                <option value="18">{if $lang === 'ru'}Розничная торговля{elseif $lang === 'uk'}Роздрібна торгівля{else}Retail{/if}</option>
                <option value="14">{if $lang === 'ru'}Оптовая торговля{elseif $lang === 'uk'}Оптова торгівля{else}Wholesale{/if}</option>
                <option value="10">{if $lang === 'ru'}Искусство, развлечения, спорт и отдых{elseif $lang === 'uk'}Мистецтво, розваги, спорт та відпочинок{else}Arts, entertainment, sports and recreation{/if}</option>
                <option value="2">{if $lang === 'ru'}Энергетика{elseif $lang === 'uk'}Енергетика{else}Energy{/if}</option>
                <option value="3">{if $lang === 'ru'}Водообеспечение и переработка отходов{elseif $lang === 'uk'}Водозабезпечення та переробка сміття{else}Water supply and waste treatment{/if}</option>
                <option value="24">{if $lang === 'ru'}Инновации и высокие технологии{elseif $lang === 'uk'}Іновації та високі технології{else}Innovation and high technology{/if}</option>
                <option value="7">{if $lang === 'ru'}Государственное управление{elseif $lang === 'uk'}Державне управління{else}Public administration{/if}</option>
                <option value="17">{if $lang === 'ru'}Гостиницы и рестораны{elseif $lang === 'uk'}Готелі та ресторани{else}Hotels and restaurants{/if}</option>
                <option value="9">{if $lang === 'ru'}Здравоохранение и социальная помощь{elseif $lang === 'uk'}Охорона здоров'я та соціальна допомога{else}Health care and social assistance{/if}</option>
                <option value="5">{if $lang === 'ru'}Потребительские услуги{elseif $lang === 'uk'}Споживчі послуги{else}Consumer services{/if}</option>
                <option value="13">{if $lang === 'ru'}Образование{elseif $lang === 'uk'}Освіта{else}Education{/if}</option>
                <option value="15">{if $lang === 'ru'}Организации и ассоциации{elseif $lang === 'uk'}Організації та асоціаціі{else}Organizations and associations{/if}</option>
            </select>
        </label>
        </div>
        
        <div class="filter__selector mb-4">
            <label  class="filter__row" for="">
                <span class="filter__label">{if $lang === 'ru'}Регион{elseif $lang === 'uk'}Регіон{else}Region{/if}</span>
                <input class="filter__input" type="text" name="region" id="region" value="">
                <i qtype="IconFind"></i>
            </label>
            <input type="hidden" name="filter[attr_10]" id="region_val" value="">
        </div>
            
        <div class="filter__selector filter__selector--price">
            <label  class="filter__row  mb-4" for="">
                <span class="filter__label">{if $lang === 'ru'}Цена от{elseif $lang === 'uk'}Цена від{else}Price from{/if}</span>
                <select name="price1" class="multiple-select" data-single="true">
                    <option selected value="">$ 0</option>
                    <option value="10000">$ 10 000</option>
                    <option value="50000">$ 50 000</option>
                    <option value="100000">$ 100 000</option>
                    <option value="250000">$ 250 000</option>
                    <option value="500000">$ 500 000</option>
                    <option value="1000000">$ 1 000 000</option>
                    <option value="5000000">$ 5 000 000</option>
                    <option value="5000000+">$ 5 000 000+</option>
                </select>
            </label>
            <label  class="filter__row" for="">
                <span class="filter__label">{if $lang === 'ru'}До{elseif $lang === 'uk'}До{else}To{/if}</span>
                <select name="price2" class="multiple-select" data-single="true">
                    <option value="10000">$ 10 000</option>
                    <option value="50000">$ 50 000</option>
                    <option value="100000">$ 100 000</option>
                    <option value="250000">$ 250 000</option>
                    <option value="500000">$ 500 000</option>
                    <option value="1000000">$ 1 000 000</option>
                    <option value="5000000">$ 5 000 000</option>
                    <option selected value="">$ 5 000 000+</option>
                </select>
            </label>
        </div>
        <button type="submit" class="btn btn--blue mt-6 btn--normal">{if $lang === 'ru'}Искать{elseif $lang === 'uk'}Пошук{else}Search{/if}</button>
    </div>
</form>

{* 
<form action="/investments" id="invest-filter" class="filter__wrapper">
        <div class="filter__selectors">
            <div class="filter__title"><span>Фильтрация</span>  
            <div class="filter__heading-filter toggle-filter">
            <i class="fa fa-close" aria-hidden="true"></i>
            </div>
    </div>
    <div class="filter__selector">
        <label class="filter__row" for="">
            <span class="filter__label">Тип</span>
            <select class="" id="filter__type" name="filter[category][parent]" multiple="multiple">
            <option value="projects">Инвестиционные проекты и стартапы</option>
            <option value="business">Продажа бизнеса</option>
            <option value="realestate">Недвижимость</option>
            <option value="land">Земля</option>
            <option value="franchising">Франчайзинг</option>
            <option value="offer">Предложения инвесторов</option>
            </select>
        </label>
    </div>
    
    <div class="filter__selector">
        <label class="filter__row" for="">
        <span class="filter__label">Отрасль</span>
        <select class="" id="branch" name="filter[attr_16][0]" multiple="multiple">
            <option value="0">Сельское хозяйство</option>
            <option value="16">Пищевая промышленность</option>
            <option value="1">Добывающая промышленность</option>
            <option value="12">Металлургия и металлообработка</option>
            <option value="11">Машиностроение и производство электрооборудования</option>
            <option value="23">Нефтехимическая промышленность</option>
            <option value="8">Деревообработка и целлюлозно-бумажная промышленность</option>
            <option value="20">Текстильная промышленность</option>
            <option value="4">Строительство и недвижимость</option>
            <option value="22">Финансовая деятельность</option>
            <option value="6">Бизнес услуги</option>
            <option value="21">Транспорт и складское хозяйство</option>
            <option value="19">ИТ и Телекоммуникации</option>
            <option value="18">Розничная торговля</option>
            <option value="14">Оптовая торговля</option>
            <option value="10">Искусство, развлечения, спорт и отдых</option>
            <option value="2">Энергообеспечение</option>
            <option value="3">Водообеспечение и переработка отходов</option>
            <option value="24">Инновации и высокие технологии</option>
            <option value="7">Государственное управление</option>
            <option value="17">Гостиницы и общественное питание</option>
            <option value="9">Здравоохранение и социальная помощь</option>
            <option value="5">Потребительские услуги</option>
            <option value="13">Образование</option>
            <option value="15">Организации и ассоциации</option>
        </select>
        </label>
    </div>
                    
    <div class="filter__selector">
        <label  class="filter__row" for="">
        <span class="filter__label">Регион</span>
        <!-- select name="filter[attr_10]" id="regions" multiple="multiple">
            <option value="Kiev">Киев</option>
            <option value="Ukraine">Украина</option>
            <option value="SNG">СНГ</option>
            <option value="Central and Western Europe">Центральная и Восточная Европа</option>
            <option value="Eastern Europe">Западная Европа</option>
            <option value="USA">США</option>
            <option value="Asia">Азия</option>
        </select -->
        <input type="text" name="region" id="region" value="">
        </label>
        <input type="hidden" name="filter[attr_10]" id="region_val" value="">
    </div>
        
        <div class="filter__selector filter__selector--price">
        <label  class="filter__row" for="">
            <span class="filter__label">Цена от</span>
            <select name="price1" class="multiple-select" data-single="true">
            <option selected value="">0 $</option>
            <option value="10000">10 000 $</option>
            <option value="50000">50 000 $</option>
            <option value="100000">100 000 $</option>
            <option value="250000">250 000 $</option>
            <option value="500000">500 000 $</option>
            <option value="1000000">1 000 000 $</option>
            <option value="5000000">5 000 000 $</option>
            <option value="5000000+">5 000 000+ $</option>
            </select>
        </label>
        <label  class="filter__row" for="">
            <span class="filter__label">До</span>
            <select name="price2" class="multiple-select" data-single="true">
            <option value="10000">10 000 $</option>
            <option value="50000">50 000 $</option>
            <option value="100000">100 000 $</option>
            <option value="250000">250 000 $</option>
            <option value="500000">500 000 $</option>
            <option value="1000000">1 000 000 $</option>
            <option value="5000000">5 000 000 $</option>
            <option selected value="">5 000 000+ $</option>
            </select>
        </label>
        </div>
    </div>
    <button class="newsletter__button newsletter__button--darken">Фильтровать</button>
</form> *}