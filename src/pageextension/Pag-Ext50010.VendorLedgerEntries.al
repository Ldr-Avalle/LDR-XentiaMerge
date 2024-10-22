pageextension 50010 "Vendor Ledger Entries" extends "Vendor Ledger Entries"
{
    layout
    {
        addafter("Vendor No.")
        {
            field(Name; Rec.Name)
            {
                ApplicationArea = All;
            }
        }
    }
}
