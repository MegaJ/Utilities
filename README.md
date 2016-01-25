# Utilities

### Prerequisites
Scripts currently run using SBCL.

### Samples
Samples can be found in the tests folder

### html_bookmark_gen

This takes a text file with links, separated by a newline and creates an html document that can be used by the "Import Bookmarks from HTML..." option in Mozilla Firefox Browser. Look at /tests/html_bookmark_gen/ for example input and output.

Needs more polish, and I hope to use string streams instead of concatenation soon. But it works. 
