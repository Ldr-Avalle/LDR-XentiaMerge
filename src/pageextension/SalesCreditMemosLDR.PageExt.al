pageextension 50079 "Sales Credit Memos_LDR" extends "Sales Credit Memos"
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
