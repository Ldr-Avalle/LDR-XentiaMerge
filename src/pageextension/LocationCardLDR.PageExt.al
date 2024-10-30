pageextension 50062 "Location Card" extends "Location Card"
{
    layout
    {
        addafter("Country/Region Code")
        {
            field(ShopCode; Rec.ShopCode)
            {
                ApplicationArea = All;
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
        }
    }
}
