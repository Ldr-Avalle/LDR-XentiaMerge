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
                    Caption = 'Employee', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Caption = 'Employee Name', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Employee Name2"; Rec."Employee Name2")
                {
                    ApplicationArea = All;
                    Caption = 'Employee Name2', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Project; Rec.Project)
                {
                    ApplicationArea = All;
                    Caption = 'Project', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Employee Name3"; Rec."Employee Name3")
                {
                    ApplicationArea = All;
                    Caption = 'Employee Name3', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
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
                field("Working center"; Rec."Working center")
                {
                    ApplicationArea = All;
                    Caption = 'Working center', Comment = 'ESP=""';
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
                field("Expiration date"; Rec."Expiration date")
                {
                    ApplicationArea = All;
                    Caption = 'Expiration date', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                {
                    ApplicationArea = All;
                    Caption = 'Grounds for Term. Code', Comment = 'ESP=""';
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

    actions
    {
    }
}

