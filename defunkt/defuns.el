(defun insert-soft-tab ()
  (interactive)
  (insert "  "))

(defun defunkt-indent () 
  (interactive)
  (insert "  "))

(defadvice zap-to-char (after dont-zap-char (arg char))
  "Doesn't include the char - zaps to the char before it (like vim)."
  (insert char)
  (backward-char))
(ad-activate 'zap-to-char)

(defun ido-goto-symbol ()
  "Will update the imenu index and then use ido to select a symbol to navigate to"
  (interactive)
  (imenu--make-index-alist)
  (let ((name-and-pos '())
        (symbol-names '()))
    (flet ((addsymbols (symbol-list)
                       (when (listp symbol-list)
                         (dolist (symbol symbol-list)
                           (let ((name nil) (position nil))
                             (cond
                              ((and (listp symbol) (imenu--subalist-p symbol))
                               (addsymbols symbol))
                              
                              ((listp symbol)
                               (setq name (car symbol))
                               (setq position (cdr symbol)))
                              
                              ((stringp symbol)
                               (setq name symbol)
                               (setq position (get-text-property 1 'org-imenu-marker symbol))))
                             
                             (unless (or (null position) (null name))
                               (add-to-list 'symbol-names name)
                               (add-to-list 'name-and-pos (cons name position))))))))
      (addsymbols imenu--index-alist))
    (let* ((selected-symbol (ido-completing-read "Symbol? " symbol-names))
           (position (cdr (assoc selected-symbol name-and-pos))))
      (goto-char position))))


(defun defunkt-find-config ()
  (interactive)
  (let ((config-file
         (completing-read "Config file: " (reject (directory-files "~/.emacs.d/defunkt/")
                                                  (lambda (x) (string-match "^\\." x))))))
    (if (empty? config-file)
        (find-file "~/.emacs.d/defunkt.el")
      (find-file (concat "~/.emacs.d/defunkt/" config-file)))))

;; fix kill-word
(defun defunkt-kill-word (arg)
  "Special version of kill-word which swallows spaces separate from words"
  (interactive "p")

  (let ((whitespace-regexp "\\s-+"))
    (kill-region (point) 
                 (cond 
                  ((looking-at whitespace-regexp) (re-search-forward whitespace-regexp) (point))
                  ((looking-at "\n") (kill-line) (defunkt-kill-word arg))
                  (t (forward-word arg) (point))))))

(defun defunkt-backward-kill-word (arg)
  "Special version of backward-kill-word which swallows spaces separate from words"
  (interactive "p")
  (if (looking-back "\\s-+")
      (kill-region (point) (progn (re-search-backward "\\S-") (forward-char 1) (point)))
    (backward-kill-word arg)))

; set the mode based on the shebang;
; TODO: this sometimes breaks
(defun defunkt-shebang-to-mode ()
  (interactive)
  (let*
      ((bang (buffer-substring (point-min) (prog2 (end-of-line) (point) (move-beginning-of-line 1))))
       (mode (progn
               (string-match "^#!.+[ /]\\(\\w+\\)$" bang)
               (match-string 1 bang)))
       (mode-fn (intern (concat mode "-mode"))))
    (when (functionp mode-fn)
      (funcall mode-fn))))
;(add-hook 'find-file-hook 'defunkt-shebang-to-mode)

; textmate style command+space
(defun insert-blank-line-after-current ()
  (interactive)
  (end-of-line)
  (newline-and-indent))


; duplicate the current line
(defun defunkt-duplicate-line () 
  (interactive)
    (beginning-of-line)
    (copy-region-as-kill (point) (progn (end-of-line) (point)))
    (insert-blank-line-after-current)
    (yank)
    (beginning-of-line))

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

(require 'thingatpt)
(defun defunkt-change-num-at-point (fn)
  (let* ((num (string-to-number (thing-at-point 'word)))
         (bounds (bounds-of-thing-at-point 'word)))
    (save-excursion
      (goto-char (car bounds))
      (defunkt-kill-word 1)
      (insert (number-to-string (funcall fn num 1))))))

(defun defunkt-inc-num-at-point ()
  (interactive)
  (defunkt-change-num-at-point '+))

(defun defunkt-dec-num-at-point ()
  (interactive)
  (defunkt-change-num-at-point '-))

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