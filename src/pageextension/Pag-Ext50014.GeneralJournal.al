pageextension 50014 "General Journal" extends "General Journal"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Payment Method Code"; Rec."Payment Method Code")
            {
                ApplicationArea = all;
            }
            field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
            {
                ApplicationArea = all;
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

