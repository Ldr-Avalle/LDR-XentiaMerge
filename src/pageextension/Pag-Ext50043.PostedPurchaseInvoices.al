pageextension 50043 "Posted Purchase Invoices" extends "Posted Purchase Invoices"
{
    layout
    {
        addafter("Shipment Method Code")
        {
            field("Invoice Type"; Rec."Invoice Type")
            {
                ApplicationArea = All;
            }
        }
    }
}
