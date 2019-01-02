{extends 'Page.view'}
{block 'breadcrumbs'}{/block}
{block 'page.class' append} add-inv-prop{/block}
{block 'content.text' prepend}
    <img src="/i/add-inv-prop-img.png" itemscope itemtype="http://schema.org/ImageObject">
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
        </table>
{/block}
