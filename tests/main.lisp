(defpackage program-launcher/tests/main
  (:use :cl
        :program-launcher
        :rove))
(in-package :program-launcher/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :program-launcher)' in your Lisp.

(defvar *init-list* '(("a" "run-program-a") ("b" "run-parogram-b")))

(deftest internal-functions-tests
    (testing "should (pathnamep *init-file*) to be true"
      (ok (pathnamep program-launcher::*init-file*)))

    (testing "bind-form test"
      (expands (program-launcher::bind-form *init-list*)
	       '((|a| (make-instance 'ltk:button :text "a"))
		 (|b| (make-instance 'ltk:button :text "b")))))
    
    (testing "setf-form test"
      (expands (program-launcher::setf-form *init-list*)
	       '((setf (ltk:command |a|)
		  (lambda () (uiop/run-program:run-program "run-program" :ignore-error-status t)))
		 (setf (ltk:command |b|)
		  (lambda () (uiop/run-program:run-program "run-program" :ignore-error-status t))))))
    
    (testing "pack-form test"
      (expands (program-launcher::pack-form *init-list*)
	       '((ltk:pack |a| :fill :x) (ltk:pack |a| :fill :x))))

    (testing "csv-line"
      (ok (equal (program-launcher::csv-line "a,b,c")
		 '(a b c)))))

