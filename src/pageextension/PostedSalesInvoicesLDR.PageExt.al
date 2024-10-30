pageextension 50040 "Posted Sales Invoices" extends "Posted Sales Invoices"
{
    layout
    {
        addafter("Payment Terms Code")
        {
            field("Payment Method Code"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
            }
            field("User ID"; Rec."User ID")
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
        gbldimensiones.SETRANGE(gbldimensiones.Usuario, USERID);
        IF gbldimensiones.FINDFIRST THEN
            rec.SETRANGE("User ID", USERID);
    end;

    var
        gbldimensiones: Record 50000;
}
