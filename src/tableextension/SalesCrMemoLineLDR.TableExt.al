tableextension 50045 "SalesCrMemoLine_LDR" extends "Sales Cr.Memo Line"
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
    }
}