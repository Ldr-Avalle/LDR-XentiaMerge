pageextension 50065 "Service Quote_LDR" extends "Service Quote"
{
    layout
    {
        addafter("Max. Labor Unit Price")
        {
            field("Posting Date_LDR"; Rec."Posting Date")
            {
                ApplicationArea = All;
            }
        }
    }
}
