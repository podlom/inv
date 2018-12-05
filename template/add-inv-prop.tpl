{extends 'Page.view'}
{block 'page.class' append} add-inv-prop{/block}
{block 'content.text'}
<img src="/i/add-inv-prop-img.png" itemscope itemtype="http://schema.org/ImageObject">
    <table class="add-inv-prop-table">
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
    </table>
    {content $editable}
{/block}