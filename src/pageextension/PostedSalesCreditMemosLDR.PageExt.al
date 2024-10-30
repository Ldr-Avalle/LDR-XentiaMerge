pageextension 50041 "Posted Sales Credit Memos_LDR" extends "Posted Sales Credit Memos"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field("User ID_LDR"; Rec."User ID")
            {
                ApplicationArea = All;
            }
        }
        addafter("Posting Date")
        {
            field("Payment Method Code_LDR"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Document Exchange Status")
        {
            field("Invoice Type_LDR"; Rec."Invoice Type")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnOpenPage()
    begin
        gbldimensiones.Reset();
        gbldimensiones.SetRange(gbldimensiones.Usuario, UserId);
        if gbldimensiones.FindFirst() then
            Rec.SetRange("User ID", UserId);
    end;

    var
        gbldimensiones: Record "User Dimensions_LDR";
}
