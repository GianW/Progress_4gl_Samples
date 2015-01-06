 def var c-busca-imagem as char format "x(200)".
 def var l-ok            as log  no-undo.
 def var c-teste        as char no-undo.

    SYSTEM-DIALOG get-dir c-busca-imagem
    INITIAL-DIR session:temp-directory  
    UPDATE l-ok.
    
if  l-ok = yes then do:
    c-teste    = c-busca-imagem.
end. 
