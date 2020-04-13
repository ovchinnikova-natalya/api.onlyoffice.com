# How it works

The work with document files in ONLYOFFICE Document Server is quite a simple process but it requires some understanding of what is going on when you click your document link to [open](https://api.onlyoffice.com/editors/open) it in the browser, or [save](https://api.onlyoffice.com/editors/save) the document or [upload](https://api.onlyoffice.com/editors/conversion) it from your computer to the document server.

The user-document interaction is done both at the client side and at the server side.

Below the main notions used throughout the current documentation are explained.

The client side includes:

* **Document storage service** - the server service which stores all the documents available to the users with the appropriate access rights. It provides the document IDs and links to these documents to the **document manager** which the user sees in the browser.

* **Document editing service** - the server service which allows to perform the document viewing and editing (in case the user has the appropriate rights to do that). The **document editor** interface is used to access all the **document editing service** features.

* **Document command service** - the server service which allows to perfom additional commands with **document editing service**.

* **Document conversion service** - the server service which allows to convert the document file into the appropriate Office Open XML format (*docx* for text documents, *xlsx* for spreadsheets and *pptx* for presentations) for their editing or downloading.

* **Document builder service** - the server service which allows to build a document easily without the need to actually run a document processing editor.

Please note, that ONLYOFFICE Document Server includes the **document editor**, **document editing service**, **document command service**, **document conversion service** and **document builder service**. The **document manager** and **document storage service** are either included to Community Server or must be implemented by the software integrators who use ONLYOFFICE Document Server on their own server.