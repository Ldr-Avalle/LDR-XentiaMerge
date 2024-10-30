pageextension 50043 "Posted Purchase Invoices_LDR" extends "Posted Purchase Invoices"
{
    layout
    {
        addafter("Shipment Method Code")
        {
            field("Invoice Type_LDR"; Rec."Invoice Type")
            {
                ApplicationArea = All;
            }
        }
    }
}
