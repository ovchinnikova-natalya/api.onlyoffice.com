<%@ Page
    Title=""
    Language="C#"
    MasterPageFile="~/Views/Shared/Site.Master"
    Inherits="System.Web.Mvc.ViewPage"
    ContentType="text/html" %>


<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    New page
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <h1>
        <span class="hdr">Creating an editor</span>
    </h1>

    <select id="chooseAndCreateDocument" class="button button-upper" name="create">
        <option selected="selected" disabled>Create</option>
        <option value="docx">docx</option>
        <option value="xlsx">xlsx</option>
        <option value="pptx">pptx</option>
    </select>

    <br />
    <br />





    <button id="permissionButton" class="button button-upper">permissions</button>

    <div id="permissionConfig" hidden="hidden">
        <input type="checkbox" class="permissionChecks" value="comment">comment<br>
        <input type="checkbox" class="permissionChecks" value="copy">copy<br>
        <input type="checkbox" class="permissionChecks" value="download">download<br>
        <input type="checkbox" class="permissionChecks" value="edit">edit<br>
        <input type="checkbox" class="permissionChecks" value="fillForms">fillForms<br>
        <input type="checkbox" class="permissionChecks" value="modifyContentControl">modifyContentControl<br>
        <input type="checkbox" class="permissionChecks" value="modifyFilter">modifyFilter<br>
        <input type="checkbox" class="permissionChecks" value="print">print<br>
        <input type="checkbox" class="permissionChecks" value="review">review<br>
    </div>


    <br />
    <br />

    <button id="customizationButton" class="button button-upper">customization</button>

    <div id="customizationConfig" hidden="hidden">
        <input type="checkbox" class="customizationChecks" value="autosave">autosave<br>
        <input type="checkbox" class="customizationChecks" value="chat">chat<br>
        <input type="checkbox" class="customizationChecks" value="commentAuthorOnly">commentAuthorOnly<br>
        <input type="checkbox" class="customizationChecks" value="comments">comments<br>
        <input type="checkbox" class="customizationChecks" value="compactHeader">compactHeader<br>
        <input type="checkbox" class="customizationChecks" value="compactToolbar">compactToolbar<br>
        <input type="checkbox" class="customizationChecks" value="compatibleFeatures">compatibleFeatures<br>
        <input type="checkbox" class="customizationChecks" value="macros">macros<br>
        <input type="checkbox" class="customizationChecks" value="plugins">plugins<br>
    </div>

    <br />
    <br />

    <label>Document title</label>
    <input id="inputDocTitle" type="text" class="input1" />

    <label>User name</label>
    <input id="inputUserName" type="text" class="input2" />

    <div id="placeholder"></div>

</asp:Content>




<asp:Content ID="Content3" ContentPlaceHolderID="ScriptPlaceholder" runat="server">

    <script id="scriptApi" type="text/javascript" src="<%= ConfigurationManager.AppSettings["editor_url"] ?? "" %>/web-apps/apps/api/documents/api.js"></script>

    <script type="text/javascript">

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
        } // users customization in editor

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
                        default: break;
                    }
                }
            }
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
                        "url": "<%= ConfigurationManager.AppSettings["storage_demo_url"] ?? "" %>" + "demo." + selectedOption,
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
                                "plugins": customization.plugins
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
            customization.autosave = customization.chat = customization.commentAuthorOnly = customization.comments = customization.compactHeader = customization.compactToolbar = customization.compatibleFeatures = customization.macros = customization.plugins =false;            
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
    </script>

</asp:Content>



