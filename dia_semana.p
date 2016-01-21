def var semana as char extent 7 no-undo.
def var dia    as int no-undo.

assign semana[1] = "Domingo"
       semana[2] = "Segunda"
       semana[3] = "Terça"
       semana[4] = "Quarta"
       semana[5] = "Quinta"
       semana[6] = "Sexta"
       semana[7] = "Sabado".

dia = weekday(today).

message semana[dia] view-as alert-box.
