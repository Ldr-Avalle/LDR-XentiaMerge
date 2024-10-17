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
        field(50091; TipoNoExenta; enum TbaiTipoNoExenta)
        {
            Description = 'TBAI_AL_01 TipoNoExenta';
        }
    }
    keys
    {
        key(Key12; "VAT Prod. Posting Group")
        {
        }
    }
}