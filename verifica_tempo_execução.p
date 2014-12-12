DO:
ETIME(yes).
    for each ped-venda no-lock,
        each ped-item where
            ped-item.nr-pedcli = ped-venda.nr-pedcli no-lock:
             DISPLAY (ETIME / 600)" segundos.".
            find item where 
            item.it-codigo = ped-item.it-codigo no-lock no-error.
            
            disp
            ped-venda.nr-pedcli
            ped-item.it-codigo.
    end.
    DISPLAY (ETIME / 600)" segundos.".
END.
