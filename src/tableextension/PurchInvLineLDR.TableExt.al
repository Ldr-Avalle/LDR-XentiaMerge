tableextension 50063 "PurchInvLine_LDR" extends "Purch. Inv. Line"
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
        // key(Key7; "VAT Prod. Posting Group")
        // {
        // }
    }
}
