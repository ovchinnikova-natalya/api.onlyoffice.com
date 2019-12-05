/*
 *
 * (c) Copyright Ascensio System Limited 2010-2017
 *
 * This program is freeware. You can redistribute it and/or modify it under the terms of the GNU 
 * General Public License (GPL) version 3 as published by the Free Software Foundation (https://www.gnu.org/copyleft/gpl.html). 
 * In accordance with Section 7(a) of the GNU GPL its Section 15 shall be amended to the effect that 
 * Ascensio System SIA expressly excludes the warranty of non-infringement of any third-party rights.
 *
 * THIS PROGRAM IS DISTRIBUTED WITHOUT ANY WARRANTY; WITHOUT EVEN THE IMPLIED WARRANTY OF MERCHANTABILITY OR
 * FITNESS FOR A PARTICULAR PURPOSE. For more details, see GNU GPL at https://www.gnu.org/copyleft/gpl.html
 *
 * You can contact Ascensio System SIA by email at sales@onlyoffice.com
 *
 * The interactive user interfaces in modified source and object code versions of ONLYOFFICE must display 
 * Appropriate Legal Notices, as required under Section 5 of the GNU GPL version 3.
 *
 * Pursuant to Section 7 § 3(b) of the GNU GPL you must retain the original ONLYOFFICE logo which contains 
 * relevant author attributions when distributing the software. If the display of the logo in its graphic 
 * form is not reasonably feasible for technical reasons, you must include the words "Powered by ONLYOFFICE" 
 * in every copy of the program you distribute. 
 * Pursuant to Section 7 § 3(e) we decline to grant you any rights under trademark law for use of our trademarks.
 *
*/


using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.Mvc;
using ASC.Api.Web.Help.DocumentGenerator;
using ASC.Api.Web.Help.Helpers;
using HtmlAgilityPack;
using log4net;

namespace ASC.Api.Web.Help.Controllers
{
    [Redirect]
    public class DocBuilderController : AsyncController
    {
        #region actions

        private readonly string[] _actionMap = new[]
            {
                "Basic",
                "gettingstarted",
                "csharpexample",
                "nodejsexample",
                "phpexample",
                "rubyexample",
                "integratingdocumentbuilder",
                "integrationapi",
                "integrationapi/usingdocbuilderfile",
                "integrationapi/cdocbuilder",
                "integrationapi/cdocbuilder/closefile",
                "integrationapi/cdocbuilder/createfile",
                "integrationapi/cdocbuilder/dispose",
                "integrationapi/cdocbuilder/executecommand",
                "integrationapi/cdocbuilder/initialize",
                "integrationapi/cdocbuilder/openfile",
                "integrationapi/cdocbuilder/run",
                "integrationapi/cdocbuilder/runtexta",
                "integrationapi/cdocbuilder/runtextw",
                "integrationapi/cdocbuilder/savefile",
                "integrationapi/cdocbuilder/setproperty",
                "integrationapi/cdocbuilder/setpropertyw",
                "integrationapi/cdocbuilder/settmpfolder",
                "integrationapi/globalvariable",
                "integrationapi/arguments",
                "textdocumentapi",
                "spreadsheetapi",
                "presentationapi",
                "global",
                "classlist",
            };

        #endregion

        public ActionResult Navigation()
        {
            return View();
        }

        public ActionResult Search(string query)
        {
            var result = new List<SearchResult>();

            foreach (var action in _actionMap)
            {
                var actionString = action.ToLower();
                var doc = new HtmlDocument();
                try
                {
                    var html = this.RenderView(actionString, new ViewDataDictionary());
                    doc.LoadHtml(html);
                }
                catch (Exception e)
                {
                    LogManager.GetLogger("ASC.Api").Error(e);
                }
                var content = doc.DocumentNode;
                if (content.SelectSingleNode("html") != null)
                {
                    content = content.SelectSingleNode("//div[contains(@class, 'layout-content')]");
                }

                if (!string.IsNullOrEmpty(query) && content != null && content.InnerText.ToLowerInvariant().Contains(query.ToLowerInvariant()))
                {
                    var headerNode = doc.DocumentNode.SelectSingleNode("//span[@class='hdr']");
                    var descrNode = doc.DocumentNode.SelectSingleNode("//p[@class='dscr']");
                    var header = headerNode != null ? headerNode.InnerText : string.Empty;
                    var descr = descrNode != null ? descrNode.InnerText : string.Empty;
                    result.Add(new SearchResult
                        {
                            Module = "docbuilder",
                            Name = actionString,
                            Resource = Highliter.HighliteString(header, query).ToHtmlString(),
                            Description = Highliter.HighliteString(descr, query).ToHtmlString(),
                            Url = Url.Action(actionString, "docbuilder")
                        });
                }
            }

            result.AddRange(DocBuilderDocumentation.JsDocParser.Search(query, Url));

            ViewData["query"] = query ?? string.Empty;
            ViewData["result"] = result;
            return View(new Dictionary<MsDocEntryPoint, Dictionary<MsDocEntryPointMethod, string>>());
        }

        public ActionResult Basic()
        {
            return View();
        }

        public ActionResult Gettingstarted()
        {
            return View();
        }

        public ActionResult Nodejsexample()
        {
            return View();
        }

        public ActionResult Rubyexample()
        {
            return View();
        }

        public ActionResult Phpexample()
        {
            return View();
        }

        public ActionResult Csharpexample()
        {
            return View();
        }

        public ActionResult Integratingdocumentbuilder()
        {
            var directoryInfo = new DirectoryInfo(Request.MapPath("~/app_data/docbuilder"));

            var examples = directoryInfo.GetFiles("*.zip", SearchOption.TopDirectoryOnly).Select(fileInfo => fileInfo.Name).ToList();

            return View(examples);
        }

        public ActionResult Integrationapi(string catchall)
        {
            if (!_actionMap.Contains("integrationapi/" + catchall, StringComparer.OrdinalIgnoreCase))
            {
                catchall = null;
            }
            return View("Integrationapi", (object)catchall);
        }

        public ActionResult Textdocumentapi(string catchall)
        {
            if (string.IsNullOrEmpty(catchall)) return View("Textdocumentapi");
            return FindDoc("word", catchall);
        }

        public ActionResult Spreadsheetapi(string catchall)
        {
            if (string.IsNullOrEmpty(catchall)) return View("Spreadsheetapi");
            return FindDoc("cell", catchall);
        }

        public ActionResult Presentationapi(string catchall)
        {
            if (string.IsNullOrEmpty(catchall)) return View("Presentationapi");
            return FindDoc("slide", catchall);
        }

        public ActionResult Global()
        {
            return View(DocBuilderDocumentation.JsDocParser.GetGlobals());
        }

        public ActionResult Classlist()
        {
            return View();
        }

        public FileResult DownloadScript(string fileId)
        {
            var hash = new Guid(fileId);
            var fileName = string.Format("{0}.docbuilder", hash);
            var builderPath = Path.Combine(Path.GetTempPath(), fileName);

            var bytes = System.IO.File.ReadAllBytes(builderPath);
            return File(bytes, System.Net.Mime.MediaTypeNames.Application.Octet, fileName);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult DocBuilderGenerate(string actionName, string builderScript)
        {
            try
            {
                builderScript = (builderScript ?? "").Trim();
                if (string.IsNullOrEmpty(builderScript))
                    throw new Exception("Empty Script");

                var fileUrl = new DocBuilderHelper(Url, Request).GenerateDocument(builderScript);
                return Redirect(fileUrl);
            }
            catch (Exception ex)
            {
                LogManager.GetLogger("ASC.DocumentBuilder").Error(ex);
                return RedirectToAction(actionName, new { error = ex.Message });
            }
        }

        [HttpPost]
        public ActionResult DocBuilderCreate(string actionName, string name, string company, string title, string format)
        {
            try
            {
                name = (name ?? "").Trim();
                if (string.IsNullOrEmpty(name))
                    name = "John Smith";

                company = (company ?? "").Trim();
                if (string.IsNullOrEmpty(company))
                    company = "ONLYOFFICE";

                title = (title ?? "").Trim();
                if (string.IsNullOrEmpty(title))
                    title = "Commercial director";

                var fileUrl = new DocBuilderHelper(Url, Request).CreateDocument(name, company, title, format);
                return Redirect(fileUrl);
            }
            catch (Exception ex)
            {
                LogManager.GetLogger("ASC.DocumentBuilder").Error(ex);
                return RedirectToAction(actionName, new { error = ex.Message });
            }
        }

        private ActionResult FindDoc(string module, string path)
        {
            var split = path.Split('/');
            var section = split[0];
            var method = split.Length > 1 ? split[1] : null;

            if (string.IsNullOrEmpty(method))
            {
                var sec = DocBuilderDocumentation.JsDocParser.GetSection(module, section);
                if (sec == null) return View("sectionnotfound");
                return View("sectionpartial", sec);
            }
            else
            {
                var met = DocBuilderDocumentation.JsDocParser.GetMethod(module, section, method);
                if (met == null) return View("methodnotfound");
                return View("methodpartial", met);
            }
        }
    }
}