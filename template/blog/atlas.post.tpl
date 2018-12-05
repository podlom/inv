{extends 'Blog.post'}
{block 'page.class' append} atlas_single{/block}
{block 'post.preview' append}
<div style="position: relative; margin-bottom: 24px;">
    <div class="box-shadow"></div>
    <div class="tabs">
      <ul class="tabs__caption">
        <li class="active">Характеристика</li>
        <li>Инвестиции</li>
        <li>Менеджмент</li>
        <li>Контакты</li>
      </ul>

      <div class="tabs__content  active" id="panel1">
        {if $post->printAttr(46)}<p><b>Тип инвестора:</b> {$post->printAttr(46)}</p>{/if}
        {if $post->printAttr(52)}<p><b>Размер инвестиций:</b> {$post->printAttr(52)}</p>{/if}
        {if $post->printAttr(53)}<p><b>Стадии инвестирования:</b> {$post->printAttr(53)}</p>{/if}
        {if $post->printAttr(59)}<p><b>Регионы инвестирования:</b> {$post->printAttr(59)}</p>{/if}
        {if $post->printAttr(51)}<p><b>Отрасли инвестирования:</b> {$post->printAttr(51)}</p>{/if}
      </div>
      <div class="tabs__content" id="panel2">

      </div>
      <div class="tabs__content" id="panel3">
        <div class="contacts contacts1">
                {if $post->getAttr(5) && $post->getAttr(45)}
                    <div class="avatar"><img src="/i/no-photo.png" alt=""></div>
                    <div class="data_contacts">
                    <p><b>Имя:</b> {$post->getAttr(5)}</p>
                    <p><b>Должность:</b> {$post->getAttr(45)}</p>
                    </div>
                {/if}
            </div>
      </div>
      <div class="tabs__content" id="panel4">
        {if $post->printAttr(10)}<p><b>Адрес:</b> {$post->printAttr(10)}</p>{/if}
        {if $post->printAttr(3)}<p><b>Телефон:</b> {$post->printAttr(3)}</p>{/if}
        {if $post->printAttr(4)}<p><b>Email:</b> <a href="mailto:{$post->getAttr(4)}">{$post->printAttr(4)}</a></p>{/if}
        {if $post->printAttr(2)}<p><b>Web:</b> <a href="{$post->printAttr(2)}">{$post->printAttr(2)}</a></p>{/if}
      </div>
    </div>
    <div class="owl-carousel owl-theme">
        <div class="item characteristic">
            <div class="title">
                Характеристика
            </div>
             <div class="content">{if $post->printAttr(46)}<p><b>Тип инвестора:</b> {$post->printAttr(46)}</p>{/if}
            {if $post->printAttr(52)}<p><b>Размер инвестиций:</b> {$post->printAttr(52)}</p>{/if}
            {if $post->printAttr(53)}<p><b>Стадии инвестирования:</b> {$post->printAttr(53)}</p>{/if}
            {if $post->printAttr(59)}<p><b>Регионы инвестирования:</b> {$post->printAttr(59)}</p>{/if}
            {if $post->printAttr(51)}<p><b>Отрасли инвестирования:</b> {$post->printAttr(51)}</p>{/if}</div>
        </div>
        <div class="item gallery">
            <div class="title">
                Инвестиции
            </div>
        </div>
        <div class="item location">
            <div class="title">
                Менеджмент
            </div>
            <div class="content">
            {if $post->printAttr(10)}<p><b>Адрес:</b> {$post->printAttr(10)}</p>{/if}
            {if $post->printAttr(3)}<p><b>Телефон:</b> {$post->printAttr(3)}</p>{/if}
            {if $post->printAttr(4)}<p><b>Email:</b> <a href="mailto:{$post->getAttr(4)}">{$post->printAttr(4)}</a></p>{/if}
            {if $post->printAttr(2)}<p><b>Web:</b> <a href="{$post->printAttr(2)}">{$post->printAttr(2)}</a></p>{/if}
            </div>
        </div>
        <div class="item contacts">
            <div class="title">
                Контакты
            </div>
            <div class="contacts contacts1">
                    {if $post->getAttr(5) && $post->getAttr(45)}
                        <div class="avatar"><img src="/i/no-photo.png" alt=""></div>
                        <div class="data_contacts">
                        <p><b>Имя:</b> {$post->getAttr(5)}</p>
                        <p><b>Должность:</b> {$post->getAttr(45)}</p>
                        </div>
                    {/if}
                </div>
        </div>
    </div>
</div>
{/block}