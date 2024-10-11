tableextension 50068 "PurchCrMemoHdr_LDR" extends "Purch. Cr. Memo Hdr."
{
    fields
    {
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Gen. Bus. Posting Group';
        }
        modify("Area")
        {
            Caption = 'Area';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'VAT Bus. Posting Group';
        }
        modify("Vendor Ledger Entry No.")
        {
            Caption = 'Vendor Ledger Entry No.';
        }
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

    var
        PostPurchLinesDelete: Codeunit "364";
}