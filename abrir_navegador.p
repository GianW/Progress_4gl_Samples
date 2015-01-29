DEFINE VARIABLE chWeb AS COM-HANDLE NO-UNDO.
DEFINE VARIABLE chWebAppl AS COM-HANDLE NO-UNDO.

CREATE "InternetExplorer.Application.1" chWeb.

ASSIGN chWebAppl = chWeb:APPLICATION
chWebAppl:VISIBLE = TRUE.

chWebAppl:Navigate("www.google.com.br"). 
