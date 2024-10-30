pageextension 50072 "Get Return Shipment Lines_LDR" extends "Get Return Shipment Lines"
{
    layout
    {
        addafter("No.")
        {
            field("Posting Date_LDR"; Rec."Posting Date")
            {
                ApplicationArea = All;
            }
            field("Vendor Nº"; Rec."Vendor Nº")
            {
                ApplicationArea = All;
            }
            field("Unit Cost_LDR"; Rec."Unit Cost")
            {
                ApplicationArea = All;
            }
        }
    }
}
