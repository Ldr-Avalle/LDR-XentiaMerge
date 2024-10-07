page 50100 "gl reg mov"
{
    ApplicationArea = All;
    Caption = 'gl reg mov', Comment = 'ESP=""';
    PageType = List;
    SourceTable = "G/L Register";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("From Entry No."; Rec."From Entry No.")
                {
                    ApplicationArea = All;
                    Caption = 'From Entry No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("To Entry No."; Rec."To Entry No.")
                {
                    ApplicationArea = All;
                    Caption = 'To Entry No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
#pragma warning disable AL0432
                field("Creation Date"; Rec."Creation Date")
#pragma warning restore AL0432
                {
                    ApplicationArea = All;
                    Caption = 'Creation Date', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                    Caption = 'Source Code', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Caption = 'User ID', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                    Caption = 'Journal Batch Name', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("From VAT Entry No."; Rec."From VAT Entry No.")
                {
                    ApplicationArea = All;
                    Caption = 'From VAT Entry No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("To VAT Entry No."; Rec."To VAT Entry No.")
                {
                    ApplicationArea = All;
                    Caption = 'To VAT Entry No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = All;
                    Caption = 'Reversed', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Posting Date', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                // field("Period Trans. No.";Rec."Period Trans. No.") //TODO:REVISAR CAMPOS
                // {
                // }
                // field("Fecha registro en Mov cont";Rec."Fecha registro en Mov cont")
                // {
                // }
                // field("Num Asiento en Mov cont";Rec."Num Asiento en Mov cont")
                // {
                // }
                // field("Fecha Asiento en Mov conta";Rec."Fecha Asiento en Mov conta")
                // {
                // }
            }
        }
    }
}