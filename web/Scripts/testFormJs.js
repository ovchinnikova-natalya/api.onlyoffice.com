$(function () {
    var title = "default"; // editors title
    var selectDoc; // select in html for  (docx , xlxs , pptx)
    var selectedOption; // docx , xlxs , pptx
    var documentType; // text , spreadsheet ,presentation
    var userName; // user name in editor
    var key; // unique editors key
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

    document.getElementById("permissionButton").onclick = function () {
        if (document.getElementById("permissionConfig").hidden == "") {
            document.getElementById("permissionConfig").hidden = "hidden";
        }
        else {
            document.getElementById("permissionConfig").hidden = "";
        }
    }   // hide and show permission list

    document.getElementById("customizationButton").onclick = function () {
        if (document.getElementById("customizationConfig").hidden == "") {
            document.getElementById("customizationConfig").hidden = "hidden";
        }
        else {
            document.getElementById("customizationConfig").hidden = "";
        }
    }   // hide and show customization list

    document.getElementById("macro").onclick = function () {
        if (document.getElementById("macrosModeList").hidden == "") {
            document.getElementById("macrosModeList").hidden = "hidden";
        }
        else {
            document.getElementById("macrosModeList").hidden = "";
        }
    }   // hide and show permission list

    function GetDocType() {
        selectDoc = document.getElementById("chooseAndCreateDocument");
        selectedOption = selectDoc.options[selectDoc.selectedIndex].text;
        switch (selectedOption) {
            case "xlsx": documentType = "spreadsheet"; break;
            case "pptx": documentType = "presentation"; break;
            default: documentType = "text"; break;
        }
    }

    function GetTitle() {
        if (document.getElementById('inputDocTitle').value != "") {
            title = document.getElementById('inputDocTitle').value;
        }
    }

    function EditorUserName() {
        userName = document.getElementById('inputUserName').value;
    }

    function GetMacroMode() {
        if (document.getElementById("marco").checked == true) {
            let tmpMacro = document.getElementsByClassName("macrosModeChecks");
            for (var i = 0; i < tmpMacro.length; i++) {
                if (tmpMacro[i].checked == true) {
                    switch (tmpMacro[i].value) {
                        case "enable": macroMode = "enable"; break;
                        case "warn": macroMode = "warn"; break;
                        case "disable": macroMode = "disable"; break;
                        case "original": break;                           
                    }
                }
            }
        }
    }

    function GetPermissions() {
        let tmp = document.getElementsByClassName("permissionChecks");
        for (var i = 0; i < tmp.length; i++) {
            if (tmp[i].checked == true) {
                switch (tmp[i].value) {
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
            }
        }
    }

    function GetCustomization() {
        let tmp = document.getElementsByClassName("customizationChecks");
        for (var i = 0; i < tmp.length; i++) {
            if (tmp[i].checked == true) {
                switch (tmp[i].value) {
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
            }
        }
        GetMacroMode();
    }

    function CreateEditor() {
        key = Math.random().toString(36).slice(-8);
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
                        "macrosMode": macroMode
                    }
                },
                "documentType": documentType,
                "height": "1200px",
                "width": "1000px"
            }
        );
    }

    function SetDefaultValues() {
        document.getElementById("chooseAndCreateDocument").selectedIndex = 0;
        document.getElementById('inputUserName').value = "";
        document.getElementById('inputDocTitle').value = "";
        document.getElementById("permissionConfig").hidden = "hidden"
        let permChecks = document.getElementsByClassName("permissionChecks");
        for (var i = 0; i < permChecks.length; i++) {
            permChecks[i].checked = false;
        }
        permissions.commentBool = permissions.copyBool = permissions.downloadBool = permissions.editBool = permissions.fillFormsBool = permissions.modifyContentControlBool = permissions.modifyFilterBool = permissions.printBool = permissions.reviewBool = false;
        document.getElementById("customizationConfig").hidden = "hidden"
        let customChecks = document.getElementsByClassName("customizationChecks");
        for (var i = 0; i < customChecks.length; i++) {
            customChecks[i].checked = false;
        }
        customization.autosave = customization.chat = customization.commentAuthorOnly = customization.comments = customization.compactHeader = customization.compactToolbar = customization.compatibleFeatures = customization.macros = customization.plugins = customization.help = false;
        document.getElementById("macrosModeList").hidden = "hidden";
        let macrosModeChecks = document.getElementsByClassName("macrosModeChecks");        
        for (var i = 0; i < macrosModeChecks.length; i++) {
            macrosModeChecks[i].checked = false;
        }
    }  // after creating editor reset all values in form

    document.getElementById("chooseAndCreateDocument").onchange = function () {
        if (window.docEditor) {
            docEditor.destroyEditor();
        }

        GetDocType();
        GetTitle();
        EditorUserName();
        GetPermissions();
        GetCustomization();

        CreateEditor();

        SetDefaultValues();
    }  // create editor with users config
});