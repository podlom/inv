<div class="section__controls flex flex-row mobile-only ">
      <select id="invest-sort" class="mobile-sort mr-2">
          {$f = $request->query->get('filter')}
          {foreach $sorts as $s}
              {if $s}

                  <option {if $f.sort==$s.0}selected{/if} value="?{if $s.0}filter[sort]={$s.0}{/if}">{$s.1}</option>
              {/if}
          {/foreach}
          <option value="">Новые</option>
      </select>
      <button aria-label="Filter" id="open-mobile-filter" class="section__controls-btn flex items-center justify-center toggle-filter">
				<svg style="max-width:1em; pl-2 pr-2" width="16" height="17" viewBox="0 0 16 17" fill="none" xmlns="http://www.w3.org/2000/svg">
						<path d="M15.3109 0.0300305H0.689296C0.431248 0.0295546 0.194826 0.170116 0.0769405 0.393966C-0.0425712 0.620831 -0.0215957 0.89402 0.131087 1.10121L5.48781 8.46385C5.4896 8.46638 5.49155 8.46877 5.49334 8.4713C5.68798 8.72768 5.79334 9.03831 5.79383 9.35734V15.3601C5.79269 15.5377 5.86424 15.7086 5.99253 15.8347C6.12098 15.9607 6.29562 16.0318 6.47773 16.0318C6.57025 16.0316 6.66196 16.0137 6.74748 15.9789L9.75755 14.8592C10.0271 14.7788 10.2062 14.5305 10.2062 14.2316V9.35734C10.2067 9.03831 10.312 8.72768 10.5065 8.4713C10.5083 8.46877 10.5102 8.46638 10.512 8.46385L15.8689 1.10105C16.0216 0.89402 16.0426 0.620989 15.9231 0.394125C15.8053 0.170116 15.5688 0.0295546 15.3109 0.0300305Z" fill="#5D87AD"/>
				</svg>
      </button>
  </div>