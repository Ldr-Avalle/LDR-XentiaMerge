pageextension 50079 "Sales Credit Memos" extends "Sales Credit Memos"
{
    trigger OnOpenPage()
    begin
        gbldimensiones.RESET;
        gbldimensiones.SETRANGE(gbldimensiones.Usuario, USERID);
        IF gbldimensiones.FINDFIRST THEN
            rec.SETRANGE("Assigned User ID", USERID);
    end;

    var
        gbldimensiones: Record 50000;
}
