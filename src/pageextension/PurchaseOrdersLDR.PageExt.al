pageextension 50029 "Purchase Orders_LDR" extends "Purchase Orders"
{
    layout
    {
        addafter("Description")
        {
            field(Retenible_LDR; Rec.Retenible)
            {
                ApplicationArea = All;
            }
        }
    }
}
