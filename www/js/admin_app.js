$("[type=checkbox]").change(function () {
  $(this).siblings("label").toggleClass("edited");
  $($(this).prev("input")).val($(this).prop("checked") ? 1 : 0);

  var toggleDisable = $(this).data("toggledisabled");
  if (toggleDisable) {
    $(this).prop("checked")
      ? $(toggleDisable).prop("disabled", false)
      : $(toggleDisable).prop("disabled", true);
  }
});

$('[data-toggle="tooltip"]').tooltip();

$("#entityParamsVotes").on("input change", function () {
  $("#entityParamsVotesInformer").text($(this).val());
});

$("#frm1").submit(function (e19) {
  try {
    const textEditorWrapper = document.querySelector("[data-quill-wrapper]");
    const inputName = textEditorWrapper.getAttribute("data-name");
    const editorsHtml = textEditorWrapper._quill.getSemanticHTML();
    const input = document.querySelector(`[name="${inputName}"]`);
    input.value = editorsHtml;
  } catch (err) {
    console.log(err);
  }

  console.log("admin_app +19");
  document.querySelector("#mceu_2 > button").click();

  console.log("admin_app +22");
  document.querySelector("#frm1 > input").click();
});
