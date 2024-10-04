(import :std/error)
(import :std/format)
(import :std/misc/decimal)

(export CD cd-to-str make-CD-from-save-line)

(defstruct CD  
  ((title : :string) (artist : :string) (rating : :ratnum) (ripped : :boolean))
  constructor: :init!
)

(defmethod {:init! CD}
  (lambda (self title artist rating (ripped #f)) 
    (set! self.title title)
    (set! self.artist artist)
    (set! self.rating rating)
    (set! self.ripped ripped)
  )
)

(def (make-CD-from-save-line title artist rating-string ripped-string)
  (def rating (string->number rating-string))
  (def ripped 
    (match ripped-string
      ("#t" #t)
      ("#f" #f)
      (else (error (format "String cannot be converted to boolean: '~a'" ripped-string)))
    )
  )
  (CD title artist rating ripped)  
)

(defmethod {displayln CD} 
  (lambda (self) 
    (displayln 
      "CD { title: '" self.title "' " 
      "artist: '" self.artist "' "
      "rating: '" self.rating "' "
      "ripped: '" self.ripped "' }"
    )
  )
)

(def (cd-to-str cd)
  (format "~a,~a,~a,~a~%" (@ cd title) (@ cd artist) (@ cd rating) (@ cd ripped))
)
