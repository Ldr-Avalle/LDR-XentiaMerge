tableextension 50146 CustLedgerEntry_LDR extends "Cust. Ledger Entry"
{
    fields
    {
        modify("Amount to Apply")
        {
            Caption = 'Importe pendiente de liquidar';
        }
        modify("Reversed by Entry No.")
        {
            Caption = 'Revertido por el movimiento Nº';
        }
        field(50000; Name; Text[100])
        {
            Caption = 'Nombre';
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer.Name Where("No." = field("Customer No.")));
            Description = 'Sercable';
        }
        field(50099; FacturaFin; Code[20])
        {
            Caption = 'Factura Fin';
            DataClassification = ToBeClassified;
        }
        field(50199; "Transaction No. BK"; Integer)
        {
            Caption = 'Transaction No. BK';
            DataClassification = ToBeClassified;
        }
    }
}