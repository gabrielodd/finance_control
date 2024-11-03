
$(document).ready(function() {
  $(document).on("click", ".remove-button", function () {
    $(this).closest('.fields').hide();
  });
});
