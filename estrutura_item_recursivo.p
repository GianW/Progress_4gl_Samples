DEFINE VARIABLE c-cod-item          LIKE estrutura.it-codigo.
DEFINE VARIABLE c-desc-aux          LIKE item.desc-item.
DEFINE VARIABLE i-sequencia         LIKE estrutura.sequencia.
DEFINE VARIABLE i-quantidade-aux    as int initial 1.
DEFINE VARIABLE i-quantidade-dig    as int initial 1.

DEFINE TEMP-TABLE tt-sequencia NO-UNDO
       FIELD item           LIKE estrutura.it-codigo
       FIELD item-filho     LIKE estrutura.es-codigo
       FIELD qtde           LIKE estrutura.quant-usada
       FIELD pai-desc       LIKE item.desc-item
       FIELD filho-desc     LIKE item.desc-item
       FIELD sequencia      LIKE estrutura.sequencia.

UPDATE c-cod-item COLUMN-LABEL "Search for".
UPDATE i-sequencia COLUMN-LABEL "Sequence".
UPDATE i-quantidade-dig COLUMN-LABEL "Amount".


RUN pi-monta-estrutura(c-cod-item, i-quantidade-aux, i-quantidade-dig, i-sequencia).
output to D:/recursao.txt.
PROCEDURE pi-monta-estrutura:
    DEFINE INPUT PARAMETER c-cod-item  LIKE estrutura.it-codigo.
    DEFINE INPUT PARAMETER i-quantidade-aux AS int.
    DEFINE INPUT PARAMETER i-quantidade-dig AS int.
    DEFINE INPUT PARAMETER i-sequencia      LIKE estrutura.sequencia.

    FOR EACH estrutura WHERE
             estrutura.it-codigo = c-cod-item   AND
             estrutura.sequencia = i-sequencia NO-LOCK:
    
        FIND tt-sequencia WHERE
             tt-sequencia.item           = estrutura.it-codigo   AND
             tt-sequencia.sequencia      = estrutura.sequencia   AND
             tt-sequencia.item-filho     = estrutura.es-codigo NO-LOCK NO-ERROR.
                
         IF AVAIL tt-sequencia THEN DO:
               tt-sequencia.qtde = tt-sequencia.qtde + estrutura.quant-usada.
               message estrutura.it-codigo view-as alert-box.
            END.

            
                FIND item WHERE
                     item.it-codigo = estrutura.it-codigo NO-LOCK NO-ERROR.
                      c-desc-aux = item.desc-item.
    
                 FIND item WHERE
                      item.it-codigo = estrutura.es-codigo NO-LOCK NO-ERROR.  
    
                
                       CREATE
                       tt-sequencia.
                       ASSIGN
                       tt-sequencia.item        = estrutura.it-codigo
                       tt-sequencia.item-filho  = estrutura.es-codigo
                       tt-sequencia.qtde        = estrutura.quant-usada * i-quantidade-aux
                       tt-sequencia.pai-desc    = c-desc-aux
                       tt-sequencia.filho-desc  = item.desc-item
                       tt-sequencia.sequencia   = estrutura.sequencia.

                       i-quantidade-aux         = tt-sequencia.qtde.
                       tt-sequencia.qtde = tt-sequencia.qtde * i-quantidade-dig.
                       i-sequencia = tt-sequencia.sequencia + 10.

                RUN pi-monta-estrutura(estrutura.es-codigo, i-quantidade-aux, i-quantidade-dig, i-sequencia).
          
        
    END.
END.

FOR EACH tt-sequencia  NO-LOCK:
                
   DISP
       tt-sequencia.item
       tt-sequencia.pai-desc
       tt-sequencia.item-filho  COLUMN-LABEL "Item Filho"
       tt-sequencia.filho-desc  COLUMN-LABEL "Desc Item Filho"
       tt-sequencia.qtde  (total ) 
       WITH FRAME f1 STREAM-IO WIDTH 200 DOWN.

END.
 output close.

