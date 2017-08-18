;;;; 4cparser.asd

(asdf:defsystem #:4cparser
  :depends-on (#:cl-async
               #:drakma
               #:cl-ppcre)
  :serial t
  :components ((:file "package")
               (:file "4cparser")))

