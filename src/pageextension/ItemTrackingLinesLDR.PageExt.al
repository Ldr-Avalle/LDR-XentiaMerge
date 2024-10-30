pageextension 50068 "Item Tracking Lines_LDR" extends "Item Tracking Lines"
{
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.Validate("Quantity (Base)", 1);
    end;
}
