#!/usr/bin/env gxi
;;; -*- Gerbil -*-
(import :std/build-script)

(defbuild-script
  '("chapter_3_cd_database/lib"
    (exe: "chapter_3_cd_database/main" bin: "chapter_3_cd_database")))
