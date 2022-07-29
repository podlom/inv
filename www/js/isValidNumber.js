$(document).ready(function () {
	const errorMap = [
		'Invalid number',
		'Invalid country code',
		'Too short',
		'Too long',
		'Invalid number',
	];

	function initTelInput({ inputId, validId, errorId }) {
		const input = document.querySelector(inputId);
		if (!input) return;
		const validMsg = document.querySelector(validId);
		const errorMsg = document.querySelector(errorId);

		const iti = window.intlTelInput(input, {
			dropdownContainer: document.body,
			utilsScript: '/js/utils.js',
		});

		const reset = function () {
			input.classList.remove('error');
			errorMsg.innerHTML = '';
			errorMsg.classList.add('hide');
			validMsg.classList.add('hide');
		};

		input.addEventListener('blur', function () {
			reset();
			if (input.value.trim()) {
				if (iti.isValidNumber()) {
					validMsg.classList.remove('hide');
				} else {
					input.classList.add('error');
					const errorCode = iti.getValidationError();
					errorMsg.innerHTML = errorMap[errorCode] || errorMap[0];
					errorMsg.classList.remove('hide');
				}
			}
		});

		input.addEventListener('change', reset);
		input.addEventListener('keyup', reset);
	}
	const ids = [
		['#phone', '#valid-msg', '#error-msg'],
		['#phone1', '#valid-msg1', '#error-msg1'],
		['#phone2', '#valid-msg2', '#error-msg2'],
		['#phone3', '#valid-msg3', '#error-msg3'],
	];
	ids.forEach(([inputId, validId, errorId]) =>
		initTelInput({ inputId, validId, errorId }),
	);
});
