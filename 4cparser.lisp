;;;; 4cparser.lisp

(in-package #:4cparser)

(defun 4c-parse (url)
  (let ((hrefs
         (mapcar (lambda (x)
                   (concatenate 'string "http://" (subseq x 8 (-(length x) 1))))
                 (ppcre:all-matches-as-strings "href=\"//i\.4cdn.org.+?\""
                                               (drakma:http-request url)))))
    (mapcar (lambda (link)
              (with-open-file (stream
                               (concatenate 'string "~/4ch/test5/" (subseq link 22))
                               :direction :output :if-does-not-exist :create
                               :if-exists :supersede :element-type '(unsigned-byte 8))
                (write-sequence (drakma:http-request link) stream)
                (print  (concatenate 'string "~/4ch/" (subseq link 22) "   Pronto"))))
            hrefs)))

(defun 4c-parse-top (url)
  (let* ((tlinks-raw
	  (ppcre:all-matches-as-strings "(?<=href=\")thread/[0-9]+" (drakma:http-request url)))
	 (tlinks  (remove-duplicates
		   (mapcar (lambda (x)
			     (concatenate 'string
					  (subseq url 0 (1+ (search "/" url :from-end t :test #'equal)))
					  x))
			   tlinks-raw)
		   :test #'equal)))
    (loop for item in tlinks do
	 (print item)(bt:make-thread (lambda () (4c-parse item))))))
