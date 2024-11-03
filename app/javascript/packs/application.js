import "bootstrap"
import "@fortawesome/fontawesome-free/css/all"
import "chartkick/chart.js"
import 'inputmask';
import { inputmask } from './inputmask';

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
require("@nathanvda/cocoon")
require('inputmask');


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

$(document).ready(function($) {
  $("#add-descricao").on("click", function () {
    var clonedRow = $(".fields:last").clone();
    $(".fields:last").after(clonedRow);
    clonedRow.find('.remove-button').removeClass('d-none')

    clonedRow.find('.valor').each(function () {
      inputmask.mask(this);
    });
  });

  var selector = $('.valor');
  inputmask.mask(selector);
});