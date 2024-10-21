tableextension 50003 Customer_LDR extends Customer
{
    DataCaptionFields = Blocked;

    fields
    {
        modify("No.")
        {
            Caption = 'NIF/NIE/CIF';

            trigger OnBeforeValidate()
            begin
                if xRec."No." = '0' then
                    FieldError("No.");
                Validate("VAT Registration No.", "No.");
            end;
        }
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Grupo contable negocio';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'Grupo registro IVA neg.';
        }
        field(50000; "Phone No. 2"; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Nº teléfono 2';
            Description = 'Sercable';
        }
        field(50001; "Facturae allowed"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Permitir Facturae';
            Description = 'Sercable';
        }
        field(50002; "Facturae Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Tipo Facturae';
            Description = 'Sercable';
            OptionMembers = fe31,fe32;
        }
        field(50003; "Customer Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Tipo de cliente';
            Description = 'Sercable';
            OptionMembers = "Jurídica","Física";
        }
        field(50004; "Accounting office"; Text[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Oficina contable';
            Description = 'Sercable';
        }
        field(50005; "Management agency"; Text[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Órgano gestor';
            Description = 'Sercable';
        }
        field(50006; "Transaction unit"; Text[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unidad tramitadora';
            Description = 'Sercable';
        }
        field(50705; "Excluir del 347"; Boolean)
        {
            Caption = 'Excluir del 347';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
        }
        field(50706; IDType; Enum TbaiTiposIdentificacion)
        {
            Caption = 'Tipo de identificación';
            DataClassification = ToBeClassified;
            Description = 'TBAI_AL_01';
        }
        field(50707; ID_LDR; Code[20])
        {
            Caption = 'ID_LDR';
            DataClassification = ToBeClassified;
            Description = 'TBAI_AL_01';
        }
        field(50909; "Factura Simplificada"; Enum TbaiNS)
        {
            DataClassification = ToBeClassified;
            Caption = 'Factura Simplificada';
            Description = 'TBAI_AL_01 factura simplificada';
        }
    }

    trigger OnAfterInsert()
    begin
        Validate("VAT Registration No.", "No.");
        "Gen. Bus. Posting Group" := 'NACIONAL';
        "VAT Bus. Posting Group" := 'NACIONAL';
        "Customer Posting Group" := 'NAC';
        "Country/Region Code" := 'ES';
        "Payment Terms Code" := 'CON';
        Validate("Prices Including VAT", true);
    end;
}