(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement.

(define (cons-all first rests)
  'replace-this-line)

(define (zip pairs)
  'replace-this-line)

;; Problem 17
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 17

  (define (f s i)
    (if (null? s)
      s
      (cons (cons i (cons (car s) nil)) (f (cdr s) (+ i 1)))
    )
  )
  (f s 0)

)
  ; END PROBLEM 17

;; Problem 18
;; List all ways to make change for TOTAL with DENOMS
(define (list-change total denoms)
  ; BEGIN PROBLEM 18

  (cond
    ((= 0 total)      '(()) )
    ((null? denoms)     nil )
    ((> 0 total)        nil )
    (else (append ( cons-all (car denoms) (list-change (- total (car denoms)) denoms) )
                  (list-change total (cdr denoms))
          )
    )
  )
)

(define (cons-all first rests)
  (if (null? rests)
  nil
  (cons (cons first (car rests)) (cons-all first (cdr rests))))
)

  ; END PROBLEM 18

;; Problem 19
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN PROBLEM 19

         expr

         ; END PROBLEM 19
         )
        ((quoted? expr)
         ; BEGIN PROBLEM 19

         (list 'quote (cadr expr))

         ; END PROBLEM 19
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 19

           (append (list form params) (map let-to-lambda body))

           ; END PROBLEM 19
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 19

           (append
              (list (list 'lambda (car (zip values)) (car (map let-to-lambda body)))) 
              (map let-to-lambda (cadr (zip values))))

           ; END PROBLEM 19
           ))
        (else
         ; BEGIN PROBLEM 19

         (map let-to-lambda expr)

         ; END PROBLEM 19
         )))

(define (zip pairs)
  (list (apply-to-all car pairs) (apply-to-all car (apply-to-all cdr pairs)))
)

(define (apply-to-all proc items)
  (if (null? items)
    nil
    (cons (proc (car items)) (apply-to-all proc (cdr items)))
  )
)
