{*
{$name}
{$description}
summ:{$summ}
count:{$count}
rating{if $count>0}{$summ/$count}{else}0{/if}
*}
<aside widget="{$id}" qtype="Rating" target={$target}>
    <progress value="{if $count>0}{$summ/$count}{else}0{/if}" max="5">
        <span class="value" style="width:{if $count>0}{$summ/$count*5|number_format:2}{else}0{/if}%"></span>
    </progress>
{*        <div class="star" {if $value}style="{$value*10}%"{/if}></div> *}
        <div class="hover"></div>
</aside>
