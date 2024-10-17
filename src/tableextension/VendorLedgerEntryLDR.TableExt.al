tableextension 50164 "VendorLedgerEntry_LDR" extends "Vendor Ledger Entry"
{
    fields
    {
        modify("Closed by Entry No.")
        {
            Caption = 'Cerrado por nº orden.';
        }
        modify("Amount to Apply")
        {
            //Caption = 'Amount to Apply', Comment = 'ESP="Importe pendiente a liquidar"';
            Caption = 'Importe pendiente a liquidar';
        }
        modify("Reversed by Entry No.")
        {
            Caption = 'Revertido por el movimiento nº';
        }
        modify("Creditor No.")
        {
            Caption = 'Nº acreedor';
        }
        modify("Payment Reference")
        {
            trigger OnAfterValidate()
            begin
                if "Payment Reference" <> '' then
                    TestField("Creditor No.");
            end;
        }
        field(50000; Name; Text[80])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field("Vendor No.")));
            Caption = 'Nombre ';
            Description = 'SERCABLE';
            FieldClass = FlowField;
        }
        field(50099; "Transaction No.BK"; Integer)
        {
            Caption = 'Transaction No. BK', Comment = 'ESP="Nº asiento BK"';
        }
    }

    var
        Text000: Label 'debe tener el mismo signo que %1.';
        Text001: Label 'no debe ser mayor que %1.';
}
