table 50004 "Employee Contract"
{
    Caption = 'Contrato empleado';
    DrillDownPageID = "Employee Contracts List";
    LookupPageID = "Employee Contracts List";

    fields
    {
        field(1; Employee; Code[20])
        {
            Caption = 'Empleado';
            DataClassification = ToBeClassified;
            TableRelation = Employee;
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
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee.Name where("No." = field(Employee)));
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
            TableRelation = "Employment Contract";

            trigger OnValidate()
            var
                EmploymentContract: Record "Employment Contract";
            begin
                if EmploymentContract.Get("Contract type") then
                    if EmploymentContract."Working %" <> 0 then "Working %" := EmploymentContract."Working %";
            end;
        }
        field(6; Duration; DateFormula)
        {
            Caption = 'Duración';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Testfield("Date of hire");
                "Due date" := CalcDate(Duration, "Date of hire" - 1);
                if (Format(Duration) = '') then
                    "Due date" := 0D;
            end;
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
            CalcFormula = Lookup(Employee."Global Dimension 1 Code" where("No." = field(Employee)));
            Enabled = true;
            FieldClass = FlowField;
            //todo: metería el blocked
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            Editable = false;
        }
        field(10; Segment; Code[20])
        {
            Caption = 'Segmento';
            DataClassification = ToBeClassified;
            Enabled = false;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
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

            trigger OnValidate()
            var
                EmployeeIntHist: Record "Employee internal historic_LDR";
                Text0001: Label 'Estás a punto de finalizar este contrato.\¿Deseas finalizar también el registro del histórico interno del empleado?';
                Text0002: Label 'Si deseas reabrir este contrato es posible que necesites volver a activar el histórico interno del empleado.\¿Deseas ver sus registros?';
                Text0003: Label 'Date of hire and duration does not match with expiration date.\%1 - %2';
            begin
                if "Due date" <> 0D then begin
                    Testfield(Duration);
                    if CalcDate(Duration, "Date of hire") <> "Due date" then
                        Error(Text0003, CalcDate(Duration, "Date of hire"), "Due date");

                    if Confirm(Text0001) then begin
                        EmployeeIntHist.Setfilter("Employee No.", '%1', Employee);
                        EmployeeIntHist.Setfilter("End Date", '%1', 0D);
                        if EmployeeIntHist.FindFIRST then begin
                            EmployeeIntHist."end Date" := "Due date";
                            EmployeeIntHist.Modify;
                        end;
                    end;
                end else if Confirm(Text0002) then begin
                    EmployeeIntHist.Setfilter("Employee No.", '%1', Employee);
                    Page.Runmodal(Page::"Employee internal historic", EmployeeIntHist);
                end;
            end;
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
            TableRelation = "Grounds for Termination";

            trigger OnValidate()
            begin
                Testfield("Expiration date");
            end;
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
            TableRelation = Agreement_LDR;
        }
        field(21; "Working center"; Code[20])
        {
            Caption = 'Centro trabajo';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('UNIDADES PRODUCCIÓN'));
        }
        field(22; Work; Code[10])
        {
            Caption = 'Obra';
            DataClassification = ToBeClassified;
            TableRelation = Work_LDR;
        }
        field(23; "Trial period formula"; DateFormula)
        {
            Caption = 'Vencimiento periodo prueba';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Trial period due date" := CalcDate("Trial period formula", "Date of hire" - 1);
            end;
        }
        field(24; "Expiration date"; Date)
        {
            Caption = 'Fecha baja';
            DataClassification = ToBeClassified;
        }
        field(25; "Employee Name2"; Text[50])
        {
            Caption = 'Nombre empleado 2';
            CalcFormula = Lookup(Employee."First Family Name" where("No." = field(Employee)));
            FieldClass = FlowField;
            Editable = false;
        }
        field(26; "Grounds for Term. Name"; Text[100])
        {
            Caption = ' Nombre del motivo';
            CalcFormula = Lookup("Grounds for Termination".Description where(Code = field("Grounds for Term. Code")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(27; "Employee Name3"; Text[50])
        {
            Caption = 'Nombre empleado 3';
            CalcFormula = Lookup(Employee."Second Family Name" where("No." = field(Employee)));
            FieldClass = FlowField;
            Editable = false;
        }
        field(28; Salario; Text[100])
        {
            Caption = 'Salario';
            FieldClass = FlowField;
            CalcFormula = Lookup("Confidential Information".Description where("Employee No." = field(Employee),
                                                                               "Confidential Code" = field(SALARIO)));
            TableRelation = "Confidential Information";
            Editable = false;
        }
    }

    keys
    {
        key(Key1; Employee, "No.")
        {
        }
    }

    trigger OnDelete()
    var
        RHSetup: Record "Human Resources Setup";
    begin
        RHSetup.Get;
        RHSetup.Testfield("Delete employee contracts");
    end;

    trigger OnInsert()
    var
        RHSetup: Record "Human Resources Setup";
#pragma warning disable AL0432
        NoSeriesMgt: Codeunit NoSeriesManagement;
#pragma warning restore AL0432
    begin
        "Creation User ID" := UserId;
        "Creation date" := Today;

        if "No." = '' then begin
            RHSetup.Find('-');
            RHSetup.Testfield("Employee Contract Nos.");
            "No." := NoSeriesMgt.GetNextNo(RHSetup."Employee Contract Nos.", 0D, TRUE);
        end;
    end;

    trigger OnModify()
    begin
        "Last modification User ID" := UserId;
        "Last modification date" := Today;
    end;
}

