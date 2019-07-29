(defpackage program-launcher
  (:use :cl
	:ltk))
(in-package :program-launcher)

(defun bind-form (init-list)
  (mapcar #'(lambda (lst)
	      (list
	       (intern (car lst))
	       `(make-instance 'button :text ,(car lst))))
	  init-list))

(defun setf-form (init-list)
  (mapcar #'(lambda (lst)
	      `(setf (command ,(intern (car lst)))
		     (lambda () (uiop:run-program ,(cadr lst) :ignore-error-status t))))
	  init-list))

(defun pack-form (init-list)
  (mapcar #'(lambda (lst)
	      `(pack ,(intern (car lst)) :fill :x))
	  init-list))

(defun csv-line (line)
  (read-from-string
   (concatenate 'string
		"("
		(substitute #\/ #\\
			    (substitute #\space #\, line))
		")")))

(defun read-from-initfile (file)
  (with-open-file (fp file :direction :input)
    (loop for line = (read-line fp nil)
       while line
       collect (csv-line line))))

(defmacro make-ltk (file-path)
  (let ((init-list (read-from-initfile file-path)))
    `(with-ltk ()
       (wm-title *tk* "Program Launcher")
       (bind *tk* "<Alt-q>" (lambda (event)
			      (declare (ignoreble event))
			      (setf *exit-mainloop* t)))
       (let (,@(bind-form init-list) ; dynamic
	     (exit-button (make-instance 'button :text "EXIT")))
	 ,@(setf-form init-list) ; dynamic
	 (setf (command exit-button) (lambda () (setf *exit-mainloop* t)))
	 ,@(pack-form init-list) ; dynamic
	 (pack exit-button :fill :x)))))

;; blah blah blah.
