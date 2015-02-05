define temp-table cliente 
    FIELD nome      AS char
    FIELD sobrenome AS char.

define var tipoArquivo as char.
define var diretorio   as char.
define var fomatado    as log.
define var cEncoding   as char.

DEFINE VARIABLE httCust AS HANDLE NO-UNDO.
DEFINE VARIABLE lReturnValue AS LOGICAL NO-UNDO.

httCust = TEMP-TABLE cliente:HANDLE.
    
CREATE cliente.
ASSIGN
    cliente.nome      = "Gian"
    cliente.sobrenome = "Winckler".
ASSIGN
    tipoArquivo = "FILE"
    diretorio   = "C:\Temp\ttCust.json"
    fomatado = TRUE
    cEncoding = ?.

lReturnValue = httCust:WRITE-JSON(
    tipoArquivo,
    diretorio,
    fomatado,
    cEncoding).

