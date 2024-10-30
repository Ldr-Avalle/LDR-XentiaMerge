pageextension 50052 "Dimensions_LDR" extends Dimensions
{
    layout
    {
        addafter("Consolidation Code")
        {
            field("Use Dimension_LDR"; Rec."Use Dimension")
            {
                ApplicationArea = All;
            }
        }
    }
}
