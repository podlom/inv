{extends 'Blog.blog'}
{block 'post.share'}{/block}

{block 'config'}
{$links = [
    concat($blog->getPath(),'/projects-15088')=>'Инвестиционные проекты и стартапы',
    concat($blog->getPath(),'/business-15089')=>'Продажа бизнеса',
    concat($blog->getPath(),'/realestate-15090')=>'Недвижимость',
    concat($blog->getPath(),'/land-15091')=>'Земельные участки',
    concat($blog->getPath(),'/offer-15092')=>'Инвесторы'
]}
{/block}
{block 'breadcrumbs'}{/block}
{* {block 'page.title'}
<div class="clearfix border-bottom">
    <h2>{$blog->getTitle()}</h2>
    <a class="add_board" href="/bulletin/add">Добавить объявление</a>
</div> 
{/block} *}
{block 'page.class' append} board_page{/block}

{block 'post.id-num'}
    <span class="id-number"><strong style="margin: 0 5px 0 0">ID:</strong> {$post->getId()}</span>
{/block}

<!-- @ts bulletin board list -->

{block 'post.description' append}
    {* !T invalid flag *}
    {* {if $post->hasAttr("10")}
        <div class="place">
            <img src="/i/ukraine.png"> {$post->printAttr("10")}
        </div>
    {/if}
    <div class="price">
        {if $post->getParent()->getId() == 15089 || $post->getParent()->getId() == 15090 ||$post->getParent()->getId() == 15091}
          <p><span style="font-weight: 700;">ЦЕНА</span> -
          {if $post->getAttr("15")!=''} ${$post->printAttr("15")|number_format:0:'.':' '}{else}Договорная{/if}</p>
        {elseif $post->getParent()->getId() == 15088}
          <p><span style="font-weight: 700;">ИНВЕСТИЦИИ</span> -
          {if $post->hasAttr("15")} ${$post->printAttr("15")|number_format:0:'.':' '}{/if}</p>
        {elseif $post->getParent()->getId() == 15092}
          <p><span style="font-weight: 700;">ИНВЕСТИЦИИ</span> -
          {if $post->hasAttr("15")} ${$post->printAttr("15")|number_format:0:'.':' '}{/if}</p>
        {/if}
    </div> *}
{/block}
{block 'post.extras'}
{* <div class="accordion" id="adv-{$post->getId()}">
  <p class="toggle_btn">
    <span>Показать текст обьявления</span>
    <span style="display: none;">Скрыть текст обьявления</span>
  </p>
  <article class="block">
      {block 'post.content'}
        {content $post attr=['class'=>'the_post_content']}
      {/block}
      <div class="contacts">
        <h2>Контакты</h2>
          <div class="contacts1" >
          {if $post->getAttr(5) && $post->getAttr(4) && $post->getAttr(3)}
                  <div class="avatar"><img src="/i/no-photo.png" alt=""></div>
                  <div class="data_contacts">
                  <p><b>Имя:</b> {$post->getAttr(5)}</p>
                  <p><b>E-Mail:</b> <a href="mailto:{$post->getAttr(5)}">{$post->getAttr(4)}</a></p>
                  <p><b>Телефон:</b> <a href="tel:{$post->getAttr(3)}">{$post->getAttr(3)}</a></p>
                  </div>

           {else}

                  <div class="avatar"><img src="/images/alex-photo.jpg" alt=""></div>
                  <div class="data_contacts">
                      <p><b>Имя:</b> Алексей Олейников</p>
                      <p><b>E-Mail:</b> <a href="mailto:info@inventure.ua">info@inventure.ua</a></p>
                      <p><b>Телефон:</b> <a href="tel:+380677136571">+38(067)713-65-71</a></p>
                  </div>

              {/if}
          </div>
      </div>
  </article>
</div> *}
{/block}