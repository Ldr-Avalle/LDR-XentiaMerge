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
                    Caption = 'Employee', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Caption = 'Employee Name', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Date of hire"; Rec."Date of hire")
                {
                    ApplicationArea = All;
                    Caption = 'Date of hire', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Contract type"; Rec."Contract type")
                {
                    ApplicationArea = All;
                    Caption = 'Contract type', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = All;
                    Caption = 'Duration', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Working %"; Rec."Working %")
                {
                    ApplicationArea = All;
                    Caption = 'Working %', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Working Time"; Rec."Working Time")
                {
                    ApplicationArea = All;
                    Caption = 'Working Time', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Project; Rec.Project)
                {
                    ApplicationArea = All;
                    Caption = 'Project', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Trial period due date"; Rec."Trial period due date")
                {
                    ApplicationArea = All;
                    Caption = 'Trial period due date', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Due date"; Rec."Due date")
                {
                    ApplicationArea = All;
                    Caption = 'Due date', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Creation User ID"; Rec."Creation User ID")
                {
                    ApplicationArea = All;
                    Caption = 'Creation User ID', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Creation date"; Rec."Creation date")
                {
                    ApplicationArea = All;
                    Caption = 'Creation date', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Last modification User ID"; Rec."Last modification User ID")
                {
                    ApplicationArea = All;
                    Caption = 'Last modification User ID', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Last modification date"; Rec."Last modification date")
                {
                    ApplicationArea = All;
                    Caption = 'Last modification date', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                {
                    ApplicationArea = All;
                    Caption = 'Grounds for Term. Code', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    Caption = 'Category', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Agreement; Rec.Agreement)
                {
                    ApplicationArea = All;
                    Caption = 'Agreement', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Working center"; Rec."Working center")
                {
                    ApplicationArea = All;
                    Caption = 'Working center', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Work; Rec.Work)
                {
                    ApplicationArea = All;
                    Caption = 'Work', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Trial period formula"; Rec."Trial period formula")
                {
                    ApplicationArea = All;
                    Caption = 'Trial period formula', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Expiration date"; Rec."Expiration date")
                {
                    ApplicationArea = All;
                    Caption = 'Expiration date', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Employee Name2"; Rec."Employee Name2")
                {
                    ApplicationArea = All;
                    Caption = 'Employee Name2', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Grounds for Term. Name"; Rec."Grounds for Term. Name")
                {
                    ApplicationArea = All;
                    Caption = 'Grounds for Term. Name', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Employee Name3"; Rec."Employee Name3")
                {
                    ApplicationArea = All;
                    Caption = 'Employee Name3', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Salario; Rec.Salario)
                {
                    ApplicationArea = All;
                    Caption = 'Salario', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
            }
        }
    }
}