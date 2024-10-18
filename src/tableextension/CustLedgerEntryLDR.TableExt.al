tableextension 50146 "CustLedgerEntry_LDR" extends "Cust. Ledger Entry"
{
    fields
    {
        field(50000; Name; Text[100])
        {
            Caption = 'Nombre';
            Description = 'Sercable';
            Editable = false;
        }
        field(50099; FacturaFin; Code[20])
        {
            Caption = 'Factura Fin';
            DataClassification = ToBeClassified;
        }
        field(50199; "Transaction No. BK"; Integer)
        {
            Caption = 'Nº asiento Bk';
            DataClassification = ToBeClassified;
        }
    }
}