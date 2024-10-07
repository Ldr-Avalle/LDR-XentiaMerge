page 50055 "Ledger List"
{
    ApplicationArea = All;
    Editable = false;
    PageType = Card;
    SourceTable = "G/L Entry";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(repeater)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Posting Date', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    Caption = 'Document Type', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'Document No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Caption = 'Amount', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Global Dimension 1 Code', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Global Dimension 2 Code', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Caption = 'User ID', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
            }
        }
    }
}