page 50001 "Employee Contracts"
{
    ApplicationArea = All;
    Caption = 'Employee Contracts', Comment = 'ESP=""';
    PageType = CardPart;
    SourceTable = "Employee Contract";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(repeater)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.', Comment = 'ESP="Nº"';
                    ToolTip = 'Especifica el nº';
                    Editable = false;
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
                field(Work; Rec.Work)
                {
                    ApplicationArea = All;
                    Caption = 'Work', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Agreement; Rec.Agreement)
                {
                    ApplicationArea = All;
                    Caption = 'Agreement', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    Caption = 'Category', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Working %"; Rec."Working %")
                {
                    ApplicationArea = All;
                    Caption = 'Working %', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                    BlankZero = true;
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
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = All;
                    Caption = 'Duration', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Trial period formula"; Rec."Trial period formula")
                {
                    ApplicationArea = All;
                    Caption = 'Trial period formula', Comment = 'ESP=""';
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
            }
        }
    }
}