(global-set-key "\C-x\C-b" 'buffer-menu)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-g" 'gist-buffer)
(global-set-key "\C-xg" 'magit-status)
(global-set-key "\M-i" 'insert-soft-tab)
(global-set-key "\C-xp" 'defunkt-find-config)
(global-set-key [C-return] 'defunkt-duplicate-line)

; vim emulation
(global-set-key [C-tab] 'other-window) 
(global-set-key [M-up] 'defunkt-inc-num-at-point)
(global-set-key [M-down] 'defunkt-dec-num-at-point)
(global-set-key (kbd "C-*") 'isearch-forward-at-point)
(global-set-key [remap kill-word] 'defunkt-kill-word)
(global-set-key [remap backward-kill-word] 'defunkt-backward-kill-word)
(global-set-key [remap aquamacs-backward-kill-word] 'defunkt-backward-kill-word)

; no printing!
(define-key osx-key-mode-map (kbd "A-p") 
  '(lambda () (interactive) (message "noop")))
