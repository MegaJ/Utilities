#!/usr/local/bin/sbcl --script
;;; format of arguments: filename, output name

;; example call:
;; ./html_bookmark_gen.lisp ~/bookmarks.txt ./landed

;; progress so far:
;; can read in the text file
;; can list all links / put them into a data structure
;; need to be able to name the output textfile
;; need to write things out to a text file
;; signal an error if there is a file with that name already
;; will restoring bookmarks overwrite existing ones? NOPE just adds a new bkmk

;; to do
;; make sure this isn't an HTML parsing task--it's not!
;; format my output !biggest task
;; clean up code, document it

(format t "hi ~%")
;; first arg is always the location of the sbcl process
(format t "~s~%" (second *posix-argv*))
(format t "~s~%" (third *posix-argv*))

(defparameter *in* (second *posix-argv*))
(defparameter *out* (third *posix-argv*))
(defparameter *list-of-links* '())

(defun spit-out (line)
  (format t "~a~%" line))

(defun add-tags (a-link)
  ;; format goal, (it's one line):
  ;; <DT><A HREF="https://www.reddit.com/r/EatCheapAndHealthy" ADD_DATE="1451909662" LAST_MODIFIED="1451909662">https://www.reddit.com/r/EatCheapAndHealthy</A>
  (add-<dt> (add-<a> a-link)))

(defun add-<A> (a-link &key href add-date last-modified icon-uri)
  (concatenate 'string "<A HREF=" a-link ">" a-link "</A>"))

(add-<a> "https://www.reddit.com/r/EatCheapAndHealthy")

(defun add-<DT> (a-string)
  (concatenate 'string "<DT>" a-string))

(add-<dt> (add-<a> "https://www.reddit.com/r/EatCheapAndHealthy"))

(defun add-new-line (a-string)
  (concatenate 'string a-string "
"))

;; function is not used nor necessary
(defun wrap-<DL> (a-string)
  (concatenate 'string "<DL>
" a-string "
</DL>"))

(wrap-<dl>
 (add-<dt> (add-<a> "https://www.reddit.com/r/EatCheapAndHealthy")))

(defun create-header ()
  (format nil "<!DOCTYPE NETSCAPE-Bookmark-file-1>
<!-- This is an automatically generated file
     using a common lisp utility program.
     It will be read and overwritten.
     DO NOT EDIT! -->
<META HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=UTF-8\">"))

(create-header)

(let ((in (open *in* :if-does-not-exist nil)))
  (when in
    (loop for line = (read-line in nil)
         while line do (push line *list-of-links*))
    (close in)))

(print *list-of-links*)

;; creating output stream uses open too
(let ((out (open *out* :direction :output :if-exists nil)))
  (if out
      (progn
	(write-line (create-header) out)
	(loop for link in *list-of-links*
	      do (write-line (add-tags link) out))
	(close out))
    (format t "~%Error! Output filename already exists~%")))




;; tag legend
;; <HR> is for horizontal bar
;; <DL> is directory list, NEEDS closing </DL>
;; <p> always follows <DL>
;; <DT> defines a tab/row item that you can select
;; <DD> only one case of this : <DD>Add bookmarks to this folder to see them displayed on the Bookmarks Toolbar
