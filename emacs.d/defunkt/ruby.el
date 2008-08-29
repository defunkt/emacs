; rinari
(add-to-list 'load-path "~/.emacs.d/vendor/rinari/")
(require 'rinari)
(setq rinari-tags-file-name "TAGS")

; rhtml
(add-to-list 'load-path "~/.emacs.d/vendor/rhtml")
(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook 'rinari-launch)
(setq auto-mode-alist (cons '("\\.html\\.erb" . rhtml-mode) auto-mode-alist))

; ruby
(require 'ruby-hacks)
(setq auto-mode-alist (cons '("Rakefile" . ruby-mode) auto-mode-alist))
(add-hook 'ruby-mode-hook
          (lambda ()
            (add-hook 'local-write-file-hooks
                      '(lambda()
                         (save-excursion
                           (untabify (point-min) (point-max))
                           (delete-trailing-whitespace))))
            (set (make-local-variable 'indent-tabs-mode) 'nil)
            (set (make-local-variable 'tab-width) 2)
            (define-key ruby-mode-map "\C-m" 'newline-and-indent)
            (require 'ruby-electric)
            (ruby-electric-mode t)))

; treetop
(require 'treetop)
