{extends 'Page.view'}
{block 'breadcrumbs'}{/block}
{block 'page.class' append} add-inv-prop{/block}
{block 'content.text' prepend}
<!-- <img src="/i/add-inv-prop-img.png" itemscope itemtype="http://schema.org/ImageObject"> -->

<p class="add-inv-prop__heading">InVenture, основываясь на многолетнем и успешном опыте работы на инвестиционном рынке, разработала для соискателей инвестиций и продавцов бизнеса комплекс технологических инструментов, направленных на скорейшую продажу компаний и привлечение капитала в инвестиционные проекты.</p>
<div class="grid-x price-table">
  <div class="cell large-4 price text-center ">
    <div class="price__header">
        <div class="price__title">Доска объявлений</div>
        <div class="price__subtitle">для малого бизнеса</div>
    </div>
    <ul class="price__advantages">
        <li><i class="fa fa-check-circle"></i> Размещение на доске объявлений InVenture</li>
    </ul>
    <div class="price__button-wrapper grid-x">
        <a href='/bulletin/add' class="blue_but cell-but price__button  small-12  medium-4 large-12 medium-offset-4 large-offset-0">Разместить</a>
    </div>
  </div>
  <div class="cell large-4 price text-center ">
    <div class="price__header">
        <div class="price__title">Реклама и продвижение</div>
        <div class="price__subtitle">для малого и среднего бизнеса</div>
    </div>
    <ul class="price__advantages">
        <li><i class="fa fa-check-circle"></i><p>Размещение на инвестиционном портале InVenture <span> – 150 000+ посетителей в месяц</span></p></li>
        <li><i class="fa fa-check-circle"></i><p> Размещение в журнале «Инвестиционный дайджест InVenture» <span> с рассылкой по базе 13 700+ подписчиков</span></p></li>
        <li><i class="fa fa-check-circle"></i><p> Рассылка по базе инвесторов <span> - 3200+ инвесторов (Украина, СНГ, ЕС, США, Азия)</span></p></li>
        <li><i class="fa fa-check-circle"></i><p> Продвижение в Facebook, LinkedIn, Telegram <span>- 15 000+ подписчиков</span></p></li>
        <li><i class="fa fa-check-circle"></i><p> Размещение на специализированных интернет площадках и досках объявлений <span> – 5 сайтов</span></p></li>
        <li><i class="fa fa-check-circle"></i><p> Рекламный баннер на инвестиционном портале InVenture <span> – отображение на всех страницах портала </span></p></li>
    </ul>
    <div class="price__button-wrapper grid-x">
        <button class="blue_but cell-but price__button  small-12 medium-4 large-12 medium-offset-4 large-offset-0 open_popup">Подробнее</button>
    </div>
  </div>
  <div class="cell large-4 price text-center ">
    <div class="price__header">
        <div class="price__title">Индивидуальный подход</div>
        <div class="price__subtitle">для среднего и крупного бизнеса</div>
    </div>
    <ul class="price__advantages">
        <li><i class="fa fa-check-circle"></i> <p>Индивидуальный комплекс продвижения и рекламы инвестиционного предложения <span> (усиленная рекламная компания, завуалированное предложение)
        </span></p></li>
        <li><i class="fa fa-check-circle"></i> <p>Разработка профессиональной презентации для работы с инвесторами <span>(инвестиционный меморандум / тизер) </span></p></li>
        <li><i class="fa fa-check-circle"></i><p> Прямые продажи <span> (анализ целевой аудитории и выход на потенциальных инвесторов, проведение профессиональной презентации, организация поездок для показа активов, совместные встречи с инвесторами и медиация переговорного процесса) </span></p></li>
        <li><i class="fa fa-check-circle"></i> <p>Консультационное сопровождение на всех этапах сделки <span>(предпродажная подготовка, оценка активов, медиация в переговорных процессах, юридическая схема сделки и др.)</span> </p></li>
    </ul>
    <div class="price__button-wrapper grid-x">
        <button class="blue_but cell-but price__button  small-12  medium-4 large-12 medium-offset-4 large-offset-0 open_popup">Подробнее</button>
    </div>
  </div>
</div>

<div class="dark_bg"></div>
<div class="my_popup">
    <div class="my_popup__wrapper">
        <h5>Заполните пожалуйста Ваши контактные данные и мы направим условия сотрудничества</h5>
        <i class="fa fa-close"></i>
        {form 'approach'}
    </div>
</div>
    <!-- <table class="add-inv-prop-table" >
        <thead>
            <tr>
                <td></td>
                <td>Разместить обьявления</td>
                <td>Комплексный подход</td>
                <td>Индивидуальный подход</td>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>Масштаб</td>
                <td>Малый бизнес</td>
                <td>Малый бизнес<br>Средний бизнес</td>
                <td>Средний бизнес<br>Крупный бизнес</td>
            </tr>
            <tr>
                <td>Интернет продажи</td>
                <td><img src="i/check.png"></td>
                <td><img src="i/check.png"></td>
                <td><img src="i/check.png"></td>
            </tr>
            <tr>
                <td>Прямые продажи</td>
                <td></td>
                <td></td>
                <td><img src="i/check.png"></td>
            </tr>
            <tr>
                <td>Комиссия</td>
                <td></td>
                <td><img src="i/check.png"></td>
                <td><img src="i/check.png"></td>
            </tr>
            <tr>
                <td>Сопровождение сделки</td>
                <td></td>
                <td><img src="i/check.png"></td>
                <td><img src="i/check.png"></td>
            </tr>
            <tr>
                <td>Консультационная поддержка</td>
                <td></td>
                <td><img src="i/check.png"></td>
                <td><img src="i/check.png"></td>
            </tr>
            <tr>
                <td>Индивидуальнальний менеджер</td>
                <td></td>
                <td></td>
                <td><img src="i/check.png"></td>
            </tr>
            <tr>
                <td>Бюджет</td>
                <td><img src="i/gold_1.png"></td>
                <td><img src="i/gold_3.png"></td>
                <td><img src="i/gold_5.png"></td>
            </tr>
            <tfoot>
                <td></td>
                <td><a href="/bulletin/add">Подробнее</a></td>
                <td><a href="/complex-approach">Подробнее</a></td>
                <td><a href="http://inventure.ua">Подробнее</a></td>
            </tfoot>
        </tbody>
    </table> -->
{/block}