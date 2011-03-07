;; css

(add-hook 'css-mode-hook
          (lambda ()
            (setq css-mode-indent-depth 2)
            (make-local-variable 'indent-line-function)
            (setq indent-line-function 'css-indent)
            (define-key css-mode-map "\C-ct" 'css-insert-section)
            (define-key css-mode-map [tab] 'defunkt-indent)))

(defun css-indent ()
  (interactive)
  (insert "  "))

(defun css-insert-section (section)
  "Inserts a kyle-style css section."
  (interactive "sSection: ")
  (insert "/*--------------------------------------------------------------------\n")
  (insert (concat "  @group " section "\n"))
  (insert "--------------------------------------------------------------------*/\n")
  (insert "\n")
  (insert "\n")
  (insert "\n")
  (insert "/* @end */")
  (forward-line -2))