    (defun kts (emacs config)
      "chris wanstrath // chris@ozmm.org"
  
      (git-clone "git://github.com/defunkt/emacs.git")
      (ruby "emacs/install.rb")
      (find-file "emacs/local.el")
      (insert '(load "defunkt"))
      (save-buffer))
