tableextension 50071 "PurchCrMemoLine_LDR" extends "Purch. Cr. Memo Line"
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
        // key(Key6; "VAT Prod. Posting Group")
        // {
        // }
    }
}