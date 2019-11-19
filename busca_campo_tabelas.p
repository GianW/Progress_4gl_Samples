DEF VAR nomeCampo AS CHAR NO-UNDO.
DEF VAR cont AS INT NO-UNDO.

UPDATE nomeCampo LABEL "Pesquisar campo:".

for each _field where
         _field._field-name = nomeCampo NO-LOCK,
    FIRST _file where
      recid(_file) = _field._file-recid NO-LOCK:

    
        DISP _field._Field-Name _file._File-Name .    
        cont = cont + 1.
    
END.

DISP cont LABEL "Total de tabelas".
