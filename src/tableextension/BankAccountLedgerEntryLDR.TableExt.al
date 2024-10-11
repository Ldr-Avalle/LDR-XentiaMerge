tableextension 50176 "BankAccountLedgerEntry_LDR" extends "Bank Account Ledger Entry"
{
    fields
    {
        modify("Reversed by Entry No.")
        {
            Caption = 'Reversed by Entry No.';
        }
        field(50099; "Transaction No. BK"; Integer)
        {
            Caption = 'Transaction No. BK';
        }
    }
}
