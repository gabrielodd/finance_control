$(document).ready(function() {
  var latestMonth = $('.toggle-month').last().data('month');
  var secondToLastMonth = $('.toggle-month').eq(-2).data('month');

  $('.panel').hide();
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
    const updateBtn = $(`button[data-despesa-id="${despesaId}"].update-valor-btn`);

    $(this).closest('.panel-body').find('.btn-danger').hide();

    valorSpan.hide();
    valorInput.show();
    updateBtn.show();
    $(this).hide();

    descriptionSpan.hide();
    descriptionInput.show();
  });

  $('.update-valor-btn').click(function() {
    const despesaId = $(this).data('despesa-id');
    const valorSpan = $(`#despesa-${despesaId}-valor`);
    const valorInput = $(`input[data-despesa-id="${despesaId}"].edit-valor-input`);
    const descriptionSpan = $(`#despesa-${despesaId}-descricao`);
    const descriptionInput = $(`input[data-despesa-id="${despesaId}"].edit-descricao-input`);
    
    $.ajax({
      type: 'PATCH',
      url: `/despesas/${despesaId}/update_valor`,
      data: { valor: valorInput.val(), descricao: descriptionInput.val() },
      dataType: 'script'
    });

    $(this).closest('.panel-body').find('.btn-danger').show();
    descriptionInput.hide();
    descriptionSpan.text(descriptionInput.val()).show();
    valorInput.hide();
    valorSpan.text(valorInput.val()).show();
    $(this).hide();
    $('.edit-valor-btn').show();
  });
});