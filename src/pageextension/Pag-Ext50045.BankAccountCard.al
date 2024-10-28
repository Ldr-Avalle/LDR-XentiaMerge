pageextension 50045 "Bank Account Card" extends "Bank Account Card"
{
    layout
    {
        addafter("Country/Region Code")
        {
            field("Net Change"; Rec."Net Change")
            {
                ApplicationArea = All;
            }
        }
    }
}
