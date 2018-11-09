$(document).ready( function () {
    $('#datatable').DataTable( {
        "pageLength": 25,
        "bLengthChange": false,
        columnDefs: [
            { orderable: false, targets: -1 },
            { orderable: false, targets: -2 },
         ]
    } );
} );