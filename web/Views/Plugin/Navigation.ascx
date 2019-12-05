<%@ Import Namespace="ASC.Api.Web.Help.DocumentGenerator" %>
<%@ Control
    Language="C#"
    Inherits="System.Web.Mvc.ViewUserControl" %>

<div class="treeheader">Get Started</div>
<ul class="side-nav root">
    <li>
        <a href="<%= Url.Action("basic") %>">Introduction</a>
    </li>
</ul>

<div class="treeheader">Documentation</div>
<ul class="side-nav root">
    <li>
        <a href="<%= Url.Action("structure") %>">Plugin structure</a>
        <ul>
            <li>
                <a href="<%= Url.Action("config") %>">config.json</a>
            </li>
            <li>
                <a href="<%= Url.Action("indexhtml") %>">index.html</a>
            </li>
            <li>
                <a href="<%= Url.Action("code") %>">Plugin code</a>
            </li>
            <li>
                <a href="<%= Url.Action("plugin") %>">window.Asc.plugin object</a>
                <ul>
                    <li>
                        <a href="<%= Url.Action("button") %>">button</a>
                    </li>
                    <li>
                        <a href="<%= Url.Action("callcommand") %>">callCommand</a>
                    </li>
                    <li>
                        <a href="<%= Url.Action("executecommand") %>">executeCommand</a>
                    </li>
                    <li>
                        <a href="<%= Url.Action("executemethod") %>">executeMethod</a>
                        <ul>
                            <li>
                                <a href="<%= Url.Action("executemethod/insertandreplacecontentcontrols") %>">InsertAndReplaceContentControls</a>
                            </li>
                            <li>
                                <a href="<%= Url.Action("executemethod/removecontentcontrols") %>">RemoveContentControls</a>
                            </li>
                            <li>
                                <a href="<%= Url.Action("executemethod/getallcontentcontrols") %>">GetAllContentControls</a>
                            </li>
                            <li>
                                <a href="<%= Url.Action("executemethod/addcontentcontrol") %>">AddContentControl</a>
                            </li>
                            <li>
                                <a href="<%= Url.Action("executemethod/removecontentcontrol") %>">RemoveContentControl</a>
                            </li>
                            <li>
                                <a href="<%= Url.Action("executemethod/getcurrentcontentcontrol") %>">GetCurrentContentControl</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="<%= Url.Action("info") %>">info object</a>
                        <ul>
                            <li>
                                <a href="<%= Url.Action("info/data") %>">data</a>
                            </li>
                            <li>
                                <a href="<%= Url.Action("info/editorType") %>">editorType</a>
                            </li>
                            <li>
                                <a href="<%= Url.Action("info/guid") %>">guid</a>
                            </li>
                            <li>
                                <a href="<%= Url.Action("info/height") %>">height</a>
                            </li>
                            <li>
                                <a href="<%= Url.Action("info/imgsrc") %>">imgSrc</a>
                            </li>
                            <li>
                                <a href="<%= Url.Action("info/mmtopx") %>">mmToPx</a>
                            </li>
                            <li>
                                <a href="<%= Url.Action("info/objectId") %>">objectId</a>
                            </li>
                            <li>
                                <a href="<%= Url.Action("info/recalculate") %>">recalculate</a>
                            </li>
                            <li>
                                <a href="<%= Url.Action("info/resize") %>">resize</a>
                            </li>
                            <li>
                                <a href="<%= Url.Action("info/width") %>">width</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="<%= Url.Action("init") %>">init</a>
                    </li>
                    <li>
                        <a href="<%= Url.Action("onExternalMouseUp") %>">onExternalMouseUp</a>
                    </li>
                    <li>
                        <a href="<%= Url.Action("onmethodreturn") %>">onMethodReturn</a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="<%= Url.Action("plugins") %>">Text document Plugins API</a>
                <ul>
                    <% foreach (var entry in PluginsDocumentation.JsDocParser.GetModule("plugins_word")) { %>
                        <li>
                            <a href="<%= Url.Action(string.Format("plugins/{0}", entry.Key.ToLower())) %>"> <%= entry.Key %></a>
                            <ul>
                                <% foreach (var method in entry.Value.Methods) { %>
                                    <li>
                                        <a href="<%= Url.Action(string.Format("plugins/{0}/{1}", entry.Key.ToLower(), method.Key.ToLower())) %>"><%= method.Key %></a>
                                    </li>
                                <% } %>
                            </ul>
                        </li>
                    <% } %>
                </ul>
            </li>
            <li>
                <a href="<%= Url.Action("scope") %>">Asc.scope object</a>
            </li>
        </ul>
    </li>
    <li>
        <a href="<%= Url.Action("installation") %>">Plugin installation</a>
    </li>
    <li>
        <a href="<%= Url.Action("localization") %>">Plugin localization</a>
    </li>
    <li>
        <a href="<%= Url.Action("example") %>">Plugin example</a>
    </li>
</ul>
<div class="treeheader">Macros</div>
<ul class="side-nav root">
    <li>
        <a href="<%= Url.Action("macros") %>">ONLYOFFICE macros</a>
    </li>
    <li>
        <a href="<%= Url.Action("writingmacros") %>">Writing macros</a>
    </li>
    <li>
        <a href="<%= Url.Action("convertingvbamacros") %>">Converting macros</a>
    </li>
    <li>
        <a href="<%= Url.Action("macrosamples") %>">Macro samples</a>
    </li>
</ul>
