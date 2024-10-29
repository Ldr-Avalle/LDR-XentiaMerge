pageextension 50080 "Purchase Order List" extends "Purchase Order List"
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
        gbldimensiones.RESET;
        gbldimensiones.SETRANGE(gbldimensiones.Usuario, USERID);
        IF gbldimensiones.FINDFIRST THEN
            rec.SETRANGE("Assigned User ID", USERID);
    end;

    var
        gbldimensiones: Record 50000;
}
