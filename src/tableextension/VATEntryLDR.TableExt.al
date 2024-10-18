tableextension 50166 "VATEntry_LDR" extends "VAT Entry"
{
    fields
    {
        field(50000; "On Deposit"; Boolean)
        {
            Caption = 'On Deposit';
            Description = 'SERCABLE';
        }
        field(50001; "Shop Code"; Text[30])
        {
            Caption = 'Shop Code';
            Description = 'SERCABLE';
        }
    }
}