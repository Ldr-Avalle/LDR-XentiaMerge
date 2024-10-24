pageextension 50020 "Sales Order Subform" extends "Sales Order Subform"
{
    layout
    {
        modify("Requested Delivery Date")
        {
            ApplicationArea = All;
            Visible = false;
        }
        modify("Promised Delivery Date")
        {
            ApplicationArea = All;
            Visible = false;
        }
    }
}
