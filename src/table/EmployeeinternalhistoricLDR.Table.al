table 50009 "Employee internal historic_LDR"
{
    Caption = 'Histórico interno empleado';

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Empleado';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Project; Code[20])
        {
            Caption = 'Proyecto';
            DataClassification = ToBeClassified;
        }
        field(3; "Production Ud."; Code[20])
        {
            Caption = 'Ud. producción';
            DataClassification = ToBeClassified;
        }
        field(4; County; Code[20])
        {
            Caption = 'Provincia';
            DataClassification = ToBeClassified;
        }
        field(5; "Start Date"; Date)
        {
            Caption = 'Fecha inicio';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(6; "End Date"; Date)
        {
            Caption = 'Fecha fin';
            DataClassification = ToBeClassified;
        }
        field(14; "Creation User ID"; Code[20])
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
        field(18; "Employee Name"; Text[30])
        {
            Caption = 'Nombre empleado';
            Editable = false;
        }
        field(19; "Employee 2º Name"; Text[30])
        {
            Caption = '2º Nombre empleado';
            Editable = false;
        }
        field(20; Segmento; Code[20])
        {
            Caption = 'Segmento';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Start Date")
        {
        }
    }
}