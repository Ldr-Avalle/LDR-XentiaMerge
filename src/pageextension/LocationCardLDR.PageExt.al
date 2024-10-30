pageextension 50062 "Location Card_LDR" extends "Location Card"
{
    layout
    {
        addafter("Country/Region Code")
        {
            field(ShopCode_LDR; Rec.ShopCode)
            {
                ApplicationArea = All;
            }
            field("Global Dimension 1 Code_LDR"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
        }
    }
}
