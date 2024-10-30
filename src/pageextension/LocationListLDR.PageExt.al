pageextension 50001 "Location List" extends "Location List"
{
    layout
    {
        addlast(Control1)
        {
            field("Shop Code"; rec.ShopCode)
            {
                ApplicationArea = All;
            }
            field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
        }
    }
}
