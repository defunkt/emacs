;; github specific lovelies

(defvar *github-root* "~/Code/github")

(defun github-ido-find-file ()
  (interactive)
  (ido-find-file-in-dir *github-root*))
