tableextension 50244 "PurchaseLine_LDR" extends "Purchase Line"
{
    fields
    {
        field(50005; Retenible; Boolean)
        {
            Description = 'Indica si la línea está sujeta a retención o no';
        }
    }
    keys
    {
        key(Key25; "Document Type", "Shortcut Dimension 1 Code", "No.", Type, "Expected Receipt Date")
        {
            SumIndexFields = "Outstanding Qty. (Base)";
        }
    }
}