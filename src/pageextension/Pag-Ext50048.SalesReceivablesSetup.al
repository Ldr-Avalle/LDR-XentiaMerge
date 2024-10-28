pageextension 50048 "Sales & Receivables Setup" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Check Prepmt. when Posting")
        {
            field("Automat. Tracking Unit Cost"; Rec."Automat. Tracking Unit Cost")
            {
                ApplicationArea = All;
            }
            field("Tracking Invoice Qty. Limit"; Rec."Tracking Invoice Qty. Limit")
            {
                ApplicationArea = All;
            }
        }
    }
}
