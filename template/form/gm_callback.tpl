{$form->open()}
    <div class="gm_row">
        {$form->getField('tel')->getInput()
        	->setAttr('placeholder', '+380677136571')
        	->setAttr('required', true)
        	->setAttr('type', 'tel')
        	->setAttr('pattern', '^\+?[0-9]{9,15}$')
        }
        <button>Заказать</button>
    </div>
{$form->protection()}
{$form->close()}