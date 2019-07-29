(defsystem "program-launcher"
  :version "0.1.0"
  :author "Akihide Nano"
  :license ""
  :depends-on ("ltk")
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description ""
  :in-order-to ((test-op (test-op "program-launcher/tests"))))

(defsystem "program-launcher/tests"
  :author "Akihide Nano"
  :license ""
  :depends-on ("program-launcher"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for program-launcher"
  :perform (test-op (op c) (symbol-call :rove :run c)))
