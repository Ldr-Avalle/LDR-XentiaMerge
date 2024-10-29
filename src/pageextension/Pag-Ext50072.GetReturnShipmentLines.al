pageextension 50072 "Get Return Shipment Lines" extends "Get Return Shipment Lines"
{
    layout
    {
        addafter("No.")
        {
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;
            }
            field("Vendor Nº"; Rec."Vendor Nº")
            {
                ApplicationArea = All;
            }
            field("Unit Cost"; Rec."Unit Cost")
            {
                ApplicationArea = All;
            }
        }
    }
}
