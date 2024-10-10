tableextension 50525 "GenJournalLine_LDR" extends "Gen. Journal Line"
{
    fields
    {
        modify("Shortcut Dimension 1 Code")
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        modify("Shortcut Dimension 2 Code")
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Gen. Bus. Posting Group';
        }
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'VAT Bus. Posting Group';
        }
        modify("VAT Prod. Posting Group")
        {
            Caption = 'VAT Prod. Posting Group';
        }
        modify("Bal. VAT Bus. Posting Group")
        {
            Caption = 'Bal. VAT Bus. Posting Group';
        }
        modify("Bal. VAT Prod. Posting Group")
        {
            Caption = 'Bal. VAT Prod. Posting Group';
        }
        modify("IC Partner G/L Acc. No.")
        {
            Caption = 'IC Partner G/L Acc. No.';
        }
        modify("IC Partner Transaction No.")
        {
            Caption = 'IC Partner Transaction No.';
        }
        modify("Job Planning Line No.")
        {
            Caption = 'Job Planning Line No.';
        }
        modify("No. of Depreciation Days")
        {
            Caption = 'No. of Depreciation Days';
        }
        modify("FA Error Entry No.")
        {
            Caption = 'FA Error Entry No.';
        }
    }

    var
        AccTypeNotSupportedErr: Label 'You cannot specify a deferral code for this type of account.';
}