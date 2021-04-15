<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>

<h1>
    <a class="up" href="<%= Url.Action("installation/") %>"></a>
    <span class="hdr">Adding plugins to ONLYOFFICE Desktop Editors</span>
</h1>
<p>There are two ways to add plugins: through the plugin manager and through the plugin folder.</p>

    <h2>Adding plugins through the plugin manager</h2>

    <p><b>Step 1.</b> Pack all the <a href="<%= Url.Action("structure") %>">plugin files</a> into a <b>zip</b> archive and change the archive extension to <em>.plugin</em>.</p>
    <note>If you download a plugin from <a href="https://github.com/ONLYOFFICE/sdkjs-plugins" target="_blank">GitHub</a>, 
        unpack the plugin folder first and then archive its elements only.</note>

    <p><b>Step 2.</b> Click the <b>Settings</b> button on the <b>Plugins</b> tab.</p>
    <img alt="Plugin settings" src="<%= Url.Content("~/content/img/plugins/plugin_settings.png") %>" />

    <p><b>Step 3.</b> In the plugin <b>Settings</b> window, click the <b>Add plugin</b> button to load your created archive:</p>
    <img alt="Adding plugin" src="<%= Url.Content("~/content/img/plugins/adding_plugins.png") %>" />

    <p>The plugin will be added to the opened editors and all the editors you will open afterwords and displayed within the <b>Plugins</b> tab.</p>
    <img alt="Plugins tab" src="<%= Url.Content("~/content/img/plugins/plugins_tab.png") %>" />


    <h2>Adding plugins through the plugin folder</h2>
    <p><b>Step 1.</b> Create a new folder in the <em>sdkjs-plugins</em> directory. The path to the folder depends on the operating system you use:</p>
    <ul style="list-style: none;">
        <li>For Linux - <em>/opt/onlyoffice/desktopeditors/editors/sdkjs-plugins/</em></li>
        <li>For Windows - <em>%ProgramFiles%\ONLYOFFICE\DesktopEditors\sdkjs-plugins\</em></li>
    </ul>

    <p><b>Step 2.</b> Use a plugin <b>GUID</b> as the folder name. You can find the plugin GUID in the <em>config.json</em> file.</p>
    <p>For example, for the <b>Extended comments</b> plugin the <em>guid</em> parameter will look the following way:</p>
    <pre>
{
    "name" : "Extended comments",
    "guid" : "asc.{91EAC419-EF8B-440C-A960-B451C7DF3A37}",
    ...
}
</pre>
    <p>So, the folder name of this plugin will be <em>{91EAC419-EF8B-440C-A960-B451C7DF3A37}</em>.</p>
    
    <p><b>Step 3.</b> Put all the plugin files to this folder:</p>
    <img alt="Plugin folder" src="<%= Url.Content("~/content/img/plugins/plugins_folder.png") %>" />
    
    <p><b>Step 4.</b> Start <a href="<%= Url.Action("basic", "desktop") %>">ONLYOFFICE Desktop Editors</a>. If everything is done correctly, the plugin will be displayed within the <b>Plugins</b> tab:</p>
    <img alt="Extended comments" src="<%= Url.Content("~/content/img/plugins/extended_comments.png") %>" />


    <h2>Removing plugins from ONLYOFFICE Desktop Editors</h2>

    <p>To uninstall the newly added plugins, proceed in the following way:</p>
    <ol>
        <li>Open the <b>Plugins</b> tab.</li>
        <li>Go to the plugin <b>Settings</b>.</li>
        <li>Click the <img alt="Remove plugin button" src="<%= Url.Content("~/content/img/plugins/remove-plugin-button.png") %>" /> <b>Remove</b> button near the corresponding plugin.</li>
    </ol>
    <note>This option is not available for the default plugins and the plugins added via the plugin folder.</note>

    <p>If you need to uninstall the default plugins, go to the <em>sdkjs-plugins</em> folder and remove the corresponding plugin folder from this directory.</p>
    <p>The table below contains default plugins guids to make it easier for you to find them:</p>
            
    <h2>Default plugins guid&#8217;s</h2>
    <table class="try-now-table">
        <tbody>
            <tr>
                <td>Highlight code</td>
                <td>{BE5CBF95-C0AD-4842-B157-AC40FEDD9841}</td>
            </tr>
            <tr>
                <td>Mendeley</td>
                <td>{BE5CBF95-C0AD-4842-B157-AC40FEDD9441}</td>
            </tr>
            <tr>
                <td>OCR</td>
                <td>{440EBF13-9B19-4BD8-8621-05200E58140B}</td>
            </tr>
            <tr>
                <td>Photo editor</td>
                <td>{07FD8DFA-DFE0-4089-AL24-0730933CC80A}</td>
            </tr>
            <tr>
                <td>Speech</td>
                <td>{D71C2EF0-F15B-47C7-80E9-86D671F9C595}</td>
            </tr>
            <tr>
                <td>Thesaurus</td>
                <td>{BE5CBF95-C0AD-4842-B157-AC40FEDD9840}</td>
            </tr>
            <tr>
                <td>Translator</td>
                <td>{7327FC95-16DA-41D9-9AF2-0E7F449F6800}</td>
            </tr>
            <tr>
                <td>YouTube</td>
                <td>{38E022EA-AD92-45FC-B22B-49DF39746DB4}</td>
            </tr>
            <tr>
                <td>Zotero</td>
                <td>{BFC5D5C6-89DE-4168-9565-ABD8D1E48711}</td>
            </tr>
            <tr>
                <td>Send</td>
                <td>{B509123E-6335-40BD-B965-91EB799346E3}</td>
            </tr>
        </tbody>
    </table>
    <note>Please note that after app updating the default plugins will appear again and you will need to uninstall them.</note>
    