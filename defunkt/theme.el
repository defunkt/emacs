(require 'color-theme)
(when (fboundp 'color-theme-initialize)
  (color-theme-initialize))
(setq color-theme-is-global t)

(load-file "~/.emacs.d/vendor/twilight-emacs/color-theme-twilight.el")
(color-theme-twilight)

; how to get the font you want:
;   M-x mac-font-panel
;   pick your font
;   M-x describe-font
(setq default-frame-alist '((font . "-apple-inconsolata-medium-r-normal--16-160-72-72-m-160-iso10646-1")))