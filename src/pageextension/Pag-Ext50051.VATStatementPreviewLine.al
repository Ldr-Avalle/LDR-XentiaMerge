pageextension 50051 "VAT Statement Preview Line" extends "VAT Statement Preview Line"
{
    layout
    {
        addafter(Description)
        {
            field("Gen. Posting Type"; Rec."Gen. Posting Type")
            {
                ApplicationArea = All;
            }
        }
    }
}
