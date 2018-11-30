{extends 'Page.view'}
{block 'content'}
    {script src='http://bizmart.info/webservice/?ver=2&calc_settings=yes&def_css=yes'}
    <h2 class="m_b-20">Калькулятор быстрого расчета стоимости готового бизнеса</h2>
    <div id="ws_wrapper">
            <div>
                <div id="ws_loading">
                    Загрузка
                </div>
                <div id="ws_calc"></div>
            </div>
            <div id="ws_calc_res" ></div>
            <div class="clear"></div>
        </div>
{/block}
{block 'seo'}{/block}
