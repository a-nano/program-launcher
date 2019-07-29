(defpackage program-launcher/tests/main
  (:use :cl
        :program-launcher
        :rove))
(in-package :program-launcher/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :program-launcher)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
