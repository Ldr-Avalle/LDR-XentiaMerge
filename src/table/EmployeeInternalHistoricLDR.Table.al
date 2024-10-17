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
            TableRelation = Employee;
        }
        field(2; Project; Code[20])
        {
            Caption = 'Proyecto';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));

            trigger OnValidate()
            begin
                AssignProjectDimToEmployee("Employee No.", Project);
            end;
        }
        field(3; "Production Ud."; Code[20])
        {
            Caption = 'Ud. producción';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('UNIDADES PRODUCCIÓN'));
        }
        field(4; County; Code[20])
        {
            Caption = 'Provincia';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('PROVINCIAS'));
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

            trigger OnValidate()
            var
                EmpIntHistoric: Record "Employee internal historic_LDR";
            begin
                if "end Date" <> 0D then
                    AssignProjectDimToEmployee("Employee No.", '')
                else begin
                    if ExistsOpenHistoricForEmployee("Employee No.") then Error(Text0001);
                    AssignProjectDimToEmployee("Employee No.", Project);
                end;
            end;
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
            FieldClass = Flowfield;
            CalcFormula = Lookup(Employee.Name where("No." = field("Employee No.")));
            Editable = false;
        }
        field(19; "Employee 2º Name"; Text[30])
        {
            Caption = '2º Nombre empleado';
            CalcFormula = Lookup(Employee."First Family Name" where("No." = field("Employee No.")));
            FieldClass = Flowfield;
            Editable = false;
        }
        field(20; Segmento; Code[20])
        {
            Caption = 'Segmento';
            DataClassification = ToBeClassified;
            //todo: metería el blocked
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Start Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestField("End Date");
    end;

    trigger OnInsert()
    begin
        TestField("Employee No.");
        if ExistsOpenHistoricForEmployee("Employee No.") then Error(Text0001);

        "Creation User ID" := UserId;
        "Creation date" := Today;
    end;

    trigger OnModify()
    begin
        if (xRec."End Date" <> 0D) and (xRec."End Date" = "End Date") then
            TestField("End Date", 0D);

        "Last modification User ID" := UserId;
        "Last modification date" := Today;
    end;

    var
        Text0001: Label 'Cada empleado no puede tener más de un registro sin fecha de finalización';

    procedure AssignProjectDimToEmployee("Employee No.": Code[20]; "Project Value": Code[20])
    var
        Employee: Record Employee;
    begin
        Rec.TestField("Employee No.");
        Employee.Get("Employee No.");
        Employee."Global Dimension 1 Code" := "Project Value";
        Employee.Modify;
    end;

    procedure ExistsOpenHistoricForEmployee("Employee No.": Code[20]) exists: Boolean
    var
        EmpIntHistoric: Record "Employee internal historic_LDR";
    begin
        EmpIntHistoric.SetFilter("Employee No.", '%1', "Employee No.");
        EmpIntHistoric.SetFilter("End Date", '%1', 0D);
        if EmpIntHistoric.FindFirst then
            exit(true);
        exit(false);
    end;
}

