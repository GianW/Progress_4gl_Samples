def input parameter p-banco   as char    no-undo.
def input parameter p-tabela  as char    no-undo.
def input parameter p-rowid   as rowid   no-undo.
def input parameter p-arquivo as char    no-undo.
def input parameter p-abre    as logical no-undo.

def var h-query  as handle no-undo.
def var h-buffer as handle no-undo.

create query h-query.
h-query:set-buffers(p-tabela).
h-query:query-prepare("for each " + p-banco + "." + p-tabela + " where rowid(" + p-banco + "." + p-tabela + ") = to-rowid('" + string(p-rowid) + "') no-lock").
h-query:query-open.

h-buffer = h-query:get-buffer-handle().

output to value(p-arquivo) no-convert.

repeat:
    h-query:get-next().
    IF h-query:query-off-end
        then leave.

    for each mglistacamp._file where
             mglistacamp._file._file-name = p-tabela no-lock,
        each mglistacamp._field use-index _field-position where
             mglistacamp._field._file-recid = recid(mglistacamp._file) no-lock:
        put unformatted ((if mglistacamp._field._label <> ? then mglistacamp._field._label else "") + " (" + mglistacamp._field._field-name + "):") format "x(70)"
                        h-buffer:buffer-field(mglistacamp._field._field-name):buffer-value skip.
    end.
end.

output close.

if p-abre then
    os-command no-wait value("notepad " + p-arquivo).

h-query:query-close().
delete object h-query.
