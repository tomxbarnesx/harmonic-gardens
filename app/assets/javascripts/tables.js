function datatableInit () {
    $('#datatable').DataTable( {
        "pageLength": 25,
        "bLengthChange": false,
        columnDefs: [
            { orderable: false, targets: -1 },
         ],
        "initComplete": function(){ 
            $("#datatable").show(); 
            $('.archive-button').show();
            }
        } ); 
};

function datatableInit2() {
    $('#datatable2').DataTable( {
        "pageLength": 25,
        "bLengthChange": false,
        columnDefs: [
            { orderable: false, targets: -1 },
         ],
        "initComplete": function(){ 
            $("#datatable2").show(); 
            $('.archive-button').show();
            }
        } ); 
}

$(document).ready( function () { 
    datatableInit();
    datatableInit2();
} );
