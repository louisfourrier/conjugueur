
$(function() {


$(document).on('page:fetch', function() {
$('#page_loading').show();
});
$(document).on('page:change', function() {
$('#page_loading').hide();
});


});

