tableextension 50164 "VendorLedgerEntry_LDR" extends "Vendor Ledger Entry"
{
    fields
    {
        modify("Closed by Entry No.")
        {
            Caption = 'Closed by Entry No.';
        }
        modify("Amount to Apply")
        {
            Caption = 'Amount to Apply', Comment = 'ESP="Importe pendiente a liquidar"';
        }
        modify("Reversed by Entry No.")
        {
            Caption = 'Reversed by Entry No.';
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
        Text000: Label 'must have the same sign as %1';
        Text001: Label 'must not be larger than %1';
}
