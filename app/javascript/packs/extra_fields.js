
$(document).ready(function() {
  const addButton = document.getElementById("add-descricao");

  var inputmask = new Inputmask({
    alias: "currency",
    prefix: "R$ ",           // Prefix for currency (Brazilian Real)
    groupSeparator: ",",      // Group thousands with period
    radixPoint: ".",          // Use comma for decimals
    digits: 2,                // Always show 2 decimal places
    autoGroup: true,          // Automatically format thousands
    digitsOptional: false,    // Ensure that 2 decimal places are always shown
    placeholder: "0",         // Pre-fill with zeros
    rightAlign: false,        // Align input from left side
    removeMaskOnSubmit: true, 
    unmaskAsNumber: true
  });
  var selector = $('.valor');
  inputmask.mask(selector);

  $("#add-descricao").on("click", function () {
    var clonedRow = $(".fields:last").clone();
    $(".fields:last").after(clonedRow);
    clonedRow.find('.remove-button').removeClass('d-none')

    clonedRow.find('.valor').each(function () {
      inputmask.mask(this);
    });
  });

  $(document).on("click", ".remove-button", function () {
    $(this).closest('.fields').hide();
  });
});
