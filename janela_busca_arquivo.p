def var c-busca-imagem as char format "x(200)".
def var l-ok           as log  no-undo.
def var c-teste        as char no-undo.

    SYSTEM-DIALOG GET-FILE c-busca-imagem
        FILTERS  "*.jpg" "*.jpg",
                "*.gif" "*.gif"                    
        DEFAULT-EXTENSION "jpg" 
        INITIAL-DIR session:temp-directory 
        /*USE-FILENAME.*/
        UPDATE l-ok.
      
if  l-ok = yes then do:
   input frame {&frame-name} c-imagem:screen-value = c-busca-imagem.
end.
