define temp-table tt-erro no-undo
    field i-sequen  as int
    field cd-erro   as int
    field mensagem  as char
    field parametro as char
    index ch-seq is primary
         i-sequen.

def input parameter table for tt-erro.

for each tt-erro:
    disp
        tt-erro.
end.
