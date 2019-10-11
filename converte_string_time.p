FUNCTION stringToTIme RETURNS INTEGER (INPUT textoHora AS CHARACTER):
    
    DEF VAR vHoras   AS INT NO-UNDO.
    DEF VAR vMinutos AS INT NO-UNDO.
    DEF VAR vSegundos AS INT NO-UNDO.
    DEF VAR vTempo    AS INT NO-UNDO.
    
    ASSIGN
        vTempo = 0
        vHoras = INT(SUBSTRING(textoHora,1,2))
        vMinutos = INT(SUBSTRING(textoHora,4,2))
        vSegundos = INT(SUBSTRING(textoHora,7,2))
        vTempo = vSegundos * 1 + (vMinutos * 60) + (vHoras * 3600).
    RETURN vTempo.
END FUNCTION.
