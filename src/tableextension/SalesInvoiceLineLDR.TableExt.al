tableextension 50042 SalesInvoiceLine_LDR extends "Sales Invoice Line"
{
    fields
    {
        modify(Description)
        {
            Description = 'SERCABLE';
        }
        modify("Description 2")
        {
            Description = 'SERCABLE';
        }
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Gen. Bus. Posting Group';
        }
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        modify("Area")
        {
            Caption = 'Area';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'VAT Bus. Posting Group';
        }
        modify("VAT Prod. Posting Group")
        {
            Caption = 'VAT Prod. Posting Group';
        }
        modify("Job Contract Entry No.")
        {
            Caption = 'Job Contract Entry No.';
        }
        field(50000; "Serial No."; Code[20])
        {
            Description = 'SERCABLE';
            trigger OnValidate()
            var
                TrackingSpecification: Record "Tracking Specification";
                TrackingSpecification2: Record "Tracking Specification";
            begin
                TestField(Type, Type::Item);
            end;
        }
        field(50091; TipoNoExenta; Option)
        {
            Description = 'TBAI_AL_01 TipoNoExenta';
            OptionCaption = 'S1 Sin inversión del sujeto pasivo,  S2 Con inversión del sujeto pasivo';
            OptionMembers = S1,S2;
        }
    }
    keys
    {
        key(Key12; "VAT Prod. Posting Group")
        {
        }
    }
}