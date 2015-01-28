DEFINE VARIABLE c-file AS CHARACTER  NO-UNDO. 
DEFINE VARIABLE c-linha AS CHARACTER  NO-UNDO.
DEFINE STREAM s-entrada.

define temp-table tt-importa-conteudo no-undo
    field   c-estab         as char     format "x(5)" label "Estab"    
    field   c-matricula     as int      format ">>>>>>>9" label "Matricula"
    field   c-valor         as decimal label "Valor"
    field   c-nome          as char    format "x(40)" label "Nome".        

assign
    c-file = "C:\Users\giancarlo.winckler\Desktop\conferencia1.csv".

INPUT STREAM s-entrada FROM VALUE(c-file).

REPEAT:
    IMPORT STREAM s-entrada UNFORMATTED c-linha.
 
    /*Onde entry e o que vem antes da primeira ocorrencia do caracter na linha */
    if entry(1, c-linha, ";") <> "EST"  AND
       entry(1, c-linha, ";") <> ""     then do:
       
        create tt-importa-conteudo.
        assign
            c-estab         = trim(entry(1, c-linha, ";"))
            c-matricula     = int(entry(2, c-linha, ";"))  
            c-valor         = decimal( entry(9, c-linha, ";") )
            c-nome          = entry(3, c-linha, ";")
            l-event-419     = no
            l-event-803     = no.

    end. 
end.

