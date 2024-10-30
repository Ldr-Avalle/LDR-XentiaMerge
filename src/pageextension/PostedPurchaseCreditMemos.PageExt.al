pageextension 50044 "Posted Purchase Credit Memos" extends "Posted Purchase Credit Memos"
{
    layout
    {
        addafter("Applies-to Doc. Type")
        {
            field("Invoice Type_LDR"; Rec."Invoice Type")
            {
                ApplicationArea = All;
            }
        }
    }
}
