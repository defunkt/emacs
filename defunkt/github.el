;; github specific lovelies

(defvar *github-root* "~/Projects/github")

(defun github-ido-find-file ()
  (interactive)
  (ido-find-file-in-dir *github-root*))

(defun github-open-blob ()
  "Opens the current line of the current file on GitHub (if it can).

Requires `github-open` be in your path: http://gist.github.com/219241
"
  (interactive)
  (if (mark)
      (github-open-blob-for-region (region-beginning) (region-end))
    (github-open-blob-for-region (point) (point))))

(defun github-open-blob-for-region (min max)
  "Opens the current region of the current file on GitHub (if it can)."
  (interactive "r")
  (shell-command (concat "github-open " (buffer-file-name)
                         " "
                         (number-to-string (line-number-at-pos min))
                         "-"
                         (number-to-string (line-number-at-pos max)))))

