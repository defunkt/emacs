;;;;;;;;;;;;
;  Global  ;
;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/")
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq mac-emulate-three-button-mouse nil)
(setq cua-highlight-region-shift-only t)
(one-buffer-one-frame-mode 0) ; forces everything to open in one window
(tool-bar-mode) ; get rid of the damn toolbar
(prefer-coding-system 'utf-8)

(load ".passwords")

(defun find-dot-emacs ()
  (interactive)
  (find-file "~/.emacs"))
(global-set-key "\C-xp" 'find-dot-emacs)

; set the mode based on the shebang;
; TODO: this sometimes breaks
(defun shebang-to-mode ()
  (interactive)
  (let*
      ((bang (nth 0 (split-string (buffer-string) "\n")))
       (mode (progn
               (string-match "^#!.+[ /]\\(\\w+\\)$" bang)
               (match-string 1 bang)))
       (mode-fn (intern (concat mode "-mode"))))
    (when (functionp mode-fn)
      (funcall mode-fn))))

; (add-hook 'find-file-hook 'shebang-to-mode)

(defun url-fetch-into-buffer (url)
  (interactive "sURL:")
  (insert (concat "\n\n" ";; " url "\n"))
  (insert (url-fetch-to-string url)))

(defun url-fetch-to-string (url)
  (with-current-buffer (url-retrieve-synchronously url)
    (beginning-of-buffer)
    (search-forward-regexp "\n\n")
    (delete-region (point-min) (point))
    (buffer-string)))

;; from http://platypope.org/blog/2007/8/5/a-compendium-of-awesomeness
;; I-search with initial contents
(defvar isearch-initial-string nil)

(defun isearch-set-initial-string ()
  (remove-hook 'isearch-mode-hook 'isearch-set-initial-string)
  (setq isearch-string isearch-initial-string)
  (isearch-search-and-update))

(defun isearch-forward-at-point (&optional regexp-p no-recursive-edit)
  "Interactive search forward for the symbol at point."
  (interactive "P\np")
  (if regexp-p (isearch-forward regexp-p no-recursive-edit)
    (let* ((end (progn (skip-syntax-forward "w_") (point)))
           (begin (progn (skip-syntax-backward "w_") (point))))
      (if (eq begin end)
          (isearch-forward regexp-p no-recursive-edit)
        (setq isearch-initial-string (buffer-substring begin end))
        (add-hook 'isearch-mode-hook 'isearch-set-initial-string)
        (isearch-forward regexp-p no-recursive-edit)))))

; TODO: this doesn't work at all yet
(global-set-key [C-*] 'isearch-forward-at-point)

; .bashrc should open in sh mode
(setq auto-mode-alist (cons '("\\.bashrc" . sh-mode) auto-mode-alist))

; custom keys
(global-set-key [C-tab] 'other-window) ; vimy window switching

; textmate style command+space
(defun insert-blank-line-after-current ()
  (interactive)
  (end-of-line)
  (insert "\n"))
(global-set-key [A-return] 'insert-blank-line-after-current)

(defadvice zap-to-char (after my-zap-to-char-advice (arg char) activate)
  "Kill up to the ARG'th occurence of CHAR, and leave CHAR.
  The CHAR is replaced and the point is put before CHAR."
  (insert char)
  (forward-char -1))

(defun my-new-frame-with-new-scratch ()
  (interactive)
  (let ((one-buffer-one-frame t))
    (new-frame-with-new-scratch)))
(defun my-close-current-window-asktosave ()
  (interactive)
  (let ((one-buffer-one-frame t))
    (close-current-window-asktosave)))

(define-key osx-key-mode-map (kbd "A-n") 'my-new-frame-with-new-scratch)
(define-key osx-key-mode-map (kbd "A-w") 'my-close-current-window-asktosave)

;;;;;;;;;;;;
;   Modes  ;
;;;;;;;;;;;;

; colors
(require 'color-theme)
(color-theme-initialize)
(setq color-theme-is-global t)
(load-file "~/.emacs.d/twilight-emacs/color-theme-twilight.el")
(color-theme-twilight)
; how to get the font you want:
;   M-x mac-font-panel
;   pick your font
;   M-x describe-font
(setq default-frame-alist '((font . "-apple-inconsolata-medium-r-normal--16-160-72-72-m-160-iso10646-1")))

; rinari
(add-to-list 'load-path "~/.emacs.d/rinari/")
(require 'rinari)
(setq rinari-tags-file-name "TAGS")

; rhtml
(add-to-list 'load-path "~/.emacs.d/rhtml")
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

; mode-compile
(autoload 'mode-compile "mode-compile"
   "Command to compile current buffer file based on the major mode" t)
(global-set-key "\C-cc" 'mode-compile)

(autoload 'mode-compile-kill "mode-compile"
 "Command to kill a compilation launched by `mode-compile'" t)
(global-set-key "\C-ck" 'mode-compile-kill)

; treetop
(require 'treetop)

; markdown
(add-to-list 'load-path "~/.emacs.d/markdown-mode")
(autoload 'markdown-mode "markdown-mode.el"
   "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.markdown" . markdown-mode) auto-mode-alist))

; cheat
(add-to-list 'load-path "~/.emacs.d/cheat.el")
(require 'cheat)

; paredit
(autoload 'paredit-mode "paredit"
     "Minor mode for pseudo-structurally editing Lisp code."
     t)
(add-hook 'emacs-lisp-mode-hook (lambda () (paredit-mode +1)))

; git
(add-to-list 'load-path "~/.emacs.d/magit")
(require 'magit)
(global-set-key "\C-x\C-g" 'magit-status)

; gist
(add-to-list 'load-path "~/.emacs.d/gist.el")
(require 'gist)

; js2
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

; js-shell
(custom-set-variables '(javascript-shell-command "johnson"))
(autoload 'javascript-shell "javascript-mode" nil t)

; growl
(require 'growl)

; Dired
(require 'dired)

; remap 'o' in dired mode to open a file
(defun dired-open-mac ()
  (interactive)
  (let ((file-name (dired-get-file-for-visit)))
    (if (file-exists-p file-name)
        (call-process "/usr/bin/open" nil 0 nil file-name))))
(define-key dired-mode-map "o" 'dired-open-mac)

; - is `cd ..` (like vim)
(define-key dired-mode-map "-" 'dired-up-directory)

; prefer dired over dumping dir list to buffer
(global-set-key "\C-x\C-d" 'dired)

; emacs shell
(global-set-key "\C-x\C-z" 'shell) ; shortcut for shell

(eval-after-load 'shell
  '(progn
     (define-key shell-mode-map "\C-p" 'comint-previous-input)
     (define-key shell-mode-map "\C-n" 'comint-next-input)))

; ido
(ido-mode t)
(setq ido-enable-flex-matching t)

; twitter
(require 'twittering-mode)
(defun twittering-friends-refresh ()
  (interactive)
  (twittering-mode)
  (twittering-friends-timeline))
(global-set-key "\C-x\C-t" 'twittering-friends-refresh)