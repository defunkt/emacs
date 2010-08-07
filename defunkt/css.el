;; css
(setq css-mode-indent-depth 2)
(add-hook 'css-mode-hook '(lambda ()
                            (define-key css-mode-map "\C-s" 'css-new-section)
                            (define-key css-mode-map [tab] 'defunkt-indent)))

(defun css-insert-section (section)
  "Inserts a kyle-style css section."
  (interactive "sSection: ")
  (insert "/*------------------------------------------------------------------------------\n")
  (insert (concat "  @group " section "\n"))
  (insert "------------------------------------------------------------------------------*/\n")
  (insert "\n")
  (insert "\n")
  (insert "\n")
  (insert "/* @end */")
  (forward-line -2))