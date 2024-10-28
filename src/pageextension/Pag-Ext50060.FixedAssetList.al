pageextension 50060 "Fixed Asset List" extends "Fixed Asset List"
{
    layout
    {
        addafter("No.")
        {
            field("Serial No."; Rec."Serial No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
            }
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = All;
            }
            field(Date; Rec.Date)
            {
                ApplicationArea = All;
            }
        }
        addafter("Search Description")
        {
            field(Proyecto; Rec.Proyecto)
            {
                ApplicationArea = All;
            }
            field("FA Posting Group"; Rec."FA Posting Group")
            {
                ApplicationArea = All;
            }
        }
    }
}
