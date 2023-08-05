// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import "bootstrap"
import "@fortawesome/fontawesome-free/css/all"
import "chartkick/chart.js"

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
require("@nathanvda/cocoon")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

$(document).ready(function() {
  $('.edit-button').on('click', function(e) {
    e.preventDefault();
    
    var despesaId = $(this).data('despesa-id');
    var row = $('#row-' + despesaId);
    var editForm = $('#edit-form-container').html();
    
    row.html(editForm);
    $('#edit-form').attr('action', '/despesas/' + despesaId);
  });

  $('.toggle-month').click(function() {
    const month = $(this).data('month');
    $(`.panel[data-month="${month}"]`).toggle();
    $(this).toggleClass("fa-chevron-down fa-chevron-up");
  });

  const newestRecord = document.querySelector('.panel-highlight');

  newestRecord.scrollIntoView({ behavior: 'smooth', block: 'start' });
});
