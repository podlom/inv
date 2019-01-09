jQuery(function(){
(function($){
//добавляем редактор в поля с html вводом
//перенес в tiny_mce.min.js

if($('[qType=formModal]').length){
    $('[qType=formModal]').formModal();
}

if($('[qType=PhotoListAdd]').length){
    uuid=1;
    $('[qType=PhotoListAdd]').click(function(){
        clone = $(this).prev().clone();
        clone.find('input').val('');
        clone.find('img').attr('src', '/img/thumb.128/skynar/images/filemanager/file.png');
        uid = uuid++;
        clone.find('[name]').each(function(){
            a = $(this).attr('name');
            e = a.lastIndexOf(']',a.length-2);
            s = a.lastIndexOf('[', e) + 1;
            $(this).attr('name', a.substr(0,s)+'a'+ uid + a.substr(e));
        });

        $(this).before(clone);
    });

    $(document).on('click', '[qType="PhotoListRemove"]', function(){
        $(this).parent().remove();
    });

}

 window.url_slug = function(s, opt) {
    s = String(s);
    opt = Object(opt);

    var defaults = {
        'delimiter': '-',
        'limit': undefined,
        'lowercase': true,
        'replacements': {},
        'transliterate': (typeof(XRegExp) === 'undefined') ? true : false
    };

    // Merge options
    for (var k in defaults) {
        if (!opt.hasOwnProperty(k)) {
            opt[k] = defaults[k];
        }
    }

    var char_map = {
        // Latin
        'À': 'A', 'Á': 'A', 'Â': 'A', 'Ã': 'A', 'Ä': 'A', 'Å': 'A', 'Æ': 'AE', 'Ç': 'C',
        'È': 'E', 'É': 'E', 'Ê': 'E', 'Ë': 'E', 'Ì': 'I', 'Í': 'I', 'Î': 'I', 'Ï': 'I',
        'Ð': 'D', 'Ñ': 'N', 'Ò': 'O', 'Ó': 'O', 'Ô': 'O', 'Õ': 'O', 'Ö': 'O', 'Ő': 'O',
        'Ø': 'O', 'Ù': 'U', 'Ú': 'U', 'Û': 'U', 'Ü': 'U', 'Ű': 'U', 'Ý': 'Y', 'Þ': 'TH',
        'ß': 'ss',
        'à': 'a', 'á': 'a', 'â': 'a', 'ã': 'a', 'ä': 'a', 'å': 'a', 'æ': 'ae', 'ç': 'c',
        'è': 'e', 'é': 'e', 'ê': 'e', 'ë': 'e', 'ì': 'i', 'í': 'i', 'î': 'i', 'ï': 'i',
        'ð': 'd', 'ñ': 'n', 'ò': 'o', 'ó': 'o', 'ô': 'o', 'õ': 'o', 'ö': 'o', 'ő': 'o',
        'ø': 'o', 'ù': 'u', 'ú': 'u', 'û': 'u', 'ü': 'u', 'ű': 'u', 'ý': 'y', 'þ': 'th',
        'ÿ': 'y',

        // Latin symbols
        '©': '(c)',

        // Greek
        'Α': 'A', 'Β': 'B', 'Γ': 'G', 'Δ': 'D', 'Ε': 'E', 'Ζ': 'Z', 'Η': 'H', 'Θ': '8',
        'Ι': 'I', 'Κ': 'K', 'Λ': 'L', 'Μ': 'M', 'Ν': 'N', 'Ξ': '3', 'Ο': 'O', 'Π': 'P',
        'Ρ': 'R', 'Σ': 'S', 'Τ': 'T', 'Υ': 'Y', 'Φ': 'F', 'Χ': 'X', 'Ψ': 'PS', 'Ω': 'W',
        'Ά': 'A', 'Έ': 'E', 'Ί': 'I', 'Ό': 'O', 'Ύ': 'Y', 'Ή': 'H', 'Ώ': 'W', 'Ϊ': 'I',
        'Ϋ': 'Y',
        'α': 'a', 'β': 'b', 'γ': 'g', 'δ': 'd', 'ε': 'e', 'ζ': 'z', 'η': 'h', 'θ': '8',
        'ι': 'i', 'κ': 'k', 'λ': 'l', 'μ': 'm', 'ν': 'n', 'ξ': '3', 'ο': 'o', 'π': 'p',
        'ρ': 'r', 'σ': 's', 'τ': 't', 'υ': 'y', 'φ': 'f', 'χ': 'x', 'ψ': 'ps', 'ω': 'w',
        'ά': 'a', 'έ': 'e', 'ί': 'i', 'ό': 'o', 'ύ': 'y', 'ή': 'h', 'ώ': 'w', 'ς': 's',
        'ϊ': 'i', 'ΰ': 'y', 'ϋ': 'y', 'ΐ': 'i',

        // Turkish
        'Ş': 'S', 'İ': 'I', 'Ç': 'C', 'Ü': 'U', 'Ö': 'O', 'Ğ': 'G',
        'ş': 's', 'ı': 'i', 'ç': 'c', 'ü': 'u', 'ö': 'o', 'ğ': 'g',

        // Russian
        'А': 'A', 'Б': 'B', 'В': 'V', 'Г': 'G', 'Д': 'D', 'Е': 'E', 'Ё': 'Yo', 'Ж': 'Zh',
        'З': 'Z', 'И': 'I', 'Й': 'J', 'К': 'K', 'Л': 'L', 'М': 'M', 'Н': 'N', 'О': 'O',
        'П': 'P', 'Р': 'R', 'С': 'S', 'Т': 'T', 'У': 'U', 'Ф': 'F', 'Х': 'H', 'Ц': 'C',
        'Ч': 'Ch', 'Ш': 'Sh', 'Щ': 'Sh', 'Ъ': '', 'Ы': 'Y', 'Ь': '', 'Э': 'E', 'Ю': 'Yu',
        'Я': 'Ya',
        'а': 'a', 'б': 'b', 'в': 'v', 'г': 'g', 'д': 'd', 'е': 'e', 'ё': 'yo', 'ж': 'zh',
        'з': 'z', 'и': 'i', 'й': 'j', 'к': 'k', 'л': 'l', 'м': 'm', 'н': 'n', 'о': 'o',
        'п': 'p', 'р': 'r', 'с': 's', 'т': 't', 'у': 'u', 'ф': 'f', 'х': 'h', 'ц': 'c',
        'ч': 'ch', 'ш': 'sh', 'щ': 'sh', 'ъ': '', 'ы': 'y', 'ь': '', 'э': 'e', 'ю': 'yu',
        'я': 'ya',

        // Ukrainian
        'Є': 'Ye', 'І': 'I', 'Ї': 'Yi', 'Ґ': 'G',
        'є': 'ye', 'і': 'i', 'ї': 'yi', 'ґ': 'g',

        // Czech
        'Č': 'C', 'Ď': 'D', 'Ě': 'E', 'Ň': 'N', 'Ř': 'R', 'Š': 'S', 'Ť': 'T', 'Ů': 'U',
        'Ž': 'Z',
        'č': 'c', 'ď': 'd', 'ě': 'e', 'ň': 'n', 'ř': 'r', 'š': 's', 'ť': 't', 'ů': 'u',
        'ž': 'z',

        // Polish
        'Ą': 'A', 'Ć': 'C', 'Ę': 'e', 'Ł': 'L', 'Ń': 'N', 'Ó': 'o', 'Ś': 'S', 'Ź': 'Z',
        'Ż': 'Z',
        'ą': 'a', 'ć': 'c', 'ę': 'e', 'ł': 'l', 'ń': 'n', 'ó': 'o', 'ś': 's', 'ź': 'z',
        'ż': 'z',

        // Latvian
        'Ā': 'A', 'Č': 'C', 'Ē': 'E', 'Ģ': 'G', 'Ī': 'i', 'Ķ': 'k', 'Ļ': 'L', 'Ņ': 'N',
        'Š': 'S', 'Ū': 'u', 'Ž': 'Z',
        'ā': 'a', 'č': 'c', 'ē': 'e', 'ģ': 'g', 'ī': 'i', 'ķ': 'k', 'ļ': 'l', 'ņ': 'n',
        'š': 's', 'ū': 'u', 'ž': 'z',

        //symbols
        ' ':'-'
    };

    // Make custom replacements
    for (var k in opt.replacements) {
        s = s.replace(RegExp(k, 'g'), opt.replacements[k]);
    }

    // Transliterate characters to ASCII
    if (opt.transliterate) {
        for (var k in char_map) {
            s = s.replace(RegExp(k, 'g'), char_map[k]);
        }
    }

    // Replace non-alphanumeric characters with our delimiter
    var alnum = (typeof(XRegExp) === 'undefined') ? RegExp('[^a-z0-9]+', 'ig') : XRegExp('[^\\p{L}\\p{N}]+', 'ig');
    s = s.replace(alnum, opt.delimiter);

    // Remove duplicate delimiters
    s = s.replace(RegExp('[' + opt.delimiter + ']{2,}', 'g'), opt.delimiter);

    // Truncate slug to max. characters
    s = s.substring(0, opt.limit);

    // Remove delimiter from ends
    s = s.replace(RegExp('(^' + opt.delimiter + '|' + opt.delimiter + '$)', 'g'), '');

    return opt.lowercase ? s.toLowerCase() : s;
}

//добавляем подтверждения на ссылки
if($('a.confirm').length){
    $('a.confirm:not([disabled])').click(function(e){
        $('body').append('<div class="reveal-modal small" id="reveal_confirm"><div>'+
            $(this).attr('dialog')+
            '</div><a class="button close-reveal-modal round fright">Нет</a><a class="button success round fright" href="'+this.href+'">Да</a>'+
        '</div>');
        $('#reveal_confirm').reveal('close', function(){$('#reveal_confirm').remove();});
        e.preventDefault();
        return false;
    });


}

//gmap.min.js
if($("[qType=gmap]").length){$("input[qType=gmap]").each(function(){$(this).after('<div class="gmap_wrap gmap_edit gmap_this"><input placeholder="Address" class="gmap_address"/><a href="#" class="button small round gmap_find">Find</a><div class="gmap"></div><i class="icon-checkmark button small round gmap_apply"> Apply</i></div>');var e=$(".gmap_this").removeClass("gmap_this");var t=e.find(".gmap");var r=e.find(".gmap_address");var i=e.find(".gmap_find");var o=new Gmap3Menu(t);var u=new Gmap3Menu(t);var a;var f={rightclick:function(e,r){a=e;if(!r.pixel){n=t.gmap3("get").getProjection().fromLatLngToPoint(e.getPosition());s=Math.pow(2,t.gmap3("get").getZoom());r.pixel=new google.maps.Point(n.x*s,n.y*s)}u.open(r)},dragend:function(e,n){if(t.gmap3({get:{id:"loc"}})!=e)return;t.gmap3({getaddress:{latLng:e.getPosition(),callback:function(e){if(e[0]&&e[0].formatted_address)$(this).parent().find(".gmap_address").val(e[0].formatted_address)}}})}};$(this).data("menu",o);marker_data={options:{draggable:true,icon:"http://maps.google.com/mapfiles/marker.png"},events:f};o.add(" Add marker","icon-plus",function(){o.close();m={latLng:current.latLng};$.extend(m,marker_data);t.gmap3({marker:m})});u.add(" Title","icon-edit",function(e){u.close();a.setTitle(window.prompt("Title",a.getTitle()));console.log(a)});u.add(" Remove","icon-remove",function(e){u.close();a.setMap(null);delete a});var l={map:{options:{zoom:5,center:[49.272105742788916,30.47241171875]},events:{rightclick:function(e,t){current=t;o.open(current)},click:function(){o.close()},dragstart:function(){o.close()},zoom_changed:function(){o.close()}}},marker:{events:f,options:{draggable:true}}};if($(this).val()){n=JSON.parse($(this).val());t.parent().find(".gmap_address").val(n.address);delete n.address;l=$.extend(true,l,n)}t.width(300).height(200).gmap3(l);i.click(function(e){e.preventDefault();$(this).parent().find(".gmap").gmap3({getlatlng:{address:$(this).prev().val(),callback:function(e){if(!e)return;$(this).gmap3({get:{name:"marker",id:"loc",callback:function(e){if(typeof e.setMap=="function")e.setMap(null);delete e}}});m={latLng:e[0].geometry.location,id:"loc",events:f};$.extend(m,marker_data);$(this).gmap3({marker:m});gapi=$(this).gmap3("get");gapi.setCenter(e[0].geometry.location);gapi.setZoom(16)}}})});r.autocomplete({source:function(){console.log(t);t.gmap3({getaddress:{address:$(this).val(),callback:function(e){if(!e)return;console.log(e);r.autocomplete("display",e,false)}}})},cb:{cast:function(e){return e.formatted_address},select:function(e){i.click()}}}).focus()});$(".gmap_apply").click(function(){_map=$(this).prev().gmap3("get");c=_map.getCenter();data={map:{options:{zoom:_map.getZoom(),center:[c.lat(),c.lng()]}},marker:{values:[]},address:$(this).parent().find(".gmap_address").val()};$(this).parent().find(".gmap").gmap3({get:{name:"marker",all:true,callback:function(e){m=[];mm=$(this).parent().find(".gmap").gmap3({get:{id:"loc"}});for(it in e){if(e[it].getPosition()&&e[it].getMap()){d={latLng:[e[it].getPosition().lat(),e[it].getPosition().lng()],options:{icon:e[it].getIcon(),title:e[it].getTitle()}};if(e[it]==mm){d.id="loc"}m.push(d)}}console.log(m,mm);data.marker.values=m;$(this).parent().parent().find("input[qType=gmap]").val(JSON.stringify(data))}}})});$(".gmap_address").keypress(function(e){if(e.keyCode==13){e.preventDefault();$(this).next().click();return false}});$("div[qType=gmap]").each(function(){def={map:{options:{zoom:5,center:[49.272105742788916,30.47241171875]}}};if(data=$(this).attr("qData")){$.extend(true,def,JSON.parse(data))}$(this).gmap3(def)})}
})(jQuery);

$(document).foundation();

});

jQuery.fn.formModal = function(a){
    onload = function(data){
        $('#modal').removeClass('loading');
        $('#modal').html('').append(data);
        $('#modal form').submit(function(e){
            e.preventDefault();
            $('#modal').html('').addClass('loading');
            jqxhr = jQuery.ajax({
                url: $(this).attr('action')+'.phtml',
                type: $(this).attr('method'),
                data: $(this).serializeArray(),
                success: onload,
                error: function(xhr, status, error){
                    $('#modal').removeClass('loading');
                    $('#modal').html('').append(status+': '+error);
                }
            });
            $('#modal').data('jqxhr', jqxhr);
        })
    }

    this.click(function(e){
        e.preventDefault();
        jqxhr = jQuery.ajax({
          url: this.href+'.phtml',
         success:onload,
        error: function(xhr, status, error){
            $('#modal').removeClass('loading');
            $('#modal').html('').append(status+': '+error);
        }
        });
$('body').append('<div id="modal" class="reveal-modal large loading"></div>');
        $('#modal').data('jqxhr', jqxhr).reveal({
            close: function(){
                $('#modal').remove();
                jqxhr = $(this).data('jqxhr');
                if(jqxhr)
                    jqxhr.abort();
                $('#modal').remove();
            }
        });
    });
}
