<html>
<body>
{foreach $_form->getFields() as $key=>$field}
   {if $field->getLabel() == 'Ваш вариант'}
      {continue}
   {/if}
   {$value = (array)${$key}}
   {$other = ${concat($key, '_other')}}
   {if $other}
    {$value.999 = $other}
   {/if}
   {$field->getLabel()}:
   {', '|implode:$value}<br>
{/foreach}
</body>
</html>
