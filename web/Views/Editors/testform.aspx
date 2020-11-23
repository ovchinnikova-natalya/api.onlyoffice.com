<%@ Page
    Title=""
    Language="C#"
    MasterPageFile="~/Views/Shared/Site.Master"
    Inherits="System.Web.Mvc.ViewPage"
    ContentType="text/html" %>

<%@ Import Namespace="System.Web.Optimization" %>


<asp:Content ID="FaqHead" ContentPlaceHolderID="HeadContent" runat="server">
    <script id="scriptApi" type="text/javascript" src="<%= ConfigurationManager.AppSettings["editor_url"] ?? "" %>/web-apps/apps/api/documents/api.js"></script>
    <%= Scripts.Render("~/bundles/test") %>
    <script type="text/javascript">
        var storage_demo_url = '<%= ConfigurationManager.AppSettings["storage_demo_url"]%>';
    </script>
</asp:Content>


<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    New page
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <h1>
        <span class="hdr">Creating an editor</span>
    </h1>

   

    <select id="chooseAndCreateDocument" class="button button-upper" name="create">
        <option selected="selected" disabled>choose doc type</option>
        <option value="docx">docx</option>
        <option value="xlsx">xlsx</option>
        <option value="pptx">pptx</option>
    </select>

    <br />
    <br />


    <button id="permissionButton" class="button button-upper">permissions</button>

    <div id="permissionConfig" hidden="hidden">        
        <input type="checkbox" class="permissionChecks" value="copy">copy<br>
        <input type="checkbox" class="permissionChecks" value="download">download<br>
        <input type="checkbox" class="permissionChecks" value="edit">edit<br>        
        <input type="checkbox" class="permissionChecks" value="print">print<br>
        <div id="documentHiddenPerm" >
            <input type="checkbox" class="permissionChecks" value="comment">comment<br>
            <input type="checkbox" class="permissionChecks" value="modifyContentControl">modifyContentControl<br>
            <input type="checkbox" class="permissionChecks" value="fillForms">fillForms<br>
            <input type="checkbox" class="permissionChecks" value="review">review<br>
        </div>  
        <div id="xlsxHiddenPerm" hidden="hidden">
            <input type="checkbox" class="permissionChecks" value="modifyFilter">modifyFilter<br>
        </div>
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
        <input id="macro" type="checkbox" class="customizationChecks" value="macros">macros<br>
        <div id="macrosModeList" hidden="hidden">            
            <select id="macroChoose" class="button" hidden="hidden">
                <option selected="selected" disabled>Choose macros mode</option>
                <option value="original">original</option>
                <option value="warn">warn</option>
                <option value="disable">disable</option>
                <option value="enable">enable</option>
            </select>
            <br />
            <br />
        </div>
        <input id="unit" type="checkbox" class="customizationChecks" value="unit">unit<br>
        <div id="unitList" hidden="hidden">               
            <select id="unitChoose" class="button"  hidden="hidden">
                <option selected="selected" disabled>choose unit</option>
                <option value="cm">cm</option>
                <option value="pt">pt</option>
                <option value="inch">inch</option>
            </select>
            <br />
            <br />
        </div>
        <input type="checkbox" class="customizationChecks" value="plugins">plugins<br>
        <input type="checkbox" class="customizationChecks" value="help">help<br>
    </div>

    <br />
    <br />

    <label>Document title</label>
    <input id="inputDocTitle" type="text" />

    <label>User name</label>
    <input id="inputUserName" type="text" />

    <button id="createEditorButton" class="button button-upper">Create editor</button>
    <br />
    <br />
    <div id="placeholder"></div>
    <br />
    <br />
    <button id="showCodeButton" class="button button-upper">Show editors config</button>
    <div id="printCode">
        <p id="codeText"></p>
    </div>

</asp:Content>





