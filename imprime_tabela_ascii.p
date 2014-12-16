DEF VAR cont  AS INTEGER.
 
DEF VAR texto AS CHARACTER FORMAT "x(10)" EXTENT 255.
 
DO cont = 1 TO 255:
    ASSIGN
        texto[cont] = STRING(cont) + " - " + CHR(cont).
END.
 
 
disp texto
    WITH no-labels TITLE "The book is on the Table ASCII "
    SCROLLBAR-VERTICAL.
