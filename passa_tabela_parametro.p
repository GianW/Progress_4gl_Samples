define temp-table tt-erro no-undo
    field i-sequen  as int
    field cd-erro   as int
    field mensagem  as char
    field parametro as char
    index ch-seq is primary
         i-sequen.

create tt-erro.
assign
    tt-erro.i-sequen = 10
    tt-erro.parametro = "Gian".

   
run recebe-temp-table.p (input table tt-erro).
