(add-hook 'sgml-mode-hook
          (lambda ()
            (define-key sgml-mode-map "\C-m" 'reindent-then-newline-and-indent)))
