;; others
(load "defunkt/url")
(load "defunkt/isearch")

;; keys
(global-set-key [C-tab] 'other-window) ; vimy window switching
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;; functions
(defun insert-soft-tab ()
  (interactive)
  (insert "  "))
(global-set-key [C-M-tab] 'insert-soft-tab)

;; experimantal
(defun defunkt-indent-region (&optional start end)
  (interactive "r")
  (message (concat "start: " (number-to-string start) " end: " (number-to-string end)))
  (save-excursion
    (goto-char start)
    (while (> end (point))
      (defunkt-indent)
      (next-line))))
;(global-set-key [M-tab] 'defunkt-indent-region)

; experimental
(defun defunkt-indent () 
  (interactive)
  (save-excursion
    (beginning-of-line)
    (when (looking-at "\\s-+") (defunkt-kill-word 1))
    (insert "  ")))
;(global-set-key "\t" 'defunkt-indent)

(defun find-dot-emacs ()
  (interactive)
  (find-file "~/.emacs.d/defunkt.el"))
(global-set-key "\C-xp" 'find-dot-emacs)

;; fix kill-word
(defun defunkt-kill-word (arg)
  "Special version of kill-word which swallows spaces separate from words"
  (interactive "p")

  (let ((whitespace-regexp "\\s-+"))
    (kill-region (point) 
                 (if (looking-at whitespace-regexp)
                     (progn (re-search-forward whitespace-regexp) (point))
                   (progn (forward-word arg) (point))))))
(global-set-key [remap kill-word] 'defunkt-kill-word)

(defun defunkt-backward-kill-word (arg)
  "Special version of backward-kill-word which swallows spaces separate from words"
  (interactive "p")
  (if (looking-back "\\s-+")
      (kill-region (point) (progn (re-search-backward "\\S-") (forward-char 1) (point)))
    (backward-kill-word arg)))
(global-set-key [remap backward-kill-word] 'defunkt-backward-kill-word)
(global-set-key [remap aquamacs-backward-kill-word] 'defunkt-backward-kill-word)

; set the mode based on the shebang;
; TODO: this sometimes breaks
(defun shebang-to-mode ()
  (interactive)
  (let*
      ((bang (buffer-substring (point-min) (prog2 (end-of-line) (point) (move-beginning-of-line 1))))
       (mode (progn
               (string-match "^#!.+[ /]\\(\\w+\\)$" bang)
               (match-string 1 bang)))
       (mode-fn (intern (concat mode "-mode"))))
    (when (functionp mode-fn)
      (funcall mode-fn))))

(add-hook 'find-file-hook 'shebang-to-mode)

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