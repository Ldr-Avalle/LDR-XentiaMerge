pageextension 50009 "Customer Ledger Entries" extends "Customer Ledger Entries"
{
    layout
    {
        addafter(Open)
        {
            field(FacturaFin; Rec.FacturaFin)
            {
                ApplicationArea = All;
            }
        }
    }
}
