pageextension 50026 "Purchase List" extends "Purchase List"
{
    layout
    {
        addafter("Buy-from Contact")
        {
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
        }
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = All;
            Visible = false;
            trigger OnLookup(var Text: Text): Boolean
            begin
                DimMgt.LookupDimValueCodeNoUpdate(1);
            end;
        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = All;
            Visible = false;
            trigger OnLookup(var Text: Text): Boolean
            begin
                DimMgt.LookupDimValueCodeNoUpdate(2);
            end;
        }
    }
    trigger OnOpenPage()
    begin
        gbldimensiones.RESET;
        gbldimensiones.SETRANGE(gbldimensiones.Usuario, USERID);
        IF gbldimensiones.FINDFIRST THEN
            rec.SETRANGE("Assigned User ID", USERID);
    end;

    VAR
        DimMgt: Codeunit 408;
        gbldimensiones: Record 50000;
}
