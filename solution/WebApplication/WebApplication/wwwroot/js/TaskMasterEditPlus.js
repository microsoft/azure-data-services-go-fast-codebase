var taskTypeMappings;
var editor;

function SourceCheck() {
    // Show the warning if the Source System has the External Value of True
    var currentSourceSystemSelectedOption;
    $.each(taskTypeMappings.ValidSourceSystems,
        function(key, value) {
            if (value.SystemId.toString() === $(':selected', $('#SourceSystemId')).val()) {
                currentSourceSystemSelectedOption = value;
                if (value.IsExternal === true) {
                    $("#ExternalWarningSource").show(500);
                } else {
                    $("#ExternalWarningSource").hide(500);
                }
            }
            console.log(`Is External Value: ${value.IsExternal}`);
        });
}

function TargetCheck() {
    // Show the warning if the Target System has the External Value of True
    var currentTargetSystemSelectedOption;
    $.each(taskTypeMappings.ValidTargetSystems,
        function(key, value) {
            if (value.SystemId.toString() === $(':selected', $('#TargetSystemId')).val()) {
                currentTargetSystemSelectedOption = value;
                if (value.IsExternal === true) {
                    $("#ExternalWarningTarget").show(500);
                } else {
                    $("#ExternalWarningTarget").hide(500);
                }
            }
            console.log(`Is External Value: ${value.IsExternal}`);
        });
}

$(document).ready(function () {
    // Hide the warning by default
    $('#ExternalWarningSource').hide();
    $('#ExternalWarningTarget').hide();

    //SetAceBasePath
    window.ace.config.set("basePath", "~/lib/ace/");

    // SmartWizard initialize
    $('#smartwizard').smartWizard({
        theme: 'dots',
        autoAdjustHeight: false,
        keyboardSettings: {
            keyNavigation: false, // Enable/Disable keyboard navigation(left and right keys are used if enabled)
            keyLeft: [37], // Left key code
            keyRight: [39] // Right key code
        },
        anchorSettings: {
            anchorClickable: false, // Enable/Disable anchor navigation
            enableAllAnchors: false, // Activates all anchors clickable all times
            markDoneStep: true, // Add done state on navigation
            markAllPreviousStepsAsDone: true, // When a step selected by url hash, all previous steps are marked done
            removeDoneStepOnNavigateBack: true, // While navigate back done step after active step will be cleared
            enableAnchorOnDoneStep: true // Enable/Disable the done steps navigation
        }
    });

    var source = $('#SourceSystemId');
    source.change(() => {
        SourceCheck();
    });

    var target = $('#TargetSystemId');
    target.change(() => {
        TargetCheck();
    });
    

    $("#TaskMasterJsonSourceType").change(function () {
        SetSourceSubType($(':selected', $('#TaskMasterJsonSourceType')).val());
        //EnterStep4b();
        EnterStep4a();
    });

    $("#TaskMasterJsonTargetType").change(function () {
        SetTargetSubType($(':selected', $('#TaskMasterJsonTargetType')).val());
        //CreateJsonEditor();
        EnterStep4a();
    });

    $("#TaskDatafactoryIrSelect").change(function () {
        EnterStep4a();
    });

    $("#TaskDatafactoryIrSelect").change(function () {
        EnterStep4a();
    });

    // After get TaskTypeMappings is run, it will call EnterStep2()
    GetTaskTypeMappings();
});

// Initialize the leaveStep event
$("#smartwizard").on("leaveStep", function (e, anchorObject, currentStepIndex, nextStepIndex, stepDirection) {
    if (currentStepIndex === 0 && nextStepIndex === 1) {
        GetTaskTypeMappings();
        return true;
    }
    if (currentStepIndex === 1 && nextStepIndex === 2) {
        EnterStep3();
        return true;
    }
    if (currentStepIndex === 2 && nextStepIndex === 3) {
        EnterStep4a();
        return true;
    }
    if (currentStepIndex === 3 && nextStepIndex === 4) {
        EnterStep5();
        return true;
    }
    return true;
});

$("#TaskMasterJsonSourceType").change(function () {
    SetSourceSubType($(':selected', $('#TaskMasterJsonSourceType')).val());
    //EnterStep4b();
    EnterStep4a();
});

$("#TaskMasterJsonTargetType").change(function () {
    SetTargetSubType($(':selected', $('#TaskMasterJsonTargetType')).val());
    //CreateJsonEditor();
    EnterStep4a();
});

const merge = (...arguments) => {

    // create a new object
    let target = {};

    // deep merge the object into the target object
    const merger = (obj) => {
        for (let prop in obj) {
            if (obj.hasOwnProperty(prop)) {
                if (Object.prototype.toString.call(obj[prop]) === '[object Object]') {
                    // if the property is a nested object
                    target[prop] = merge(target[prop], obj[prop]);
                } else {
                    // for regular property
                    if (obj[prop] !== undefined) {
                        target[prop] = obj[prop];
                    }
                }
            }
        }
    };

    // iterate through all objects and
    // deep merge them with target
    for (let i = 0; i < arguments.length; i++) {
        merger(arguments[i]);
    }

    return target;
};

function GetTaskTypeMappings() {
    var DataToPost = {};

    DataToPost = {
        TaskTypeId: $('#TaskTypeId').val()
    };


    $('#smartwizard').smartWizard("loader", "show");
    $.ajax({
        url: "/TaskTypeMapping/FindMapping",
        dataType: "json",
        type: "post",
        data: DataToPost,
        success: function (data, textStatus, jqXHR) {
            taskTypeMappings = data;
            EnterStep2();
            $('#smartwizard').smartWizard("loader", "hide");
        },
        error: function (xhr, status, error) {
            var errorMsg = `${xhr.status}: ${xhr.responseText}`;
            toastr.warning(`Error - ${errorMsg}`);
            $('#smartwizard').smartWizard("loader", "hide");
            $('#smartwizard').smartWizard("reset");
        }
    });
};


function EnterStep2() {
    var currentSourceSystemSelectedOption = $(':selected', $('#SourceSystemId'));

    currentSourceSystemSelectedOption = $(':selected', $('#SourceSystemId'));
    $('#SourceSystemId option').remove();
    $.each(taskTypeMappings.ValidSourceSystems, function (key, value) {
        var opt = $('<option value="' + value.SystemId + '">' + value.SystemName + ' (' + value.SystemType + ') ' + '</option>')
        if (opt.val() == currentSourceSystemSelectedOption.val()) {
            opt.attr('selected', 'selected');
        }
        $('#SourceSystemId').append(opt);
    })
    SourceCheck();
}

function EnterStep3() {
    //Find Selected SourceSystem
    var currentSourceSystemSelectedOption = $(':selected', $('#SourceSystemId'));;
    $.each(taskTypeMappings.ValidSourceSystems,
        function(key, value) {
            if (value.SystemId.toString() === $(':selected', $('#SourceSystemId')).val()) {
                currentSourceSystemSelectedOption = value;
            }
        });

    var validTargetSystemTypes = [];
    //FindAll taskTypeMappings that Match Selected Source System Type
    $.each(taskTypeMappings.TaskTypeMappings,
        function(key, value) {
            if (value.SourceSystemType === currentSourceSystemSelectedOption.SystemType) {
                validTargetSystemTypes.push(value.TargetSystemType);
            }
        });

    //Populate Valid Target Systems Select
    var currentTargetSystemSelectedOption = $(':selected', $('#TargetSystemId'));
    $('#TargetSystemId option').remove();

    $.each(taskTypeMappings.ValidTargetSystems,
        function(key, value) {
            var opt = $('<option value="' +
                value.SystemId +
                '">' +
                value.SystemName +
                ' (' +
                value.SystemType +
                ') ' +
                '</option>')
            if (opt.val() == currentTargetSystemSelectedOption.val()) {
                opt.attr('selected', 'selected');
            }
            if (validTargetSystemTypes.includes(value.SystemType)) {
                $('#TargetSystemId').append(opt);
            }
        });
    TargetCheck();
}

function EnterStep4a() {
    //Find Selected SourceSystem && SelectedTargetSystem
    var currentSourceSystemSelectedOption;
    var currentTargetSystemSelectedOption;
    $.each(taskTypeMappings.ValidSourceSystems,
        function(key, value) {
            if (value.SystemId.toString() === $(':selected', $('#SourceSystemId')).val()) {
                currentSourceSystemSelectedOption = value;
            }
        });
    $.each(taskTypeMappings.ValidTargetSystems,
        function(key, value) {
            if (value.SystemId.toString() === $(':selected', $('#TargetSystemId')).val()) {
                currentTargetSystemSelectedOption = value;
            }
        });

    if (!currentSourceSystemSelectedOption || !currentTargetSystemSelectedOption)
        HideJsonEditor("Source or target system is invalid");

    var validSourceSubTypes = taskTypeMappings.TaskTypeMappings
        .filter(value => value.SourceSystemType === currentSourceSystemSelectedOption.SystemType && value.TargetSystemType === currentTargetSystemSelectedOption.SystemType)
        .map(value => value.SourceType)
        .filter((value, index, self) => self.indexOf(value) === index);

    //Populate Valid Source Sub Types
    var currentSourceSubType = GetCurrentlySelectedSourceSubType();
    $('#TaskMasterJsonSourceType option').remove();
    if (!validSourceSubTypes.includes(currentSourceSubType))
        $('#TaskMasterJsonSourceType').append($('<option value=""></option>'));

    $.each(validSourceSubTypes,
        function(key, value) {
            var opt = $('<option value="' + value + '">' + value + '</option>');
            if (opt.val() == currentSourceSubType) {
                opt.attr('selected', 'selected');
            }
            $('#TaskMasterJsonSourceType').append(opt);
        });

    if ($(':selected', $('#TaskMasterJsonSourceType')).val()) {
        EnterStep4b();
    }
}

function EnterStep4b() {
    //Find Selected SourceSystem && SelectedTargetSystem
    var currentSourceSystemSelectedOption;
    var currentTargetSystemSelectedOption;
    $.each(taskTypeMappings.ValidSourceSystems,
        function(key, value) {
            if (value.SystemId.toString() === $(':selected', $('#SourceSystemId')).val()) {
                currentSourceSystemSelectedOption = value;
            }
        });
    $.each(taskTypeMappings.ValidTargetSystems,
        function(key, value) {
            if (value.SystemId.toString() === $(':selected', $('#TargetSystemId')).val()) {
                currentTargetSystemSelectedOption = value;
            }
        });

    var currentSourceSubType = GetCurrentlySelectedSourceSubType();

    //Update SourceSubType in JSON Object
    GetTaskMasterJson_Source();

    var validTargetSubTypes = taskTypeMappings.TaskTypeMappings
        .filter(value => value.SourceSystemType === currentSourceSystemSelectedOption.SystemType && value.TargetSystemType === currentTargetSystemSelectedOption.SystemType && value.SourceType === currentSourceSubType)
        .map(value => value.TargetType)
        .filter((value, index, self) => self.indexOf(value) === index);

    //Populate Valid Target Sub Types
    var currentTargetSubType = GetCurrentlySelectedTargetSubType();
    $('#TaskMasterJsonTargetType option').remove();
    if (!validTargetSubTypes.includes(currentTargetSubType))
        $('#TaskMasterJsonTargetType').append($('<option value=""></option>'));

    $.each(validTargetSubTypes,
        function(key, value) {
            var opt = $('<option value="' + value + '">' + value + '</option>')
            if (opt.val() == currentTargetSubType) {
                opt.attr('selected', 'selected');
            }
            $('#TaskMasterJsonTargetType').append(opt);
        });

    if ($(':selected', $('#TaskMasterJsonTargetType')).val()) {
        EnterStep4c();
    }


}

function EnterStep4c() {
    var TargetSystemType = GetCurrentlySelectedTargetSystem().SystemType;
    var SourceSystemType = GetCurrentlySelectedSourceSystem().SystemType;
    var TargetSubType = GetCurrentlySelectedTargetSubType();
    var SourceSubType = GetCurrentlySelectedSourceSubType();

    //Update TargetSubType in JSON Object
    GetTaskMasterJson_Target();


    //var validDatafactoryIrs = [];
    //$.each(taskTypeMappings.TaskTypeMappings, function (key, value) {
    //    if (value.SourceSystemType === SourceSystemType && value.TargetSystemType === TargetSystemType && value.SourceType === SourceSubType && value.TargetType === TargetSubType) {
    //        if (!validDatafactoryIrs.includes(value.TaskDatafactoryIr)) {
    //            validDatafactoryIrs.push(value.TaskDatafactoryIr);
    //        }
    //    }
    //})

    ////Populate Valid Target Sub Types
    //var currentDataFactoryIr = GetCurrentlySelectedDatafactoryIr();
    //$('#TaskDatafactoryIrSelect option').remove();
    //if (!currentDataFactoryIr)
    //    $('#TaskDatafactoryIrSelect').append($('<option value=""></option>'));

    //$.each(validDatafactoryIrs, function (key, value) {
    //    var opt = $('<option value="' + value + '">' + value + '</option>')
    //    if (opt.val() == currentDataFactoryIr) {
    //        opt.attr('selected', 'selected');
    //    }
    //    $('#TaskDatafactoryIrSelect').append(opt);
    //})

    //if ($(':selected', $('#TaskDatafactoryIrSelect')).val()) {
    //    CreateJsonEditor();
    //}
    CreateJsonEditor();
}

function EnterStep5() {
    if (editor !== undefined) {
        $('#TaskMasterJson').val(JSON.stringify(editor.getValue()));
    }
}



function CreateJsonEditor() {
    var TargetSystemType = GetCurrentlySelectedTargetSystem().SystemType;
    var SourceSystemType = GetCurrentlySelectedSourceSystem().SystemType;
    var TargetSubType = GetCurrentlySelectedTargetSubType();
    var SourceSubType = GetCurrentlySelectedSourceSubType();
    /*var DatafactoryIr = GetCurrentlySelectedDatafactoryIr();*/

    //Update DatafactoryIr in Form Input
    //$('#TaskDatafactoryIr').val(DatafactoryIr);

    var SelectedTaskTypeMapping;
    $.each(taskTypeMappings.TaskTypeMappings,
        function(key, value) {
            if (value.SourceSystemType === SourceSystemType &&
                value.TargetSystemType === TargetSystemType &&
                value.TargetType === TargetSubType &&
                value.SourceType === SourceSubType) {
                SelectedTaskTypeMapping = value;
            }
        });

    if (SelectedTaskTypeMapping) {
        var schema = SelectedTaskTypeMapping.TaskMasterJsonSchema;

        if ($('#editor_holder').children().length > 0) {
            editor.destroy();
        }

        if (!schema) {
            schema = `{ \"title\": \"Task Master Json\", \"type\": \"object\" }`;
            toastr.warning(`Schema not found -- Task Type Mapping (${SelectedTaskTypeMapping.MappingName}) for Source System ${SelectedTaskTypeMapping.SourceSystemType}.${SourceSubType} -> Target System ${SelectedTaskTypeMapping.TargetSystemType}.${TargetSubType} has not been configured. please contact your Pipeline Administrator`);
        }

        try {
            if ($('#editor_holder').children().length > 0) {
                editor.destroy();
            }
            $('#editor_holder').show();
            editor = new JSONEditor(document.getElementById('editor_holder'), {
                theme: 'bootstrap4',
                iconlib: "fontawesome5",
                schema: JSON.parse(schema)
            });
            $('.je-switcher').parent().addClass("alert-warning");
            $('#TaskMasterJsonShowHide').hide();
            setTimeout(function () {
                $(".ace_editor").height(400);
            }, 2000);


            editor.on('ready', () => {
                // Now the api methods will be available
                //On ready we merge the existing value with the defaults from the schema to ensure that optional attributes are set with their default values. If we don't do this they wont show up in the form.
                const CurrentVal = JSON.parse($('#TaskMasterJson').val());
                const DefaultVal = editor.getValue();
                const MergedValue = merge(DefaultVal, CurrentVal);
                editor.setValue(MergedValue);
            });

        } catch (err) {
            HideJsonEditor(err);
        }
    } else {
        toastr.warning(`Task Mapping for Target(${TargetSystemType}) and Source(${SourceSystemType}) was not found`);
    }
}

function HideJsonEditor(err) {
    toastr.warning("Validation errors are preventing the use of the enahanced editor. " + err, "Enhanced Editor Error");
    $('#editor_holder').hide();
    $('#TaskMasterJsonShowHide').show();
}

function GetCurrentlySelectedSourceSystem() {
    var Selected;
    $.each(taskTypeMappings.ValidSourceSystems, function (key, value) {
        if (value.SystemId.toString() === $(':selected', $('#SourceSystemId')).val()) {
            Selected = value;
        }
    });
    return Selected;
}

function GetCurrentlySelectedTargetSystem() {
    var Selected;
    $.each(taskTypeMappings.ValidTargetSystems, function (key, value) {
        if (value.SystemId.toString() === $(':selected', $('#TargetSystemId')).val()) {
            Selected = value;
        }
    });
    return Selected;
}

//function GetCurrentlySelectedDatafactoryIr() {
//    var selected = $(':selected', $('#TaskDatafactoryIrSelect')).val();
//    if (!selected)
//        selected = $('#TaskDatafactoryIr').val();
//    return selected;
//}

function GetCurrentlySelectedTargetSubType() {
    if (JSON.parse($('#TaskMasterJson').val()) === undefined) {
        return "";
    } else {
        if (JSON.parse($('#TaskMasterJson').val()).Target !== undefined) {
            return JSON.parse($('#TaskMasterJson').val()).Target.Type;
        } else {
            return "";
        }
    }


}

function GetCurrentlySelectedSourceSubType() {
    if (JSON.parse($('#TaskMasterJson').val()) === undefined) {
        return "";
    } else {
        if (JSON.parse($('#TaskMasterJson').val()).Source !== undefined) {
            return JSON.parse($('#TaskMasterJson').val()).Source.Type;
        } else {
            return "";
        }
    }
}

function SetSourceSubType(Type) {
    var TemplateJson = JSON.parse('{"Source":{}, "Target":{}}');
    if (JSON.parse($('#TaskMasterJson').val()) !== undefined) {
        TemplateJson = JSON.parse($('#TaskMasterJson').val());
        if (TemplateJson.Source === undefined) {
            TemplateJson.Source = {};
        }
        TemplateJson.Source.Type = Type;
    }

    $('#TaskMasterJson').val(JSON.stringify(TemplateJson));
}

function SetTargetSubType(Type) {
    var TemplateJson = JSON.parse('{"Source":{}, "Target":{}}');
    if (JSON.parse($('#TaskMasterJson').val()) !== undefined) {
        TemplateJson = JSON.parse($('#TaskMasterJson').val());
        if (TemplateJson.Target === undefined) {
            TemplateJson.Target = {};
        }
        TemplateJson.Target.Type = Type;
    }

    $('#TaskMasterJson').val(JSON.stringify(TemplateJson));
}

function GetTaskMasterJson() {
    return JSON.parse($('#TaskMasterJson').val());
}

function GetTaskMasterJson_Source() {
    var tmj = GetTaskMasterJson();
    if (tmj.Source === undefined) {
        tmj.Source = {};
    }
    $('#TaskMasterJson').val(JSON.stringify(tmj));
    return tmj.Source;
}

function GetTaskMasterJson_Target() {
    var tmj = GetTaskMasterJson();
    if (tmj.Target === undefined) {
        tmj.Target = {};
    }
    $('#TaskMasterJson').val(JSON.stringify(tmj));
    return tmj.Target;
}