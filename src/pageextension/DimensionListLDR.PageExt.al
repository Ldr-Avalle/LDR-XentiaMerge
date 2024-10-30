pageextension 50053 "Dimension List" extends "Dimension List"
{
    layout
    {
        addafter(Name)
        {
            field("Use Dimension"; Rec."Use Dimension")
            {
                ApplicationArea = All;
            }
        }
    }
}
