;; others
(load "defunkt/dired")
(load "defunkt/ruby")
(load "defunkt/shell")
(load "defunkt/javascript")
(load "defunkt/erlang")
(load "defunkt/python")
(load "defunkt/sgml")
(load "defunkt/erc")
(load "defunkt/artist")

;; all modes
(add-hook 'before-save-hook 'delete-trailing-whitespace)

; bash
(setq auto-mode-alist (cons '("\\.bashrc" . sh-mode) auto-mode-alist))

; obj-c
(setq auto-mode-alist (cons '("\\.m" . objc-mode) auto-mode-alist))
;; (setq c-default-style "bsd" c-basic-offset 2)

; magit
(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "green3")
     (set-face-foreground 'magit-diff-del "red3")))

; markdown
(add-to-list 'load-path "~/.emacs.d/vendor/markdown-mode")
(autoload 'markdown-mode "markdown-mode.el"
   "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.markdown" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.ron" . markdown-mode) auto-mode-alist))
(add-hook 'markdown-mode-hook '(lambda ()
                                 (define-key markdown-mode-map (kbd "A-r") 'markdown-preview)
                                 (define-key markdown-mode-map (kbd "<tab>") 'defunkt-indent)))


; paredit
(autoload 'paredit-mode "paredit"
     "Minor mode for pseudo-structurally editing Lisp code."
     t)
(add-hook 'emacs-lisp-mode-hook (lambda () (paredit-mode +1)))

; jasper
(setq auto-mode-alist (cons '("\\.jr" . emacs-lisp-mode) auto-mode-alist))

; mode-compile
(autoload 'mode-compile "mode-compile"
   "Command to compile current buffer file based on the major mode" t)
(global-set-key "\C-cc" 'mode-compile)

(autoload 'mode-compile-kill "mode-compile"
 "Command to kill a compilation launched by `mode-compile'" t)
(global-set-key "\C-ck" 'mode-compile-kill)

; ido
;(ido-mode t)
;(setq ido-enable-flex-matching t)

; css
(setq css-mode-indent-depth 2)
(add-hook 'css-mode-hook '(lambda ()
                            (define-key css-mode-map [tab] 'defunkt-indent)))


; yaml
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-hook 'yaml-mode-hook
    '(lambda ()
       (define-key yaml-mode-map "\C-m" 'newline-and-indent)))


; c
(add-hook 'c-mode-hook
          '(lambda ()
             (setq c-auto-newline t)
             (define-key c-mode-map "{" 'defunkt/c-electric-brace)))

; mustache
(add-to-list 'auto-mode-alist '("\\.mustache$" . tpl-mode))
(add-hook 'tpl-mode-hook '(lambda () (font-lock-mode 1)))

(setq show-trailing-whitespace (not buffer-read-only))