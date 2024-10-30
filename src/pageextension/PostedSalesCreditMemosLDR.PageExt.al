pageextension 50041 "Posted Sales Credit Memos" extends "Posted Sales Credit Memos"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = All;
            }
        }
        addafter("Posting Date")
        {
            field("Payment Method Code"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Document Exchange Status")
        {
            field("Invoice Type"; Rec."Invoice Type")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnOpenPage()
    begin
        gbldimensiones.RESET;
        gbldimensiones.SETRANGE(gbldimensiones.Usuario, USERID);
        IF gbldimensiones.FINDFIRST THEN
            rec.SETRANGE("User ID", USERID);
    end;

    var
        gbldimensiones: Record 50000;
}
