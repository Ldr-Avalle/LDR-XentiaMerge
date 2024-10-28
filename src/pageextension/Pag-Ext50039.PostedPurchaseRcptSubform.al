pageextension 50039 "Posted Purchase Rcpt. Subform" extends "Posted Purchase Rcpt. Subform"
{
    layout
    {
        addafter("Quantity Invoiced")
        {
            field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
            {
                ApplicationArea = All;
            }
        }
    }
}
