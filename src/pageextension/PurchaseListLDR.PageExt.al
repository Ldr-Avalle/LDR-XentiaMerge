pageextension 50026 "Purchase List_LDR" extends "Purchase List"
{
    layout
    {
        addafter("Buy-from Contact")
        {
            field(Amount_LDR; Rec.Amount)
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
        gbldimensiones.Reset();
        gbldimensiones.SetRange(gbldimensiones.Usuario, UserId);
        if gbldimensiones.FindFirst() then
            Rec.SetRange("Assigned User ID", UserId);
    end;

    var
        DimMgt: Codeunit DimensionManagement;
        gbldimensiones: Record "User Dimensions_LDR";
}
