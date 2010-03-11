;; channel name in prompt
(setq erc-prompt (lambda ()
                   (if (and (boundp 'erc-default-recipients) (erc-default-target))
                       (erc-propertize (concat (erc-default-target) ">") 'read-only t 'rear-nonsticky t 'front-nonsticky t)
                     (erc-propertize (concat "ERC>") 'read-only t 'rear-nonsticky t 'front-nonsticky t))))

(setq erc-track-exclude-types '("JOIN" "PART" "QUIT" "NICK" "MODE"))
(setq erc-button-url-regexp
      "\\([-a-zA-Z0-9_=!?#$@~`%&*+\\/:;,]+\\.\\)+[-a-zA-Z0-9_=!?#$@~`%&*+\\/:;,]*[-a-zA-Z0-9\\/]")

(setq erc-mode-line-format "%t (%n)")

(defun defunkt-erc-update-topic (parsed)
  (interactive)

  (if (get-buffer (erc-response.contents parsed))
      (with-current-buffer (erc-response.contents parsed)
        (if (hash-table-p erc-channel-users)
            (let* ((users (number-to-string (hash-table-count erc-channel-users)))
                   (erc-mode-line-format (concat "%t (%n) " users)))
              (erc-update-mode-line-buffer (current-buffer)))))))

;; (add-hook 'erc-server-JOIN-functions
;;           (lambda (PROC parsed)
;;             (defunkt-erc-update-topic parsed)))
;; (add-hook 'erc-server-PART-functions
;;           (lambda (PROC parsed)
;;             (defunkt-erc-update-topic parsed)))

(setq erc-autojoin-channels-alist
      '(("freenode.net" "#github" "#logicalawesome" "#rip"
         "#resque" "#{" "#sinatra" "#redis" "#coffeescript"
         "#thechangelog" )))