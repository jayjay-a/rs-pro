// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree .
//= require jquery3
//= require popper
//= require materialize-sprockets
//= require select2
//= require cocoon

document.addEventListener("turbolinks:load", function() { //fixes having to refresh to get javascript to work cause of turbolinks
    $(document).ready(function() { //select2 drop boxes
        $('select').select2();
    });
   
    $(document).ready(function(){ //datepicker
        $('.datepicker').datepicker({
            format: 'yyyy-mm-dd',
            showDaysInNextAndPreviousMonths: true
        });
      });
    
})

$(document).on('cocoon:before-insert', function(e, insertedItem) { //adds select2 to cocoon nested fields
    $(document).ready(function() { //select2 drop boxes
        $('select').select2();
    });

    $(document).ready(function(){ //datepicker
        $('.datepicker').datepicker({
        });
      });
});
