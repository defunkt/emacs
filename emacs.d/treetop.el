; from http://github.com/hornbeck/public_emacs

(defvar treetop-mode-hook nil)

(defvar treetop-mode-map
        (let ((treetop-mode-map (make-keymap)))
             (define-key treetop-mode-map "\C-j" 'newline-and-indent)
             treetop-mode-map)
             "Keymap for treetop major mode")

(add-to-list 'auto-mode-alist '("\\.treetop\\'" . treetop-mode))

(defconst treetop-font-lock-keywords
  (list
   '("\\<\\grammar\\|rule\\|def\\|end\\>" . font-lock-builtin-face))
   "Minimal highlighting expressions for treetop mode")

(defvar treetop-mode-syntax-table
  (let ((treetop-mode-syntax-table (make-syntax-table)))
    (modify-syntax-entry ?_ "w" treetop-mode-syntax-table)
    (modify-syntax-entry ?/ ". 124b" treetop-mode-syntax-table)
    (modify-syntax-entry ?* ". 23" treetop-mode-syntax-table)
    (modify-syntax-entry ?\n "> b" treetop-mode-syntax-table)
    treetop-mode-syntax-table)
  "Syntax table for treetop-mode")

(defun treetop-mode ()
  "Major mode for editing treetop files"
  (interactive)
  (kill-all-local-variables)
  (set-syntax-table treetop-mode-syntax-table)
  (use-local-map treetop-mode-map)
  (set (make-local-variable 'font-lock-defaults) '(treetop-font-lock-keywords))
  (set (make-local-variable 'indent-line-function) 'treetop-indent-line)
  (local-set-key "\t" "  ")
  (setq major-mode 'treetop-mode)
  (setq mode-name "treetop")
  (run-hooks 'treetop-mode-hook))

(provide 'treetop)