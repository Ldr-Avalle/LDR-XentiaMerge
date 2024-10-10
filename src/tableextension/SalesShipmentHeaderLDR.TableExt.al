tableextension 50026 SalesShipmentHeader_LDR extends "Sales Shipment Header"
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
        field(50008; "Posting Hour"; Time)
        {
            Description = 'TBAI_AL_01';
        }
    }
}