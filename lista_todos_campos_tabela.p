find first customer no-lock.
 
run pi-lista-campos(input "mgesp",
                    input "customer",
                    input rowid(customer),
                    input "c:\temp\teste-lista-campos.txt",
                    input yes).
 
procedure pi-lista-campos.
    def input parameter p-banco   as char    no-undo.
    def input parameter p-tabela  as char    no-undo.
    def input parameter p-rowid   as rowid   no-undo.
    def input parameter p-arquivo as char    no-undo.
    def input parameter p-abre    as logical no-undo.
    
    create alias mglistacamp for database value(p-banco).
    run lista_todos_campos_tabela_dois.p  (input p-banco,
                                           input p-tabela,
                                           input p-rowid,
                                           input p-arquivo,
                                           input p-abre).
    delete alias mglistacamp.

end procedure.

