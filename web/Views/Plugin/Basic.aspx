﻿<%@  Page
    Title=""
    Language="C#"
    MasterPageFile="~/Views/Shared/Site.Master"
    Inherits="System.Web.Mvc.ViewPage"
    ContentType="text/html" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Overview
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h1>
        <span class="hdr">Overview</span>
    </h1>

    <p>
        ONLYOFFICE Docs and Desktop Editors offer support for plugins allowing developers to add specific features to the editors that are not directly related to the OOXML format.
    </p>
    <p>
        This documentation describes:
    </p>
    <ul>
        <li>How to <a href="<%= Url.Action("structure") %>">build</a>, <a href="<%= Url.Action("localization") %>">localize</a>, run, test and publish a plugin</li>
        <li>How to <a href="<%= Url.Action("writingmacros") %>">write</a> and run a macro 
            or <a href="<%= Url.Action("convertingvbamacros") %>">convert</a> VBA macros to use in ONLYOFFICE</li>
        <li>How to use ONLYOFFICE methods and events</li>
        <li>Where to find guides and plugin/macro code samples to get started</li>
    </ul>


    <h2>What plugins can do</h2>

    <p>Here are some examples of what you can do with ONLYOFFICE plugins:</p>
    <ul>
        <li>connect third-party services, like Telegram, YouTube, Thesaurus, Translator, Zotero, OCR, etc.;</li>
        <li>add custom components & controls in the UI, like Trackchanges, Trackchanges_off;</li>
        <li>enhance the existing user experience and the editors&#8217; functionality: Autocomplete, Search & Replace, Move cursor, Extended comments;</li>
        <li>automate tasks in documents with Macros.</li>
    </ul>
    <p>Code samples are available at <a href="https://github.com/ONLYOFFICE/sdkjs-plugins" target="_blank">https://github.com/ONLYOFFICE/sdkjs-plugins</a>.</p>
    <p>If you are looking for ready-to-use plugins, please visit <a href="https://www.onlyoffice.com/en/app-directory" target="_blank">ONLYOFFICE App Directory</a>.</p>


    <h2>How to create plugins</h2>

    <p>To create your own plugin, you need to follow a few steps:</p>
    <ol>
        <li>Learn the fundamental concepts for building plugins on the Getting started with plugins page 
            and write code that defines the plugin appearance and behavior.</li>
        <li>After building the plugin, test it thoroughly and make sure the plugin looks and works as you expected. 
            Try to anticipate the problems that might occur and suggest your solutions to them.</li>
        <li>Now you can use the plugin on your own or suggest it for publishing by contacting us at <a href="mailto:marketing@onlyoffice.com" target="_blank">marketing@onlyoffice.com</a>.</li>
    </ol>


    <h2>How to get help</h2>

    <p>If you have any questions about plugins, try to find them in the FAQ section first.</p>
    <p>You can also request a feature or report a bug by posting an issue <a href="https://github.com/ONLYOFFICE/sdkjs-plugins/issues" target="_blank">on GitHub</a>.</p>

</asp:Content>
