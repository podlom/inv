jQuery(document).ready(function() {
     console.log('utm_widget1.js +2: document is ready');
//
//     var navClip = false;
//     if (navigator.clipboard) {
//         console.log('utm_widget1.js: navigator.clipboard is supported');
//         navClip = true;
//     } else {
//         console.log('utm_widget1.js: navigator.clipboard is not supported');
//     }
//
//     /* $('ul.utm-list li').click(function(){
//         var th = $(this);
//         var ur = $(th).data('add-url');
//         console.log('UTM params: ' + ur);
//
//         var p2 = $(th).parentNode.parentNode;
//         console.dir(p2);
//     });
//
//     jQuery('select[name="utm-list"]').change(function(){
//         var v1 = jQuery('#utm-list1').val();
//         console.log('utm_widget1.js: change event selected val: ' + v1);
//     });
//
//     jQuery('select[name="utm-list"]').blur(function(){
//         var v1 = jQuery('#utm-list1').val();
//         console.log('utm_widget1.js: blur event selected val: ' + v1);
//     }); */
//
     jQuery('select[name="utm-list"]').change(function() {
         var v1 = jQuery('select[name="utm-list"]').val();
         console.log('utm_widget1.js +34: Selected val: ' + v1);
         if (navClip && v1.length) {
             navigator.clipboard.writeText(v1);
             console.log('utm_widget1.js +37: copied to clipboard: ' + v1);
         } else {
             if (v1.length) {
                 const copyToClipboard = str => {
                     const el = document.createElement('textarea');
                     el.value = v1;
                     el.setAttribute('readonly', '');
                     el.style.position = 'absolute';
                     el.style.left = '-9999px';
                     document.body.appendChild(el);
                     el.select();
                     document.execCommand('copy');
                     document.body.removeChild(el);
                 };
             }
         }
     });
});

var copySelect = document.getElementsByClassName('copySelect')

for (var i = 0; i < copySelect.length; i++) {
    copySelect[i].addEventListener("change", copyToClipboard, false)
}

function copyToClipboard() {
    var t = this.options[this.selectedIndex].value;

    navigator.clipboard.writeText(t)
    var el = document.createElement('textarea')
        el.value = t;
        el.setAttribute('readonly', '')
        el.style.position = 'absolute'
        el.style.left = '-9999px'
        document.body.appendChild(el)
        el.select()
        document.execCommand('copy')
        document.body.removeChild(el)
}