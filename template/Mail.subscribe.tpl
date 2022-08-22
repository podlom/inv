{$form->attr('class', 'subscribe')->open()}
{if $form->getErrors()}
	<div class="callout alert">
		<p>{if $lang == 'en'}You have successfully subscribed to the newsletter
			{elseif $lang == 'uk'}Ви успішно підписані на
			розсилку{else}Вы успешно подписаны на рассылку
			{/if}</p>
		{foreach $form->getErrors() as $err}
			<!-- div>{$err.1}</div -->
		{/foreach}
	</div>
{/if}
{if $lang == 'en'}
	{if ($form->getField('firstname') && $form->getField('lastname'))}
		{$form->getField('firstname')->getInput()->attr('id', 'subscribeFirstname')->attr('placeholder', 'First Name')}
		{$form->getField('lastname')->getInput()->attr('id', 'subscribeLastname')->attr('placeholder', 'Surname')}
	{else}
		<input name="subscribe[firstname]" type="text" class="subscription__input" placeholder="First Name" required>
		<input name="subscribe[lastname]" type="text" class="subscription__input" placeholder="Surname">
	{/if}
	{$form->getField('company')->getInput()->attr('id', 'subscribeCompany')->attr('placeholder', 'Company')}
	{$form->getField('job')->getInput()->attr('id', 'subscribeJob')->attr('placeholder', 'Position')}
	{$form->getField('email')->getInput()->attr('id', 'subscribeMail')->attr('placeholder', 'E-mail')}
	{* $form->getField('phone')->getInput()->attr('id', 'subscribeTel')->attr('placeholder', 'Phone') *}
	{literal}
		<div class="input-aproach">
			<input type="tel" id="phone" name="subscribe[phone]" required>
			<span id="valid-msg" class="hide">✓ Valid</span>
			<span id="error-msg" class="hide"></span>
		</div>
	{/literal}
	<div class="subscription__check-block">
		<div class="subscription__check-item" onclick="changeCheckBox('ru')">
			<div id="check-box-ru" class="subscription__check-box subscription__check-box--active">
				<svg width="14" height="11" viewBox="0 0 14 11" fill="none" xmlns="http://www.w3.org/2000/svg">
					<path fill-rule="evenodd" clip-rule="evenodd"
						d="M12.933 1.13796C12.5104 0.677973 11.8087 0.677973 11.3861 1.13796L5.16652 7.89884L2.62286 5.10422C2.1843 4.65292 1.49855 4.65292 1.05999 5.12158C0.64535 5.59024 0.64535 6.33663 1.06796 6.81397L4.34521 10.3637L4.39306 10.4244C4.82364 10.9017 5.51737 10.9017 5.94795 10.4244L12.933 2.82167C13.3557 2.35301 13.3557 1.59794 12.933 1.13796Z"
						fill="white" />
				</svg>
			</div>
			<span class="subscription__check-label">
				Russian
			</span>
			<input type="checkbox" value="ru" name="subscribe[lang][]" id="check-ru" checked="true" hidden>
		</div>
		<div onclick="changeCheckBox('en')" class="subscription__check-item">
			<div id="check-box-en" class="subscription__check-box">
				<svg width="14" height="11" viewBox="0 0 14 11" fill="none" xmlns="http://www.w3.org/2000/svg">
					<path fill-rule="evenodd" clip-rule="evenodd"
						d="M12.933 1.13796C12.5104 0.677973 11.8087 0.677973 11.3861 1.13796L5.16652 7.89884L2.62286 5.10422C2.1843 4.65292 1.49855 4.65292 1.05999 5.12158C0.64535 5.59024 0.64535 6.33663 1.06796 6.81397L4.34521 10.3637L4.39306 10.4244C4.82364 10.9017 5.51737 10.9017 5.94795 10.4244L12.933 2.82167C13.3557 2.35301 13.3557 1.59794 12.933 1.13796Z"
						fill="white" />
				</svg>
			</div>
			<span class="subscription__check-label">
				English
			</span>
			<input type="checkbox" value="en" name="subscribe[lang][]" id="check-en" hidden>
		</div>
	</div>

	<input type="hidden" name="subscribe[ga_utm]" value="">
	<div class='grid-x'><button class="blue_but cell-but small-12 w-full g-recaptcha"
			data-sitekey="6Le8bI8fAAAAAFT1lTrt6gL31hrhm8mFfc4nKmbX" type="submit" id="subscribeButton"
			data-callback="submitDigest">Subscribe</button></div>
	<!-- div class='grid-x'><button type='button' class="blue_but cell-but  small-12 close__popup">Close</button></div -->

{elseif $lang == 'uk'}
	{if ($form->getField('firstname') && $form->getField('lastname'))}
		{$form->getField('firstname')->getInput()->attr('id', 'subscribeFirstname')->attr('placeholder', 'Імʼя')}
		{$form->getField('lastname')->getInput()->attr('id', 'subscribeLastname')->attr('placeholder', 'Прізвище')}
	{else}
		<input name="subscribe[firstname]" type="text" class="subscription__input" placeholder="Імʼя" required>
		<input name="subscribe[lastname]" type="text" class="subscription__input" placeholder="Прізвище">
	{/if}
	{$form->getField('company')->getInput()->attr('id', 'subscribeCompany')->attr('placeholder', 'Компанія')}
	{$form->getField('job')->getInput()->attr('id', 'subscribeJob')->attr('placeholder', 'Посада')}
	{$form->getField('email')->getInput()->attr('id', 'subscribeMail')->attr('placeholder', 'E-mail')}
	{* $form->getField('phone')->getInput()->attr('id', 'subscribeTel')->attr('placeholder', 'Номер телефону') *}
	{literal}
		<div class="input-aproach">
			<input type="tel" id="phone" name="subscribe[phone]" required>
			<span id="valid-msg" class="hide">✓ Правильний</span>
			<span id="error-msg" class="hide"></span>
		</div>
	{/literal}
	<div class="subscription__check-block">
		<div class="subscription__check-item" onclick="changeCheckBox('ru')">
			<div id="check-box-ru" class="subscription__check-box subscription__check-box--active">
				<svg width="14" height="11" viewBox="0 0 14 11" fill="none" xmlns="http://www.w3.org/2000/svg">
					<path fill-rule="evenodd" clip-rule="evenodd"
						d="M12.933 1.13796C12.5104 0.677973 11.8087 0.677973 11.3861 1.13796L5.16652 7.89884L2.62286 5.10422C2.1843 4.65292 1.49855 4.65292 1.05999 5.12158C0.64535 5.59024 0.64535 6.33663 1.06796 6.81397L4.34521 10.3637L4.39306 10.4244C4.82364 10.9017 5.51737 10.9017 5.94795 10.4244L12.933 2.82167C13.3557 2.35301 13.3557 1.59794 12.933 1.13796Z"
						fill="white" />
				</svg>
			</div>
			<span class="subscription__check-label">
				Русский
			</span>
			<input type="checkbox" value="ru" name="subscribe[lang][]" id="check-ru" checked="true" hidden>
		</div>
		<div onclick="changeCheckBox('en')" class="subscription__check-item">
			<div id="check-box-en" class="subscription__check-box">
				<svg width="14" height="11" viewBox="0 0 14 11" fill="none" xmlns="http://www.w3.org/2000/svg">
					<path fill-rule="evenodd" clip-rule="evenodd"
						d="M12.933 1.13796C12.5104 0.677973 11.8087 0.677973 11.3861 1.13796L5.16652 7.89884L2.62286 5.10422C2.1843 4.65292 1.49855 4.65292 1.05999 5.12158C0.64535 5.59024 0.64535 6.33663 1.06796 6.81397L4.34521 10.3637L4.39306 10.4244C4.82364 10.9017 5.51737 10.9017 5.94795 10.4244L12.933 2.82167C13.3557 2.35301 13.3557 1.59794 12.933 1.13796Z"
						fill="white" />
				</svg>
			</div>
			<span class="subscription__check-label">
				Английский
			</span>
			<input type="checkbox" value="en" name="subscribe[lang][]" id="check-en" hidden>
		</div>
	</div>
	<input type="hidden" name="subscribe[ga_utm]" value="">
	<div class='grid-x'><button class="blue_but cell-but small-12 w-full g-recaptcha"
			data-sitekey="6Le8bI8fAAAAAFT1lTrt6gL31hrhm8mFfc4nKmbX" type="submit" id="subscribeButton"
			data-callback="submitDigest">Підписатися</button></div>

{else}
	{if isset($smarty.get.id) && isset($smarty.get.email)}
		<p>Вы успешно отписаны от рассылки</p>
	{else}
		{if ($form->getField('firstname') && $form->getField('lastname'))}
			{$form->getField('firstname')->getInput()->attr('id', 'subscribeFirstname')->attr('placeholder', $form->getField('firstname')->getLabel())}
			{$form->getField('lastname')->getInput()->attr('id', 'subscribeLastname')->attr('placeholder', $form->getField('lastname')->getLabel())}
		{else}
			<input name="subscribe[firstname]" type="text" class="subscription__input" placeholder="Имя" required>
			<input name="subscribe[lastname]" type="text" class="subscription__input" placeholder="Фамилия">
		{/if}
		{$form->getField('company')->getInput()->attr('id', 'subscribeCompany')->attr('placeholder', $form->getField('company')->getLabel())}
		{$form->getField('job')->getInput()->attr('id', 'subscribeJob')->attr('placeholder', $form->getField('job')->getLabel())}
		{$form->getField('email')->getInput()->attr('id', 'subscribeMail')->attr('placeholder', $form->getField('email')->getLabel())}
		{literal}
			<div class="input-aproach">
				<input type="tel" id="phone" name="subscribe[phone]" required>
				<span id="valid-msg" class="hide">✓ Правильний</span>
				<span id="error-msg" class="hide"></span>
			</div>
		{/literal}
		<div class="subscription__check-block">
			<div class="subscription__check-item" onclick="changeCheckBox('ru')">
				<div id="check-box-ru" class="subscription__check-box subscription__check-box--active">
					<svg width="14" height="11" viewBox="0 0 14 11" fill="none" xmlns="http://www.w3.org/2000/svg">
						<path fill-rule="evenodd" clip-rule="evenodd"
							d="M12.933 1.13796C12.5104 0.677973 11.8087 0.677973 11.3861 1.13796L5.16652 7.89884L2.62286 5.10422C2.1843 4.65292 1.49855 4.65292 1.05999 5.12158C0.64535 5.59024 0.64535 6.33663 1.06796 6.81397L4.34521 10.3637L4.39306 10.4244C4.82364 10.9017 5.51737 10.9017 5.94795 10.4244L12.933 2.82167C13.3557 2.35301 13.3557 1.59794 12.933 1.13796Z"
							fill="white" />
					</svg>
				</div>
				<span class="subscription__check-label">
					Російська
				</span>
				<input type="checkbox" value="ru" name="subscribe[lang][]" id="check-ru" checked="true" hidden>
			</div>
			<div onclick="changeCheckBox('en')" class="subscription__check-item">
				<div id="check-box-en" class="subscription__check-box">
					<svg width="14" height="11" viewBox="0 0 14 11" fill="none" xmlns="http://www.w3.org/2000/svg">
						<path fill-rule="evenodd" clip-rule="evenodd"
							d="M12.933 1.13796C12.5104 0.677973 11.8087 0.677973 11.3861 1.13796L5.16652 7.89884L2.62286 5.10422C2.1843 4.65292 1.49855 4.65292 1.05999 5.12158C0.64535 5.59024 0.64535 6.33663 1.06796 6.81397L4.34521 10.3637L4.39306 10.4244C4.82364 10.9017 5.51737 10.9017 5.94795 10.4244L12.933 2.82167C13.3557 2.35301 13.3557 1.59794 12.933 1.13796Z"
							fill="white" />
					</svg>
				</div>
				<span class="subscription__check-label">
					Англійська
				</span>
				<input type="checkbox" value="en" name="subscribe[lang][]" id="check-en" hidden>
			</div>
		</div>

		<input type="hidden" name="subscribe[ga_utm]" value="">
		<div class='grid-x'>
			<button class="blue_but cell-but small-12 w-full g-recaptcha" data-sitekey="6Le8bI8fAAAAAFT1lTrt6gL31hrhm8mFfc4nKmbX"
				type="submit" id="subscribeButton" data-callback="submitDigest">Подписаться</button>
		</div>
		<!-- div class='grid-x'><button type='button' class="blue_but cell-but  small-12 close__popup">Закрыть</button></div -->
	{/if}

{/if}
{$form->protection()}
{$form->close()}