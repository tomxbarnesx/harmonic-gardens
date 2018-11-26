function datatableInit () {
    dDatatableInit = $('#datatable').DataTable( {
        "pageLength": 25,
        "bLengthChange": false,
        columnDefs: [
            { orderable: false, targets: -1 },
            { orderable: false, targets: -2 },
         ]
        } ); 
    
        datatableInit;
};

$(document).ready( function () { 
    datatableInit();
} );
