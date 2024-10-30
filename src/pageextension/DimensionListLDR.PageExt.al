pageextension 50053 "Dimension List_LDR" extends "Dimension List"
{
    layout
    {
        addafter(Name)
        {
            field("Use Dimension_LDR"; Rec."Use Dimension")
            {
                ApplicationArea = All;
            }
        }
    }
}
