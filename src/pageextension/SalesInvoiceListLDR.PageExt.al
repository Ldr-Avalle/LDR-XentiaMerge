pageextension 50078 "Sales Invoice List_LDR" extends "Sales Invoice List"
{
    trigger OnOpenPage()
    begin
        gbldimensiones.Reset();
        gbldimensiones.SetRange(gbldimensiones.Usuario, UserId);
        if gbldimensiones.FindFirst() then
            Rec.SetRange("Assigned User ID", UserId);
    end;

    var
        gbldimensiones: Record "User Dimensions_LDR";
}
