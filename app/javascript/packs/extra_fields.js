
$(document).ready(function() {
  const addButton = document.getElementById("add-descricao");

  $("#add-descricao").on("click", function () {
    var clonedRow = $(".fields:last").clone();
    $(".fields:last").after(clonedRow);
  });

  $(document).on("click", ".remove-button", function () {
    $(this).closest('.fields').hide();
  });
});
