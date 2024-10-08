tableextension 50003 "Customer_LDR" extends Customer
{
    fields
    {
        modify("No.")
        {
            Caption = 'NIF/NIE/CIF';
        }
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Gen. Bus. Posting Group';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'VAT Bus. Posting Group';
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
        field(50706; IDType; Option)
        {
            Caption = 'Tipo de identificación';
            DataClassification = ToBeClassified;
            Description = 'TBAI_AL_01';
            OptionCaption = ', 02: NIF-IVA,03: Pasaporte,04: Documento oficial deidentificación expedido por el país o territorio de residencia,05: Certificado de residencia, 06: Otro documento probatorio';
            OptionMembers = ,"NIF-IVA",Pasaporte,"Documento oficial deidentificación expedido por el país o territorio de residencia","Certificado de residencia","Otro documento probatorio";
        }
        field(50707; ID_LDR; Code[20])
        {
            Caption = 'ID_LDR';
            DataClassification = ToBeClassified;
            Description = 'TBAI_AL_01';
        }
        field(50909; "Factura Simplificada"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Factura Simplificada';
            Description = 'TBAI_AL_01 factura simplificada';
            OptionCaption = 'No,Sí';
            OptionMembers = N,S;
        }
    }
}
