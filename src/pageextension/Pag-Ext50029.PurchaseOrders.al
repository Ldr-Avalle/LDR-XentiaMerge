pageextension 50029 "Purchase Orders" extends "Purchase Orders"
{
    layout
    {
        addafter("Description")
        {
            field(Retenible; Rec.Retenible)
            {
                ApplicationArea = All;
            }
        }
    }
}
