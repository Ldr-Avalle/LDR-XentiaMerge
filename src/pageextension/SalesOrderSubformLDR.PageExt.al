pageextension 50020 "Sales Order Subform_LDR" extends "Sales Order Subform"
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
