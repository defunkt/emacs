;;
; defunkt's lisp playground
;

(defun empty? (target)
  (eq target nil))

(defalias 'nil? 'empty?)
(setq else t)

;
; (each (dog cat monkey) (x)
;  (print x))
;
(defmacro each (list iterator body)
  `(let ((_l (if (listp ',list) ',list ,list)))
   (while (not (empty? _l))
     (funcall (lambda (,@iterator) ,body) (car _l))
     (setq _l (cdr _l)))))

;
; (eacht (dog cat monkey)
;   (print this))
;
(defmacro eacht (list body)
  `(each ,list (this) ,body))

; rubyish
(defun select (list body)
  (if (empty? list) 
      nil
    (if (funcall body (car list))
        (cons (car list) (select (cdr list) body))
      (select (cdr list) body))))

; rubyish
(defun reject (list body) 
  (if (empty? list)
      nil
    (if (funcall body (car list))
        (reject (cdr list) body)        
      (cons (car list) (reject (cdr list) body)))))