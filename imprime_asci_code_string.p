DEF VAR teste AS CHAR NO-UNDO.
DEF VAR i AS INT NO-UNDO.

teste = "D
F4".

DO i = 1 TO LENGTH(teste):
    MESSAGE keycode(SUBSTRING(teste, i, 1)).    
END.
