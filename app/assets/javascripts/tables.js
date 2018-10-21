$(document).ready( function () {
    $('#datatable').DataTable( {
        "pageLength": 25,
        columnDefs: [
            { orderable: false, targets: -1 },
            { orderable: false, targets: -2 },
            { orderable: false, targets: -3 },
         ]
    } );
} );