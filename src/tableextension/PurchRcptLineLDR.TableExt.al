tableextension 50054 "PurchRcptLine_LDR" extends "Purch. Rcpt. Line"
{
    fields
    {
        field(50001; "Vendor Shipement No."; Code[35])
        {
            Description = 'SERCABLE';
        }
    }
    keys
    {
        key(Key8; "VAT Prod. Posting Group")
        {
        }
    }
}