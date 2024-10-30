pageextension 50054 "Analysis View List_LDR" extends "Analysis View List"
{
    layout
    {
        addafter("Dimension 4 Code")
        {
            field("Account Filter_LDR"; Rec."Account Filter")
            {
                ApplicationArea = All;
            }
        }
    }
}
