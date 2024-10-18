tableextension 50068 "PurchCrMemoHdr_LDR" extends "Purch. Cr. Memo Hdr."
{
    fields
    {
        field(50008; "Posting Hour"; Time)
        {
            Description = 'TBAI_AL_01';
        }
    }
    keys
    {
        key(Key9; "Document Date", "No.")
        {
        }
    }
}