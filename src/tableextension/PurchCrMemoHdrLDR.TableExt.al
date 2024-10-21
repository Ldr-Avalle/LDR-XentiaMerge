tableextension 50068 PurchCrMemoHdr_LDR extends "Purch. Cr. Memo Hdr."
{
    fields
    {
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Grupo contable negocio';
        }
        modify("Area")
        {
            Caption = 'Cód. provincia';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'Grupo registro IVA neg.';
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

    trigger OnAfterInsert()
    begin
        Rec."Posting Hour" := Time;
    end;

    var
        PostPurchLinesDelete: Codeunit "PostPurch-Delete";
}