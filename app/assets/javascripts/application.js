// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function() {
	$('.btn-search').click(function(){
	  $('.searchbar').toggleClass('clicked');
	  $('.stage').toggleClass('faded');

	  
	  if($('.searchbar').hasClass('clicked')){
	    $('.btn-extended').focus();
	  }
	  
	});

  });

// $(document).ready(function() {

//  $("#datepicker").datepicker({
//       language: "pl",
//       autoclose: true,
//       //removed line: startDate: '+1d',
//       weekStart: 1,
//       default: 'D, dd MM yy',
//       beforeShowDay: function(date){
//            var formattedDate = $.fn.datepicker.DPGlobal.formatDate(date, 'D, dd MM yy', 'pl');
//            if ($.inArray(formattedDate.toString(), selected_dates) != -1){
//                return {
//                   enabled : false
//                };
//            }
//           return;
//       }
//   });
// });
