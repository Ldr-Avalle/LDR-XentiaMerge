tableextension 50071 PurchCrMemoLine_LDR extends "Purch. Cr. Memo Line"
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
        field(50005; Retenible; Boolean)
        {
            Description = 'Indica si la línea está sujeta a retención o no';
            trigger OnValidate()
            begin
                if (Type <> Type::"G/L Account") then
                    Error('Solo pueden estar sujetas a retención las líneas de Cuenta');
            end;
        }
    }
    keys
    {
        key(Key6; "VAT Prod. Posting Group")
        {
        }
    }
}