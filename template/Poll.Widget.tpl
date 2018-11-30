<aside widget="{$id}" qtype="Poll" class="poll{if $value} result{/if}">
    <h3>{$name}</h3>
    {if $description}<p>{$description}</p>{/if}
    {$summ = 0}
    {foreach $variants as $variant}
        {$summ = $summ + $variant->getTotal()}
    {/foreach}
    {foreach $variants as $variant}
        <label class="answer-wrap">
            {if !$value}<input type="radio" name="poll_{$id}" value="{$variant->getId()}"{if $variant->getId()===$value} checked{/if}{if $value} disabled{/if}>{/if}
            <div class="answer">
                <h5> {$variant->getName()}</h5>
                <div class="is-pool-block" {if !$value}style="display: none;"{/if}>
                    <span class="persent">
                        {if $variant->getTotal()}
                            <span class="one">{($variant->getTotal()/$summ*100)|number_format:0}{else}0{/if}%</span>
                            <span class="two right">Проголосовало {$variant->getTotal()} из {$summ}</span>
                    </span>
                    <progress value="{$variant->getTotal()}" max="{$summ}">
                        {* if browser does not support progerssbar*}
                        <span class="value" style="width:{($variant->getTotal()/$summ*100)|number_format:2}%"></span>
                    </progress>
                </div>
            </div>
        </label>
    {/foreach}
    {if !$value}
        <div class="blue_but m_t-10" qtype="button">Голосовать</div>
        <div class="blue_but m_t-10 show_res">Показать результаты</div>
    {/if}
</aside>
