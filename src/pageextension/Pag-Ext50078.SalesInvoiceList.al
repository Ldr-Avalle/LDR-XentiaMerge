pageextension 50078 "Sales Invoice List" extends "Sales Invoice List"
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
