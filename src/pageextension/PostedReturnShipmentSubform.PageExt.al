pageextension 50073 "Posted Return Shipment Subform" extends "Posted Return Shipment Subform"
{
    layout
    {
        addafter("Quantity Invoiced")
        {
            field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
            {
                ApplicationArea = All;
            }
        }
        modify("Direct Unit Cost")
        {
            Visible = false;
        }
        modify("Quantity Invoiced")
        {
            Visible = false;
        }
    }

}
