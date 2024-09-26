tableextension 50204 ItemLedgerEntry_LDR extends "Item Ledger Entry"
{
    fields
    {
        modify(Description)
        {
            Description = 'Sercable';
        }
        modify("Area")
        {
            Caption = 'Cód. provincia';
        }
        modify("Cost Amount (Actual) (ACY)")
        {
            Caption = 'Importe coste (Real) (DA)';
        }
        field(50000; "On Deposit"; Boolean)
        {
            Caption = 'En depósito';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
        }
    }

    keys
    {
        key(Key10; "Item No.", "Global Dimension 1 Code", "Posting Date")
        {
            SumIndexFields = Quantity;
        }
        key(Key15; "Entry Type", "Global Dimension 1 Code", "Item No.", "Posting Date", "Location Code")
        {
            SumIndexFields = "Invoiced Quantity", Quantity;
        }
    }
}
