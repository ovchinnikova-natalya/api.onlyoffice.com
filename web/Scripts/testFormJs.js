$(document).ready(function () {
   
    var title = "default"; // editors title
    var selectedOption = "docx"; // docx , xlxs , pptx
    var documentType = "text"; // text , spreadsheet ,presentation
    var userName = ""; // user name in editor
    var key = ""; // unique editors key
    var permissions = {
        commentBool: false,
        copyBool: false,
        downloadBool: false,
        editBool: false,
        fillFormsBool: false,
        modifyContentControlBool: false,
        modifyFilterBool: false,
        printBool: false,
        reviewBool: false
    }  // users permissions in editor
    var customization = {
        autosave: false,
        chat: false,
        commentAuthorOnly: false,
        comments: false,
        compactHeader: false,
        compactToolbar: false,
        compatibleFeatures: false,
        macros: false,
        plugins: false,
        help: false
    } // users customization in editor
    var macroMode = "original";
    var unit = "cm";
    var sJWT = ""; // token

    $("#copyCodeText").click(function () {
        const el = document.createElement('textarea');
        el.value = $("#codeText").text();
        document.body.appendChild(el);
        el.select();
        document.execCommand('copy');
        document.body.removeChild(el);
    });

    $("#permissionButton").click(function () {
        $("#permissionConfig").toggle();
    });   // hide and show permission list

    $("#customizationButton").click(function () {
        $("#customizationConfig").toggle();
    })   // hide and show customization list

    $("#macro").click(function () {
        $("#macrosModeList").toggle();
    })   // hide and show macros mode list

    $("#unit").click(function () {
        $("#unitList").toggle();
    })   // hide and show unit list

    $("#chooseAndCreateDocument").change(function () {
        let tmp1 = $("#documentHiddenPerm");
        let tmp2 = $("#xlsxHiddenPerm");
        selectedOption = $('select[name=create]').val();
        switch (selectedOption) {
            case "xlsx": documentType = "spreadsheet"; tmp2.show(); tmp1.hide(); break;
            case "pptx": documentType = "presentation"; tmp1.hide(); tmp2.hide(); break;
            default: tmp1.show(); tmp2.hide(); break;
        }
    }) //hide and show some special advanced parametres

    function GetTitle() {
        if ($('#inputDocTitle').val() != "") {
            title = $('#inputDocTitle').val();
        }
    }

    function EditorUserName() {
        userName = $('#inputUserName').val();
    }

    function GetMacroMode() {
        if ($("#macro").prop("checked")) {
            switch ($("select[name=macros] option:selected").val()) {
                case "enable": macroMode = "enable"; break;
                case "warn": macroMode = "warn"; break;
                case "disable": macroMode = "disable"; break;
                case "original": break;
            }
        }
    }

    function GetUnit() {
        if ($("#unit").prop("checked")) {
            switch ($("select[name=units] option:selected").val()) {
                case "pt": unit = "pt"; break;
                case "inch": unit = "inch"; break;
                case "cm": break;
            }
        }
    }

    function GetPermissions() {
        $('.permissionChecks:checked').each(function () {
            switch ($(this).val()) {
                case "comment": permissions.commentBool = true; break;
                case "copy": permissions.copyBool = true; break;
                case "download": permissions.downloadBool = true; break;
                case "edit": permissions.editBool = true; break;
                case "fillForms": permissions.fillFormsBool = true; break;
                case "modifyContentControl": permissions.modifyContentControlBool = true; break;
                case "modifyFilter": permissions.modifyFilterBool = true; break;
                case "print": permissions.printBool = true; break;
                case "review": permissions.reviewBool = true; break;
                default: break;
            }
        })
    }

    function GetCustomization() {
        $('.customizationChecks:checked').each(function () {
            switch ($(this).val()) {
                case "autosave": customization.autosave = true; break;
                case "chat": customization.chat = true; break;
                case "commentAuthorOnly": customization.commentAuthorOnly = true; break;
                case "comments": customization.comments = true; break;
                case "compactHeader": customization.compactHeader = true; break;
                case "compactToolbar": customization.compactToolbar = true; break;
                case "compatibleFeatures": customization.compatibleFeatures = true; break;
                case "macros": customization.macros = true; break;
                case "plugins": customization.plugins = true; break;
                case "help": customization.help = true; break;
                default: break;
            }
        });        
        GetMacroMode();
        GetUnit();
    }

    $("#showCodeButton").click(function () {
        $("#CopyDiv").toggle();
        let text = $("#codeText");
        if (text.html() == "") {
            if (key == "") {
                key = Math.random().toString(36).slice(-8);
            }            
            GetTitle();
            EditorUserName();
            GetPermissions();
            GetCustomization();
            if (secret != "") {
                GenerateToken();
            }
            text.html('docEditor = new DocsAPI.DocEditor("placeholder", <br>'
                + '{<br>'
                + '&nbsp&nbsp "document":<br>'
                + '&nbsp&nbsp {<br>'
                + `&nbsp&nbsp&nbsp&nbsp "fileType": ${selectedOption},<br>`
                + `&nbsp&nbsp&nbsp&nbsp "key": ${key},<br>`
                + `&nbsp&nbsp&nbsp&nbsp "title": ${title}.${selectedOption},<br>`
                + `&nbsp&nbsp&nbsp&nbsp "url": ${storage_demo_url}demo.${selectedOption},<br>`
                + `&nbsp&nbsp&nbsp&nbsp "permissions":&nbsp{<br>`
            )
            if (permissions.copyBool == false) {
                text.html(text.html() + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "copy": ${permissions.copyBool},<br>`);
            }
            if (permissions.downloadBool == false) {
                text.html(text.html() + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "download": ${permissions.downloadBool},<br>`);
            }
            if (permissions.printBool == false) {
                text.html(text.html() + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "print": ${permissions.printBool},<br>`
                );
            }
            text.html(text.html() + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "edit": ${permissions.editBool},<br>`);            
            if (selectedOption == "xlsx") {
                if (permissions.modifyFilterBool == false) {
                    text.html(text.html() + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "modifyFilter": ${permissions.modifyFilterBool},<br>`);
                }
            }
            if (selectedOption == "docx") {
                if (permissions.modifyContentControlBool == false) {
                    text.html(text.html() + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "modifyContentControl": ${permissions.modifyContentControlBool},<br>`);
                }
                text.html(text.html()                    
                    + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "comment": ${permissions.commentBool},<br>`
                    + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "fillForms": ${permissions.fillFormsBool},<br>`
                    + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "review": ${permissions.reviewBool},<br>`
                );
            }
            text.html(text.html()
                + `&nbsp&nbsp&nbsp&nbsp }<br>`

                + '&nbsp&nbsp },<br>'
                + '&nbsp&nbsp "editorConfig":&nbsp{<br>'

                + `&nbsp&nbsp&nbsp&nbsp "user":&nbsp{<br>`

                + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "name": ${userName}<br>`

                + `&nbsp&nbsp&nbsp&nbsp },<br>`
                + `&nbsp&nbsp&nbsp&nbsp "customization":&nbsp{<br>`
            );
            if (customization.autosave == false) {
                text.html(text.html() + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "autosave": ${customization.autosave},<br>`);
            }
            if (customization.chat == false) {
                text.html(text.html() + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "chat": ${customization.chat},<br>`);
            }
            if (customization.commentAuthorOnly == true) {
                text.html(text.html() + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "commentAuthorOnly": ${customization.commentAuthorOnly},<br>`);
            }
            if (customization.comments == false) {
                text.html(text.html() + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "comments": ${customization.comments},<br>`);
            }
            if (customization.compactHeader == true) {
                text.html(text.html() + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "compactHeader": ${customization.compactHeader},<br>`);
            }
            if (customization.compactToolbar == true) {
                text.html(text.html() + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "compactToolbar": ${customization.compactToolbar},<br>`);
            }
            if (customization.compatibleFeatures == true) {
                text.html(text.html() + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "compatibleFeatures": ${customization.compatibleFeatures},<br>`);
            }
            if (customization.macros == false) {
                text.html(text.html() + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "macros": ${customization.macros},<br>`);
            }
            if (customization.plugins == false) {
                text.html(text.html() + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "plugins": ${customization.plugins},<br>`);
            }
            if (customization.help == false) {
                text.html(text.html() + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "help": ${customization.help},<br>`);
            }
            if (macroMode != "original") {
                text.html(text.html() + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "macrosMode": ${macroMode},<br>`);
            }
            if (unit != "cm") {
                text.html(text.html() + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "unit": ${unit},<br>`);
            }
            text.html(text.html()
                + `&nbsp&nbsp&nbsp&nbsp }<br>`

                + '&nbsp&nbsp },<br>'
                + `&nbsp&nbsp "documentType": ${documentType},<br>`
                + '&nbsp&nbsp "height": "1200px",<br>'
                + '&nbsp&nbsp "width": "1000px",<br>'
            );
            if (secret != "") {
                text.html(text.html() + `&nbsp&nbsp "token": ${sJWT}<br>`);
            }
            text.html(text.html()
                + '}<br>'
                + ');<br>'
            );
        }
        else {
            text.html("");
        }
    })  // hide and show users config

    function GenerateToken() {
        var oHeader = { alg: 'HS256', typ: 'JWT' };
        var sHeader = JSON.stringify(oHeader);
        var oPayLoad = {};
        oPayLoad.document = {
            fileType: selectedOption,
            key: key,
            title: title + "." + selectedOption,
            url: storage_demo_url + "demo." + selectedOption,
            permissions: {
                comment: permissions.commentBool,
                copy: permissions.copyBool,
                download: permissions.downloadBool,
                edit: permissions.editBool,
                fillForms: permissions.fillFormsBool,
                modifyContentControl: permissions.modifyContentControlBool,
                modifyFilter: permissions.modifyFilterBool,
                print: permissions.printBool,
                review: permissions.reviewBool
            }
        };
        oPayLoad.editorConfig = {
            user: { name: userName },
            customization: {
                autosave: customization.autosave,
                chat: customization.chat,
                commentAuthorOnly: customization.commentAuthorOnly,
                comments: customization.comments,
                compactHeader: customization.compactHeader,
                compactToolbar: customization.compactToolbar,
                compatibleFeatures: customization.compatibleFeatures,
                macros: customization.macros,
                plugins: customization.plugins,
                help: customization.help,
                macrosMode: macroMode,
                unit: unit
            }
        };
        oPayLoad.documentType = documentType;
        oPayLoad.height = "1200px";
        oPayLoad.width = "1000px";
        var sPayload = JSON.stringify(oPayLoad);
        sJWT = KJUR.jws.JWS.sign("HS256", sHeader, sPayload, { utf8: secret });
        console.log(sJWT);
    }

    function CreateEditor() {
        if (key == "") {
            key = Math.random().toString(36).slice(-8);
        }        
        if (secret != "" && sJWT == "") {
            GenerateToken();
        }        
        window.docEditor = new DocsAPI.DocEditor("placeholder",
            {
                "document":
                {
                    "fileType": selectedOption,
                    "key": "" + key,
                    "title": title + "." + selectedOption,
                    "url": storage_demo_url + "demo." + selectedOption,
                    "permissions": {
                        "comment": permissions.commentBool,
                        "copy": permissions.copyBool,
                        "download": permissions.downloadBool,
                        "edit": permissions.editBool,
                        "fillForms": permissions.fillFormsBool,
                        "modifyContentControl": permissions.modifyContentControlBool,
                        "modifyFilter": permissions.modifyFilterBool,
                        "print": permissions.printBool,
                        "review": permissions.reviewBool
                    }
                },
                "editorConfig": {
                    "user": {
                        "name": userName
                    },
                    "customization": {
                        "autosave": customization.autosave,
                        "chat": customization.chat,
                        "commentAuthorOnly": customization.commentAuthorOnly,
                        "comments": customization.comments,
                        "compactHeader": customization.compactHeader,
                        "compactToolbar": customization.compactToolbar,
                        "compatibleFeatures": customization.compatibleFeatures,
                        "macros": customization.macros,
                        "plugins": customization.plugins,
                        "help": customization.help,
                        "macrosMode": macroMode,
                        "unit": unit
                    }
                },
                "documentType": documentType,
                "height": "1200px",
                "width": "1000px",
                "token": sJWT
            }
        );
    }

    function SetDefaultValues() {
        $("#codeText").html("");
        $("#xlsxHiddenPerm").hide();
        $("#documentHiddenPerm").show();
        $("#chooseAndCreateDocument").selectedIndex = 0;
        $("#macroChoose").selectedIndex = 0;
        $("#unitChoose").selectedIndex = 0;
        $('#inputUserName').val("");
        $('#inputDocTitle').val("");
        $('.permissionChecks:checked').each(function () {
            $(this).prop("checked", false);
        });
        permissions.commentBool = permissions.copyBool = permissions.downloadBool = permissions.editBool = permissions.fillFormsBool = permissions.modifyContentControlBool = permissions.modifyFilterBool = permissions.printBool = permissions.reviewBool = false;
        $('.customizationChecks:checked').each(function () {
            $(this).prop("checked", false);
        });
        customization.autosave = customization.chat = customization.commentAuthorOnly = customization.comments = customization.compactHeader = customization.compactToolbar = customization.compatibleFeatures = customization.macros = customization.plugins = customization.help = false;
        macroMode = "original";
        $("#macrosModeList").hide();
        unit = "cm";
        $("#unitList").hide();
        $("#customizationConfig").hide();
        $("#permissionConfig").hide();
        key = "";
        sJWT = "";
    }  // after creating editor reset all values in form

    $("#createEditorButton").click(function () {
        if (window.docEditor) {
            docEditor.destroyEditor();
            SetDefaultValues();
        }
        GetTitle();
        EditorUserName();
        GetPermissions();
        GetCustomization();
        CreateEditor();
    })  // create editor with users config
});