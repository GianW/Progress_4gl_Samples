def var iPos as integer.
def var pChar as char.


prompt-for pChar.
assign pChar.


DO iPos = 1 TO LENGTH(pChar):
    IF CAN-DO("á,ã,â,à",SUBSTRING(pChar,iPos,1)) THEN
    ASSIGN SUBSTRING(pChar,iPos,1) = "a".
    IF CAN-DO("é,ê,è",SUBSTRING(pChar,iPos,1)) THEN
    ASSIGN SUBSTRING(pChar,iPos,1) = "e".
    IF CAN-DO("í,î,ì",SUBSTRING(pChar,iPos,1)) THEN
    ASSIGN SUBSTRING(pChar,iPos,1) = "i".
    IF CAN-DO("ó,õ,ô,ò",SUBSTRING(pChar,iPos,1)) THEN
    ASSIGN SUBSTRING(pChar,iPos,1) = "o".
    IF CAN-DO("ú,û,ù",SUBSTRING(pChar,iPos,1)) THEN
    ASSIGN SUBSTRING(pChar,iPos,1) = "u".
END.

disp UPPER(pChar). 
