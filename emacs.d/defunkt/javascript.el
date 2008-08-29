; js2
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(custom-set-variables '(js2-strict-missing-semi-warning nil))


; js-shell
(custom-set-variables '(javascript-shell-command "johnson"))
(autoload 'javascript-shell "javascript-mode" nil t)
