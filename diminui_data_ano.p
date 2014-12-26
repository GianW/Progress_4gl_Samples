def var da-dt-ini as date.

assign
    da-dt-ini = add-interval(today, -12, "months").

MESSAGE da-dt-ini
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
