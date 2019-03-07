{extends 'Page.view'}
{block 'breadcrumbs'}{/block}
{block 'page.class' append} add-inv-prop{/block}
{block 'content.text' prepend}

<p class="add-inv-prop__heading"><b>InVenture Investment Group</b> has a huge experience in the investment market and provides a set of technological tools for investment applicants and business sellers that will help to raise capital or sell a business.</p>
<div class="grid-x price-table">
  <div class="cell large-6 price text-center ">
    <div class="price__header">
        <div class="price__title">Investment advertising and promotion</div>
        <div class="price__subtitle">for small and medium businesses</div>
    </div>
    <ul class="price__advantages">
        <li><i class="fa fa-check-circle"></i><p>Placing an offer on the largest Investment portal InVenture   <span> - 150 000+ visitors per month </span> </p></li>
        <li><i class="fa fa-check-circle"></i><p>Placing an offer in the monthly magazine “Investment Digest InVenture”   <span> - 13 700+ subscribers </span> </p></li>
        <li><i class="fa fa-check-circle"></i><p>Weekly newsletter through InVenture’s investors a database   <span> - 3200+ investors (Ukraine, CIS, EU, US, Asia) </span> </p></li>
        <li><i class="fa fa-check-circle"></i><p>Promotion of the offer in own investment communities Facebook, LinkedIn, Telegram   <span> (15 000+ subscribers) </span> </p></li>
        <li><i class="fa fa-check-circle"></i><p>Placing an offer manually on specialized websites and investment advertising boards  <span>  - 5 sites </span> </p></li>
        <li><i class="fa fa-check-circle"></i><p>Placing an advertising banner on the Investment portal InVenture   <span> (150,000+ target audience hits per month) </span> </p></li>
    </ul>
    <div class="price__button-wrapper grid-x">
        <button class="blue_but cell-but price__button  small-12 medium-4 large-12 medium-offset-4 large-offset-0 open_popup">Подробнее</button>
    </div>
  </div>
  <div class="cell large-6 price text-center ">
    <div class="price__header">
        <div class="price__title">Individual approach</div>
        <div class="price__subtitle">for medium and large businesses</div>
    </div>
    <ul class="price__advantages">
        <li><i class="fa fa-check-circle"></i><p>Individual complex of promotion and advertising of the investment proposal <span> (enhanced advertising campaign)</span></p></li>
        <li><i class="fa fa-check-circle"></i><p>Development of a professional presentation for investors <span> (investment memorandum / teaser)</span></p></li>
        <li><i class="fa fa-check-circle"></i><p>Direct sales and individual promotion <span> (analysis of the target audience and access to potential investors, professional presentation, organizing trips to show assets, joint meetings with investors and mediation of the negotiation process with investors)</span></p></li>
        <li><i class="fa fa-check-circle"></i><p>Consulting support at all stages of the transaction <span> (pre-sale preparation, asset valuation, mediation in negotiation processes, developing a legal scheme of the transaction, etc.)</span></p></li>
    </ul>
    <div class="price__button-wrapper grid-x">
        <button class="blue_but cell-but price__button  small-12 medium-4 large-12 medium-offset-4 large-offset-0 open_popup">Подробнее</button>
    </div>
  </div>
  <!-- <div class="cell large-4 price text-center ">
    <div class="price__header">
        <div class="price__title">Индивидуальный подход</div>
        <div class="price__subtitle">для среднего и крупного бизнеса</div>
    </div>
    <ul class="price__advantages">
        <li><i class="fa fa-check-circle"></i> <p>Индивидуальный комплекс продвижения и рекламы инвестиционного предложения <span> (усиленная рекламная кампания, завуалированное предложение)
        </span></p></li>
        <li><i class="fa fa-check-circle"></i> <p>Разработка профессиональной презентации для работы с инвесторами <span>(инвестиционный меморандум / тизер) </span></p></li>
        <li><i class="fa fa-check-circle"></i><p> Прямые продажи <span> (анализ целевой аудитории и выход на потенциальных инвесторов, проведение профессиональной презентации, организация поездок для показа активов, совместные встречи с инвесторами и медиация переговорного процесса) </span></p></li>
        <li><i class="fa fa-check-circle"></i> <p>Консультационное сопровождение на всех этапах сделки <span>(предпродажная подготовка, оценка активов, медиация в переговорных процессах, юридическая схема сделки и др.)</span> </p></li>
    </ul>
    <div class="price__button-wrapper grid-x">
        <button class="blue_but cell-but price__button  small-12  medium-4 large-12 medium-offset-4 large-offset-0 open_popup">Подробнее</button>
    </div>
  </div> -->
</div>

<div class="dark_bg"></div>
<div class="my_popup">
    <div class="my_popup__wrapper">
        <h5>Please fill in your contact details and we will send the terms of cooperation</h5>
        <i class="fa fa-close"></i>
        {form 'approach'}
    </div>
</div>
 <!--    <img src="/i/add-inv-prop-img.png" itemscope itemtype="http://schema.org/ImageObject">
    <table class="add-inv-prop-table">
            <thead>
                <tr>
                    <td></td>
                    <td>Complex Approach </td>
                    <td>Individual Approach</td>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Scale</td>
                    <td>Small Business<br> and Medium Business</td>
                    <td>Medium Business<br> and Big Business</td>
                </tr>
                <tr>
                    <td>Online sales</td>
                    <td><img src="/i/check.png"></td>
                    <td><img src="/i/check.png"></td>
                </tr>
                <tr>
                    <td>Direct sales</td>
                    <td></td>
                    <td><img src="/i/check.png"></td>
                </tr>
                <tr>
                    <td>Success Fee</td>
                    <td><img src="/i/check.png"></td>
                    <td><img src="/i/check.png"></td>
                </tr>
                <tr>
                    <td>Deal support</td>
                    <td><img src="/i/check.png"></td>
                    <td><img src="/i/check.png"></td>
                </tr>
                <tr>
                    <td>Consulting support</td>
                    <td><img src="/i/check.png"></td>
                    <td><img src="/i/check.png"></td>
                </tr>
                <tr>
                    <td>Individual manager</td>
                    <td></td>
                    <td><img src="/i/check.png"></td>
                </tr>
                <tr>
                    <td>Budget</td>
                    <td><img src="/i/gold_3.png"></td>
                    <td><img src="/i/gold_5.png"></td>
                </tr>
                <tfoot>
                    <td></td>
                    <td><a href="/en/complex-approach">Read more</a></td>
                    <td><a href="">Read more</a></td>
                </tfoot>
            </tbody>
        </table> -->
{/block}
