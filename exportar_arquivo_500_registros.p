DEFINE TEMP-TABLE tt-teste 
    FIELD id AS INT.

DEFINE VARIABLE l-para AS LOG INITIAL FALSE.
DEFINE VARIABLE i-cont AS INT.

def stream s-exp.

DO WHILE l-para = FALSE:
    ASSIGN
        i-cont = i-cont + 1.

    CREATE tt-teste.
        ASSIGN
            tt-teste.id = i-cont.

     IF i-cont = 2300 THEN
         ASSIGN
            l-para = TRUE.
                     
END.

ASSIGN i-cont = 0.

RUN pi-saida(INPUT "1").

FOR EACH tt-teste:
    
    ASSIGN
        i-cont = i-cont + 1.

  put stream s-exp unformatted
      tt-teste.id
      ";"
      SKIP.

  IF i-cont > 499 THEN DO:
      output stream s-exp close.
      ASSIGN i-cont = 0.
      RUN pi-saida(INPUT STRING(tt-teste.id)).

  END.

END.




PROCEDURE pi-saida.

DEFINE INPUT PARAM c-valor AS CHAR.
 ASSIGN 
     c-valor = c-valor + ".txt".
OUTPUT stream s-exp TO VALUE("C:\temp\" + c-valor).
                                                 
END PROCEDURE.


