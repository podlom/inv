
   <section class="grid-container payment">
       <h2>Оплата счета <a href="">Отмена</a></h2>
       <article>
           <div class="invoice">
               <h1>Счет</h1>
               <p>invoice no.</p>
               <p>№ {$invoice->getId()}</p>
               <p>Invoice date</p>
               <p>{$invoice->getCreated()}</p>
           </div>
           <div class="amount">
               <div class="div1">
                    <div>
                       <p>DESCRIPTION</p>
                       <p>{$invoice->getDescription()}</p>
                   </div>
                   <div>
                       <p>AMOUNT</p>
                       <p>{$invoice->getAmount()} {$invoice->getCurrency()}</p>
                   </div>
               </div>
               <div class="div2">
                  <p>TOTAL: <span>{$invoice->getAmount()} {$invoice->getCurrency()}</span></p>
               </div>
              {if ($invoice->getStatus()&3) != 3}
               <div class="pay_button">
                  Оплатить с помощью
                      {foreach $buttons as $button}
                        {$t =$button->getSubmit()->setAttr('type', 'image')->setAttr('src', '/i/Liqpay.png')}
                        {$button}
                      {/foreach}
               </div>
                {/if}
           </div>
       </article>
   </section>
