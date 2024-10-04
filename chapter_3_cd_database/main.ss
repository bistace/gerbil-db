(import "cd" "db")

(def (main . args)
  ; (def test_cd_1 (CD "test" "toto" 3/5))
  ; (def test_cd_2 (CD "test2" "toto2" 2/5 #t))

  (def test_db (DB))
  {load-from-file test_db "out.db"}
  ; {add_cd test_db test_cd_1}
  ; {add_cd test_db test_cd_2}
  ; {dump test_db}
  (displayln {select test_db "title" "test2"})
  (displayln {select test_db "title" "test3"})
  (displayln {select test_db "artist" "toto"})
  (displayln {select test_db "artist" "toto3"})
  (displayln {select test_db "rating" 3/5})
  (displayln {select test_db "rating" 4/5})
  (displayln {select test_db "ripped" #t})
  (displayln {select test_db "ripped" #f})
  {save-to-file test_db}  
)
