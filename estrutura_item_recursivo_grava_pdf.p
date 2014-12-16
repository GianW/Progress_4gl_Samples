{PDFinclude/pdf_inc.i}
DEFINE VARIABLE c-cod-item          LIKE estrutura.it-codigo.
DEFINE VARIABLE c-cod-dig           LIKE estrutura.it-codigo.
DEFINE VARIABLE c-desc-aux          LIKE item.desc-item.
DEFINE VARIABLE i-quantidade-aux    AS INT INITIAL 1.
DEFINE VARIABLE i-contador          AS INT INITIAL 0 NO-UNDO.
DEFINE VARIABLE i-contador-aux      AS INT INITIAL 720 NO-UNDO.
DEFINE VARIABLE i-verificador       AS INT INITIAL 0 NO-UNDO.
DEFINE VARIABLE i-quantidade-dig    AS INT INITIAL 1.

DEFINE TEMP-TABLE tt-sequencia NO-UNDO
       FIELD item           LIKE estrutura.it-codigo
       FIELD item-filho     LIKE estrutura.es-codigo
       FIELD qtde           LIKE estrutura.quant-usada 
       FIELD pai-desc       LIKE item.desc-item
       FIELD filho-desc     LIKE item.desc-item format "x(20)"
       FIELD sequencia      LIKE estrutura.sequencia.

UPDATE c-cod-item COLUMN-LABEL "Search for".
UPDATE i-quantidade-dig COLUMN-LABEL "Amount".

c-cod-dig = c-cod-item.

RUN pi-monta-estrutura(c-cod-item, i-quantidade-aux, i-quantidade-dig).



PROCEDURE pi-monta-estrutura:
    DEFINE INPUT PARAMETER c-cod-item  LIKE estrutura.it-codigo.
    DEFINE INPUT PARAMETER i-quantidade-aux AS int.
    DEFINE INPUT PARAMETER i-quantidade-dig AS int.

    FOR EACH estrutura WHERE
             estrutura.it-codigo = c-cod-item NO-LOCK:
    
        FIND tt-sequencia WHERE
             tt-sequencia.item           = estrutura.it-codigo   AND
             tt-sequencia.sequencia      = estrutura.sequencia   AND
             tt-sequencia.item-filho     = estrutura.es-codigo NO-LOCK NO-ERROR.
                
         
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

                RUN pi-monta-estrutura(estrutura.es-codigo, i-quantidade-aux, i-quantidade-dig).
           
        
    END.
END.

    RUN pdf_new  ("Spdf","C:\Temp\recursao.pdf").
    
            /*Tamanho da pagina*/
    RUN pdf_set_PageHeight ("Spdf", 842).
    RUN pdf_set_PageWidth ("Spdf", 760).
    
    RUN pdf_load_image ("Spdf","totLogo","C:\Users\giancarlo.winckler\Desktop\logo-totvs.jpg").

    RUN pdf_new_page        ("Spdf"). /* NOVA PAGINA */
    RUN pdf_stroke_fill     ("Spdf",1.0,1.0,1.0). /*Define cor para o rect*/
    RUN pdf_rect            ("Spdf", 5,5,584,832,2). /* Coluna, Linha, Largura, Comprimento, Espessura*/
    RUN pdf_rect            ("Spdf", 12,740,572,90,1.5). /*Rect cabe‡alho*/
    RUN pdf_rect            ("Spdf", 11,740,90,90,1.5). /*Borda Logo*/
    RUN pdf_place_image     ("Spdf", "totLogo",15, 100, 80, 80). /*Coluna , Linha , Largura , Comprimento*/
    run pdf_set_font        ("Spdf","Helvetica-Bold", 26).
    run pdf_text_align      ("Spdf","Tabela Estrutura", "center", 320, 780 ).
    run pdf_skip            ("Spdf").
    run pdf_set_font        ("Spdf","Helvetica", 14).
    run pdf_text_align      ("Spdf","Item pesquisado:", "right", 280, 760 ).
    run pdf_text_align      ("Spdf",c-cod-dig, "left", 320, 760 ).

FOR EACH tt-sequencia  NO-LOCK:

    i-verificador = i-contador MODULO 2.

          if i-verificador = 1 then do:
              RUN pdf_stroke_fill     ("Spdf",0.6,0.7,0.5).
              RUN pdf_stroke_color    ("Spdf", 1.0,1.0,1.0).
              RUN pdf_rect            ("Spdf", 12,i-contador-aux - 4,570,16,0.5). /* Coluna, Linha, Largura, Comprimento, Espessura*/
          end.

          else do:
                  RUN pdf_stroke_fill     ("Spdf",1.0,1.0,1.0).
                  RUN pdf_stroke_color    ("Spdf", 1.0,1.0,1.0).
                  RUN pdf_rect            ("Spdf", 12,i-contador-aux - 4,570,14,0.5). /* Coluna, Linha, Largura, Comprimento, Espessura*/
          end.
          run pdf_set_font        ("Spdf","Courier", 12).
          run pdf_text_align      ("Spdf",tt-sequencia.item, "left", 20, i-contador-aux).
          run pdf_text_align      ("Spdf", tt-sequencia.pai-desc , "left", 80, i-contador-aux).
          run pdf_text_align      ("Spdf",tt-sequencia.item-filho, "left", 350, i-contador-aux).
          run pdf_text_align      ("Spdf",tt-sequencia.filho-desc , "left", 460, i-contador-aux).
          i-contador = i-contador + 1. 
          i-contador-aux = i-contador-aux - 17.

          if i-contador-aux < 5 then do:
                RUN pdf_new_page        ("Spdf").
                RUN pdf_stroke_fill     ("Spdf",1.0,1.0,1.0). /*Define cor para o rect*/
                RUN pdf_rect            ("Spdf", 5,5,584,832,2). /* Coluna, Linha, Largura, Comprimento, Espessura*/
                RUN pdf_rect            ("Spdf", 12,740,572,90,1.5). /*Rect cabe‡alho*/
                RUN pdf_rect            ("Spdf", 11,740,90,90,1.5). /*Borda Logo*/
                RUN pdf_place_image     ("Spdf", "totLogo",15, 100, 80, 80). /*Coluna , Linha , Largura , Comprimento*/
                run pdf_set_font        ("Spdf","Helvetica-Bold", 26).
                run pdf_text_align      ("Spdf","Tabela Estrutura", "center", 320, 780 ).
                run pdf_skip            ("Spdf").
                run pdf_set_font        ("Spdf","Helvetica", 14).
                run pdf_text_align      ("Spdf","Item pesquisado:", "right", 280, 760 ).
                run pdf_text_align      ("Spdf",c-cod-dig, "left", 320, 760 ).

              i-contador-aux = 720.

          end.


END.
 
RUN pdf_close("Spdf").
