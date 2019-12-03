FUNCTION isNumber RETURN LOG(entrada AS CHAR):
    DEF VAR i AS INT NO-UNDO.
    DEF VAR vTamEntrada AS INT NO-UNDO.
    DEF VAR testeValor AS INT NO-UNDO.

    vTamEntrada = length(entrada).

    DO i = 1 TO vTamEntrada:
        testeValor = ?.
        testeValor = INT(substring(entrada, i, 1)) NO-ERROR.
        IF testeValor = ? THEN RETURN NO.
    END.

    RETURN YES.
END FUNCTION.
