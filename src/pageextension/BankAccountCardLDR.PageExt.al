pageextension 50045 "Bank Account Card_LDR" extends "Bank Account Card"
{
    layout
    {
        addafter("Country/Region Code")
        {
            field("Net Change_LDR"; Rec."Net Change")
            {
                ApplicationArea = All;
            }
        }
    }
}
