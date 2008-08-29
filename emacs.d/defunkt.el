(add-to-list 'load-path "~/.emacs.d/vendor")

(load ".passwords")

(load "defunkt/global")
(load "defunkt/helpers")
(load "defunkt/modes")
(load "defunkt/theme")

(vendor 'cheat)
(vendor 'magit)
(vendor 'gist)
(vendor 'growl)
(vendor 'twittering-mode)