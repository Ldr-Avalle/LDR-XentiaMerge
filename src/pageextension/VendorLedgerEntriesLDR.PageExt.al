pageextension 50010 "Vendor Ledger Entries_LDR" extends "Vendor Ledger Entries"
{
    layout
    {
        addafter("Vendor No.")
        {
            field(Name_LDR; Rec.Name)
            {
                ApplicationArea = All;
            }
        }
        modify("Reversed Entry No.")
        {
            ApplicationArea = All;
            Editable = true;
        }
        modify("Reversed by Entry No.")
        {
            ApplicationArea = All;
            Editable = true;
        }
        modify("Exported to Payment File")
        {
            ApplicationArea = All;
            Editable = false;
        }
    }
}
