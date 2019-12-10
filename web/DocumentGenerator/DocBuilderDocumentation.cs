using ASC.Common.Logging;
using System.Collections.Generic;

namespace ASC.Api.Web.Help.DocumentGenerator
{
    public static class DocBuilderDocumentation
    {
        public static JsDocParser JsDocParser { get; private set; }

        static DocBuilderDocumentation()
        {
            JsDocParser = new JsDocParser(new List<string> { "word", "cell", "slide" }, LogManager.GetLogger("ASC.PluginsDocs"),
                new Dictionary<string, string>
                {
                    { "word", "textdocumentapi" },
                    { "cell", "spreadsheetapi" },
                    { "slide", "presentationapi" }
                },
                new Dictionary<string, string>
                {
                    { "CDE", "word" },
                    { "CPE", "slide" },
                    { "CSE", "cell" }
                },
                "docbuilder"
            );
        }
    }
}