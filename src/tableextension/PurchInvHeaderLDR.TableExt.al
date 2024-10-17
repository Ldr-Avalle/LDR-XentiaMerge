tableextension 50056 "PurchInvHeader_LDR" extends "Purch. Inv. Header"
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
        key(Key10; "Document Date", "No.")
        {
        }
    }

    trigger OnAfterInsert()
    begin
        rec."Posting Hour" := Time;
    end;

    var
        PostPurchLinesDelete: Codeunit "PostPurch-Delete";
}
