table 50027 IDI_LDR
{
    DrillDownPageID = IDI;
    LookupPageID = IDI;

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
            TableRelation = Employee;
        }
        field(3; Proyecto; Code[20])
        {
            Caption = 'Proyecto';
            DataClassification = ToBeClassified;
            TableRelation = Job;
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
            OptionMembers = Enero,Febrero,Marzo,Abril,Mayo,Junio,Julio,Agosto,Septiembre,Octubre,Noviembre,Diciembre;
        }
        field(6; "Coste/Hora present."; Decimal)
        {
            Caption = 'Coste/Hora present.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Coste horas present." := "Horas present." * "Coste/Hora present.";
            end;
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

            trigger OnValidate()
            var
                JobSetup: Record "Jobs Setup";
            begin
                JobSetup.Get;
                JobSetup.Testfield("Max. IDi hours per month");
                if "Horas just." > JobSetup."Max. IDi hours per month" then
                    JobSetup.FieldError("Max. IDi hours per month");

                "% Dedicación present." := "Horas present." / JobSetup."Max. IDi hours per month";
                "Coste horas present." := "Horas present." * "Coste/Hora present.";
            end;
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
            CalcFormula = Lookup(Employee.Name where("No." = field(Employee)));
            Caption = 'Nombre';
            Editable = false;
            fieldClass = Flowfield;
        }
        field(13; "Second Family Name"; Text[30])
        {
            CalcFormula = Lookup(Employee."Second Family Name" where("No." = field(Employee)));
            Caption = 'Nombre segunda familia';
            Editable = false;
            fieldClass = Flowfield;
        }
        field(14; "First Family Name"; Text[30])
        {
            CalcFormula = Lookup(Employee."First Family Name" where("No." = field(Employee)));
            Caption = 'Nombre primera familia';
            Editable = false;
            fieldClass = Flowfield;
        }
        field(15; "Project name"; Text[100])
        {
            CalcFormula = Lookup(Job.Description where("No." = field(Proyecto)));
            Caption = 'Nombre proyecto';
            Editable = false;
            fieldClass = Flowfield;
            TableRelation = Job;
        }
        field(16; "Coste/Hora just."; Decimal)
        {
            Caption = 'Coste/Hora just.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Coste horas just." := "Horas just." * "Coste/Hora just.";
            end;
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

            trigger OnValidate()
            var
                JobSetup: Record "Jobs Setup";
            begin
                JobSetup.Get;
                JobSetup.Testfield("Max. IDI hours per month");
                if "Horas just." > JobSetup."Max. IDi hours per month" then JobSetup.fieldERROR("Max. IDi hours per month");

                "% Dedicación just." := "Horas just." / JobSetup."Max. IDi hours per month";
                "Coste horas just." := "Horas just." * "Coste/Hora just.";
            end;
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

    trigger OnDelete()
    begin
        Testfield("Justification register date", 0D);
    end;

    trigger OnInsert()
    var
        IDI: Record IDI_LDR;
    begin
        if Code = '' then
            if IDI.FindLast() then
                Code := IncStr(IDI.Code)
            ELSE
                Code := '00001';
        Proyecto := '13P0001'
    end;

    trigger OnModify()
    begin
        Testfield("Justification register date", 0D);
    end;
}

