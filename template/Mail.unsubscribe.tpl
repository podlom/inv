{$form->attr('class', 'unsubscribe')->open()}
{if $form->getErrors()}
    <div class="callout alert">
        {foreach $form->getErrors() as $err}
            <!-- div>{$err.1}</div -->
        {/foreach}
    </div>
{/if}
{if $lang == 'en'}
    <p>You have been unsubscribed from mailing list</p>

{else}
    <p>Вы успешно подписаны на рассылку</p>

{/if}
{$form->protection()}
{$form->close()}