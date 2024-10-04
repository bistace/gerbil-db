(import "cd" "db")

(def (main . args)
  (def test_db (DB))
  {load-from-file test_db "out.db"}

  ; (def test_cd_1 (CD "test" "toto" 3/5))
  ; (def test_cd_2 (CD "test2" "toto2" 2/5 #t))
  ; {add_cd test_db test_cd_1}
  ; {add_cd test_db test_cd_2}

  {save-to-file test_db}  
)
