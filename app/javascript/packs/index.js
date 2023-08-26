$(document).ready(function() {
  var latestMonth = $('.toggle-month').last().data('month');
  $('.panel').hide();
  $('.panel[data-month="' + latestMonth + '"]').show();

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
    const valorInput = $(`input[data-despesa-id="${despesaId}"]`);

    valorSpan.hide();
    valorInput.show().focus();
  });

  $('.edit-valor-input').blur(function() {
    const despesaId = $(this).data('despesa-id');
    const valorSpan = $(`#despesa-${despesaId}-valor`);
    const valorInput = $(this);
    
    $.ajax({
      type: 'PATCH',
      url: `/despesas/${despesaId}/update_valor`,
      data: { valor: valorInput.val() },
      dataType: 'script'
    });

    valorInput.hide();
    valorSpan.text(valorInput.val()).show();
  });
});