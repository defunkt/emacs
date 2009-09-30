(defvar defunkt-todo-global-file "~/.todo"
  "Path to the todo file used by `defunkt-todo-quick-jump' and friends.")

(defun defunkt-todo-quick-enter ()
  "Prompts for a new todo item to be inserted into the global todo file."
  (interactive)
  (let ((item (read-string "TODO: ")))
    (if (string= "" item)
        (defunkt-todo-quick-jump)
      (defunkt-todo-add-global-item item))))

(defun defunkt-todo-quick-jump ()
  "Visits the global todo file."
  (interactive)
  (find-file defunkt-todo-global-file))

(defun defunkt-todo-add-global-item (item)
  "Adds an item to the global todo file."
  (save-excursion
    (set-buffer (find-file-noselect defunkt-todo-global-file))
    (when (not (= (point-min) (point-max)))
      (goto-char (point-max))
      (insert "\n"))
    (insert item)
    (defunkt-todo-toggle))
  (message "TODO: Item added."))

(defun defunkt-todo-toggle ()
  "Toggles the todo state if it's active, otherwise activates it. "
  (interactive)
  (save-excursion
    (move-beginning-of-line 1)
    (if (string= (char-to-string (char-after)) "[")
        (defunkt-todo-toggle-status)
      (insert "[ ] "))
    (save-buffer)))

(defun defunkt-todo-done? ()
  "Is this line a done todo item?"
  (save-excursion
    (move-beginning-of-line 1)
    (search-forward "[ ]" (+ 3 (point)) t)))

(defun defunkt-todo-toggle-status ()
  "Toggle the todo state."
  (interactive)
  (save-excursion
    (if (defunkt-todo-done?)
        (defunkt-todo-set-done)
      (defunkt-todo-set-begun))))

(defun defunkt-todo-set-begun ()
  "Set a todo item as begun."
  (defunkt-todo-set-status " "))

(defun defunkt-todo-set-done ()
  "Set a todo item as done."
  (defunkt-todo-set-status "X"))

(defun defunkt-todo-set-status (status)
  "Give the current todo item to an arbitrary status."
  (save-excursion
    (move-beginning-of-line 1)
    (forward-char 1)
    (delete-char 1)
    (insert status)))

(defun defunkt-todo-move-item-up ()
  "Moves the focused todo item down a line."  
  (interactive)
  (save-excursion
    (beginning-of-line 1)
    (when (not (= (point-min) (point)))
      (let ((word (delete-and-extract-region (point) (point-at-eol))))
        (delete-char 1)
        (forward-line -1)
        (insert (concat word "\n")))
      (save-buffer)))
  (when (not (= (point-min) (point)))
    (forward-line -2)))

(defun defunkt-todo-move-item-down ()
  "Moves the focused todo item up a line."    
  (interactive)
  (let (eof chars)
    (setq chars (- (point) (point-at-bol)))
    (save-excursion
      (end-of-line 1)
      (setq eof (= (point-max) (point)))
      (when (not eof)
        (let ((word (delete-and-extract-region (point-at-bol) (point))))
          (delete-char 1)
          (forward-line 1)
          (insert (concat word "\n")))
        (save-buffer)))
    (when (not eof)
      (forward-line 1)
      
)))