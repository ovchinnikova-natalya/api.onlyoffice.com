<%@ Import Namespace="ASC.Api.Web.Help.DocumentGenerator" %>
<%@ Page
    Title=""
    Language="C#"
    MasterPageFile="~/Views/Shared/Site.Master"
    Inherits="System.Web.Mvc.ViewPage"
    ContentType="text/html" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    <%= ((DBMethod)Model).Name %>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% var method = (DBMethod)Model; %>

    <h1>
        <a href="<%= Request.Path.Substring(0, Request.Path.LastIndexOf('/')) %>" class="up"></a>
       <span class="hdr"><%= method.Name %></span>
    </h1>            

    <h4 class="header-gray" id="<%= method.Name %>">
        <%= method.Name %>(<%= method.Params != null ? string.Join(", ", method.Params.Select(p => p.Optional ? string.Format("[{0}]", p.Name) : p.Name)) : "" %>)
        <% if (method.Returns != null && method.Returns.Any())
           { %>
            &rarr; { <%= DocBuilderDocumentation.JsDocParser.ReturnTypeToHtml(method) %> }
        <% } %>
    </h4>

    <% if (method.See != null) { %>
        <div class="details">
            <span><%= method.See %></span>
        </div>
    <% } %>

    <% if (method.Inherits != null) { %>
        <div class="details">
            <span><%= method.Inherits %></span>
        </div>
    <% } %>

    <span id="dscr" class="dscr">
        <%= method.Description %>
    </span>

    <% if (method.Params != null && method.Params.Any()) { %>
    <% var hasOptional = method.Params.Any(m => m.Optional); %>
    <h2>Parameters:</h2>
    <table class="table">
        <thead>
            <tr class="tablerow">
                <td>Name</td>
                <td>Type</td>
                <% if (hasOptional) { %>
                    <td>Default</td>
                <% } %>
                <td>Description</td>
            </tr>
        </thead>
        <tbody>
            <% foreach(var p in method.Params) { %>
                <tr class="tablerow">
                    <td><em><%= p.Name %></em></td>
                    <td>
                        <em><%= DocBuilderDocumentation.JsDocParser.ParamTypeToHtml(p) %></em>
                    </td>
                    <% if (hasOptional) { %>
                        <td><%= p.DefaultValue == null ? (p.Optional ? "null" : "") : p.DefaultValue %></td>
                    <% } %>
                    <td><%= p.Description %></td>
                </tr>
            <% } %>
        </tbody>
    </table>
    <% } %>

    <% if (method.Returns != null && method.Returns.Any()) { %>
    <h2>Returns:</h2>
    <dl class="param-type">
        <dt>Type</dt>
        <dd>
            <%= DocBuilderDocumentation.JsDocParser.ReturnTypeToHtml(method) %>
        </dd>
    </dl>
    <% } %>

    <% if (method.Example != null) { %>
        <% if (!string.IsNullOrEmpty(method.Example.Script)) { %>
                <h2>Example</h2>
                <div class="button copy-code">Copy code</div>
<pre><%= method.Example.Script %></pre>
        <% } %>

        <% if (!string.IsNullOrEmpty(method.Example.DemoUrl)) { %>
            <h2>Resulting document</h2>
            <iframe class="docbuilder_resulting_docs" src="<%= method.Example.DemoUrl %>" frameborder="0" scrolling="no" allowtransparency></iframe>
        <% } %>
    <% } %>

</asp:Content>
