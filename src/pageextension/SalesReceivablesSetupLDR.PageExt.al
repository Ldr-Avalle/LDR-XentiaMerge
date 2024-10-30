pageextension 50048 "Sales & Receivables Setup_LDR" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Check Prepmt. when Posting")
        {
            field("Automat. Tracking Unit Cost_LDR"; Rec."Automat. Tracking Unit Cost")
            {
                ApplicationArea = All;
            }
            field("Tracking Invoice Qty. Limit_LDR"; Rec."Tracking Invoice Qty. Limit")
            {
                ApplicationArea = All;
            }
        }
    }
}
