DEF TEMP-TABLE teste 
    FIELD valor AS CHAR.

CREATE teste.
valor = "a".

CREATE teste.
valor = "b".
                           
DEFINE QUERY qCont FOR teste CACHE 0.
OPEN QUERY qCont PRESELECT EACH teste.
DISP NUM-RESULTS( "qCont" ).
