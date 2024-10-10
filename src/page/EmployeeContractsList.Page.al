page 50004 "Employee Contracts List"
{
    ApplicationArea = All;
    Caption = 'Lista contratos empleados';
    Editable = false;
    PageType = Card;
    SourceTable = "Employee Contract";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(repeater)
            {
                field(Employee; Rec.Employee)
                {
                    ApplicationArea = All;
                    Caption = 'Employee', Comment = 'ESP="Empleado"';
                    ToolTip = 'Especifica el empleado';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Caption = 'Employee Name', Comment = 'ESP="Nombre"';
                    ToolTip = 'Especifica el nombre';
                }
                field("Employee Name2"; Rec."Employee Name2")
                {
                    ApplicationArea = All;
                    Caption = 'Employee Name2';
                    ToolTip = 'Especifica el employee name2';
                }
                field(Project; Rec.Project)
                {
                    ApplicationArea = All;
                    Caption = 'Project', Comment = 'ESP="Proyecto"';
                    ToolTip = 'Especifica el proyecto';
                }
                field("Employee Name3"; Rec."Employee Name3")
                {
                    ApplicationArea = All;
                    Caption = 'Employee Name3';
                    ToolTip = 'Especifica el employee name3';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.', Comment = 'ESP="Nº"';
                    ToolTip = 'Especifica el nº';
                }
                field("Date of hire"; Rec."Date of hire")
                {
                    ApplicationArea = All;
                    Caption = 'Date of hire', Comment = 'ESP="Fecha alta"';
                    ToolTip = 'Especifica la fecha alta';
                }
                field("Contract type"; Rec."Contract type")
                {
                    ApplicationArea = All;
                    Caption = 'Contract type', Comment = 'ESP="Tipo contrato"';
                    ToolTip = 'Especifica el tipo contrato';
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = All;
                    Caption = 'Duration', Comment = 'ESP="Duración"';
                    ToolTip = 'Especifica la duración';
                }
                field("Working %"; Rec."Working %")
                {
                    ApplicationArea = All;
                    Caption = 'Working %', Comment = 'ESP="% Jornada"';
                    ToolTip = 'Especifica el % jornada';
                }
                field("Working Time"; Rec."Working Time")
                {
                    ApplicationArea = All;
                    Caption = 'Working Time', Comment = 'ESP="Horario laboral"';
                    ToolTip = 'Especifica el horario laboral';
                }
                field("Working center"; Rec."Working center")
                {
                    ApplicationArea = All;
                    Caption = 'Working center', Comment = 'ESP="Centro trabajo"';
                    ToolTip = 'Especifica el centro trabajo';
                }
                field("Trial period due date"; Rec."Trial period due date")
                {
                    ApplicationArea = All;
                    Caption = 'Trial period due date', Comment = 'ESP="Fecha venc. per. prueba"';
                    ToolTip = 'Especifica la fecha venc. per. prueba';
                }
                field("Due date"; Rec."Due date")
                {
                    ApplicationArea = All;
                    Caption = 'Due date', Comment = 'ESP="Fecha vencimiento"';
                    ToolTip = 'Especifica la fecha vencimiento';
                }
                field("Expiration date"; Rec."Expiration date")
                {
                    ApplicationArea = All;
                    Caption = 'Expiration date', Comment = 'ESP="Fecha baja"';
                    ToolTip = 'Especifica la fecha baja';
                }
                field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                {
                    ApplicationArea = All;
                    Caption = 'Grounds for Term. Code', Comment = 'ESP="Cód. motivo terminación"';
                    ToolTip = 'Especifica el cód. motivo terminación';
                }
                field(Salario; Rec.Salario)
                {
                    ApplicationArea = All;
                    Caption = 'Salario', Comment = 'ESP="Salario"';
                    ToolTip = 'Especifica';
                }
            }
        }
    }
}