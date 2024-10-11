tableextension 50206 "VATPostingSetup_LDR" extends "VAT Posting Setup"
{
    fields
    {
        modify("VAT Bus. Posting Group")
        {
            Caption = 'VAT Bus. Posting Group';
        }
        modify("VAT Prod. Posting Group")
        {
            Caption = 'VAT Prod. Posting Group';
        }
    }

    var
        Text10700: Label 'The %1 for %2 No Taxable VAT must be 0.';
        Text1100000: Label 'The %1 for %2 No Taxable VAT must be 0.';
        Text1100001: Label 'The %1 for %2 Not Taxable VAT must be 0.';
}