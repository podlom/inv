{extends 'Page.view'}
{block 'breadcrumbs'}

        <div class="clearfix border-bottom">
        <h2>{$page->getH1()|truncate:75:" ..."|trim}</h2>
    </div>

{/block}
{block 'content'}
<div class="dark_bg"></div>
    <div class="my_popup">
        <h5>Fill in your contact details and we will send the terms of cooperation</h5>
        <i class="fa fa-close"></i>
        {form 'approach'}
    </div>
    <div class="viewbox-cnt-body add-inv-prop-body">
        <div class="box-shadow"></div>
        <div class="img"></div>
        <table class="add-inv-prop-table complex-approach-table">
            <thead>
                <tr>
                    <td>Services</td>
                    <td>Advertising</td>
                    <td>Full Support</td>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><b>Investment offer advertising on the largest investment portal InVenture </b><br>
(70 000+ visitors per month) - https://inventure.com.ua</td>
                    <td>
                        <p><b>Period:</b></p>
                        <p>6 months</p>
                        <p><b>Publication in the Russian and English language</b></p>
                        <p><b>Editing</b></p>
                        <p><b>Photo gallery</b></p>
                        <p><b>Attachment of documents</b></p>
                        <p style="color: red">Contact details of the customer</p>
                    </td>
                    <td>
                        <p><b>Period:</b></p>
                        <p>until the transaction is completed</p>
                        <p><b>Publication in the Russian and English language
</b></p>

                        <p><b>Editing</b></p>
                        <p><b>Photo gallery</b></p>
                        <p><b>Attachment of documents</b></p>
                        <p style="color: red">Contact details of the broker</p>
                        <p><b>TOP position for 1 month</b></p>
                        <p><b>First positions on key queries in Google search</b></p>
                    </td>
                </tr>
                <tr>
                    <td><b>Investment offer advertising  in the monthly magazine "InVenture Investment Digest" </b><br> with the 12 800+ subscribers (investors from Ukraine, CIS, EU, USA, Asia)</td>
                    <td><p><b>1 release</b></td>
                    <td><p><b>2 releases</b></p></td>
                </tr>
                <tr>
                    <td><b>Investment offer promotion in the private investment communities of social networks Facebook and LinkedIn</b><br>
(12 000+ + subscribers)</td>
                    <td><p><b>1 publication </b></p>
<p>(including $20 advertising budget for 1 month) </p></td>
                    <td><p><b>2 publications </b></p>
<p>(including $30 per month advertising budget)</p>
<b>Publication in the FB social investors community </b> 2 publications
(including $30 per month advertising budget)
Publication in the FB social investors community "Investment Mosaic"</td>
                </tr>
                <tr>
                    <td><b>Investment offer advertising  on specialized Internet sites and bulletin boards</b></td>
                    <td></td>
                    <td><b>5 websites</b></td>
                </tr>
                <tr>
                    <td><b>Advertising banner in a thematic analytical research (native advertising)</b> (native advertising)</td>
                    <td></td>
                    <td><b>1 banner</b></td>
                </tr>
                <tr>
                    <td><b>Advertising banner with a display on all pages of the InVenture investment portal </b> (150,000+ visitors of the target audience per month)</td>
                    <td></td>
                    <td><b>1 month</b></td>
                </tr>
                <tr>
                    <td><b>Development of a professional presentation for working with investors</b></td>
                    <td></td>
                    <td><b>+</b></td>
                </tr>
                 <tr>
                    <td><b>Investment advisory support </b><br> (meetings and negotiations with investors, comprehensive consultation on transaction implementation)</td>
                    <td></td>
                    <td><b>+</b></td>
                </tr>
                <tfoot>
                    <td></td>
                    <td><a class="open_popup">Подробнее</a></td>
                    <td><a class="open_popup">Подробнее</a></td>
                </tfoot>
            </tbody>
        </table>
        {content $page}
    </div>
{/block}
