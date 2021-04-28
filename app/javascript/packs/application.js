// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
require("semantic-ui-sass")
import { loadStripe } from '@stripe/stripe-js';

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// agreements checkbox code
function checkAllBoxes(){
  // check all checkboxes on any change
  var checkboxes = $("input.agreements[type=checkbox]");
  var count = checkboxes.length;
  for (var box of checkboxes) {
    box = $(box)
    if (box.is(":checked")) {
      count -= 1;
    }
  }
  var button = $("button.new-registration-checkout");
  if (count == 0) {
    // enable payment button
    button.removeClass('disabled');
  } else {
    button.addClass('disabled');
  }
  console.log(`${count} missing checks`);
}

$(document).on('turbolinks:load', function () {
  var checkboxes = $("input.agreements[type=checkbox]");
  if (checkboxes.length > 0) {
    checkAllBoxes();
    checkboxes.change(function () {
      checkAllBoxes();
    });
  }
});

// stripe payment for race registrations
$(document).on('turbolinks:load', function () {
  var button = $("button.new-registration-checkout")
  if (button.length) {
    button = button[0]
    // todo finish checkout buttons here
    var stripeKey = $('meta[name="stripe-key"]').attr('content')
    var stripePromise = loadStripe(stripeKey);
    var postUrl = $(button).attr('data-post-url');

    button.addEventListener('click', function () {
      // Get Stripe.js instance
      stripePromise.then((stripe) => {
        Fetch.postJSON(postUrl).then((session) => {
          return stripe.redirectToCheckout({
            sessionId: session.id,
          })
        }).then((result) => {
          if(result.error){
            alert(result.error.message);
          }
        })
      })
    });
  }
});

// Open mobile menu
$(document).on('turbolinks:load', function () {
  $('#mobile-menu-button').on('click', () => {
      $('#mobile-menu').sidebar('toggle');
  });
});

// Dropdowns
$(document).on("turbolinks:load", () => $(".ui.dropdown").dropdown());