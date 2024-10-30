pageextension 50060 "Fixed Asset List_LDR" extends "Fixed Asset List"
{
    layout
    {
        addafter("No.")
        {
            field("Serial No._LDR"; Rec."Serial No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("Global Dimension 1 Code_LDR"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 2 Code_LDR"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
            }
            field("Location Code_LDR"; Rec."Location Code")
            {
                ApplicationArea = All;
            }
            field(Date_LDR; Rec.Date)
            {
                ApplicationArea = All;
            }
        }
        addafter("Search Description")
        {
            field(Proyecto_LDR; Rec.Proyecto)
            {
                ApplicationArea = All;
            }
            field("FA Posting Group_LDR"; Rec."FA Posting Group")
            {
                ApplicationArea = All;
            }
        }
    }
}
