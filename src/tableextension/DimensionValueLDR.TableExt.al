tableextension 50216 DimensionValue_LDR extends "Dimension Value"
{
    trigger OnAfterInsert()
    var
        GLSetup: Record "General Ledger Setup";
    begin
        //todo: no se para que vale, yo lo quitaria
        GLSetup.GET;
        IF GLSetup."Shortcut Dimension 3 Code" = "Dimension Code" THEN
            "Global Dimension No." := 3;
        IF GLSetup."Shortcut Dimension 4 Code" = "Dimension Code" THEN
            "Global Dimension No." := 4;
        IF GLSetup."Shortcut Dimension 5 Code" = "Dimension Code" THEN
            "Global Dimension No." := 5;
    end;

    trigger OnAfterModify()
    var
        GLSetup: Record "General Ledger Setup";
    begin
        //todo: no se para que vale, yo lo quitaria
        GLSetup.GET;
        IF GLSetup."Shortcut Dimension 3 Code" = "Dimension Code" THEN
            "Global Dimension No." := 3;
        IF GLSetup."Shortcut Dimension 4 Code" = "Dimension Code" THEN
            "Global Dimension No." := 4;
        IF GLSetup."Shortcut Dimension 5 Code" = "Dimension Code" THEN
            "Global Dimension No." := 5;
    end;
}
