pageextension 50014 "General Journal_LDR" extends "General Journal"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Payment Method Code_LDR"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
            }
            field("Pmt. Discount Date_LDR"; Rec."Pmt. Discount Date")
            {
                ApplicationArea = All;
            }
        }
        modify("Transaction No.")
        {
            Editable = false;
        }
        modify("Payment Terms Code")
        {
            Visible = false;
        }
    }
}

