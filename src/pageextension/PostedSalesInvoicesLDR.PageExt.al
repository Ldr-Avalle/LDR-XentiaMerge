pageextension 50040 "Posted Sales Invoices_LDR" extends "Posted Sales Invoices"
{
    layout
    {
        addafter("Payment Terms Code")
        {
            field("Payment Method Code_LDR"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
            }
            field("User ID_LDR"; Rec."User ID")
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
        gbldimensiones.SetRange(gbldimensiones.Usuario, UserId);
        if gbldimensiones.FindFirst() then
            Rec.SetRange("User ID", UserId);
    end;

    var
        gbldimensiones: Record "User Dimensions_LDR";
}
