function loadScript(t){return new Promise(e=>{const n=document.createElement("script");n.src=t,n.type="text/javascript",n.async=!0,n.onload=e,document.body.appendChild(n)})}if(-1!==window.location.pathname.indexOf("msb")){loadScript("https://cdn.jsdelivr.net/npm/sweet-modal@1.3.2/dist/min/jquery.sweet-modal.min.js").then(()=>{$.sweetModal.defaultSettings.confirm.ok.label="Выбрать",$.sweetModal.defaultSettings.confirm.cancel.label="Отменить"});const t=[{title:"Срок существования бизнеса",answers:["до 1 года","от 1 до 5 лет","более 5 лет"]},{title:"Выберите формат вашего бизнеса?",answers:["Производство","Интернет-магазин","Оптовые продажи","Работаю, как агент","Услуги","Офлайн продажи","Инфобизнес","B2B"],hasOther:!0},{title:"Ежемесячный оборот вашей компании?",answers:["0 – 50’000 грн","50’000 – 100’000 грн","100’000 – 400’000 грн","400’000 – 1’000’000 грн","1’000’000 – 3’000’000 грн","3’000’000 – 5’000’000 грн","Более 5’000’000 грн"]},{title:"Укажите задачу, которую вам бы хотелось решить в первую очередь",answers:["Запустить новый проект","Получать больше доход","Создать компанию №1, в отрасли/мире","Выйти из операционных процессов"]},{title:"Укажите проблему, решив которую, мы создадим для вас существенное облегчение?",answers:["Не знаю за что взяться, нужен план действий","Деньги в кассе есть, а прибыли в кармане нет","Бардак и хаос – нет системы управления","Все тащу один, нет сильной команды","У компании большие финансовые обязательства","Не могу расти органически, нужен инвестор","Мне приходится докладывать свои деньги (кассовые разрывы)","Не могу эффективно контролировать бухгалтера","Большая клиентская нагрузка, не контролирую оплаты"],hasOther:!0}];class e{constructor(t){this.questions=t}start(){const t=this.generate();this.insert(t)}insert(t){document.getElementById("calc-form").insertAdjacentHTML("afterbegin",t)}getOption(t,e){return`\n\t\t\t<div class="question__item">\n\t\t\t\t<span>${t}</span>\n\t\t\t\t<input type="radio" name="${e.title}" value="${t}" checked="checked"/>\n\t\t\t</div>`}generate(){return this.questions.map((t,e)=>`\n\t\t\t\t<div\n\t\t\t\t\tid="step${e}"\n\t\t\t\t\tclass="question_hide ${0===e?"active":""} ${t.hasOther?"has-other":""}"\n\t\t\t\t>\n\t\t\t\t\t<h3 class="text-center mb-4">\n\t\t\t\t\t\t${t.title}\n\t\t\t\t\t</h3>\n\t\t\t\t\t<div class="question_one">\n\t\t\t\t\t\t${t.answers.map(e=>this.getOption(e,t)).join("")}\n\t\t\t\t\t\t${t.hasOther?`<div data-id="step${e}" data-question="${t.title}" class="question__other">Другое</div>`:""}\n\t\t\t\t\t</div>\n\n\t\t\t\t</div>`).join("")}}new e(t).start(),$(".question__other").click(function(t){console.log("question__other clicked"),$.sweetModal.prompt("Введите ваш вариант",null,null,t=>{if(t){const e=`option__${(new Date).getTime()}`,n=`\n\t\t\t\t\t\t <div class="question__item" id="${e}">\n\t\t\t\t\t\t <span>${t}</span>\n\t\t\t\t\t\t <input type="radio" name="${$(this).attr("data-question")}" value="${t}" checked="checked"/>\n\t\t\t\t\t </div>`;$(this).before(n),$(`#${e}`).on("click",select),$(`#${e}`).click()}})});let n=1,s=0,a=0,i=$(".calculation_price_form .question_hide");const c=t.length,o=100/c;function select(){$(this).parent().children(".active").removeClass("active"),$(this).addClass("active"),n>c||($(i[n]).addClass("active"),$(i[n-1]).removeClass("active"),++n==c+1&&($(".calculation_text_finis").css("display","block"),$(".calculation_text_finis").html("Мы найдём правильные решения для вас, и обсудим их по телефону в ближайшее время. Пожалуйста оставьте Ваши контактные данные.")),s++,a++,$(".progress-bar").css("width",s*o+"%"),$(".sr-only").text(Math.round(a*o)+"%"))}function successCalculatorRequest(){let t=$.sweetModal({content:"Спасибо! Наши менеджеры скоро свяжутся с вами.",icon:$.sweetModal.ICON_SUCCESS});setTimeout(function(){t.close()},2e3),n=1,s=0,a=0,i=$(".calculation_price_form .question_hide"),$(".calculation_text_finis").text(""),document.getElementById("calc-form").reset(),$(".question_hide, .question__item").removeClass("active"),$(".question_hide:first-of-type").addClass("active")}function successContactRequest(){let t=$.sweetModal({content:"Спасибо! Наши менеджеры скоро свяжутся с вами.",icon:$.sweetModal.ICON_SUCCESS});setTimeout(function(){t.close()},2e3),document.getElementById("contact-form").reset()}$(".next_calc,.question__item").on("click",select),$(".back_calc").on("click",function(){n<=1||(s--,a--,--n==c&&($(".calculation_text_finis").css("display","none"),$(".calculation_text_finis").text("")),$(i[n-1]).addClass("active"),$(i[n]).removeClass("active"),$(".progress-bar").css("width","100"-(100-s*o)+"%"),$(".sr-only").text(Math.round(100-(100-a*o))+"%"))}),$(".scroll-to-contact").click(function(){$("html, body").animate({scrollTop:$("#contact-form").offset().top-82},2e3)}),$(".reveal-list").click(function(){$(this).next().removeClass("hidden"),$(this).addClass("hidden")}),$("#contact-form").submit(function(t){t.preventDefault();const e=$('#contact-form input[name="fullname"]').val(),n=$('#contact-form input[name="phone"]').val();if(!e||!n)return;const s=new FormData;s.append("sf_msb_form1[name]",e),s.append("sf_msb_form1[tel]",n),$.ajax({url:"/invest.php",type:"POST",data:s,processData:!1,contentType:!1,success:function(t,e,n){},error:function(t,e,n){}}),successContactRequest()}),$("#calc-form").submit(function(t){t.preventDefault();const e=$(".question__item.active input");let n=[];e.each(function(t){n.push({question:$(this).attr("name"),answer:$(this).attr("value")})});const s=n.map(({question:t,answer:e})=>`${t}: ${e}`).join(", \n"),a=$('#calc-form input[name="fullname"]').val(),i=$('#calc-form input[name="phone"]').val();if(!a||!i)return;const c=new FormData;c.append("sf_msb_form2[name]",a),c.append("sf_msb_form2[tel]",i),c.append("sf_msb_form2[quiz]",s),$.ajax({url:"/invest.php",type:"POST",data:c,processData:!1,contentType:!1,success:function(t,e,n){},error:function(t,e,n){}}),successCalculatorRequest()})}