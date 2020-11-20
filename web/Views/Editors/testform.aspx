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
        <span class="hdr">Test Form</span>
    </h1>
    
    <select name="create" class="button button-upper" id="Open">
        <option selected="selected" disabled >Create</option>
        <option value="docx">docx</option>
        <option value="xlsx">xlsx</option>
        <option value="pptx">pptx</option>
    </select>
    
    <hr color="white"/>
    <label>Document title</label>
    <input  type="text" class="input1" id="in1" />

    <label>User name</label>
    <input type="text" class="input2" id="in2" />

    <div id="placeholder"></div>

</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="ScriptPlaceholder" runat="server">

    <script id="scriptApi" type="text/javascript" src="<%= ConfigurationManager.AppSettings["editor_url"] ?? "" %>/web-apps/apps/api/documents/api.js"></script>



    <% var ext = Request["type"] == "spreadsheet" ? "xlsx" : Request["type"] == "presentation" ? "pptx" : "docx"; %>
    <script type="text/javascript">
        document.getElementById("Open").onchange = function () {
            if (!document.getElementById("placeholder"))
                docEditor.destroyEditor();
            var a = document.getElementById("Open");
            var b = a.options[a.selectedIndex].text;
            switch (b) {
                case "docx": var type1 = "text"; break;
                case "xlsx": var type1 = "spreadsheet"; break;
                case "pptx": var type1 = "presentation"; break;
            }
            if (document.getElementById('in1').value == "") {
                var title = "default";
            }
            else {
                title = document.getElementById('in1').value;
            }
            var name = document.getElementById('in2').value;
            var key = Math.random().toString(36).slice(-8);
            window.docEditor = new DocsAPI.DocEditor("placeholder",
                {
                    "document":
                    {
                        "fileType": b,
                        "key": "" + key,
                        "title": title + "." + b,
                        "url": "https:\/\/d2nlctn12v279m.cloudfront.net\/assets\/docs\/samples\/demo." + b
                    },
                    "editorConfig":
                    {
                        "user": { "name": name }
                    },
                    "documentType": type1,
                    "height": "1200px",
                    "width": "1000px"
                }
            );
            document.getElementById("Open").selectedIndex = 0;
            document.getElementById('in2').value = "";
            document.getElementById('in1').value = "";
        }
    </script>


</asp:Content>
