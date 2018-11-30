<div class="admin-pages">
    <div class="menu-blocks">   
        <div>
            <div>
                <p>Новости</p>
                <i class="fa fa-newspaper-o"></i>
            </div>
            <div>
                <a href="/admin/blog/11">Больше информации <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div>
            <div>
                <p>Инвестиционные предложения</p>
                <i class="fa fa-wpforms"></i>
            </div>
            <div>
                <a href="/admin/blog/7859">Больше информации <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div>
            <div>
                <p>Мероприятия</p>
                <i class="fa fa-calendar"></i>
            </div>
            <div>
                <a href="/admin/blog/34">Больше информации <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div>
            <div>
                <p>Доска объявлений</p>
                <i class="fa fa-list-alt"></i>
            </div>
            <div>
                <a href="/admin/blog/14976">Больше информации <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
    </div>
    <div class="invoice">
        <div class="title">
            <h2>Inventure</h2>
            <div>Дата: {$invoice->getCreated()}</div>
        </div>
        <div>
            <div>
                <p>Плательщик</p>
                <p><b>Дональд Трамп</b></p>
                <p>14789, Белый Дом, Вашигтон, США, Северная Америка</p>
                <p>Телефон: 9379992</p>
                <p>donald@gmail.com</p>
            </div>
            <div>
                <p>Получатель</p>
                <p><b>Inventure</b></p>
                <p>улица Старовокзальная, 24, 3 этаж, Киев, Украина, 03150</p>
                <p>Телефон: +38 044 223 39 71</p>
                <p>info@inventure.ua</p>
            </div>
            <div>
                <p style="margin-bottom: 15px;"><b>Invoice #{$invoice->getId()}</b></p>
                <p><b>Номер платежа:</b> {$invoice->getId()}</p>
                <p><b>Дата платежа:</b> {$invoice->getCreated()}</p>
                <p><b>Акаунт:</b> 12345</p>
            </div>
        </div>
        <div class="table">
            <table>
                <thead>
                    <tr>
                        <td>Количество</td>
                        <td>Название</td>
                        <td>Индекс</td>
                        <td>Стоимость</td>
                    </tr>
                </thead>
                <tbody>
                    {foreach $products as $product}
                    <tr>
                        <td>{$product->getCount()}</td>
                        <td>{$product->getName()}</td>
                        <td>{$product->getIndex()}</td>
                        <td>{$product->getPrice()} UAH</td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>
