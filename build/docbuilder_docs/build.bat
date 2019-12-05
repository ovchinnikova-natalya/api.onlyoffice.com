@echo off

REM variables
set sdkjsPath=sdkjs
set outPath=jsdoc
set branch=master
set cloneRepo=N
set parseDocs=Y

if %cloneRepo% NEQ Y goto skipClone
    REM clear folder
    rd %sdkjsPath% /S /Q
    md %sdkjsPath%

    git clone -b %branch% https://github.com/ONLYOFFICE/sdkjs.git %sdkjsPath%
:skipClone

if %parseDocs% NEQ Y goto skipParse
    REM clear tmp & out folder
    rd tmp /S /Q
    md tmp
    rd out /S /Q
    md out
    rd %outPath% /S /Q
    md %outPath%

    REM copy files
    copy %sdkjsPath%\word\apiBuilder.js tmp\word.js
    copy %sdkjsPath%\cell\apiBuilder.js tmp\cell.js
    copy %sdkjsPath%\slide\apiBuilder.js tmp\slide.js
    copy %sdkjsPath%\word\api_plugins.js tmp\word_plugins.js

    REM download dependencies
    call npm install

    echo deleting anonymous functions
    node reformat_script.js

    echo generating docs
    node node_modules\jsdoc\jsdoc.js tmp\word.js  -t . -c .\conf.json
    move out %outPath%\word
    md out
    node node_modules\jsdoc\jsdoc.js tmp\cell.js  -t . -c .\conf.json
    move out %outPath%\cell
    md out
    node node_modules\jsdoc\jsdoc.js tmp\slide.js  -t . -c .\conf.json
    move out %outPath%\slide
    md out
    node node_modules\jsdoc\jsdoc.js tmp\word_plugins.js  -t . -c .\conf.json
    move out %outPath%\plugins_word
    md out
:skipParse