table 50004 "Employee Contract"
{
    Caption = 'Contrato empleado';

    fields
    {
        field(1; Employee; Code[20])
        {
            Caption = 'Empleado';
            DataClassification = ToBeClassified;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Employee Name"; Text[50])
        {
            Caption = 'Nombre';
            Editable = false;
        }
        field(4; "Date of hire"; Date)
        {
            Caption = 'Fecha alta';
            DataClassification = ToBeClassified;
        }
        field(5; "Contract type"; Code[20])
        {
            Caption = 'Tipo contrato';
            DataClassification = ToBeClassified;
        }
        field(6; Duration; DateFormula)
        {
            Caption = 'Duración';
            DataClassification = ToBeClassified;
        }
        field(7; "Working %"; Integer)
        {
            Caption = '% Jornada';
            DataClassification = ToBeClassified;
            MaxValue = 100;
            MinValue = 0;
        }
        field(8; "Working Time"; Text[50])
        {
            Caption = 'Horario laboral';
            DataClassification = ToBeClassified;
        }
        field(9; Project; Code[20])
        {
            Caption = 'Proyecto';
            Enabled = true;
            Editable = false;
        }
        field(10; Segment; Code[20])
        {
            Caption = 'Segmento';
            DataClassification = ToBeClassified;
            Enabled = false;
        }
        field(11; Demarcation; Option)
        {
            Caption = 'Demarcación';
            DataClassification = ToBeClassified;
            Enabled = false;
            OptionCaption = ' ,Gijón,Oviedo,Avilés';
            OptionMembers = " ","Gijón",Oviedo,"Avilés";
        }
        field(12; "Trial period due date"; Date)
        {
            Caption = 'Fecha venc. per. prueba';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Due date"; Date)
        {
            Caption = 'Fecha vencimiento';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Creation User ID"; Code[30])
        {
            Caption = 'Creación usuario id';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Creation date"; Date)
        {
            Caption = 'Fecha creación';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16; "Last modification User ID"; Code[30])
        {
            Caption = 'Última modificación usuario id';
            DataClassification = ToBeClassified;
        }
        field(17; "Last modification date"; Date)
        {
            Caption = 'Última modificación fecha';
            DataClassification = ToBeClassified;
        }
        field(18; "Grounds for Term. Code"; Code[10])
        {
            Caption = 'Grounds for Term. Code';
            DataClassification = ToBeClassified;
        }
        field(19; Category; Option)
        {
            Caption = 'Categoría';
            DataClassification = ToBeClassified;
            OptionMembers = "Aydte depta",Comercial,Dependienta,Promotor,Visitador,"Jefe de proyecto",Director,Viajante,"Jefe secci´Š¢n";
        }
        field(20; Agreement; Code[50])
        {
            Caption = 'Convenio';
            DataClassification = ToBeClassified;
        }
        field(21; "Working center"; Code[20])
        {
            Caption = 'Centro trabajo';
            DataClassification = ToBeClassified;
        }
        field(22; Work; Code[10])
        {
            Caption = 'Obra';
            DataClassification = ToBeClassified;
        }
        field(23; "Trial period formula"; DateFormula)
        {
            Caption = 'Vencimiento periodo prueba';
            DataClassification = ToBeClassified;
        }
        field(24; "Expiration date"; Date)
        {
            Caption = 'Fecha baja';
            DataClassification = ToBeClassified;
        }
        field(25; "Employee Name2"; Text[50])
        {
            Caption = 'Nombre empleado 2';
            Editable = false;
        }
        field(26; "Grounds for Term. Name"; Text[100])
        {
            Caption = ' Nombre del motivo';
            Editable = false;
        }
        field(27; "Employee Name3"; Text[50])
        {
            Caption = 'Nombre empleado 3';
            Editable = false;
        }
        field(28; Salario; Text[100])
        {
            Caption = 'Salario';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; Employee, "No.")
        {
        }
    }
}