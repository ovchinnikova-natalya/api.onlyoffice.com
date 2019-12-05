<%@ Import Namespace="ASC.Api.Web.Help.DocumentGenerator" %>
<%@ Page
    Title=""
    Language="C#"
    MasterPageFile="~/Views/Shared/Site.Master"
    Inherits="System.Web.Mvc.ViewPage"
    ContentType="text/html" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    List of all ONLYOFFICE Document Builder classes and methods
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h1>
        <span class="hdr">List of all ONLYOFFICE Document Builder classes and methods</span>
    </h1>

    <h2 id="Integration"><a href="<%= Url.Action("integrationapi/cdocbuilder") %>">Integration API</a></h2>
    <h5 class="builder_page_class">
        <a href="<%= Url.Action("integrationapi/cdocbuilder") %>">CDocBuilder</a>
    </h5>
    <table class="table table-classlist">
                <thead>
                    <tr class="tablerow">
                        <td class="table-classlist-name">Name</td>
                        <td>Description</td>
                    </tr>
                </thead>
                <tbody>
                    <tr class="tablerow">
                        <td><a href="<%= Url.Action("integrationapi/cdocbuilder/closefile") %>">CloseFile</a></td>
                        <td>Close the file to stop working with it. You can use a single <b>ONLYOFFICE Document Builder</b> instance to work with all your files, but you need to close the previous file before you can start working with the next one in this case.</td>
                    </tr>
                    <tr class="tablerow">
                        <td><a href="<%= Url.Action("integrationapi/cdocbuilder/createfile") %>">CreateFile</a></td>
                        <td>Create a new file. The type of the file which will be created needs to be set.</td>
                    </tr>
                    <tr class="tablerow">
                        <td><a href="<%= Url.Action("integrationapi/cdocbuilder/dispose") %>">Dispose</a></td>
                        <td>Unloading the <b>ONLYOFFICE Document Builder</b> from the application memory when it is no longer needed.</td>
                    </tr>
                    <tr class="tablerow">
                        <td><a href="<%= Url.Action("integrationapi/cdocbuilder/executecommand") %>">ExecuteCommand</a></td>
                        <td>
                            Execute the command which will be used to create the document file (text document, spreadsheet, PDF, etc.).
                            See the <a href="<%= Url.Action("textdocumentapi") %>">Text document API</a> and <a href="<%= Url.Action("spreadsheetapi") %>">Spreadsheet API</a> sections for more information which commands are available for various document types.
                        </td>
                    </tr>
                    <tr class="tablerow">
                        <td><a href="<%= Url.Action("integrationapi/cdocbuilder/initialize") %>">Initialize</a></td>
                        <td>Initializing the <b>ONLYOFFICE Document Builder</b> as a library for the application to be able to work with it.</td>
                    </tr>
                    <tr class="tablerow">
                        <td><a href="<%= Url.Action("integrationapi/cdocbuilder/openfile") %>">OpenFile</a></td>
                        <td>Open the document file which will be edited and saved afterwards.</td>
                    </tr>
                    <tr class="tablerow">
                        <td><a href="<%= Url.Action("integrationapi/cdocbuilder/run") %>">Run</a></td>
                        <td>Run <b>ONLYOFFICE Document Builder</b> executable. If you do not want to write a C++ application, you can simply use the <b>docbuilder.exe</b> executable file and run it with the <b>.docbuilder</b> file as an argument, where all the code for the document file creation will be written. For C++ the path to the executable file from the <em>sPath</em> parameter must be used, the <em>CDocBuilder</em> object created and the <em>Run</em> method is called.</td>
                    </tr>
                    <tr class="tablerow">
                        <td><a href="<%= Url.Action("integrationapi/cdocbuilder/runtexta") %>">RunTextA</a></td>
                        <td>Run the all the commands for the document creation using a single command. Compared to <a href="<%= Url.Action("integrationapi/cdocbuilder/executecommand") %>">CDocBuilder.ExecuteCommand</a> where only one command at a time is allowed, <em>CDocBuilder.RunTextA</em> makes it possible to enter all the commands for the document creation at once.</td>
                    </tr>
                    <tr class="tablerow">
                        <td><a href="<%= Url.Action("integrationapi/cdocbuilder/runtextw") %>">RunTextW</a></td>
                        <td>Run the all the commands for the document creation using a single command. Compared to <a href="<%= Url.Action("integrationapi/cdocbuilder/executecommand") %>">CDocBuilder.ExecuteCommand</a> where only one command at a time is allowed, <em>CDocBuilder.RunTextW</em> makes it possible to enter all the commands for the document creation at once.</td>
                    </tr>
                    <tr class="tablerow">
                        <td><a href="<%= Url.Action("integrationapi/cdocbuilder/savefile") %>">SaveFile</a></td>
                        <td>Save the file after all the changes are made. The type of the file which will be saved needs to be set.</td>
                    </tr>
                    <tr class="tablerow">
                        <td><a href="<%= Url.Action("integrationapi/cdocbuilder/setproperty") %>">SetProperty</a></td>
                        <td>The argument which can be trasferred to the program outside the <a href="<%= Url.Action("integrationapi/cdocbuilder/executecommand") %>">CDocBuilder.ExecuteCommand</a> method.</td>
                    </tr>
                    <tr class="tablerow">
                        <td><a href="<%= Url.Action("integrationapi/cdocbuilder/setpropertyw") %>">SetPropertyW</a></td>
                        <td>The argument which can be trasferred to the program outside the <a href="<%= Url.Action("integrationapi/cdocbuilder/executecommand") %>">CDocBuilder.ExecuteCommand</a> method.</td>
                    </tr>
                    <tr class="tablerow">
                        <td><a href="<%= Url.Action("integrationapi/cdocbuilder/settmpfolder") %>">SetTmpFolder</a></td>
                        <td>The path to the folder where the program will temporarily save files needed for the program correct work. After the successful document file creation all the files will be deleted from the folder. If no temporary folder is set, the system one will be used.</td>
                    </tr>
                </tbody>
            </table>

    <h2 id="TextDocuments"><a href="<%= Url.Action("textdocumentapi") %>">Text documents API</a></h2>
    <% var word = DocBuilderDocumentation.JsDocParser.GetModule("word"); %>
    <% foreach (var section in word.Values) { %>
        <h5 class="builder_page_class">
            <a href="<%= Url.Action(string.Format("{0}/{1}", section.Path, section.Name)) %>"><%= section.Name %></a>
        </h5>
        <table class="table table-classlist">
            <thead>
                <tr class="tablerow">
                    <td class="table-classlist-name">Name</td>
                    <td>Description</td>
                </tr>
            </thead>
            <tbody>
                <% foreach (var method in section.Methods.Values) { %>
                    <tr class="tablerow">
                        <td><a href="<%= Url.Action(string.Format("{0}/{1}/{2}", section.Path, section.Name, method.Name)) %>"><%= method.Name %></a></td>    
                        <td><%= method.Description %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>

    <h2 id="SpreadsheetDocuments"><a href="<%= Url.Action("spreadsheetapi") %>">Spreadsheet API</a></h2>
    <% var cell = DocBuilderDocumentation.JsDocParser.GetModule("cell"); %>
    <% foreach (var section in cell.Values) { %>
        <h5 class="builder_page_class">
            <a href="<%= Url.Action(string.Format("{0}/{1}", section.Path, section.Name)) %>"><%= section.Name %></a>
        </h5>
        <table class="table table-classlist">
            <thead>
                <tr class="tablerow">
                    <td class="table-classlist-name">Name</td>
                    <td>Description</td>
                </tr>
            </thead>
            <tbody>
                <% foreach (var method in section.Methods.Values) { %>
                    <tr class="tablerow">
                        <td><a href="<%= Url.Action(string.Format("{0}/{1}/{2}", section.Path, section.Name, method.Name)) %>"><%= method.Name %></a></td>    
                        <td><%= method.Description %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>

    <h2 id="PresentationDocuments"><a href="<%= Url.Action("presentationapi") %>">Presentation API</a></h2>
    <% var slide = DocBuilderDocumentation.JsDocParser.GetModule("slide"); %>
    <% foreach (var section in slide.Values) { %>
        <h5 class="builder_page_class">
            <a href="<%= Url.Action(string.Format("{0}/{1}", section.Path, section.Name)) %>"><%= section.Name %></a>
        </h5>
        <table class="table table-classlist">
            <thead>
                <tr class="tablerow">
                    <td class="table-classlist-name">Name</td>
                    <td>Description</td>
                </tr>
            </thead>
            <tbody>
                <% foreach (var method in section.Methods.Values) { %>
                    <tr class="tablerow">
                        <td><a href="<%= Url.Action(string.Format("{0}/{1}/{2}", section.Path, section.Name, method.Name)) %>"><%= method.Name %></a></td>    
                        <td><%= method.Description %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>

    <h5 class="builder_page_class"><a href="<%= Url.Action("global") %>">Global</a></h5>

</asp:Content>
