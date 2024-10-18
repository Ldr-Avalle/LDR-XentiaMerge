tableextension 50049 "PurchRcptHeader_LDR" extends "Purch. Rcpt. Header"
{
    DataCaptionFields = "Applies-to Doc. Type";
    fields
    {
        field(50001; "Total albarán"; Decimal)
        {
            Description = 'SERCABLE';
        }
        field(50008; "Posting Hour"; Time)
        {
            Description = 'TBAI_AL_01';
        }
    }

    keys
    {
        key(Key7; "Document Date", "No.")
        {
        }
    }
}
