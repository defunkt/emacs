    ;;; integrate ido with artist-mode
   (defun artist-ido-select-operation (type)
     "Use ido to select a drawing operation in artist-mode"
     (interactive (list (ido-completing-read "Drawing operation: "
                                             (list "Pen" "Pen Line" "line" "straight line" "rectangle"
                                                   "square" "poly-line" "straight poly-line" "ellipse"
                                                   "circle" "text see-thru" "text-overwrite" "spray-can"
                                                   "erase char" "erase rectangle" "vaporize line" "vaporize lines"
                                                   "cut rectangle" "cut square" "copy rectangle" "copy square"
                                                   "paste" "flood-fill"))))
     (artist-select-operation type))
   (defun artist-ido-select-settings (type)
     "Use ido to select a setting to change in artist-mode"
     (interactive (list (ido-completing-read "Setting: "
                                             (list "Set Fill" "Set Line" "Set Erase" "Spray-size" "Spray-chars"
                                                   "Rubber-banding" "Trimming" "Borders"))))
     (if (equal type "Spray-size")
       (artist-select-operation "spray set size")
       (call-interactively (artist-fc-get-fn-from-symbol
			    (cdr (assoc type '(("Set Fill" . set-fill)
					       ("Set Line" . set-line)
					       ("Set Erase" . set-erase)
					       ("Rubber-banding" . rubber-band)
					       ("Trimming" . trimming)
					       ("Borders" . borders)
					       ("Spray-chars" . spray-chars))))))))
   (add-hook 'artist-mode-init-hook
	     (lambda ()
	       (define-key artist-mode-map (kbd "C-c C-a C-o") 'artist-ido-select-operation)
	       (define-key artist-mode-map (kbd "C-c C-a C-c") 'artist-ido-select-settings)))