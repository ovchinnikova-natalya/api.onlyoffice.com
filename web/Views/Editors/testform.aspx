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
        <input id="macro" type="checkbox" class="customizationChecks" value="macros">macros<br>
        <div id="macrosModeList" hidden="hidden">
            <br />
            <label>Choose macros mode:</label>
            <br />
            <input type="checkbox" class="macrosModeChecks" value="original">original<br>
            <input type="checkbox" class="macrosModeChecks" value="warn">warn<br>
            <input type="checkbox" class="macrosModeChecks" value="disable">disable<br>
            <input type="checkbox" class="macrosModeChecks" value="enable">enable<br>
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

    <div id="placeholder"></div>

</asp:Content>





