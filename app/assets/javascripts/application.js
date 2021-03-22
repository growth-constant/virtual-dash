//-# require semantic-ui
//= require fetch-rails

// Open mobile menu
$(function (){
    $('#mobile-menu-button').on('click', function () {
        $('#mobile-menu').sidebar('toggle');
    });
});