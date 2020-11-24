$(function () {
    var title = "default"; // editors title
    var selectDoc; // select in html for  (docx , xlxs , pptx)
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
    }   // hide and show macros mode list

    document.getElementById("unit").onclick = function () {
        if (document.getElementById("unitList").hidden == "") {
            document.getElementById("unitList").hidden = "hidden";
        }
        else {
            document.getElementById("unitList").hidden = "";
        }
    }   // hide and show unit list

    document.getElementById("chooseAndCreateDocument").onchange = function () {
        let tmp1 = document.getElementById("documentHiddenPerm");
        let tmp2 = document.getElementById("xlsxHiddenPerm");
        selectDoc = document.getElementById("chooseAndCreateDocument");
        selectedOption = selectDoc.options[selectDoc.selectedIndex].text;
        switch (selectedOption) {
            case "xlsx": documentType = "spreadsheet"; tmp2.hidden = ""; tmp1.hidden = "hidden"; break;
            case "pptx": documentType = "presentation"; tmp1.hidden = tmp2.hidden = "hidden"; break;
            default: tmp1.hidden = ""; tmp2 = "hidden"; break;
        }
    } //hide and show some special advanced parametres

    function GetTitle() {
        if (document.getElementById('inputDocTitle').value != "") {
            title = document.getElementById('inputDocTitle').value;
        }
    }

    function EditorUserName() {
        userName = document.getElementById('inputUserName').value;
    }

    function GetMacroMode() {
        if (document.getElementById("macro").checked == true) {
            let tmpMacro = document.getElementById("macroChoose");
            switch (tmpMacro.options[tmpMacro.selectedIndex].text) {
                case "enable": macroMode = "enable"; break;
                case "warn": macroMode = "warn"; break;
                case "disable": macroMode = "disable"; break;
                case "original": break;
            }
        }
    }

    function GetUnit() {
        if (document.getElementById("unit").checked == true) {
            let tmpUnit = document.getElementById("unitChoose");
            switch (tmpUnit.options[tmpUnit.selectedIndex].text) {
                case "pt": unit = "pt"; break;
                case "inch": unit = "inch"; break;
                case "cm": break;
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
        GetUnit();
    }

    document.getElementById("showCodeButton").onclick = function () {
        let text = document.getElementById("codeText");
        if (text.innerHTML == "") {
            text.innerHTML = 'docEditor = new DocsAPI.DocEditor("placeholder", <br>';
            text.innerHTML = text.innerHTML + '{<br>';
            text.innerHTML = text.innerHTML + "    ";
            text.innerHTML = text.innerHTML + '&nbsp&nbsp "document":<br>';
            text.innerHTML = text.innerHTML + '&nbsp&nbsp {<br>';

            text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp "fileType": ${selectedOption},<br>`;
            text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp "key": ${key},<br>`;
            text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp "title": ${title}.${selectedOption},<br>`;
            text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp "url": ${storage_demo_url}demo.${selectedOption},<br>`;
            text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp "permissions":&nbsp{<br>`;

            text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "copy": ${permissions.copyBool},<br>`;
            text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "download": ${permissions.downloadBool},<br>`;
            text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "edit": ${permissions.editBool},<br>`;
            text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "print": ${permissions.printBool},<br>`;
            if (selectedOption == "xlsx") {
                text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "modifyFilter": ${permissions.modifyFilterBool},<br>`;
            }
            if (selectedOption == "docx") {
                text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "modifyContentControl": ${permissions.modifyContentControlBool},<br>`;
                text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "comment": ${permissions.commentBool},<br>`;
                text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "fillForms": ${permissions.fillFormsBool},<br>`;
                text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "review": ${permissions.reviewBool},<br>`;
            }

            text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp }<br>`;

            text.innerHTML = text.innerHTML + '&nbsp&nbsp },<br>';
            text.innerHTML = text.innerHTML + '&nbsp&nbsp "editorConfig":&nbsp{<br>';

            text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp "user":&nbsp{<br>`;

            text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "name": ${userName}<br>`;

            text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp },<br>`;
            text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp "customization":&nbsp{<br>`;

            text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "autosave": ${customization.autosave},<br>`;
            text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "chat": ${customization.chat},<br>`;
            text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "commentAuthorOnly": ${customization.commentAuthorOnly},<br>`;
            text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "comments": ${customization.comments},<br>`;
            text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "compactHeader": ${customization.compactHeader},<br>`;
            text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "compactToolbar": ${customization.compactToolbar},<br>`;
            text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "compatibleFeatures": ${customization.compatibleFeatures},<br>`;
            text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "macros": ${customization.macros},<br>`;
            text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "plugins": ${customization.plugins},<br>`;
            text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "help": ${customization.help},<br>`;
            text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "macrosMode": ${macroMode},<br>`;
            text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp "unit": ${unit},<br>`;

            text.innerHTML = text.innerHTML + `&nbsp&nbsp&nbsp&nbsp }<br>`;

            text.innerHTML = text.innerHTML + '&nbsp&nbsp },<br>';
            text.innerHTML = text.innerHTML + `&nbsp&nbsp "documentType": ${documentType},<br>`;
            text.innerHTML = text.innerHTML + '&nbsp&nbsp "height": "1200px",<br>';
            text.innerHTML = text.innerHTML + '&nbsp&nbsp "width": "1000px",<br>';
            text.innerHTML = text.innerHTML + `&nbsp&nbsp "token": ${sJWT}<br>`;

            text.innerHTML = text.innerHTML + '}<br>';

            text.innerHTML = text.innerHTML + ');<br>';
        }
        else {
            text.innerHTML = "";
        }
    }

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
        key = Math.random().toString(36).slice(-8);
        GenerateToken();
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
        document.getElementById("codeText").innerHTML = "";
        document.getElementById("xlsxHiddenPerm").hidden = "hidden";
        document.getElementById("documentHiddenPerm").hidden = "";
        document.getElementById("chooseAndCreateDocument").selectedIndex = 0;
        document.getElementById("macroChoose").selectedIndex = 0;
        document.getElementById("unitChoose").selectedIndex = 0;
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
        macroMode = "original";
        document.getElementById("macrosModeList").hidden = "hidden";
        macroMode = "original";
        document.getElementById("unitList").hidden = "hidden";
    }  // after creating editor reset all values in form

    document.getElementById("createEditorButton").onclick = function () {
        if (window.docEditor) {
            docEditor.destroyEditor();
            SetDefaultValues();
        }

        GetTitle();
        EditorUserName();
        GetPermissions();
        GetCustomization();

        CreateEditor();
    }  // create editor with users config
});