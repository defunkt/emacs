(add-hook 'python-mode-hook
          (lambda ()
            (define-key python-mode-map "\C-m" 'newline-and-indent)
             (add-hook 'local-write-file-hooks
                        '(lambda()
                           (save-excursion
                             (untabify (point-min) (point-max))
                             (delete-trailing-whitespace))))
             (set (make-local-variable 'tab-width) 4)
             (set (make-local-variable 'indent-tabs-mode) 'nil)))
