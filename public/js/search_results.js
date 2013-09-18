$(document).ready(function() {
    
    $('#searchresults').find('tr').click( function(){
      
      var row = $(this).index()
      var id  = $(this).find('td:last').text()
      
      $.ajax({
        url: '/determinerow',
        dataType: 'json',
        type: 'POST',
        data : { row: row, id: id},
        accepts: "application/json",
        
        success: function(row_results) {  
          $('#name').text(row_results[3]);
          $('#url').text(row_results[7]);
          $('#email').text(row_results[1]);
          $('#phone').text(row_results[4]);
          $('#industry').text(row_results[2]);
          $('#employees').text(row_results[0]);
          $('#status').text(row_results[5]);
          $('#type').text(row_results[6]);
        }
      })
    });
  });