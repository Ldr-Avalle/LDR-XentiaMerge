pageextension 50032 "Purch. Cr. Memo Subform_LDR" extends "Purch. Cr. Memo Subform"
{
    layout
    {
        addafter("Bin Code")
        {
            field(Retenible_LDR; Rec.Retenible)
            {
                ApplicationArea = All;
            }
        }
    }
}
