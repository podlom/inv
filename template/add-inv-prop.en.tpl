{extends 'Page.view'}
{block 'page.class' append} add-inv-prop{/block}
{block 'content.text'}
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
                    <td><span class="check"></span></td>
                    <td><span class="check"></span></td>
                </tr>
                <tr>
                    <td>Direct sales</td>
                    <td></td>
                    <td><span class="check"></span></td>
                </tr>
                <tr>
                    <td>Success Fee</td>
                    <td><span class="check"></span></td>
                    <td><span class="check"></span></td>
                </tr>
                <tr>
                    <td>Deal support</td>
                    <td><span class="check"></span></td>
                    <td><span class="check"></span></td>
                </tr>
                <tr>
                    <td>Consulting support</td>
                    <td><span class="check"></span></td>
                    <td><span class="check"></span></td>
                </tr>
                <tr>
                    <td>Individual manager</td>
                    <td></td>
                    <td><span class="check"></span></td>
                </tr>
                <tr>
                    <td>Budget</td>
                    <td><span class="gold2"></span></td>
                    <td><span class="gold3"></span></td>
                </tr>
                <tfoot>
                    <td></td>
                    <td><a href="/en/complex-approach">Read more</a></td>
                    <td><a href="">Read more</a></td>
                </tfoot>
            </tbody>
        </table>
    {content $editable}
{/block}
