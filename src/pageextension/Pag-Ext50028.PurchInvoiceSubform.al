pageextension 50028 "Purch. Invoice Subform" extends "Purch. Invoice Subform"
{
    layout
    {
        addafter("Variant Code")
        {
            field(Retenible; Rec.Retenible)
            {
                ApplicationArea = All;
            }
        }
    }
}
