pageextension 50080 "Purchase Order List_LDR" extends "Purchase Order List"
{
    layout
    {
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
    }
    trigger OnOpenPage()
    begin
        gbldimensiones.Reset;
        gbldimensiones.SetRange(gbldimensiones.Usuario, UserId);
        if gbldimensiones.FindFirst then
            Rec.SetRange("Assigned User ID", UserId);
    end;

    var
        gbldimensiones: Record "User Dimensions_LDR";
}
