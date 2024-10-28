pageextension 50054 "Analysis View List" extends "Analysis View List"
{
    layout
    {
        addafter("Dimension 4 Code")
        {
            field("Account Filter"; Rec."Account Filter")
            {
                ApplicationArea = All;
            }
        }
    }
}
