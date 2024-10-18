table 50027 "IDI_LDR"
{
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Código';
            DataClassification = ToBeClassified;
        }
        field(2; Employee; Code[20])
        {
            Caption = 'Empleado';
            DataClassification = ToBeClassified;
        }
        field(3; Proyecto; Code[20])
        {
            Caption = 'Proyecto';
            DataClassification = ToBeClassified;
        }
        field(4; "Año"; Decimal)
        {
            Caption = 'Año';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
        }
        field(5; Mes; Option)
        {
            Caption = 'Mes';
            DataClassification = ToBeClassified;
            OptionCaption = '';
            OptionMembers = mes;
        }
        field(6; "Coste/Hora present."; Decimal)
        {
            Caption = 'Coste/Hora present.';
            DataClassification = ToBeClassified;
        }
        field(7; "% Dedicación present."; Decimal)
        {
            Caption = '% Dedicación present.';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(8; "Horas present."; Decimal)
        {
            Caption = 'Horas present.';
            DataClassification = ToBeClassified;
        }
        field(9; "Coste horas present."; Decimal)
        {
            Caption = 'Coste horas present.';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(10; Actividad; Text[30])
        {
            Caption = 'Actividad';
            DataClassification = ToBeClassified;
        }
        field(11; Hito; Text[30])
        {
            Caption = 'Hito';
            DataClassification = ToBeClassified;
        }
        field(12; Name; Text[30])
        {
            Caption = 'Nombre';
            Editable = false;
        }
        field(13; "Second Family Name"; Text[30])
        {
            Caption = 'Nombre segunda familia';
            Editable = false;
        }
        field(14; "First Family Name"; Text[30])
        {
            Caption = 'Nombre primera familia';
            Editable = false;
        }
        field(15; "Project name"; Text[100])
        {
            Caption = 'Nombre proyecto';
            Editable = false;
        }
        field(16; "Coste/Hora just."; Decimal)
        {
            Caption = 'Coste/Hora just.';
            DataClassification = ToBeClassified;
        }
        field(17; "% Dedicación just."; Decimal)
        {
            Caption = '% Dedicación just.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; "Horas just."; Decimal)
        {
            Caption = 'Horas just.';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }
        field(19; "Coste horas just."; Decimal)
        {
            Caption = 'Coste horas just.';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(20; "Justification date"; Date)
        {
            Caption = 'Fecha justificación';
            DataClassification = ToBeClassified;
            Description = 'Fecha en la que se justificón';
            Editable = false;
        }
        field(21; "Justification register date"; Date)
        {
            Caption = 'Fecha just. registrada';
            DataClassification = ToBeClassified;
            Description = 'Fecha en la que se ejecuta el proceso';
            Editable = false;
        }
        field(22; Comments; Text[250])
        {
            Caption = 'Comentarios';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            SumIndexfields = "Coste/Hora present.", "% Dedicación present.", "Horas present.", "Coste horas present.", "Coste/Hora just.", "% Dedicación just.", "Horas just.", "Coste horas just.";
        }
        key(Key2; Employee, "Año", Mes)
        {
            SumIndexfields = "Coste/Hora present.", "% Dedicación present.", "Horas present.", "Coste horas present.", "Coste/Hora just.", "% Dedicación just.", "Horas just.", "Coste horas just.";
        }
        key(Key3; Proyecto, "Año", Mes, Employee)
        {
            SumIndexfields = "Coste/Hora present.", "% Dedicación present.", "Horas present.", "Coste horas present.", "Coste/Hora just.", "% Dedicación just.", "Horas just.", "Coste horas just.";
        }
    }
}