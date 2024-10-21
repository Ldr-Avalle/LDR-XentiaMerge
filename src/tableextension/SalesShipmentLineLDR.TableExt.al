tableextension 50035 SalesShipmentLine_LDR extends "Sales Shipment Line"
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
            Caption = 'Grupo contable negocio';
        }
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Grupo contable producto';
        }
        modify("Area")
        {
            Caption = 'Cód. provincia';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'Grupo registro IVA neg.';
        }
        modify("VAT Prod. Posting Group")
        {
            Caption = 'Grupo registro IVA prod.';
        }
    }
}