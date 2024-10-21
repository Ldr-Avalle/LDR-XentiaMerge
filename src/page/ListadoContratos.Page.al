page 50044 ListadoContratos
{
    ApplicationArea = All;
    Caption = 'Listado Contratos';
    Editable = false;
    PageType = List;
    SourceTable = "Employee Contract";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Employee; Rec.Employee)
                {
                    ApplicationArea = All;
                    Caption = 'Employee', Comment = 'ESP="Empleado"';
                    ToolTip = 'Especifica el empleado';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.', Comment = 'ESP="Nº"';
                    ToolTip = 'Especifica el nº';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Caption = 'Employee Name', Comment = 'ESP="Nombre"';
                    ToolTip = 'Especifica el nombre';
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
                field(Project; Rec.Project)
                {
                    ApplicationArea = All;
                    Caption = 'Project', Comment = 'ESP="Proyecto"';
                    ToolTip = 'Especifica el proyecto';
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
                field("Creation User ID"; Rec."Creation User ID")
                {
                    ApplicationArea = All;
                    Caption = 'Creation User ID';
                    ToolTip = 'Especifica Creation User ID';
                }
                field("Creation date"; Rec."Creation date")
                {
                    ApplicationArea = All;
                    Caption = 'Creation date';
                    ToolTip = 'Especifica la Creation date';
                }
                field("Last modification User ID"; Rec."Last modification User ID")
                {
                    ApplicationArea = All;
                    Caption = 'Last modification User ID';
                    ToolTip = 'Especifica Last modification User ID';
                }
                field("Last modification date"; Rec."Last modification date")
                {
                    ApplicationArea = All;
                    Caption = 'Last modification date';
                    ToolTip = 'Especifica Last modification date';
                }
                field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                {
                    ApplicationArea = All;
                    Caption = 'Grounds for Term. Code', Comment = 'ESP="Cód. motivo terminación"';
                    ToolTip = 'Especifica el cód. motivo terminación';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    Caption = 'Category', Comment = 'ESP="Categoría"';
                    ToolTip = 'Especifica la categoría';
                }
                field(Agreement; Rec.Agreement)
                {
                    ApplicationArea = All;
                    Caption = 'Agreement', Comment = 'ESP="Convenio"';
                    ToolTip = 'Especifica el convenio';
                }
                field("Working center"; Rec."Working center")
                {
                    ApplicationArea = All;
                    Caption = 'Working center', Comment = 'ESP="Centro trabajo"';
                    ToolTip = 'Especifica el centro trabajo';
                }
                field(Work; Rec.Work)
                {
                    ApplicationArea = All;
                    Caption = 'Work', Comment = 'ESP="Obra"';
                    ToolTip = 'Especifica la obra';
                }
                field("Trial period formula"; Rec."Trial period formula")
                {
                    ApplicationArea = All;
                    Caption = 'Trial period formula', Comment = 'ESP="Vencimiento periodo prueba"';
                    ToolTip = 'Especifica el vencimiento periodo prueba';
                }
                field("Expiration date"; Rec."Expiration date")
                {
                    ApplicationArea = All;
                    Caption = 'Expiration date', Comment = 'ESP="Fecha baja"';
                    ToolTip = 'Especifica la fecha baja';
                }
                field("Employee Name2"; Rec."Employee Name2")
                {
                    ApplicationArea = All;
                    Caption = 'Employee Name2';
                    ToolTip = 'Especifica el employee Name2';
                }
                field("Grounds for Term. Name"; Rec."Grounds for Term. Name")
                {
                    ApplicationArea = All;
                    Caption = 'Grounds for Term. Name';
                    ToolTip = 'Especifica el Grounds for Term. Name';
                }
                field("Employee Name3"; Rec."Employee Name3")
                {
                    ApplicationArea = All;
                    Caption = 'Employee Name3';
                    ToolTip = 'Especifica el Employee Name3';
                }
                field(Salario; Rec.Salario)
                {
                    ApplicationArea = All;
                    Caption = 'Salario';
                    ToolTip = 'Especifica el salario';
                }
            }
        }
    }
}