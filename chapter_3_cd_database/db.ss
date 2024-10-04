(import :std/format)
(import :std/io)
(import :std/iter)
(import :std/misc/list)
(import :std/sugar)
(import "cd")

(export DB)

; cds : evector => contains all CDs in the database
(defstruct DB (cds : :list) constructor: :init!)

(defmethod {:init! DB}
  (lambda (self)
    (set! self.cds (make-list 0))
  )
)

(defmethod {add_cd DB}
  (lambda (self (cd : CD))
    (push! cd self.cds)
  )
)

(defmethod {dump DB}
  (lambda (self)
    (map (lambda ((cd : CD)) {displayln cd}) self.cds)
  )
)

(defmethod {load-from-file DB}
  (lambda (self (filename : :string))
    (def reader (open-buffered-reader (open-file-reader filename)))
    (let ((line (BufferedReader-read-line reader)) (sline '()) (cd '())) 
      (until (string-empty? line)
        (set! sline (string-split line #\,))
        (set! cd (apply make-CD-from-save-line sline))
        {add_cd self cd}
        (set! line (BufferedReader-read-line reader))
      )
    )
    (BufferedReader-close reader)
  )
)

(defmethod {save-to-file DB}
  (lambda (self (filename "out.db"))
    (def writer (open-file-writer filename))
      (for (cd self.cds)
        (Writer-write writer (string->utf8 (cd-to-str cd)))
      )
    (Writer-close writer)
  )
)

(defmethod {len DB}
  (lambda (self)
    (length self.cds)
  )
)

(defmethod {select DB}
  (lambda (self field value)
    (if (not (member field '("title" "artist" "rating" "ripped")))
      (error (format "Specified field is not a CD slot: '~a'" field))
    )
    (match field
      ("title" (select-title self value))
      ("artist" (select-artist self value))
      ("rating" (select-rating self value))
      ("ripped" (select-ripped self value))
      (else (error (format "Select not implemented: '~a'" field)))       
    )  
  )
)

(def (select-title (db : DB) (title : :string))
  (filter (lambda (cd) (equal? (@ cd title) title)) (@ db cds))
)

(def (select-artist (db : DB) (artist : :string))
  (filter (lambda (cd) (equal? (@ cd artist) artist)) (@ db cds))
)

(def (select-rating (db : DB) (rating : :ratnum))
  (filter (lambda (cd) (equal? (@ cd rating) rating)) (@ db cds))
)

(def (select-ripped (db : DB) (ripped : :boolean))
  (filter (lambda (cd) (equal? (@ cd ripped) ripped)) (@ db cds))
)
