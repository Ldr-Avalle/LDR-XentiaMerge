table 50008 "Employee Training_LDR"
{
    Caption = 'Formación empleado';

    fields
    {
        field(1; "Code"; Integer)
        {
            Caption = 'Código';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Empleado';
            DataClassification = ToBeClassified;
        }
        field(3; Date; Date)
        {
            Caption = 'Fecha';
            DataClassification = ToBeClassified;
        }
        field(4; Type; Option)
        {
            Caption = 'Tipo';
            DataClassification = ToBeClassified;
            OptionCaption = 'PRL,Habilidades comerciales,Producto,Procesos y sistemas';
            OptionMembers = PRL,"Comercial skills",Item,"Processes and systems";
        }
        field(5; Description; Text[250])
        {
            Caption = 'Descripción';
            DataClassification = ToBeClassified;
        }
        field(6; Hours; Decimal)
        {
            Caption = 'Horas';
            DataClassification = ToBeClassified;
        }
        field(14; "Creation User ID"; Code[30])
        {
            Caption = 'Usuario creación';
            DataClassification = ToBeClassified;
        }
        field(15; "Creation date"; Date)
        {
            Caption = 'Fecha creación';
            DataClassification = ToBeClassified;
        }
        field(16; "Last modification User ID"; Code[20])
        {
            Caption = 'Usuario última modificación';
            DataClassification = ToBeClassified;
        }
        field(17; "Last modification date"; Date)
        {
            Caption = 'Fecha última modificación';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Code")
        {
        }
    }
}