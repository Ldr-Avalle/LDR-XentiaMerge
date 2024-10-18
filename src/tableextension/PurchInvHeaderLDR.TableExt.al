tableextension 50056 "PurchInvHeader_LDR" extends "Purch. Inv. Header"
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
        key(Key10; "Document Date", "No.")
        {
        }
    }
}
