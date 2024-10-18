table 50012 Work_LDR
{
    Caption = 'Obra';

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Código';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Descripción';
            DataClassification = ToBeClassified;
        }
        field(3; "No. of Contracts"; Integer)
        {
            Caption = 'Nº contratos';
            FieldClass = FlowField;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }
}