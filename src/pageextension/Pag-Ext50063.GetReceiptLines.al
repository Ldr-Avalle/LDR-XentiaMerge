pageextension 50063 "Get Receipt Lines" extends "Get Receipt Lines"
{
    layout
    {
        addafter("Variant Code")
        {
            field("Vendor Shipement No."; Rec."Vendor Shipement No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("Unit Cost"; Rec."Unit Cost")
            {
                ApplicationArea = All;
            }

        }
        addafter("Unit of Measure")
        {
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;
            }
        }
    }
}