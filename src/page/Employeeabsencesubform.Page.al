page 50022 "Employee absence subform."
{
    ApplicationArea = All;
    Caption = 'Subform. Registro ausencias', Comment = 'ESP=""';
    PageType = CardPart;
    SourceTable = "Employee Absence";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(repeater)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Caption = 'Entry No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                    Caption = 'From Date', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;
                    Caption = 'To Date', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Cause of Absence Code"; Rec."Cause of Absence Code")
                {
                    ApplicationArea = All;
                    Caption = 'Cause of Absence Code', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Quantity', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comment', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
            }
        }
    }
}