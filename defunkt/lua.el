;; use an indentation width of two spaces
(setq lua-indent-level 2)

(defun lua-insert-puts ()
  (interactive)
  (insert "puts()")
  (backward-char))

(defun lua-rake-run ()
  (interactive)
  (shell-command "rake run"))

(add-hook 'lua-mode-hook
          '(lambda ()
             (define-key lua-mode-map (kbd "A-r") 'lua-rake-run)
             (define-key lua-mode-map "\C-L" 'lua-insert-puts)))

;; Add dangling '(', remove '='
;; (setq lua-cont-eol-regexp
;;       (eval-when-compile
;;         (concat
;;          "\\((\\|\\_<"
;;          (regexp-opt '("and" "or" "not" "in" "for" "while"
;;                        "local" "function") t)
;;          "\\_>\\|"
;;          "\\(^\\|[^" lua-operator-class "]\\)"
;;          (regexp-opt '("+" "-" "*" "/" "^" ".." "==" "<" ">" "<=" ">=" "~=") t)
;;          "\\)"
;;          "\\s *\\=")))

;; (defun lua-calculate-indentation (&optional parse-start)
;;   "Overwrites the default lua-mode function that calculates the
;; column to which the current line should be indented to."
;;   (save-excursion
;;     (when parse-start
;;       (goto-char parse-start))

;;     ;; We calculate the indentation column depending on the previous
;;     ;; non-blank, non-comment code line. Also, when the current line
;;     ;; is a continuation of that previous line, we add one additional
;;     ;; unit of indentation.
;;     (+ (if (lua-is-continuing-statement-p) lua-indent-level 0)
;;        (if (lua-goto-nonblank-previous-line)
;;            (+ (current-indentation) (lua-calculate-indentation-right-shift-next))
;;          0))))

;; (defun lua-calculate-indentation-right-shift-next (&optional parse-start)
