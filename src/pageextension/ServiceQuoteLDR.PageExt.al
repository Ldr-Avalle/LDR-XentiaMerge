pageextension 50065 "Service Quote" extends "Service Quote"
{
    layout
    {
        addafter("Max. Labor Unit Price")
        {
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;
            }
        }
    }
}
