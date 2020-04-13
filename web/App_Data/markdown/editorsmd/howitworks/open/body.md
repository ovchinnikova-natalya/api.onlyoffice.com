# Opening file

The reference figure and the steps below explain the process of opening the document in ONLYOFFICE Document Server.

![opening](https://api.onlyoffice.com/content/img/editor/opening.jpg)

1. The user uses the **document manager** (found in his/her browser) to open the document for viewing or editing.

    >The browser **document manager** receives the list of all documents available to the user from the **document storage service**.

2. The document identifier and the link to it at the **document storage service** are sent using the [JavaScript API](https://api.onlyoffice.com/editors/basic) to the **document editor**.

3. The **document editor** forms a request to the ****** for document opening. The document editor uses the document identifier and its link received from the **document manager** (at step 2).

4. The **document editing service**downloads the document file from the **document storage service** using the ID and link provided. At this step the [conversion](https://api.onlyoffice.com/editors/conversion) of the file into Office Open XML format is also performed for the **document editor** better performance and formats compatibility.

5. When ready the **document editing service** transfers the document file to the browser-based **document editor**.

6. The **document editor** displays the document file and/or (in case the appropriate rights are provided) allows its editing.

After the editing is finished, the [document saving](https://api.onlyoffice.com/editors/save) process takes place.

## How this can be done in practice

1. Create an empty *html* file.

2. Add the *div* element as shown below.

    ```html
    <div id="placeholder"></div>
    ```

3. Specify your ONLYOFFICE Document Server link with the JavaScript API that will be used for your website.

    ```html
    <script type="text/javascript" src="https://documentserver/web-apps/apps/api/documents/api.js"></script>
    ```

    Where the **documentserver** is the name of the server with the ONLYOFFICE Document Server installed.

4. Add the script initializing the **Document Editor** for the div element with the configuration for the document you want to open.

    ```php
    new DocsAPI.DocEditor("placeholder", {
        "document": {
            "fileType": "docx",
            "key": "Khirz6zTPdfd7",
            "title": "Example Document Title.docx",
            "url": "https://example.com/url-to-example-document.docx"
        },
        "documentType": "text"
    });
    ```

    Where the **example.com** is the name of the server where **document manager** and **document storage** **service** are installed.

5. Open your *html* file in the browser.