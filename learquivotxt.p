DEFINE VARIABLE c-file AS CHARACTER  NO-UNDO. /* nome do arquivo completo diretório + arquivo*/
DEFINE VARIABLE c-linha AS CHARACTER  NO-UNDO. /* linha que está sendo lida*/
DEFINE STREAM s-entrada.

INPUT STREAM s-entrada FROM VALUE(c-file).

REPEAT:
        IMPORT STREAM s-entrada UNFORMATTED c-linha.
END.
