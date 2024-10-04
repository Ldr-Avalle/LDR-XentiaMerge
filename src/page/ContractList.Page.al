page 50007 "Contract List"
{
    ApplicationArea = All;
    Caption = 'Lista contratos';
    PageType = Card;
    SourceTable = "G/L Register CP_LDR";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(repeater)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = '"No."', Comment = 'ESP"Nº"';
                    ToolTip = 'Especifica el nº';
                }
                field("From Entry No."; Rec."From Entry No.")
                {
                    ApplicationArea = All;
                    Caption = 'From Entry No.', Comment = 'ESP""';
                    ToolTip = 'Especifica';
                }
                field("To VAT Entry No."; Rec."To VAT Entry No.")
                {
                    ApplicationArea = All;
                    Caption = 'To VAT Entry No.', Comment = 'ESP""';
                    ToolTip = 'Especifica';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                    Caption = 'Creation Date', Comment = 'ESP""';
                    ToolTip = 'Especifica';
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                    Caption = 'Source Code', Comment = 'ESP""';
                    ToolTip = 'Especifica';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Caption = 'User ID', Comment = 'ESP""';
                    ToolTip = 'Especifica';
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                    Caption = 'Journal Batch Name', Comment = 'ESP""';
                    ToolTip = 'Especifica';
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = All;
                    Caption = 'Reversed', Comment = 'ESP""';
                    ToolTip = 'Especifica';
                }
                //TODO:PREGUNTAR A AITOR SI LOS AÑADO A LA TABLA DE LA QUE TIRA O LOS ELIMINO YA QUE NO LOS CONTIENE ACTUALMENTE ESTOS CAMPOS
                // field(Floor; Rec.Floor)
                // {
                // }
                // field(CP; Rec.CP)
                // {
                // }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            group("&Contract")
            {
                Caption = '&Contract', Comment = 'ESP=""';
                action(Card)
                {
                    Caption = 'Card', Comment = 'ESP=""';
                    Image = EditLines;
                    ShortcutKey = 'Shift+F5';

                    trigger OnAction()
                    begin
                        Page.Run(Page::"Contract Card", Rec)
                    end;
                }
            }
        }
    }
}