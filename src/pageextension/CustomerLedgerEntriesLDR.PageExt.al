pageextension 50009 "Customer Ledger Entries_LDR" extends "Customer Ledger Entries"
{
    layout
    {
        addafter(Open)
        {
            field(FacturaFin_LDR; Rec.FacturaFin)
            {
                ApplicationArea = All;
            }
        }
        modify(Reversed)
        {
            ApplicationArea = All;
            Editable = true;
        }
        modify("Reversed by Entry No.")
        {
            ApplicationArea = All;
            Editable = true;
        }
        modify("Reversed Entry No.")
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
