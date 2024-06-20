$('[type=checkbox]').change(function(){
	$(this).siblings('label').toggleClass('edited')
	$($(this).prev('input')).val($(this).prop('checked') ? 1 : 0)
	
	var toggleDisable = $(this).data('toggledisabled');
	if(toggleDisable){
		$(this).prop('checked') ? $(toggleDisable).prop('disabled', false) : $(toggleDisable).prop('disabled', true)
	}
})

$('[data-toggle="tooltip"]').tooltip()


$('#entityParamsVotes').on('input change', function(){
	$('#entityParamsVotesInformer').text($(this).val())
})

$('#frm1').submit(function(e19){
	console.log('admin_app +19');
	e19.preventDefault();

	console.log('admin_app +22');
	document.querySelector('#mceu_2 > button').click();

	console.log('admin_app +25');
	$('#frm1').submit();
});