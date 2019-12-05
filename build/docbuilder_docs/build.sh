#!/usr/bin/env

# variables
sdkjsPath=sdkjs
outPath=jsdoc
branch=master
cloneRepo=true
parseDocs=true

if $cloneRepo
then
    # clear folder
    rm -rf $sdkjsPath

    git clone -b $branch https://github.com/ONLYOFFICE/sdkjs.git $sdkjsPath
fi

if $parseDocs
then
    # clear tmp & out folder
    rm -rf tmp
    rm -rf out
    rm -rf $outPath
    mkdir tmp
    mkdir out
    mkdir $outPath

    # copy files
    cp $sdkjsPath/word/apiBuilder.js tmp/word.js
    cp $sdkjsPath/cell/apiBuilder.js tmp/cell.js
    cp $sdkjsPath/slide/apiBuilder.js tmp/slide.js
    cp $sdkjsPath/word/api_plugins.js tmp/word_plugins.js

    # download dependencies
    npm install

    echo deleting anonymous functions
    node reformat_script.js

    echo generating docs
    node node_modules/jsdoc/jsdoc.js tmp/word.js  -t . -c ./conf.json
    mv out $outPath/word/
    mkdir out
    node node_modules/jsdoc/jsdoc.js tmp/cell.js  -t . -c ./conf.json
    mv out $outPath/cell/
    mkdir out
    node node_modules/jsdoc/jsdoc.js tmp/slide.js  -t . -c ./conf.json
    mv out $outPath/slide/
    mkdir out
    node node_modules/jsdoc/jsdoc.js tmp/word_plugins.js  -t . -c ./conf.json
    mv out $outPath/plugins_word/
    mkdir out
fi