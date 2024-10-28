pageextension 50032 "Purch. Cr. Memo Subform" extends "Purch. Cr. Memo Subform"
{
    layout
    {
        addafter("Bin Code")
        {
            field(Retenible; Rec.Retenible)
            {
                ApplicationArea = All;
            }
        }
    }
}
