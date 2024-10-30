pageextension 50059 "Fixed Asset Card" extends "Fixed Asset Card"
{
    layout
    {
        addafter("Main Asset/Component")
        {
            field(Location; Rec.Location)
            {
                ApplicationArea = All;
            }
        }
    }
}
