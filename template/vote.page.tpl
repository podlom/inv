{extends 'Page.view'}
{block 'content'}
    {$names=['', 'Какой контент в сфере инвестиций Вас интересует больше всего?','Во что Вы планируете инвестировать большую часть средств в 2015 году?', 'Ваш текущий или будущий вид деятельности?']}
    {for $ids = 1 to 3}
        <div class="vote-block">
            <span class="viewbox-cnt acc-caption m_b-10"><h2>{$names[$ids]}</h2></span>
            <div class="viewbox-cnt acc-content m_b-10">
                {widget $ids}
            </div>
        </div>
    {/for}
{script_code require=['jquery']}
$(function() {
    $('.vote-block:first .acc-content').addClass('active');
    $('.acc-content').not('.active').hide();
    $('.acc-caption').click(function() {
        $('.acc-content').not($(this).next('.acc-content')).removeClass('active').slideUp(600); // сворачиваем элементы
        $(this).next('.acc-content').addClass('active').slideDown(600);
        //$('.acc-content').hasClass('active').parent($(this).css("color", "black"));
    });
});
{/script_code}
{/block}
