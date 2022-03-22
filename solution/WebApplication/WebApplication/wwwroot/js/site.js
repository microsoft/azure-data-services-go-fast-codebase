// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.

function DataTablesGridPrep(PrepOptions) {
    params = {}; location.search.replace(/[?&]+([^=&]+)=([^&]*)/gi, function (s, k, v) { params[k] = v });
    var PostData = { QueryParams: null };
    if (Object.keys(params).length > 0) {
        PostData = { QueryParams: params };
    }

    if (typeof PrepOptions !== 'undefined') {
        if (typeof PrepOptions.QueryParams !== 'undefined') {
            //Do someting -- TBA
        }
    }

    $.ajax({
        url: "/" + ModelName + "/GetGridOptions",
        dataType: "json",
        type: "post",
        data: PostData,
        success: function (data, textStatus, jqXHR) {
            DataTablesGridStart(data, PrepOptions);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert("Error");
        }
    });
}

$.urlParam = function (name) {
    var results = new RegExp('[\?&]' + name + '=([^&#]*)')
        .exec(window.location.search);

    return (results !== null) ? results[1] || 0 : null;
}


function RestyleDataTableButtons() {
    $('.dt-buttons').removeClass("btn-group").addClass("btn-toolbar");
    $('.btn', $('.dt-buttons')).removeClass("btn-secondary");
    $('.dt-buttons').css("display", "block");
    $('.buttons-page-length', $('.dt-buttons')).addClass("btn-secondary");
    if ($('#ads-btn-crud-group').length === 0) {
        $('.ads-btn-crud', $('.dt-buttons')).wrapAll("<div id='ads-btn-crud-group' class='btn-group'/>");
    }
    if ($('#ads-btn-nav-group').length === 0) {
        $('.ads-btn-nav', $('.dt-buttons')).wrapAll("<div id='ads-btn-nav-group' class='btn-group'/>");
    }
    if ($('#ads-btn-action-group').length === 0) {
        $('.ads-btn-action', $('.dt-buttons')).wrapAll("<div id='ads-btn-action-group' class='btn-group'/>");
    }
}


function DataTablesGridStart(GridOptions, PrepOptions) {
    var gridheader = $("#adsgofast_tablelist").find("thead").find("tr");
    gridheader.empty();

    $.each(GridOptions.GridColumns, function (index, value) {
        gridheader[0].append($("<th>" + value["name"] + "</th>")[0]);
    });

    //QueryParams
    params = {}; location.search.replace(/[?&]+([^=&]+)=([^&]*)/gi, function (s, k, v) { params[k] = v })

    //PrepOptions 
    if (typeof PrepOptions === 'undefined') {
        PrepOptions = {};
    }

    if (typeof PrepOptions.AjaxDataFunction === 'undefined') {
        PrepOptions.AjaxDataFunction = function (d) {
            d.QueryParams = params;
        }
    }

    //Navigation Buttons
    NavButtons = [
        {
            extend: "pageLength",
            className: 'btn'
        },
    ];

    CrudButtons = [];

    $.each(GridOptions["CrudButtons"], function (index, value) {
        var CrudController = ModelName;
        if (GridOptions["CrudController"] !== undefined) {
            CrudController = GridOptions["CrudController"];
        }

        if (value === "Create" || value === "CreatePlus") {
            imageclass = "fas fa-plus";
            btnclass = "btn-primary";
            imgtitle = "Add Item";
        }

        if (value === "Edit" || value === "EditPlus") {
            extend = "selectedSingle",
                imageclass = "fas fa-edit";
            btnclass = "btn-warning";
            imgtitle = "Edit Item";
        }

        if (value === "Details" || value === "DetailsPlus") {
            extend = "selectedSingle",
                imageclass = "fas fa-info-circle";
            btnclass = "btn-info";
            imgtitle = "View Details";
        }

        if (value === "Delete" || value === "DeletePlus") {
            extend = "selectedSingle",
                imageclass = "fas fa-trash";
            btnclass = "btn-danger";
            imgtitle = "Delete Item";
        }

        if (typeof imageclass !== 'undefined') {
            var CrudButton =
            {
                text: '<i data-toggle="tooltip" title="' + imgtitle + '" class="' + imageclass + '" style=\'width:16px\'></i>',
                className: btnclass + ' ads-btn-crud'
            };

            if (value === "Create" || value === "CreatePlus") {
                CrudButton.action = function (e, dt, node, config) {
                    window.location = "/" + CrudController + "/" + value + window.location.search;
                }
            }
            else {
                if (GridOptions["UseCompositeKey"]) {
                    CrudButton.action = function (e, dt, node, config) {
                        var url = "/" + CrudController + "/" + value;
                        var count = GridOptions.PrimaryKeyColumns.length;

                        url = url + "?" + GridOptions.PrimaryKeyColumns[0] + "=" + dt.data()[dt.rows({ selected: true }).indexes()[0]][GridOptions.PrimaryKeyColumns[0]];

                        for (var i = 1; i < count; i++) {
                            url = url + "&" + GridOptions.PrimaryKeyColumns[i] + "=" + dt.data()[dt.rows({ selected: true }).indexes()[0]][GridOptions.PrimaryKeyColumns[i]];
                        }
                        window.location = url;
                    }
                }
                else {
                    CrudButton.action = function (e, dt, node, config) {
                        window.location = "/" + CrudController + "/" + value + "/" + dt.data()[dt.rows({ selected: true }).indexes()[0]][GridOptions.PrimaryKeyColumns[0]];
                    }
                }
            }


            if (typeof extend !== 'undefined') { CrudButton.extend = extend; }
            CrudButtons.push(CrudButton);
        };
        imageclass = undefined;
    });

    if (GridOptions.SuppressCrudButtons === false || GridOptions.SuppressCrudButtons === undefined) {
        NavButtons.push(CrudButtons);
    }

    $.each(GridOptions.Navigations, function (index, value) {
        NewButton = {
            extend: 'selectedSingle',
            className: 'btn-outline-primary ads-btn-nav',
            action: function (e, dt, node, config) {
                window.location = value.Url + dt.data()[dt.rows({ selected: true }).indexes()[0]][GridOptions.PrimaryKeyColumns[0]];
            }
        };

        if (value.Icon !== undefined) {
            NewButton.text = '<i data-toggle="tooltip" class="fas fa-' + value.Icon + ' style="width: 16px" title="' + value.Description + '"></i>';
        }
        else {
            NewButton.text = value.Description;
        }

        NavButtons.push(NewButton);
    });


    var DataTableInitialisationObject = {
        dom: 'Bfrtip',
        "processing": true, // for show progress bar
        "serverSide": true, // for process server side
        "filter": true, // this is for disable filter (search box)
        "orderMulti": false, // for disable multiple column at once
        "stateSave": true,
        "scrollX": true,
        "scrollY": "60vh",
        "scrollCollapse": true,
        "pageLength": 25,
        "select": true,
        "autoWidth": GridOptions.AutoWidth,
        "buttons": NavButtons,
        "ajax": {
            "url": "/" + ModelName + "/GetGridData",
            "type": "POST",
            "data": PrepOptions.AjaxDataFunction,
            "datatype": "json"
        },
        "fixedColumns": {
            leftColumns: 1,
            rightColumns: 0
        },
        "columnDefs":
            [{
                targets: [],
                render: $.fn.dataTable.render.number(',', '.', 2, '$')
            }],

        "columns": GridOptions.GridColumns,
        "bStateSave": true,
        "fnStateSave": function (oSettings, oData) {
            localStorage.setItem('DataTables_' + window.location.pathname, JSON.stringify(oData));
        },
        "fnStateLoad": function (oSettings) {
            return JSON.parse(localStorage.getItem('DataTables_' + window.location.pathname));
        },
        "initComplete": function () {
            var api = this.api();

            //if (localStorage.getItem(`DataTables_${ModelName}_selected`) != undefined) {
            //    var selected = localStorage.getItem(`DataTables_${ModelName}_selected`).split(',');
            //    selected.forEach(function (s) {
            //        api.row(s).select();
            //    });
            //}
        }
    };

    if (GridOptions.InitialOrder !== undefined) {
        DataTableInitialisationObject.order = GridOptions.InitialOrder;
    }

    //Add Ads Go Fast Column Formats
    $.each(GridOptions.GridColumns, function (index, value) {
        if (value.ads_format !== undefined) {
            if (value.ads_format.toLowerCase() === "money") {
                GridOptions.GridColumns[index].render = $.fn.dataTable.render.number(',', '.', 2, '$');
            };
            if (value.ads_format.toLowerCase() === "int") {
                GridOptions.GridColumns[index].render = $.fn.dataTable.render.number(',', '.', 0, '');
            };
            if (value.ads_format.toLowerCase() === "datetime") {
                GridOptions.GridColumns[index].render = function (data, type, row, meta) {
                    return moment.utc(data).local().format('DD/MM/YYYY HH:mm:ss');
                }
            }
            if (value.ads_format.toLowerCase() === "bool") {
                GridOptions.GridColumns[index].render = function (data, type, row, meta) {
                    var item = '<i data-toggle="tooltip" title="InActive" class="far fa-square" style="width:16px; color:grey"></i>';
                    if (data) {
                        item = '<i data-toggle="tooltip" title="Active" class="far fa-check-square" style="width:16px; color: black"></i>';
                    }
                    return item;
                };
            }
            if (value.ads_format.toLowerCase() === "taskstatus") {
                GridOptions.GridColumns[index].render = function (data, type, row, meta) {
                    var item = '<i data-toggle="tooltip" title="Off" class="fas fa-times-circle" style="width:16px; color:red"></i>';
                    if (data === "Complete") {
                        item = '<a><i data-toggle="tooltip" title="Complete" class="fas fa-check-circle" style="width:16px; color:green"></i> ' + data + '</a>';
                    }
                    if (data === "InProgress") {
                        item = '<a><i data-toggle="tooltip" title="InProgress" class="fas fa-running" style="width:16px; color:Orange"></i> ' + data + '</a>';
                    }
                    if (data === "FailedNoRetry" || data === "FailedRetry") {
                        item = '<a><i data-toggle="tooltip" title="FailedNoRetry" class="fas fa-times-circle" style="width:16px; color:red"></i> ' + data + '</a>';
                    }
                    if (data === "Untried") {
                        item = '<a><i data-toggle="tooltip" title="Untried" class="fas fa-pause-circle" style="width:16px"></i> ' + data + '</a>';
                    }
                    return item;
                };
            }

            if (value.ads_format.toLowerCase() === "taskrunnerstatus") {
                GridOptions.GridColumns[index].render = function (data, type, row, meta) {
                    var item = '<i data-toggle="tooltip" title="Off" class="fas fa-times-circle" style="width:16px; color:red"></i>';
                    if (data === "Idle") {
                        item = '<a><i data-toggle="tooltip" title="Idle" class="fas fa-pause-circle" style="width:16px"></i> ' + data + '</a>';
                    }
                    if (data === "Running") {
                        item = '<a><i data-toggle="tooltip" title="InProgress" class="fas fa-running" style="width:16px"></i> ' + data + '</a>';
                    }
                    return item;
                };
            }
        }
    });


    var dt = $("#adsgofast_tablelist").DataTable(DataTableInitialisationObject);
    dt.on('init.dt', function () {
        console.log('Table initialisation complete: ' + new Date().getTime());
        RestyleDataTableButtons();
    })


    dt.on('select.dt deselect.dt', function () {
        //localStorage.setItem(`DataTables_${ModelName}_selected`, dt.rows({ selected: true }).toArray());
    });


    dt.on('draw', function () {
        adsgofast_tablelist_wrapper

        $('[data-toggle="tooltip"]').tooltip()
        $('[data-toggle="popover"]').popover();


    });

    dt.on('column-sizing.dt', function (e, settings) {
        $('#adsgofast_tablelist_wrapper').width($($('.dataTables_scrollHeadInner')[0]).width() + 25);

    });
};

//Sidebar Stuff
$(document).ready(function () {

    $("#sidebar").mCustomScrollbar({
        theme: "minimal"
    });

    $('#dismiss, .overlay').on('click', function () {
        // hide sidebar
        $('#sidebar').removeClass('active');
        // hide overlay
        $('.overlay').removeClass('active');
    });

    $('#sidebarCollapse').on('click', function () {
        // open sidebar
        $('#sidebar').addClass('active');
        // fade in the overlay
        $('.overlay').addClass('active');
        $('.collapse.in').toggleClass('in');
        $('a[aria-expanded=true]').attr('aria-expanded', 'false');
    });


});