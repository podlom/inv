var input = document.querySelector("#phone"),
    input1 = document.querySelector("#phone1"),
    input2 = document.querySelector("#phone2"),
    input3 = document.querySelector("#phone3"),
    errorMsg = document.querySelector("#error-msg"),
    validMsg = document.querySelector("#valid-msg"),
    errorMsg1 = document.querySelector("#error-msg1"),
    validMsg1 = document.querySelector("#valid-msg1"),
    errorMsg2 = document.querySelector("#error-msg2"),
    validMsg2 = document.querySelector("#valid-msg2"),
    errorMsg3 = document.querySelector("#error-msg3"),
    validMsg3 = document.querySelector("#valid-msg3");

// here, the index maps to the error code returned from getValidationError - see readme
var errorMap = ["Invalid number", "Invalid country code", "Too short", "Too long", "Invalid number"];

// initialise plugin
var iti = window.intlTelInput(input, {
  utilsScript: "/js/utils.js?1562189064761"
});

var reset = function() {
  input.classList.remove("error");
  errorMsg.innerHTML = "";
  errorMsg.classList.add("hide");
  validMsg.classList.add("hide");
};

// on blur: validate
input.addEventListener('blur', function() {
  reset();
  if (input.value.trim()) {
    if (iti.isValidNumber()) {
      validMsg.classList.remove("hide");
    } else {
      input.classList.add("error");
      var errorCode = iti.getValidationError();
      errorMsg.innerHTML = errorMap[errorCode];
      errorMsg.classList.remove("hide");
    }
  }
});

var iti2 = window.intlTelInput(input2, {
  utilsScript: "/js/utils.js?1562189064761"
});

var reset2 = function() {
  input2.classList.remove("error");
  errorMsg2.innerHTML = "";
  errorMsg2.classList.add("hide");
  validMsg2.classList.add("hide");
};

// on blur: validate
input2.addEventListener('blur', function() {
  reset2();
  if (input2.value.trim()) {
    if (iti2.isValidNumber()) {
      validMsg2.classList.remove("hide");
    } else {
      input2.classList.add("error");
      var errorCode = iti2.getValidationError();
      errorMsg2.innerHTML = errorMap[errorCode];
      errorMsg2.classList.remove("hide");
    }
  }
});


var iti3 = window.intlTelInput(input3, {
  utilsScript: "/js/utils.js?1562189064761"
});

var reset3 = function() {
  input3.classList.remove("error");
  errorMsg3.innerHTML = "";
  errorMsg3.classList.add("hide");
  validMsg3.classList.add("hide");
};

// on blur: validate
input3.addEventListener('blur', function() {
  reset3();
  if (input3.value.trim()) {
    if (iti3.isValidNumber()) {
      validMsg3.classList.remove("hide");
    } else {
      input3.classList.add("error");
      var errorCode = iti3.getValidationError();
      errorMsg3.innerHTML = errorMap[errorCode];
      errorMsg3.classList.remove("hide");
    }
  }
});

// on keyup / change flag: reset
input.addEventListener('change', reset);
input.addEventListener('keyup', reset);
input2.addEventListener('change', reset2);
input2.addEventListener('keyup', reset2);
input3.addEventListener('change', reset3);
input3.addEventListener('keyup', reset3);




$(document).ready(function() {
	function initTelInput(id){
		const input = document.querySelector(id);
		input && window.intlTelInput(input, {
			dropdownContainer: document.body,
			utilsScript: "/js/utils.js",
		});
	}
	const ids = ['#phone', "#phone2", "#phone3"]
	ids.forEach(initTelInput)
});