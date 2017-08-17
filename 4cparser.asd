;;;; 4cparser.asd

(asdf:defsystem #:4cparser
  :description "Describe 4cparser here"
  :author "Your Name <your.name@example.com>"
  :license "Specify license here"
  :depends-on (#:cl-async
               #:drakma
               #:cl-ppcre)
  :serial t
  :components ((:file "package")
               (:file "4cparser")))

