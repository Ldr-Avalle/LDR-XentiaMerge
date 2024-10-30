pageextension 50063 "Get Receipt Lines_LDR" extends "Get Receipt Lines"
{
    layout
    {
        addafter("Variant Code")
        {
            field("Vendor Shipement No._LDR"; Rec."Vendor Shipement No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("Unit Cost_LDR"; Rec."Unit Cost")
            {
                ApplicationArea = All;
            }
        }
        addafter("Unit of Measure")
        {
            field("Posting Date_LDR"; Rec."Posting Date")
            {
                ApplicationArea = All;
            }
        }
    }
}