;; others
(load "defunkt/dired")
(load "defunkt/ruby")
(load "defunkt/shell")
(load "defunkt/javascript")


; turn off cua-mode because i hate it
(cua-mode nil)

; bash
(setq auto-mode-alist (cons '("\\.bashrc" . sh-mode) auto-mode-alist))


; obj-c
(setq auto-mode-alist (cons '("\\.m" . objc-mode) auto-mode-alist))


; markdown
(add-to-list 'load-path "~/.emacs.d/vendor/markdown-mode")
(autoload 'markdown-mode "markdown-mode.el"
   "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.markdown" . markdown-mode) auto-mode-alist))


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
(ido-mode t)
(setq ido-enable-flex-matching t)