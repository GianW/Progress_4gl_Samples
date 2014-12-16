{PDFinclude/pdf_inc.i}
def var contador as int.
DEFINE VARIABLE c-cod-item          LIKE estrutura.it-codigo.
DEFINE VARIABLE c-desc-aux          LIKE item.desc-item.
DEFINE VARIABLE i-quantidade-aux    as int initial 1.

DEFINE TEMP-TABLE tt-sequencia NO-UNDO
       FIELD item           LIKE estrutura.it-codigo
       FIELD item-filho     LIKE estrutura.es-codigo
       FIELD qtde           LIKE estrutura.quant-usada
       FIELD pai-desc       LIKE item.desc-item
       FIELD filho-desc     LIKE item.desc-item.

UPDATE c-cod-item.

RUN pi-monta-estrutura(c-cod-item, i-quantidade-aux).


PROCEDURE pi-monta-estrutura:
    DEFINE INPUT PARAMETER c-cod-item  LIKE estrutura.it-codigo.
    DEFINE INPUT PARAMETER i-quantidade-aux AS int.

    FOR EACH estrutura WHERE
             estrutura.it-codigo = c-cod-item NO-LOCK:
    
        FIND tt-sequencia WHERE
             tt-sequencia.item           = estrutura.it-codigo   AND
             tt-sequencia.item-filho     = estrutura.es-codigo NO-LOCK NO-ERROR.

            IF AVAIL tt-sequencia THEN DO:
               tt-sequencia.qtde = tt-sequencia.qtde + (estrutura.quant-usada * i-quantidade-aux) .
            END.

            IF NOT AVAIL tt-sequencia THEN DO:
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
                       tt-sequencia.filho-desc  = item.desc-item.

                       i-quantidade-aux         = tt-sequencia.qtde.

                RUN pi-monta-estrutura(estrutura.es-codigo, i-quantidade-aux).
    
            END.
        
    END.
END.

RUN pdf_new  ("Spdf","C:\Temp\recursao.pdf").

        /*Tamanho da pagina*/
RUN pdf_set_PageHeight ("Spdf", 842). 
RUN pdf_set_PageWidth ("Spdf", 595).

RUN pdf_load_image ("Spdf","totLogo","C:\Users\giancarlo.winckler\Desktop\logo-totvs.jpg").

            RUN pdf_new_page        ("Spdf"). /* NOVA PAGINA */
            RUN pdf_stroke_fill     ("Spdf",1.0,1.0,1.0). /*Define cor para o rect*/
            RUN pdf_rect            ("Spdf", 5,5,584,832,2). /* Coluna, Linha, Largura, Comprimento, Espessura*/
            RUN pdf_rect            ("Spdf", 12,690,572,90,1.5). /*Rect cabe‡alho*/
            RUN pdf_rect            ("Spdf", 11,708,90,90,1.5). /*Borda Logo*/
            RUN pdf_place_image     ("Spdf", "totLogo",15, 130, 80, 80). /*Coluna , Linha , Largura , Comprimento*/

FOR EACH tt-sequencia  NO-LOCK:
                
   DISP
       contador
       tt-sequencia.item
       tt-sequencia.pai-desc
       tt-sequencia.item-filho  COLUMN-LABEL "Item Filho"
       tt-sequencia.filho-desc  COLUMN-LABEL "Desc Item Filho"
       tt-sequencia.qtde  (total ) 
       WITH FRAME f1 WIDTH 200 DOWN.
   contador = contador + 1.

END.

RUN pdf_close("Spdf").
