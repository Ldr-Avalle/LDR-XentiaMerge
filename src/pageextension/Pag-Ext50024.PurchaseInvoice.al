pageextension 50024 "Purchase Invoice" extends "Purchase Invoice"
{
    trigger OnAfterGetRecord()
    begin
        rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions(rec."Dimension Set ID", ShortcutDimCode);
    end;

    var
        DimMgt: Codeunit DimensionManagement;
        ShortcutDimCode: ARRAY[8] OF Code[20];
}
