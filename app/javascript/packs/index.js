$(document).ready(function() {
  var latestMonth = $('.toggle-month').last().data('month');
  var secondToLastMonth = $('.toggle-month').eq(-2).data('month');

  $('.panel').hide();
  $('.delayed-job-panel').show();
  $('.panel[data-month="' + latestMonth + '"]').show();
  $('.panel[data-month="' + secondToLastMonth + '"]').show();

  $('.toggle-month').click(function() {
    const month = $(this).data('month');
    $(`.panel[data-month="${month}"]`).toggle();
    $(this).toggleClass("fa-chevron-down fa-chevron-up");
  });

  const newestRecord = document.querySelector('.panel-highlight');

  setTimeout(function() {
    newestRecord.classList.remove("panel-highlight");
  }, 1000);

  newestRecord.scrollIntoView({ behavior: 'smooth', block: 'start' });

  $('.edit-valor-btn').click(function() {
    const despesaId = $(this).data('despesa-id');
    const valorSpan = $(`#despesa-${despesaId}-valor`);
    const valorInput = $(`input[data-despesa-id="${despesaId}"].edit-valor-input`);

    const descriptionSpan = $(`#despesa-${despesaId}-descricao`);
    const descriptionInput = $(`input[data-despesa-id="${despesaId}"].edit-descricao-input`);

    const dateSpan = $(`#despesa-${despesaId}-date`);
    const dateInput = $(`input[data-despesa-id="${despesaId}"].edit-date-input`);

    const updateBtn = $(`button[data-despesa-id="${despesaId}"].update-valor-btn`);

    $(this).closest('.panel-body').find('.btn-danger').show();
    $(this).closest('.panel-body').find('.btn-primary').show();

    valorSpan.hide();
    valorInput.show();
    updateBtn.show();
    // $(".edit-valor-btn").hide();

    descriptionSpan.hide();
    descriptionInput.show();

    dateSpan.hide();
    dateInput.show();
    $(".panel-highlight").removeClass("animated-text");
  });

  $('.add-despesa-btn').click(function() {
    $(this).closest('.panel-body').find('.new-despesa').show();
  });

  $('.cancel-update-btn').click(function() {
    const despesaId = $(this).data('despesa-id');
    const valorSpan = $(`#despesa-${despesaId}-valor`);
    const valorInput = $(`input[data-despesa-id="${despesaId}"].edit-valor-input`);
    const dateSpan = $(`#despesa-${despesaId}-date`);
    const dateInput = $(`input[data-despesa-id="${despesaId}"].edit-date-input`);
    const descriptionSpan = $(`#despesa-${despesaId}-descricao`);
    const descriptionInput = $(`input[data-despesa-id="${despesaId}"].edit-descricao-input`);

    $(this).closest('.panel-body').find('.update-valor-btn').hide();
    $(this).closest('.panel-body').find('.btn-danger').hide();
    $(this).hide();
    descriptionInput.hide();
    descriptionSpan.show();
    valorInput.hide();
    dateInput.hide();
    valorSpan.show();
    dateSpan.show();
  });

  $('.update-valor-btn').click(function() {
    const despesaId = $(this).data('despesa-id');
    const valorSpan = $(`#despesa-${despesaId}-valor`);
    const valorInput = $(`input[data-despesa-id="${despesaId}"].edit-valor-input`);
    const dateSpan = $(`#despesa-${despesaId}-date`);
    const dateInput = $(`input[data-despesa-id="${despesaId}"].edit-date-input`);
    const descriptionSpan = $(`#despesa-${despesaId}-descricao`);
    const descriptionInput = $(`input[data-despesa-id="${despesaId}"].edit-descricao-input`);

    const oldValue = parseFloat($(`#despesa-${despesaId}-valor`).text().replace(',', '.'));
    const newValue = parseFloat(valorInput.val().replace(',', '.'));

    const currentPanel = $(this).closest('.panel');
    const totalElement = currentPanel.find('.panel-body-font.total-value');
    const currentTotal = parseFloat(totalElement.text().replace(',', '.'));
    const newTotal = currentTotal - oldValue + newValue;

    const month = $(this).closest('.col-md-12').data('month')
    const totalMonthElement = $(`.col-md-12[data-month="${month}"]`).last().next().find('.total-month');
    const totalSpentText = totalMonthElement.text();
    const floatValue = parseFloat(totalSpentText.match(/[\d.]+/));
    const newTotalMonth = floatValue - oldValue + newValue;

    $.ajax({
      type: 'PATCH',
      url: `/despesas/${despesaId}/update_valor`,
      data: { valor: valorInput.val(), descricao: descriptionInput.val(), date: dateInput.val() },
      dataType: 'script'
    });

    $(this).closest('.panel-body').find('.btn-danger').hide();
    $(this).closest('.panel-body').find('.cancel-update-btn').hide();
    descriptionInput.hide();
    descriptionSpan.text(descriptionInput.val()).show();
    valorInput.hide();
    valorSpan.text(valorInput.val()).show();
    dateInput.hide();
    dateSpan.text(dateInput.val()).show();

    $(this).hide();
    totalElement.text(newTotal.toFixed(2));
    totalMonthElement.text("Total: " + newTotalMonth.toFixed(2));
    $('.edit-valor-btn').show();
    $(".panel-highlight").addClass("animated-text");

    console.log(month);
  });
});