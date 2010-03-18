(defun defunkt-coffee-mode-hook ()
  "defunkt's hacks and experiments for `coffee-mode.el'."

  ;; Compile .js on every save.
  (add-hook 'before-save-hook 'coffee-compile-file)

  ;; I like debug mode, sometimes.
  (setq coffee-debug-mode nil))

(add-hook 'coffee-mode-hook (lambda () (defunkt-coffee-mode-hook)))