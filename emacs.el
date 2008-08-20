; global
(add-to-list 'load-path "~/.emacs.d/")
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq mac-emulate-three-button-mouse nil)
(setq cua-highlight-region-shift-only t)
(one-buffer-one-frame-mode 0) ; forces everything to open in one window

(defun edit-my-preferencpes ()
  "Edits my local preferences."
  (interactive)
  (find-file 
   ; Change this for your homedir!
   "~/Library/Preferences/Aquamacs Emacs/Preferences.el"))
(define-key global-map "\C-xP" 'edit-my-preferences)

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

(defmacro quick-key (keymap &rest keypairs)
  "Quickly define keys for a specific KEYMAP by giving pairs, like (\"\\C-ca\" 'do-nothing-special)"
  `(progn ,@(map 'list (lambda (kp)
                         `(define-key ,keymap ,(car kp) ,(cadr kp)))
                 keypairs)))

; colors
(require 'color-theme)
(color-theme-initialize)
(setq color-theme-is-global t)
(color-theme-dark-laptop)

; rinari
(add-to-list 'load-path "~/.emacs.d/rinari/")
(require 'rinari)
(global-set-key (kbd "C-x C-M-f") 'find-file-in-project) ;; optional
(setq rinari-tags-file-name "TAGS")

; markdown
(add-to-list 'load-path "~/.emacs.d/markdown-mode")
(autoload 'markdown-mode "markdown-mode.el"
   "Major mode for editing Markdown files" t)
(setq auto-mode-alist
   (cons '("\\.markdown" . markdown-mode) auto-mode-alist))

; git
(add-to-list 'load-path "~/.emacs.d/git-emacs")
(require 'git-emacs)

; dired
(require 'dired)

; remap 'o' in dired mode to open a file
(defun dired-open-mac ()
  (interactive)
  (let ((file-name (dired-get-file-for-visit)))
    (if (file-exists-p file-name)
        (call-process "/usr/bin/open" nil 0 nil file-name))))
(define-key dired-mode-map "o" 'dired-open-mac)