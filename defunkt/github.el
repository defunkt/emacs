;; github specific lovelies

(defvar *github-root* "~/Projects/github")

(defun github-ido-find-file ()
  (interactive)
  (ido-find-file-in-dir *github-root*))
