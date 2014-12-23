OUTPUT TO "c:\temp\3-itens-fabricados.txt".   
        
def var c-desc-fam-comerc   like fam-comerc.descricao.

for each item no-lock:
    
   if item.compr-fabric = 2 then do:

    find grup-estoque of item 
            no-lock no-error.

    find familia of item
            no-lock no-error.

    find fam-comerc where
         fam-comerc.fm-cod-com   = item.fm-cod-com 
                no-lock no-error.
        if avail fam-comerc then
            c-desc-fam-comerc  = fam-comerc.descricao.

    disp
        item.it-codigo              column-label "Item"
        item.desc-item              column-label "Descri‡Æo"
        item.un
        item.class-fiscal           column-label "Class Fiscal"
        item.data-implant           column-label "Data Implanta‡Æo"
        item.ge-codigo              column-label "Codigo do Grupo"
        grup-estoque.descricao      column-label "Descri‡Æo do Grupo"
        familia.fm-codigo           column-label "Cod Fam"
        familia.descricao           column-label "Fam Descri‡Æo"
        item.fm-cod-com             column-label "Familia Comercial"
        c-desc-fam-comerc           column-label "Descri‡Æo Fam Comercial" 
        with frame f1 width 280 stream-io down.
    end.

    else
        next.


 end.

 OUTPUT CLOSE.
