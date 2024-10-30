pageextension 50001 "Location List_LDR" extends "Location List"
{
    layout
    {
        addlast(Control1)
        {
            field("Shop Code_LDR"; Rec.ShopCode)
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
