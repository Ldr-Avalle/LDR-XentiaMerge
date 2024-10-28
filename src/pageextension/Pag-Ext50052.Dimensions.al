pageextension 50052 Dimensions extends Dimensions
{
    layout
    {
        addafter("Consolidation Code")
        {
            field("Use Dimension"; Rec."Use Dimension")
            {
                ApplicationArea = All;
            }
        }
    }
}
