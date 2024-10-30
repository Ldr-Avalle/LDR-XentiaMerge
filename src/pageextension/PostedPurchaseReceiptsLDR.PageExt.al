pageextension 50042 "Posted Purchase Receipts_LDR" extends "Posted Purchase Receipts"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Order Date_LDR"; Rec."Order Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shipment Method Code")
        {
            field("Vendor Shipment No._LDR"; Rec."Vendor Shipment No.")
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
