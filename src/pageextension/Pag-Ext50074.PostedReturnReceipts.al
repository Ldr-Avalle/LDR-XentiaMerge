pageextension 50074 "Posted Return Receipts" extends "Posted Return Receipts"
{
    trigger OnOpenPage()
    begin
        gbldimensiones.RESET;
        gbldimensiones.SETRANGE(gbldimensiones.Usuario, USERID);
        IF gbldimensiones.FINDFIRST THEN
            rec.SETRANGE("User ID", USERID);
    end;

    var
        gbldimensiones: Record 50000;
}
