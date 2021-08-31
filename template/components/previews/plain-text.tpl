{block 'breadcrumbs'}{/block}
<div class="preview__wrapper">
  <div class="preview__wrapper-main pt-6 mobile-mt-0">
      <h1 class="preview__title mb-2">
        {content $editable  part="title" tag="span" attrs=['itemprop'=>'headline']}
      </h1>

      {assign "isContactsPage" value=(
        $request->getPathInfo() == '/about/contacts' ||
        $request->getPathInfo() == '/en/about/contacts'
      )}

      <div class="preview__info-wrapper items-center">
        <div class="flex">
            {if !$isContactsPage}
                {include 'components/share-btn'}
            {/if}
        </div>
      </div>
  </div>
</div>
