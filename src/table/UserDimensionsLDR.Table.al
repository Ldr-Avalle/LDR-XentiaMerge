table 50000 "User Dimensions_LDR"
{
    Caption = 'Dimensiones de usuario';

    fields
    {
        field(1; User; Text[250])
        {
            Caption = 'Usuario';
            DataClassification = ToBeClassified;
        }
        field(2; "Project Dimension Value"; Code[20])
        {
            Caption = 'Valor dimensión proyecto';
            DataClassification = ToBeClassified;
        }
        field(3; "Provincias Dimension Value"; Code[20])
        {
            Caption = 'Valor dimensión provincias';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(4; "Unidades Prod  Dimension Value"; Code[20])
        {
            Caption = 'Valor dimensión unidades producción';
            DataClassification = ToBeClassified;
        }
        field(5; "Location Code"; Code[10])
        {
            Caption = 'Cód ubicación';
            DataClassification = ToBeClassified;
        }
        field(7; "Shop Address"; Text[100])
        {
            Caption = 'Dirección tienda';
            DataClassification = ToBeClassified;
        }
        field(8; "Segmento Dimension Value"; Code[20])
        {
            Caption = 'Valor dimensión segmento';
            DataClassification = ToBeClassified;
        }
        field(9; "Shop Code"; Text[30])
        {
            Caption = 'Cód tienda';
            DataClassification = ToBeClassified;
        }
        field(10; Usuario; Code[50])
        {
            Caption = 'Usuario';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; User)
        {
        }
    }
}