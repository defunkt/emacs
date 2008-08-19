; rinari
(add-to-list 'load-path "~/.emacs.d/rinari")
(require 'rinari)
(global-set-key (kbd "C-x C-M-f") 'find-file-in-project) ;; optional
(setq rinari-tags-file-name "TAGS")