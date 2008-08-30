;; others
(load "defunkt/url")
(load "defunkt/isearch")

;; keys
(global-set-key [C-tab] 'other-window) ; vimy window switching

;; functions
(defun insert-soft-tab ()
  (interactive)
  (insert "  "))
(global-set-key [C-M-tab] 'insert-soft-tab)

(defun find-dot-emacs ()
  (interactive)
  (find-file "~/.emacs.d/defunkt.el"))
(global-set-key "\C-xp" 'find-dot-emacs)

(defun find-customizations ()
  (interactive)
  (find-file "~/Library/Preferences/Aquamacs Emacs/customizations.el"))
(global-set-key "\C-xc" 'find-customizations)

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

; textmate style command+space
(defun insert-blank-line-after-current ()
  (interactive)
  (end-of-line)
  (newline-and-indent))
(global-set-key [A-return] 'insert-blank-line-after-current)

; for loading libraries in from the vendor directory
(defun vendor (library)
  (let* ((file (symbol-name library)) 
         (normal (concat "~/.emacs.d/vendor/" file)) 
         (suffix (concat normal ".el"))
         (defunkt (concat "~/.emacs.d/defunkt/" file)))
    (cond 
     ((file-directory-p normal) (add-to-list 'load-path normal) (require library))
     ((file-directory-p suffix) (add-to-list 'load-path suffix) (require library))
     ((file-exists-p suffix) (require library)))
    (when (file-exists-p (concat defunkt ".el"))
      (load defunkt))))