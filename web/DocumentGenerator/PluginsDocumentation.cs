using ASC.Common.Logging;
using System.Collections.Generic;

namespace ASC.Api.Web.Help.DocumentGenerator
{
    public static class PluginsDocumentation
    {
        public static JsDocParser JsDocParser { get; private set; }

        static PluginsDocumentation()
        {
            JsDocParser = new JsDocParser(new List<string> { "plugins_word" }, LogManager.GetLogger("ASC.PluginsDocs"),
                new Dictionary<string, string>
                {
                    { "plugins_word", "plugins" }
                },
                new Dictionary<string, string>
                {
                    { "CDE", "plugins_word" },
                },
                "plugin"
            );
        }
    }
}