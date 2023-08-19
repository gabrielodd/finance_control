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

  newestRecord.scrollIntoView({ behavior: 'smooth', block: 'start' });
});