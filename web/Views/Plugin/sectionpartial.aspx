<%@ Import Namespace="ASC.Api.Web.Help.DocumentGenerator" %>
<%@ Page
    Title=""
    Language="C#"
    MasterPageFile="~/Views/Shared/Site.Master"
    Inherits="System.Web.Mvc.ViewPage"
    ContentType="text/html" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%= ((DBEntry)Model).Name %>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% var section = (DBEntry)Model; %>

    <h1>
       <span class="hdr"><%= section.Name %></span>
    </h1>

    <h4 class="header-gray" id="<%= section.Name %>">new <%= section.Name %>(<%= section.Params != null ? string.Join(", ", section.Params.Select(p => p.Name)) : "" %>)</h4> 

    <span id="dscr" class="dscr">
        <%= section.Description %>
    </span>

    <% if (section.Params != null && section.Params.Any()) { %>
    <h2>Parameters:</h2>
    <table class="table table-classlist">
        <thead>
            <tr class="tablerow">
                <td class="table-classlist-name">Name</td>
                <td>Type</td>
                <td>Description</td>
            </tr>
        </thead>
        <tbody>
            <% foreach(var p in section.Params) { %>
                <tr class="tablerow">
                    <td><em><%= p.Name %>></em></td>
                    <td><%= DocBuilderDocumentation.JsDocParser.ParamTypeToHtml(p) %></td>
                    <td><%= p.Description %></td>
                </tr>
            <% } %>
        </tbody>
    </table>
    <% } %>

    <h2>Methods</h2>
    <table class="table table-classlist">
        <thead>
            <tr class="tablerow">
                <td class="table-classlist-name">Name</td>
                <td>Description</td>
            </tr>
        </thead>
        <tbody>
            <% foreach (var method in section.Methods) { %>
                <tr class="tablerow">
                    <td><a href="<%= Url.Action(string.Format("{0}/{1}/{2}", section.Path, section.Name.ToLower(), method.Key.ToLower())) %>"><%= method.Key %></a></td>
                    <td><%= method.Value.Description %></td>
                </tr>
            <% } %>
        </tbody>
    </table>

    <% if (section.Example != null) { %>
        <% if (!string.IsNullOrEmpty(section.Example.Script)) { %>
                <h2>Example</h2>
                <div class="button copy-code">Copy code</div>
<pre><%= section.Example.Script %></pre>
        <% } %>

        <% if (!string.IsNullOrEmpty(section.Example.DemoUrl)) { %>
            <h2>Resulting document</h2>
            <iframe class="docbuilder_resulting_docs" src="<%= section.Example.DemoUrl %>" frameborder="0" scrolling="no" allowtransparency></iframe>
        <% } %>
    <% } %>

</asp:Content>
