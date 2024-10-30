pageextension 50059 "Fixed Asset Card_LDR" extends "Fixed Asset Card"
{
    layout
    {
        addafter("Main Asset/Component")
        {
            field(Location_LDR; Rec.Location)
            {
                ApplicationArea = All;
            }
        }
    }
}
