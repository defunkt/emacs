; testing testing

'campfire-join-room
'campfire-speak
'campfire-receive-message

(defvar campfire-sleep-interval 2
  "Time the Campfire listen loop should sleep for, in seconds.")

(defun campfire-listen ()
  (while t
    (dolist (message (campfire-messages))
      (campfire-receive-message message))
    (sleep-for (* 1000 campfire-sleep-interval))))

(defun campfire-messages ()
)

(defun campfire-url-http-post (url args)
  "Send ARGS to URL as a POST request."
  (let ((url-request-method "POST")
        (url-request-extra-headers
         '(("Content-Type" . "application/x-www-form-urlencoded")))
        (url-request-data
         (concat (mapconcat (lambda (arg)
                              (concat (url-hexify-string (car arg))
                                      "="
                                      (url-hexify-string (cdr arg))))
                            args
                            "&")
                 "\r\n")))
    ;; `kill-url-buffer'      to discard the result
    ;; `switch-to-url-buffer' to view the results (debugging).
    (url-retrieve url 'switch-to-url-buffer)))

(defun kill-url-buffer (status)
  "Kill the buffer returned by `url-retrieve'."
  (kill-buffer (current-buffer)))

(defun switch-to-url-buffer (status)
  "Switch to the buffer returned by `url-retreive'.
    The buffer contains the raw HTTP response sent by the server."
  (switch-to-buffer (current-buffer)))


response = post("poll.fcgi", {:l => @last_cache_id, :m => @membership_key,
          :s => @timestamp, :t => "#{Time.now.to_i}000"}, :ajax => true)
        if response.body.length > 1
          lines = response.body.split("\r\n")
          
          if lines.length > 0
            @last_cache_id = lines.pop.scan(/chat.poller.lastCacheID = (\d+)/).to_s
            lines.each do |msg|
              unless msg.match(/timestamp_message/)
                if msg.length > 0
                  messages << {
                    :id => msg.scan(/message_(\d+)/).to_s,
                    :user_id => msg.scan(/user_(\d+)/).to_s,
                    :person => msg.scan(/\\u003Ctd class=\\"person\\"\\u003E(?:\\u003Cspan\\u003E)?(.+?)(?:\\u003C\/span\\u003E)?\\u003C\/td\\u003E/).to_s,
                    :message => msg.scan(/\\u003Ctd class=\\"body\\"\\u003E\\u003Cdiv\\u003E(.+?)\\u003C\/div\\u003E\\u003C\/td\\u003E/).to_s
                  }
                end
              end
            end

(provide 'campfire)