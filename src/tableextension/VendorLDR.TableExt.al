tableextension 50153 Vendor_LDR extends Vendor
{
    fields
    {
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Grupo contable negocio';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'Grupo registro IVA neg.';
        }

        modify("Creditor No.")
        {
            trigger OnAfterValidate()
            var
                codeunitTypeHelper: Codeunit "Type Helper";
                err01: Label 'El campo Nº acreedor debe ser numérico.';
            begin
                if not codeunittypehelper.IsNumeric("Creditor No.") then
                    Error(err01);
            end;
        }
        modify("Pay-to No. of Return Orders")
        {
            Caption = 'Pago a-Nº de pedidos de devoluciones';
        }

        field(50004; "Retención"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'SERCABLE';
        }
        field(50005; "No.Cuenta"; Text[20])
        {
            Description = 'SERCABLE';
            TableRelation = "G/L Account"."No.";
        }
        field(50705; "Excluir del 347"; Boolean)
        {
            Description = 'SERCABLE';
        }
    }
    trigger OnAfterInsert()
    begin
        rec."Country/Region Code" := 'ES';
    end;

    var
        Text1100000: Label 'Payment Discount (VAT Adjustment)';
        VendVatRegNo: Record Vendor;
}
