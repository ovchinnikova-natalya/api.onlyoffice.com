const path = require("path");
const fs = require("fs");

const reg = /\(function\s?\(window\,\s?builder\)\s*?{([\s\S]*)}/m;

var docs = path.join(__dirname, "tmp");
[ "word.js", "cell.js", "slide.js", "word_plugins.js" ].forEach(m => {
    var file = path.join(docs, m);
    var content = fs.readFileSync(file).toString();
    var matches = content.match(reg);
    if (matches != null) {
        fs.writeFileSync(file, matches[1]);
    }
});