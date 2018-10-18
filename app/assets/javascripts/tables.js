$(document).ready( function () {
    $('#datatable').DataTable( {
        columnDefs: [
            { orderable: false, targets: -1 },
            { orderable: false, targets: -2 },
            { orderable: false, targets: -3 },
         ]
    } );
} );