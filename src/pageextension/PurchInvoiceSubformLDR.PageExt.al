pageextension 50028 "Purch. Invoice Subform_LDR" extends "Purch. Invoice Subform"
{
    layout
    {
        addafter("Variant Code")
        {
            field(Retenible_LDR; Rec.Retenible)
            {
                ApplicationArea = All;
            }
        }
    }
}
