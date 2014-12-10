DEFINE TEMP-TABLE ttMyOne NO-UNDO
FIELD c-nome AS CHARACTER
FIELD c-endereco AS CHARACTER.


 CREATE ttMyOne. 
   ASSIGN ttMyOne.c-nome     = "teste" 
          ttMyOne.c-endereco = "teste". 

IF TEMP-TABLE ttMyOne:HAS-RECORDS THEN
  MESSAGE "Tem conteudo na temp-table." VIEW-AS ALERT-BOX.
ELSE
  MESSAGE "A temp-table está vazia." VIEW-AS ALERT-BOX.
