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
                    Caption = 'Posting Date', Comment = 'ESP="Fecha registro"';
                    ToolTip = 'Especifica la fecha registro';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    Caption = 'Document Type', Comment = 'ESP="Tipo documento"';
                    ToolTip = 'Especifica el tipo documento';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'Document No.', Comment = 'ESP="Nº documento"';
                    ToolTip = 'Especifica el nº documento';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description', Comment = 'ESP="Descripción"';
                    ToolTip = 'Especifica la descripción';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Caption = 'Amount', Comment = 'ESP="Importe"';
                    ToolTip = 'Especifica el importe';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Global Dimension 1 Code', Comment = 'ESP="Cód. dimensión global 1"';
                    ToolTip = 'Especifica el cód. dimensión global 1';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Global Dimension 2 Code', Comment = 'ESP="Cód. dimensión global 2"';
                    ToolTip = 'Especifica el cód. dimensión global 2';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Caption = 'User ID';
                    ToolTip = 'Especifica el user id';
                }
            }
        }
    }
}