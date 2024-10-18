tableextension 50164 "VendorLedgerEntry_LDR" extends "Vendor Ledger Entry"
{
    fields
    {
        field(50000; Name; Text[80])
        {
            Caption = 'Nombre ';
            Description = 'SERCABLE';
        }
        field(50099; "Transaction No.BK"; Integer)
        {
            Caption = 'Transaction No. BK', Comment = 'ESP="Nº asiento BK"';
        }
    }
}